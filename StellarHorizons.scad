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

module labeledWell(f,label,x,y,z,w,h) {
    if (f == 0)
        well(x,y,z,w,h);

    if (is_list(label)) {
        s = max(len(label[0]),len(label[1]));
        translate([x+w/2,y+h/2+0.5,z-0.4])
            linear_extrude(f == 0? 1 : 0.4)
                text(label[0],size = w / s,halign="center",valign="bottom");
        translate([x+w/2,y+h/2-0.5,z-0.4])
            linear_extrude(f == 0? 1 : 0.4)
                text(label[1],size = w / s,halign="center",valign="top");
    }
    else {
        translate([x+w/2,y+h/2,z-0.4])
            linear_extrude(f == 0? 1 : 0.4)
                text(label,size = w / len(label),halign="center",valign="center");
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
module resourceTray(topTab,bottomTab,h,sizes,prefix,labels,f=0,labelSize=9,prefixSize=9,depth=20) {
    fl = 1;
    function computeOffset(l,c) = c==0? 1 : (l[c-1] + 1 + computeOffset(l,c-1));
    function computeSize(l,c) = l[c] + (c==0? 1 : (1 + computeSize(l,c-1)));
    w = 217;
    vCell = h - 2;
    
    module doLabel(f,offset,col) {
        if (len(prefix))
            translate([offset + 2*sizes[col]/6,1 + vCell/2,0.6])
                linear_extrude(f==0?1:0.4) 
                    text(prefix,prefixSize,font="Noto Emoji:style=Bold",
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
                roundedCube([w,h,depth],5);
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

// WORLD CARD TRAY PRINTS IN DRAFT
module worldCardTray3() {
    e = 9;
    difference() {
        roundedCube([108,78,20],5);
        translate([1,(77-55)/2,0.2 + 0.28]) rotate([90,0,90]) linear_extrude(106) polygon([
            [e,0], [0,e], [0,99], [55,99], [55,e], [55-e,0] ]);
    }
}

shearYZ = 0.4;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;


module factionTray(fname, units, f = 0, split = 6) {
    unitSep = 7;
    function computeOffset(l,c) = 
        (c==0||c==split)? 3 : 
            (l[c-1].y * 2.2 + unitSep + computeOffset(l,c-1));
    function countUnits(l,c) =
        l[c].y + ((c==0)? 0 : countUnits(l,c-1));
    function adjust(y) = y * 2.2 + 0.4;
    
    cw = 26;

    module renderLabels(offset,thick) {
        for (i=[0:len(units)-1]) {
            name = units[i].x;
            size = adjust(units[i].y);
            xOffset = (i<split)? 1 : w-cw-1;
            yOffset = computeOffset(units,i);    
            translate([xOffset+cw/2,yOffset+4,depth+offset]) linear_extrude(thick) 
                text(name,size=i==5?4.5:5.5,halign="center",valign="top");
        }
        translate([cw/2,(computeOffset(units,split-1) + adjust(units[split-1].y + 2) + h)/2,depth+offset])
            rotate([0,0,90]) {
        if (is_string(fname)) 
            linear_extrude(thick)
                text(fname,size=7,halign="center",valign="center");
        else if (len(fname)==2) {
            translate([0, +0.5,0]) linear_extrude(thick)
                text(fname[0],size=6,halign="center",valign="bottom");
            translate([0, -0.5,0]) linear_extrude(thick)
                text(fname[1],size=6,halign="center",valign="top");
        }
        else if (len(fname)==3) {
            translate([0, +4,0]) linear_extrude(thick)
                text(fname[0],size=6,halign="center",valign="bottom");
            translate([0, 0,0]) linear_extrude(thick)
                text(fname[1],size=6,halign="center",valign="center");
            translate([0, -4,0]) linear_extrude(thick)
                text(fname[2],size=6,halign="center",valign="top");
        }
    }
    }

    assert(countUnits(units,len(units)-1) == 33, "Wrong number of units");
    w = 86;
    h = 110;
    depth = 15;
    if (f==0) {
        difference() {            
            roundedCube([w,h,depth],rad=2);
            for (i=[0:len(units)-1]) {
                size = adjust(units[i].y);
                xOffset = (i<split)? 1 : w-cw-1;
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
    nc = floor(max(w,h) / size2) + 2;
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


// lid adds 1mm of height
//6 cups is 
// (6 * (50+4)) = 324
// CUP PRINTS IN DRAFT
module cup(halfHeight = 25, halfWidth = 25,depth = 35, tabHeight = 5) {
    eps = 0.2;
    module tab(rot) {
        rotate([0,0,rot]) translate([halfWidth,0,0]) tabPart(tabHeight, eps);
    }
    module slot(rot) {
        rotate([0,0,rot]) translate([halfWidth,0,0]) slotPart(tabHeight);
    }  
    
    difference() {
        union() {
            roundedCube([halfWidth*2,halfHeight*2,depth],5);
            translate([halfWidth/2,-1,0]) cube([halfWidth,1,3]);
            translate([halfWidth/2,halfHeight*2,0]) cube([halfWidth,1,3]);
        }
        well(1,1,1, halfWidth*2-2,halfHeight*2-2, 5);
        /* translate([halfSize,halfSize,0.20+0.28]) {
            rotate([0,0,45])
            linear_extrude(1)
                text(label, size = 5, halign="center",valign="center");
        } */
    }
    translate([halfWidth,halfHeight,0]) {
        tab(0);
        slot(180);
    }
    
    translate([-1,halfHeight*2 + 10,0]) {
        difference() {
            roundedCube([halfWidth*2 + 2,halfHeight*2 + 2, 3],5);
            translate([1-eps/2,1-eps/2,0.20+0.28]) 
                roundedCube([halfWidth*2+eps,halfHeight*2+eps,5],4);
        }
    }
    
}

// HEX TRAY PRINTS IN DRAFT
module anotherHexTray() {
    module rt() {  
        a1 =  -90;
        b1 = -75;
        translate([-1,0.5,0]) linear_extrude(16) offset(r=3) polygon([ [a1,b1], [a1,-9], [a1-b1/2,b1] ]);
    }
    difference() {
        translate([-193/2,-159/2,0]) roundedCube([193,159,16],5);
        translate([0,0,0.2+0.28]) {
            cylinder(d=180,h=99,$fn=6);
            rt();
            scale([1,-1,1]) rt();
            scale([-1,-1,1]) rt();
            scale([-1,1,1]) rt();
        }
        translate([0,0,-1]) cylinder(d=160,h=99,$fn=6);
    }
}

module vpTray(f=0) {
    cx = 53;
    cy = 37;
    module labels(f) {
        labeledWell(f,"Vx1", 1,1,1, cx,cy);
        labeledWell(f,"Vx3", cx+2,1,1, cx,cy);
        labeledWell(f,"Vx5", 1,cy+2,1, cx,cy);
        labeledWell(f,"Vx10", cx+2,cy+2,1, cx,cy);
    }
    if (f)
        labels(f);
    else {
        difference() {
            roundedCube([109,77,30],5);
            labels(f);
        }
    }
}

module smallTray(nw) {
    w = 109;
    c = (w - (nw+1)) / nw;
    difference() {
        roundedCube([109,40,28],5);
        for (i=[0:nw-1])
            well((c+1)*i+1,1,1,c,38);
    }
}

// DICE TRAY PRINTS IN DRAFT
module diceTray(w = 190, h = 82, d = 27) {
    th = 0.2 + 0.28 * 2;
    difference() {
        roundedCube([w,h,d],5);
        translate([1,1,th]) roundedCube([w-2,h-2,99],5);
        translate([5,5,-1]) cube([w-10,h-10,99]);
    }
    translate([5,5,0]) meshWallXY(w-10,h-10,th,0,10,15);
}

// Print this tray in DRAFT
module anotherMiscTray(flag) {
    w = 160;
    h = 82;
    cx = (w-4)/3;
    cy = (h-3)/2;
    th = 0.20 + 0.28;
    d = 17;
    eps = 0.2;
    union() {
        difference() {
            roundedCube([w,h,d],5);
            well(1,1,th, cx,cy);
            well(1,cy+2,th, cx,cy);
            well(cx+2,1,th, cx,cy);
            well(cx+2,cy+2,th, cx,cy);
            well(cx+cx+3,1,th, cx,cy);
            well(cx+cx+3,cy+2,th, cx,cy);
            if (flag==0)
                translate([w/2-15,h/2-0.5,-1]) cube([30,1,2]);
        }
        if (flag==1)
            translate([w/2-15+eps/2,h/2-0.5+eps/2,d]) cube([30-eps,1-eps,1-eps]);
    }
}

// total depth is 62mm; these are 26, so cups need to be 36 incl lid
module structureTray(f,labels) {
    module labels(f) {
        labeledWell(f,labels[0],1,1,1, cx,cy);
        labeledWell(f,labels[1],2+cx,1,1, cx,cy);
        labeledWell(f,labels[2],3+cx*2,1,1, cx,cy);
    }
    cx = (179 - 4) / 3;
    cy = 50;
    if (f==0) {
        difference() {
            roundedCube([179,52,26],5);
            labels(f);
        }
    }
    else
        labels(f);
}

module smallHexTray() {
    difference() {
        cylinder(d=181,h=17,$fn=6);
        translate([0,0,-1]) cylinder(d=160,h=99,$fn=6);
        translate([0,0,1]) cylinder(d=180,h=99,$fn=6);
    }
}

module bigHexTray() {
    difference() {
        cylinder(d=235,h=21,$fn=6);
        translate([0,0,0.6]) cylinder(d=180,h=99,$fn=6);
        translate([0,0,16.6]) cylinder(d=234,h=99,$fn=6);
        translate([0,0,-1]) cylinder(d=160,h=99,$fn=6);
        for (i=[30:60:330])
            rotate([0,0,i]) translate([80,0,-1]) linear_extrude(99)
                polygon([ [0,45], [20,56], [20,-56], [0,-45] ]);
    }
}

module spacerPart1() {
    difference() {
        union() {
            translate([0,9,0]) cube([42,16,16]);
            translate([42,0,0]) cube([108,25,16]);
            translate([150-16,25,0]) cube([16,50,16]);
        }
        translate([100,5,14]) cube([10,2,99]);
        translate([130,5,14]) cube([10,2,99]);
    }
}

module spacerPart2() {
    translate([100.1,5.1,14.2]) cube([9.8,1.8,1.8]);
    translate([131.1,5.1,14.2]) cube([9.8,1.8,1.8]);
    translate([42+43,0,16]) linear_extrude(4) polygon([ [0,25], [5,25], [43,0], [0,0] ]);
    translate([42,0,16]) linear_extrude(4) polygon([ [54,0], [54+120,66], [54+120,-60], [54+62,-60], [54+62,0] ]);
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

//translate([0,0,0]) factionTray("Japan",Japan,0);
//translate([130,0,0]) factionTray(["North","America"],NorthAmerica,0);
//translate([260,0,0]) factionTray(["South","America","& Africa"],SouthAmericaAfrica,0);
//translate([390,0,0]) factionTray("Asia",Asia,0);
//translate([45,120,0]) factionTray("China",China,0);
//translate([45+130,120,0]) factionTray("Russia",Russia,0);
//translate([45+260,120,0]) factionTray("Europe",Europe,0);
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
//resourceTray(true,true,rt,[70, 45, 40, 32, 24 ], "", ["0/1","2/3","4/5","6/7","8/9"], f );
//translate([0,st+4+(rt+4)*1,0]) 
//resourceTray(true,true,rt,resourceMoneySizes,"\U01f4a7",resourceMoneyLabels,f); // supplies
//translate([0,st+4+(rt+4)*2,0]) 
//resourceTray(true,true,rt,resourceMoneySizes,"\U01f525",resourceMoneyLabels,f); // fuel
//translate([0,st+4+(rt+4)*3,0]) 
//resourceTray(true,true,rt,resourceMoneySizes,"\U01faa8",resourceMoneyLabels,f,9,7); // ore
//translate([0,st+4+(rt+4)*4,0]) 
//resourceTray(false,true,rt,resourceMoneySizes,"\U01f4b2",resourceMoneyLabels,f); // cash
 
 
// resourceTray(false,false,79,[70,50,46,46], "", ["1x/2x", "3x/4x", "5x/10x", "15x/20x" ], labelSize=7.5, f=1, depth=22);

//, "Vx1", "Vx3", "Vx5", "Vx10" ], 0, 7, 7);
 
// miscTray();
//rotate([0,0,45]) miscTray();
//smallTray(4);
cup(halfWidth=40);
//anotherHexTray();
//diceTray(); // bottom layer
//diceTray(110,96,32); // top layer
// anotherMiscTray(0);
// translate([0,90,0]) anotherMiscTray(1);
// vpTray(1);
//worldCardTray3();
//structureTray(1,[ ["Research","Station"], ["Supply","Station"], "Spaceport"]);
//structureTray(1,[ ["Defense","Network"], ["Mining","Station"],"Refinery"]);

//smallHexTray();
//smallTray(3);/
///spacerPart1();
//rotate([180,0,0]) spacerPart2();
//bigHexTray();

//translate([0,0,-14])
//factionTray("Test",[ ["One",1], ["Two",2], ["Three",3], ["Four",4] ]);