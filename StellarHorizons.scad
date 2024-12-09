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

module labeledWell(label,x,y,z,w,h) {
    well(x,y,z,w,h);
    translate([x+w/2,y+h/2,z-0.4]) linear_extrude(0.5)
        text(label,size = h/4,halign="center",valign="center");
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


// tab is 4mm deep minus the epsilon
module tabPart(tabHeight = 5,eps = 0.2) {
    translate([0,-3+eps/2,0]) cube([2+eps,6-eps,tabHeight]);
    translate([2+eps,-5+eps/2,0]) cube([2-eps-eps,10-eps,tabHeight]);
}

// slot is 4mm deep
module slotPart(tabHeight = 5) {
    translate([0,-7,0]) cube([4,2,tabHeight]);
    translate([2,-5,0]) cube([2,2,tabHeight]);
    translate([2,+3,0]) cube([2,2,tabHeight]);
    translate([0,+5,0]) cube([4,2,tabHeight]);
}


// each tray is 45mm + 4mm tabs (only on ends)
// 49 cash
// 49 ore
// 49 supplies
// 49 fuel
// 49 numbers
// 45 misc
//280 total
module resourceTray(topTab,bottomTab,h,sizes,prefix,labels,f=0,labelSize=9,prefixSize=9) {
    fl = 1;
    function computeOffset(l,c) = c==0? 1 : (l[c-1] + 1 + computeOffset(l,c-1));
    function computeSize(l,c) = l[c] + (c==0? 1 : (1 + computeSize(l,c-1)));
    w = 217;
    vCell = h - 2;
    
    module doLabel(f,offset,col) {
        if (len(prefix))
            translate([offset + 2*sizes[col]/6,1 + vCell/2,0.6])
                linear_extrude(f==0?1:0.4) 
                    text(prefix,prefixSize,font="Noto Emoji:style=Regular",
                        halign = "center",valign = "center");
        translate([offset + sizes[col]/2,1 + vCell/2,0.6])
            rotate([0,0,sizes[col]<20? 90 : 0]) linear_extrude(f==0?1:0.4)
                text(labels[col],size=labelSize,
                    halign = len(prefix)? "left" : "center",valign = "center");

    }

    if (f) {
        for (col=[0:len(sizes)-1]) {
            offset = computeOffset(sizes,col);
            doLabel(f,offset,col);
        }    
    }
    else {
        union() {
            difference() {
                roundedCube([w,h,20],5);
                for (col=[0:len(sizes)-1]) {
                    offset = computeOffset(sizes,col);
                    well(offset, 1, 1, sizes[col], vCell);
                    doLabel(f,offset,col);
                }
            }
            if (topTab) {
                translate([w/4,h]) rotate([0,0,90]) tabPart(10);
                translate([3*w/4,h]) rotate([0,0,90]) tabPart(10);
            }
            if (bottomTab) {
                translate([w/4,0]) rotate([0,0,-90]) slotPart(10);
                translate([3*w/4,0]) rotate([0,0,-90]) slotPart(10);
            }
        }
    }
}

module miscTray() {
    function computeOffset(l,c) = c==0? 1 : (l[c-1] + 1 + computeOffset(l,c-1));
    module labeledWell(label,x,y,z,w,h) {
        well(x,y,z,w,h);
        translate([x+w/2,y+h/2,z-0.4]) linear_extrude(1)
            text(label,size = h/4,halign="center",valign="center");
    }

    w = 217;
    h = 40;
    vCell = h-2;

