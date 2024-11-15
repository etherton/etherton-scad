



module terrainTray() {
    chips = 12.4; // 12.2 + slop
    terrain = 12.6; // 12.4 + 
    difference() {
        cube([124,142,26]);
        //cylinder(h=26,d=144,$fn=6);
        translate([62,71,13]) rotate([0,0,30]) cylinder(h=26,d=142,$fn=6);
        
        translate([62,71-43,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62,71,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62,71+43,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62+38,71+22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62+38,71-22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62-38,71+22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62-38,71-22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
    }
}

//terrainTray();

module trayBand() {
    th = 0.5;
    difference() {
        cube([150+th*2,23+th*2,10]);
        translate([th,th,-1])cube([150,23,99]);
    }
}

//trayBand();

module roundTokenTray() {
    difference() {
        cube([2+40.4*4,128,13]);
        for (i=[0:5]) {
            for (j=[0:2]) {
                translate([i*27+14,1+(127/3)*j,13+0.6]) 
                    rotate([-90,0,0]) cylinder(d=26,h=(127/3)-1);
            }
        }
    }
    for (i=[0:5]) {
        for (j=[0:3]) {
            translate([i*27+14,(127/3)*j,13+0.6]) 
                rotate([-90,0,0]) difference() { cylinder(d=26,h=1); cylinder(d=13,h=1); }
        }
    }
}

//roundTokenTray();

module chipTray() {
    difference() {
        cube([1+40.4*4+1,128,20]);
        for (i=[0:3]) {
            for (j=[0:2]) {
                translate([1+i*40.4+20.2,1+j*(127/3),20+0.6]) 
                    rotate([-90,0,0]) cylinder(d=40.4,h=(127/3)-1,$fn=60);
            }
        }
    }
    for (i=[0:3]) {
        for (j=[0:3]) {
            translate([1+i*40.4+20.2,j*(127/3),20+0.6]) 
                rotate([-90,0,0]) difference() { cylinder(d=40.4,h=1,$fn=60); cylinder(d=27,h=1); }
        }
    }
}

// chipTray();

// roundTokenTray();


module cubeDiceTray() {
    rad=5;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    module roundedWell(w,h) {
        hull() {
            translate([rad,rad,rad]) sphere(rad);
            translate([w-rad,rad,rad]) sphere(rad);
            translate([w-rad,h-rad,rad]) sphere(rad);
            translate([rad,h-rad,rad]) sphere(rad);
            translate([rad,rad,99]) sphere(rad);
            translate([w-rad,rad,99]) sphere(rad);
            translate([w-rad,h-rad,99]) sphere(rad);
            translate([rad,h-rad,99]) sphere(rad);
        }
    }
    difference() {
        roundedCube([150,170,22.4]);
        translate([1,170-41,0.6]) roundedCube([31,40,99]);
        translate([1+5,170-41+5,-1]) roundedCube([21,30,99]);
        translate([1,170-61,0.6]) roundedWell(31,19);
        translate([33,170-61,0.6]) roundedWell(37,60);
        translate([33+37+1,170-61,0.6]) roundedWell(77,60);
        for (i=[0:1]) {
            for (j=[0:3]) {
                translate([1+j*((150-5)/4+1),47+31*i,0.6]) roundedWell(145/4,30);
            }
        }
        translate([1,1,0.6]) roundedWell(44,45);
        translate([46,1,0.6]) roundedWell(51,45);
        translate([98,1,0.6]) roundedWell(51,45);
        
    }
}

// cubeDiceTray();

module cardTray() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    difference() {
        roundedCube([136,128,45]);
        translate([1,1,0.6]) roundedCube([36,91,99]);
        translate([99,36,0.6]) roundedCube([36,91,99]);
        //translate([93,1,0.6]) roundedCube([48,40,99]);
        //translate([93,41,0.6]) roundedCube([44,40,99]);
        translate([1,93,0.6]) roundedCube([48,34,99]);
        translate([50,93,0.6]) roundedCube([48,34,99]);
        translate([87,1,0.6]) roundedCube([48,34,99]);
        translate([38,1,0.6]) roundedCube([48,34,99]);
        translate([38,36,0.6]) roundedCube([48,20,99]);
        translate([38,57,0.6]) roundedCube([48,35,99]);
        translate([87,36,0.6]) roundedCube([10,56,99]);
    }
}

cardTray();