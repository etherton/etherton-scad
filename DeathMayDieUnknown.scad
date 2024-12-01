$fn=60;

module fearUnknownTray() { 
  difference() {
    w = 130;
    h = 84;
    cube([w,h,14.6]);
    
    // ability tiles
    translate([1,1,0.6]) cube([47,33,99]);
    translate([10,-1,0.6]) cube([27,3,88]);
    
    // shortcuts
    translate([w-1-23-7/2,1,0.6]) cube([23,23,99]);
    translate([w-1-20-7/2,-1,0.6]) cube([17,3,99]);
    translate([w-1-30.4,1,14.6-2*2.3]) cube([30.4,30.4,99]);
    
    // gates + start
    translate([49+25,20,2.6]) cylinder(d=41,h=99);
    translate([49+25-10,-1,2.6]) cube([20,5,99]);
    
    // progress
    translate([w-4-30,30,14-2.3]) cylinder(d=61,h=99);
    
    small = 21;
    med = 25.6;
    
    // small hearts are 21, all others are 26
    
    // 3x gates
    translate([w-13,47,0.6+2.3*2]) cylinder(d=med,h=99);
    translate([w-5,47-10,0.6+2.3*2]) cube([6,20,99]);
    
    // 3x hearts
    for (i=[0:1]) {
        translate([14+27*i,h-13,0.6+2.3*2]) cylinder(d=med,h=99);
        translate([14+27*i-(med-10)/2,h-3,0.6+2.3*2]) cube([med-10,5,99]);
    }

    // 1x hearts
    for (i=[0:2]) {
        translate([w-(12+22*i),h-11,0.6]) cylinder(d=small,h=99);
        translate([w-(12+22*i)-(small-8)/2,h-3,0.6]) cube([small-8,5,99]);
    }
    
    // fire
    translate([13+14.5,35+13,0.6]) { cylinder(d=med,h=99); translate([0,0,-1]) cylinder(d=20,h=99); }
    translate([13+15+26,35+13,0.6]) { cylinder(d=med,h=99); translate([0,0,-1]) cylinder(d=20,h=99); }
  }
}


module deathMayDieTray() { 
  difference() {
    w = 116;
    h = 63;
    cube([w,h,21.6]);
    
    // ability tiles
    translate([1,1,5.6]) cube([47,33,99]);
    translate([10,-1,5.6]) cube([27,3,88]);
    
    // shortcuts
    translate([w-1-23-7/2,1,7.6]) cube([23,23,99]);
    translate([w-1-20-7/2,-1,7.6]) cube([17,3,99]);
    translate([w-1-30.4,1,21.6-2*2.3]) cube([30.4,30.4,99]);
    
    // progress
    translate([w-4-30,30,21.6-2.3]) cylinder(d=61,h=99);
    
    small = 21;
    med = 25.6;
    
    // small hearts are 21, all others are 26
    
    // gates x 3
    translate([49+13,13,21.6-2.3*4]) { cylinder(d=med,h=99); translate([-7,-15,0]) cube([14,5,99]); }
    
    // 3x hearts (8 total)
    translate([w-14,h-13,0.6]) { cylinder(d=med,h=99); translate([-7,10,0]) cube([14,5,99]); }
    translate([w-14-27,h-13,0.6]) { cylinder(d=med,h=99); translate([-7,10,0]) cube([14,5,99]); }

    // 1x hearts
    for (i=[0:1]) {
        translate([12+22*i,h-11,0.6]) cylinder(d=small,h=99);
        translate([12+22*i-(small-8)/2,h-3,0.6]) cube([small-8,5,99]);
    }
    
    // fire
    //translate([13+14.5,35+13,0.6]) { cylinder(d=med,h=99); translate([0,0,-1]) cylinder(d=20,h=99); }
    //translate([13+15+26,35+13,0.6]) { cylinder(d=med,h=99); translate([0,0,-1]) cylinder(d=20,h=99); }
  }
}

module ring(diam,wells) {
    difference() {
        cylinder(d=diam+4,h=3);
        translate([0,0,-1]) cylinder(d=diam-11,h=5);
        translate([0,0,0.6]) cylinder(d=diam+0.2,h=5);
    }
    translate([diam/2+1.5,0,0]) {
        th = 2.4;
        wa = 0.8;
        difference() {
            translate([0,-11,0]) cube([th*3+wa*4,22,6]);
            for (i=[0:wells-1])
                translate([wa + i * (th+wa),0,10]) rotate([0,90,0]) cylinder(d=21,h=th);
        }
    }
}

//ring();
//ring(25,3);
ring(45,4);

//deathMayDieTray();