// Stellar Horizons

$fn=60;
thick = 2.0;

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


        

module resourceTray() {
    fl = 1;

    offsets = [1, 28, 60, 100, 140, 190];
    difference() {
        roundedCube([offsets[5]-1,40 /*158*/,20],5);
        for (row=[0:0]) {
            for (col=[0:4]) {
                well(offsets[col],1 + row * 39.25, 1, offsets[col+1] - offsets[col]-1, 38);
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
    difference() {
        roundedCube([28,109 + 16.4,14],rad=2);
        for (i=[0:5]) {
            translate([1,2+i*21,1]) cube([26,i==5?16.4 : 14.4,99]);
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

unitSep = 6;
function computeOffset(l,c) = c==0? 0 : (l[c-1].y * 2.1 + unitSep + computeOffset(l,c-1));
function computeSize(l,c) = l[c].y * 2.1 + (c==0? unitSep : (unitSep + computeSize(l,c-1)));

shearYZ = 0.4;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

module factionTray(fname, units) {
    difference() {
        roundedCube([28,computeSize(units,len(units)-1) + unitSep + 2,14],rad=2);
        for (i=[0:len(units)-1]) {
            name = units[i].x;
            size = units[i].y * 2;
            offset = 1 + computeOffset(units,i);
            translate([14,offset,13]) linear_extrude(2) 
                text(name,size=4,halign="center",valign="baseline");
            translate([1,offset,0.6]) multmatrix(M) cube([26,size,99]);
        }
        translate([14,computeSize(units,len(units)-1) + 1,13]) linear_extrude(2)
                text(fname,size=4,halign="center",valign="baseline");
    }
}

Japan = [ ["Probe",2], ["Rover",1], ["Tele",1], ["Base",6], ["Orbit",3], ["Flyby",4],
    ["LV1",2], ["LV2",3], ["CV2",1], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",2], ["CV7",1], ["CV9",1] ];

NorAm = [ ["Probe",1], ["Rover",2], ["Tele",1], ["Base",6], ["Orbit",2], ["Flyby",2],
    ["LV1",2], ["LV2",3], ["CV2",4], ["CV3",2], ["CV4",2], ["CV5",2], ["CV6",2], ["CV8",2] ];

SthAm = [ ["Probe",1], ["Rover",1], ["Tele",1], ["Base",6], ["Orbit",2], ["Flyby",3],
    ["LV1",2], ["LV2",3], ["CV2",2], ["CV3",3], ["CV4",2], ["CV5",3], ["CV6",2], ["CV7",2] ];

// smallSolarTray();
//translate([200,0,0]) 
//rotate([0,0,45]) resourceTray();
//settlementTray(); // x2
//structureTray(); // x3
//worldCardTray();

factionTray("Japan",Japan);
translate([30,0,0]) factionTray("NorAm",NorAm);
translate([60,0,0]) factionTray("SthAm",SthAm);