    sizes = [30,30,28,37, 28,28,28,28];
    labels = [ ["Px1"], ["Px2","Px5"], ["H/T"], ["Dmg"], ["Vx1"], ["Vx3"], ["Vx5"], ["Vx10"] ];
    union() {
        difference() {
            roundedCube([w,h,20],5);
            for (i=[0:len(sizes)-1]) {
                ncy = len(labels[i]);
                vSize1 = floor(vCell / ncy);
                for (j=[0:ncy-1]) {
                    vSize =  (j==ncy-1)? h - 2 - (ncy-1)*(vSize1+1) : vSize1; 
                    labeledWell(labels[i][j], computeOffset(sizes,i), 
                        j * (vSize1+1) + 1, 1, sizes[i], vSize);
                }
            }
        }
        translate([w/4,h]) rotate([0,0,90]) tabPart(10);
        translate([3*w/4,h]) rotate([0,0,90]) tabPart(10);

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

module worldCardTray2() {
    e = 9;
    difference() {
        roundedCube([109,38,30],2);
        translate([2,1,0]) rotate([90,0,90]) linear_extrude(105) polygon([
            [e,0], [0,e], [0,99], [36,99], [36,e], [36-e,0] ]);
    }
}


shearYZ = 0.4;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;


module factionTray(n1, n2, units, f = 0, split = 6) {
    unitSep = 7;
    function computeOffset(l,c) = 
        (c==0||c==split)? 3 : 
            (l[c-1].y * 2.2 + unitSep + computeOffset(l,c-1));
    function countUnits(l,c) =
        l[c].y + ((c==0)? 0 : countUnits(l,c-1));
    module renderLabels(offset,thick) {
        for (i=[0:len(units)-1]) {
            name = units[i].x;
            size = units[i].y * 2.2 + 0.4;
            xOffset = (i<split)? 1 : w-27;
            yOffset = computeOffset(units,i);    
            translate([xOffset+cw/2,yOffset+4,depth+offset]) linear_extrude(thick) 
                text(name,size=i==5?4.5:5.5,halign="center",valign="top");
        }
        if (len(n2)==0) 
            translate([1+cw/2, h - 9,depth+offset]) linear_extrude(thick)
                text(n1,size=6,halign="center",valign="bottom");
        else {
            translate([1+cw/2, h - 6,depth+offset]) linear_extrude(thick)
                text(n1,size=3.5,halign="center",valign="bottom");
            translate([1+cw/2, h - 6.5,depth+offset]) linear_extrude(thick)
                text(n2,size=3.5,halign="center",valign="top");
        }
    }

    assert(countUnits(units,len(units)-1) == 33, "Wrong number of units");
    w = 86;
    h = 110;
    cw = 26;
    depth = 15;
    if (f==0) {
        difference() {            
            roundedCube([w,h,depth],rad=2);
            for (i=[0:len(units)-1]) {
                size = units[i].y * 2.2 + 0.4;
                xOffset = (i<split)? 1 : w-27;
                yOffset = computeOffset(units,i);    
                translate([xOffset,yOffset-1,1]) 
                    multmatrix(M)
                        cube([cw,size,99]);
            }
            renderLabels(-0.6,1);
            translate([cw+2,1,depth-1]) roundedCube([w-cw*2-4,h - 2,99],rad=2);
            translate([cw+3,2,1]) roundedCube([w-cw*2-6,25,99],rad=2);
            translate([cw+3,28,1]) roundedCube([w-cw*2-6,h-30,99],rad=2);
        }
        translate([w+5,1,0]) {
            difference() {
                roundedCube([w-cw*2-4,h-2,0.8],2);
                translate([(w-cw*2-4)/2,0,-1]) scale([1,0.666,1]) cylinder(d=16,h=2);
            }
        }
    }
    else
        renderLabels(-0.4,0.4);

}

/* module factionLid() {
    difference() {
        roundedCube([26,116,0.8],rad=2);
        translate([13,0,-1]) scale([1,0.666,1]) cylinder(d=16,h=2);
    }
} */

module meshWallXY(w,h,th,border,size1,size2) {
    cube([border,h,th]); translate([w-border,0,0]) cube([border,h,th]);
    cube([w,border,th]); translate([0,h-border,0]) cube([w,border,th]);
    nc = floor(max(w,h) / size2) + 1;
    difference() {
        translate([border,border,0]) cube([w-border*2,h-border*2,th]);
        rotate([0,0,45]) {
            for (i=[-nc:nc]) {
                for (j=[-nc:nc]) {
                    translate([i*size2,j*size2,-1]) cube([size1,size1,th+2]);
                }
            }
        }
    }
}

module meshWallYZ(w,h,th,border,size1,size2) {
    rotate([90,0,90]) meshWallXY(w,h,th,border,size1,size2);
}

module meshWallXZ(w,h,th,border,size1,size2) {
    rotate([90,0,0]) meshWallXY(w,h,th,border,size1,size2);
}

module moonTray() {
    difference() {
        cube([88,54,30]);
        // translate([11/2,1,1]) cube([77,2.4,99]);
        translate([10/2,53-2.4,1]) cube([78,2.6,99]);
        translate([44,1,77/2+1]) rotate([-90,0,0]) cylinder(h=52,d=77,$fn=180);
    }
    translate([0,54,0]) meshWallYZ(197,65,1,5,10,15);
    translate([0,54,30]) meshWallXZ(88,35,1,5,10,15);
    translate([-5,0,0]) cube([11,250,0.2 + 0.28]);
    
}


module cup(halfSize = 29, height = 40, tabHeight = 5) {
    eps = 0.2;
    module tab(rot) {
        rotate([0,0,rot]) translate([halfSize,0,0]) tabPart(tabHeight, eps);
    }
    module slot(rot) {
        rotate([0,0,rot]) translate([halfSize,0,0]) slotPart(tabHeight);
    }  
    
