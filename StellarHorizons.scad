// Stellar Horizons

$fn=60;
thick = 2.0;

use</Users/etherton/Downloads/Noto_Emoji/NotoEmoji-VariableFont_wght.ttf>

module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

module well(x,y,z,w,h,rad = 5) {
    translate([x,y,z]) hull() {
        translate([rad,rad,rad]) sphere(r=rad);
        translate([w-rad,rad,rad]) sphere(r=rad);
        translate([rad,h-rad,rad]) sphere(r=rad);
        translate([w-rad,h-rad,rad]) sphere(r=rad);
        translate([rad,rad,99]) sphere(r=rad);
        translate([w-rad,rad,99]) sphere(r=rad);
        translate([rad,h-rad,99]) sphere(r=rad);
        translate([w-rad,h-rad,99]) sphere(r=rad);
    }
}

// don't print this in draft mode
module smallSolarTray() {
    w=184; h = 158;
    moonDiam = 77;
    difference() {
        roundedCube([w,h,31],5);
        translate([w/4,3*h/4,-1]) { 
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,2]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4,3*h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,2]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4-moonDiam/2,3*h/4-moonDiam/2,13]) cube([moonDiam,moonDiam,99]);
        
        translate([w/4,h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,4]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4,h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,4]) cylinder(d=moonDiam,h=99);
        }
        translate([w/2,h/2,-1]) cylinder(d=40,h=99);
        translate([w/2,h/2,15]) cylinder(d=180,h=99,$fn=6);
    } 
}


        

module resourceTray(f) {
    fl = 1;
    sizes = [ 34, 38, 42, 46, 51 ];
    labels = [ "1", "2", "5", "10", "25" ];
    prefixes = ["\U01f4b2", "\U01faa8", "\U01f525", "\U01f4a7" ];
    function computeOffset(l,c) = c==0? 1 : (l[c-1] + 1 + computeOffset(l,c-1));
    function computeSize(l,c) = l[c] + (c==0? 1 : (1 + computeSize(l,c-1)));
    w = 217;
    h = 195;
    hCell = (h - 5)/4;
    
    module doLabel(f,offset,row,col) {
        translate([offset + 2*sizes[col]/6,1 + row * (hCell+1) + hCell/2,0.4])
            linear_extrude(f==0?1:0.6) 
                text(prefixes[row],size=row==1?7:9,font="Noto Emoji:style=Regular",
                    halign = "center",valign = "center");
        translate([offset + 3*sizes[col]/6,1 + row * (hCell+1) + hCell/2,0.4])
            linear_extrude(f==0?1:0.6) 
                text(labels[col],size=10,
                    halign = "left",valign = "center");

    }

    if (f) {
        cube(.6);
        for (row=[0:3]) {
            for (col=[0:len(sizes)-1]) {
                offset = computeOffset(sizes,col);
                doLabel(f,offset,row,col);
            }
        }
    }
    else difference() {
        roundedCube([w,h,20],5);
        for (row=[0:3]) {
            for (col=[0:len(sizes)-1]) {
                offset = computeOffset(sizes,col);
                well(offset,1 + row * (hCell+1), 1, sizes[col], hCell);
                doLabel(f,offset,row,col);
            }
        }
    }
}

module settlementTray() { // x2
    extra = 5;
    five = 10.4;
    six = 12.4;
    x1s = five+1; x1 = 2;
    x3s = six+1; x3 = x1 + x1s*4 + extra;
    x5s = five+1; x5 = x3 + x3s*2 + extra;
    x15s = five+1; x15 = x5 + x5s*2 + extra;
    offsets = [ 
        x1, x1+1*x1s, x1+2*x1s, x1+3*x1s,  // 1x (5 each)
        x3, x3 + x3s, // 3x (6 each)
        x5, x5 + x5s, // 5x
        x15, x15 + x15s // 15X
    ];

    sizes = [ five, five, five, five, six, six, five, five, five, five ];
            
    difference() {
        roundedCube([23,offsets[9] + sizes[9] + 2,10],rad=2);
        for (i=[0:9])
            translate([1,offsets[i],1]) cube([21,sizes[i],99]);
    }
}

module structureTray() { // x3
    // The Defense Structure counters are thinner than the others!
    difference() {
        roundedCube([28,109 + 15.8,14],rad=2);
        for (i=[0:5]) {
            translate([1,2+i*21,1]) cube([26,i==5?15.8 : 14.4,99]);
        }   
    }
}

module worldCardTray() {
    w = 55; h = 36;
    difference() {
        roundedCube([w*2+3,h*3+4,19],5);
        e =  9;
        for (i=[0:1]) {
            for (j=[0:2]) {
                translate([i?w+1+1:1,1+j*(h+1),1]) {
                    linear_extrude(99) {
                        polygon([ [ 0,e ], [ 0,h-e ], [ e,h], [w-e,h],
                            [w,h-e], [w,e], [w-e,0], [e,0] ]);
                    }
                }
                translate([-1,1+j*(h+1)+e,1]) cube([3,h-e-e,99]);
                translate([w*2+3-2,1+j*(h+1)+e,1]) cube([3,h-e-e,99]);
            }
        }
    }
}


shearYZ = 0.4;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

factionSplit1 = 7;
factionSplit2 = 99;