    difference() {
        roundedCube([halfSize*2,halfSize*2,height],5);
        well(1,1,1, halfSize*2-2,halfSize*2-2, 5);
        /* translate([halfSize,halfSize,0.20+0.28]) {
            rotate([0,0,45])
            linear_extrude(1)
                text(label, size = 5, halign="center",valign="center");
        } */
    }
    translate([halfSize,halfSize,0]) {
        tab(0);
        //tab(90);
        slot(180);
        //slot(270);
    }
    
    translate([halfSize*2 + 10,0,0]) {
        difference() {
            roundedCube([halfSize*2 + 2,halfSize*2 + 2, 3],5);
            translate([1+eps/2,1+eps/2,0.20+0.28]) 
                roundedCube([halfSize*2-eps,halfSize*2-eps,5],4);
        }
    }
    
}

module vpTray() {
    difference() {
        roundedCube([79,79,20],5);
        labeledWell("Vx1", 1,1,1, 38,38);
        labeledWell("Vx3", 40,1,1, 38,38);
        labeledWell("Vx5", 1,40,1, 38,38);
        labeledWell("Vx10", 40,40,1, 38,38);
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

//translate([0,0,0]) 
//factionTray("Japan","",Japan,1);
//translate([90,0,0]) 
//factionTray("North","America",NorthAmerica,1);
//translate([180,0,0]) 
//factionTray("S.America","& Africa",SouthAmericaAfrica,1);
//translate([270,0,0]) 
//factionTray("Asia","",Asia,1);
//translate([45,120,0]) 
//factionTray("China","",China,1);
//translate([45+90,120,0]) 
//factionTray("Russia","",Russia,1);
//translate([45+180,120,0]) 
//factionTray("Europe","",Europe,1);
//factionLid();
//moonTray();

resourceMoneySizes = [34, 38, 42, 46, 51 ];
resourceMoneyLabels = [ "1", "2", "5", "10", "25" ];
//resourceTray(false,true,45,resourceMoneySizes, "\U01f4b2", resourceMoneyLabels, 1); // cash
//translate([0,50,0]) r
// resourceTray(true,resourceMoneySizes, "\U01faa8", resourceMoneyLabels, 0, 7); // ore
//translate([0,100,0]) resourceTray(resourceMoneySizes, "\U01f525", resourceMoneyLabels); // fuel
//translate([0,150,0]) 
//resourceTray(false,resourceMoneySizes, "\U01f4a7", resourceMoneyLabels); // supplies

//translate([0,200,0]) 
//resourceTray( [70, 45, 40, 32, 24 ], "", ["0/1","2/3","4/5","6/7","8/9"] );
//resourceTray( [34, 28, 27, 30, 30, 30, 30], "", ["Px1","Px2","Px5","Vx1","Vx3","Vx5","V10"]);
    
//resourceTray(true,false,40,[30,16,16,28,37, 27,27,27,27], "", [ "Px1", "Px2","Px5", "H/T", "Dmg", "Vx1", "Vx3", "Vx5", "Vx10" ], 0, 7, 7);

f = 1;
st = 34;
rt = 45;
echo ("Should be 279: ",st + ((rt+4)*5));
//resourceTray(true,false,st,[40,35,35,45,56], "", [ "Px1", "Px2","Px5", "H/T", "Dmg"], f);
//translate([0,st+4,0]) 
resourceTray(true,true,rt,[70, 45, 40, 32, 24 ], "", ["0/1","2/3","4/5","6/7","8/9"], f );
//translate([0,st+4+(rt+4)*1,0]) resourceTray(true,true,rt,resourceMoneySizes,"\U01f4a7",resourceMoneyLabels,f);
//translate([0,st+4+(rt+4)*2,0]) resourceTray(true,true,rt,resourceMoneySizes,"\U01f525",resourceMoneyLabels,f);
//translate([0,st+4+(rt+4)*3,0]) resourceTray(true,true,rt,resourceMoneySizes,"\U01faa8",resourceMoneyLabels,f,9,7);
//translate([0,st+4+(rt+4)*4,0]) resourceTray(false,true,rt,resourceMoneySizes,"\U01f4b2",resourceMoneyLabels,f);
 

//, "Vx1", "Vx3", "Vx5", "Vx10" ], 0, 7, 7);
 
// miscTray();
//rotate([0,0,45]) miscTray();

//cup();

//vpTray();
worldCardTray2();

//translate([0,0,-14])
//factionTray("Test",[ ["One",1], ["Two",2], ["Three",3], ["Four",4] ]);