module factionTray(n1, n2, units) {
    unitSep = 7;
    function computeOffset(l,c) = 
        (c==0||c==factionSplit1||c==factionSplit2)? 3 : 
            (l[c-1].y * 2.2 + unitSep + computeOffset(l,c-1));
    function countUnits(l,c) =
        l[c].y + ((c==0)? 0 : countUnits(l,c-1));

    assert(countUnits(units,len(units)-1) == 33, "Wrong number of units");
    w = 82;
    h = 108;
    union() {
        difference() {
            roundedCube([w,h,15],rad=2);
            for (i=[0:len(units)-1]) {
                name = units[i].x;
                size = units[i].y * 2.2 + 0.4;
                xOffset = (i<factionSplit1)? 1 : 28*2-1;
                yOffset = computeOffset(units,i);    
                /* translate([xOffset+13,yOffset+4,14]) linear_extrude(2) 
                    text(name,size=3,halign="center",valign="top");*/
                translate([xOffset,yOffset-1,1]) multmatrix(M) cube([26,size,99]);
            }
            translate([28,1,14]) roundedCube([26,h - 2,99],rad=2);
            translate([29,2,1]) roundedCube([24, h/2 - 2,99],rad=2);
            translate([29,2 + h/2 - 1,1]) roundedCube([24, h/2 - 3,99],rad=2);
            if (len(n2)==0) 
                translate([14, h - 9,14]) linear_extrude(2)
                    text(n1,size=6,halign="center",valign="bottom");
            else {
                translate([14, h - 6,14]) linear_extrude(2)
                    text(n1,size=3.5,halign="center",valign="bottom");
                translate([14, h - 6.5,14]) linear_extrude(2)
                    text(n2,size=3.5,halign="center",valign="top");
            }
        }
       for (i=[0:len(units)-1]) {
            name = units[i].x;
            size = units[i].y * 2.2 + 0.4;
            xOffset = (i<factionSplit1)? 1 : 28*2-1;
            yOffset = computeOffset(units,i);    
            translate([xOffset,yOffset-1+size,1]) multmatrix(M) {
                difference() {
                    cube([26,2,24]);
                    translate([13,0,18]) 
                        rotate([90,0,0])
                            linear_extrude(2,center=true)
                                text(name,size=5,halign="center",valign="top");
                    translate([13,-1,24]) scale([1,1,0.5]) rotate([90,0,0]) cylinder(h=99,d=20,center=true);
                }
            }
        }
    }
}

module factionLid() {
    difference() {
        roundedCube([26,72-36,0.8],rad=2);
        translate([13,0,-1]) scale([1,0.666,1]) cylinder(d=16,h=2);
    }
}

Japan = [ ["Probe",2], ["Rover",1], ["Tele",1], ["Base",6], ["Orbit",3], ["Flyby",4],
    ["LV1",2], ["LV2",3], ["CV2",1], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",2], ["CV7",1], ["CV9",1] ];

NorthAmerica = [ ["Probe",1], ["Rover",2], ["Tele",1], ["Base",6], ["Orbiter",2], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",4], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",2], ["CV8",2] ];

SouthAmericaAfrica = [ ["Probe",1], ["Rover",1], ["Tele",1], ["Base",6], ["Orbiter",2], ["Flyby",3],
    ["LV1",2], ["LV2",3], ["CV2",2], ["CV3",3], ["CV4",2], ["CV5",3], ["CV6",2], ["CV7",2] ];

Asia = [ ["Probe",1], ["Rover",1], ["Tele",1], ["Base",6], ["Orbiter",2], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",4], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",3], ["CV7",2] ];

China = [ ["Probe",1], ["Rover",1], ["Tele",1], ["Base",6], ["Orbiter",2], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",4], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",3], ["CV7",2] ];

Russia  = [ ["Probe",1], ["Rover",1], ["Tele",1], ["Base",6], ["Orbiter",3], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",4], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",2], ["CV7",1], ["CV8",1] ];

Europe = [ ["Probe",2], ["Rover",2], ["Tele",2], ["Base",6], ["Orbiter",2], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",1], ["CV3",3], ["CV4",2], ["CV5",2], ["CV6",1], ["CV7",2], ["CV8",1] ];

// smallSolarTray();
//translate([200,0,0]) 
//rotate([0,0,45]) 
//resourceTray(1);
/* translate([0,0,0]) settlementTray();
translate([25,0,0]) settlementTray();
translate([50,0,0]) structureTray();
translate([80,0,0]) structureTray();
translate([110,0,0]) structureTray(); */
//settlementTray(); // x2
// structureTray(); // x3
//worldCardTray();

translate([0,0,0]) factionTray("Japan","",Japan);
/* translate([90,0,0]) factionTray("North","America",NorthAmerica);
translate([180,0,0]) factionTray("S.America","& Africa",SouthAmericaAfrica);
translate([270,0,0]) factionTray("Asia","",Asia);
translate([45,120,0]) factionTray("China","",China);
translate([45+90,120,0]) factionTray("Russia","",Russia);
translate([45+180,120,0]) factionTray("Europe","",Europe); */
//factionLid();


//translate([0,0,-14])
//factionTray("Test",[ ["One",1], ["Two",2], ["Three",3], ["Four",4] ]);