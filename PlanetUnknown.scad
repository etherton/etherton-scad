// Box is 98mm deep, SUSAN is 50mm deep
// Box is about 315mm interior.

// 146x288 - Corp Boards x 8
// Fractured corp is 148x148
// planet boards are 289x289
// moon boards are 153x153

module roundedCube(vec,rad=3) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

module well(x,y,z,w,h,rad = 3) {
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

module cornerBox1() {
    h1 = 68;
    h2 = 86;
    difference() {
        roundedCube([157,157,48]);
        translate([1,1,1]) roundedCube([77,h1,99]);
        translate([79,1,1]) roundedCube([77,h1,99]);
        translate([1,h1+2,1]) roundedCube([77,h2,99]);
        translate([79,h1+2,1]) roundedCube([77,h2,99]);
        translate([0,12,40]) cube([149,146,50]);
        translate([1,12,23.5]) cube([148,146,16.5]);
        ///translate([-10,79,10]) roundedCube([88,88,99]);
     }
}


module cornerBox2() {
    difference() {
        roundedCube([157,157,48]);
        for(r=[0:1]) {
            for (c=[0:2]) {
                translate([1+c*52,1+r*78,1])
                roundedCube([51,77,99]);
            }
        }
        translate([0,-1,40]) cube([149,146,50]);
        translate([1,-1,23.5]) cube([148,146,16.5]);
        //translate([1.5,1.5,18.5]) roundedCube([154,154,5]);
        //translate([4,4,10]) roundedCube([148,148,8.5]);
     }
    for(r=[0:1]) {
        for (c=[0:2]) {
            translate([11+c*52,11+r*78,1])
            roundedCube([51-20,77-20,4]);
        }
    }
}

module cornerBox3() {
    difference() {
        roundedCube([157,157,48]);
        translate([1,1,10]) roundedCube([155,155,99]);
        translate([11,11,-1]) roundedCube([135,135,99]);
        translate([0,-1,40]) cube([149,146,50]);
        translate([1,-1,23.5]) cube([148,146,16.5]);
        //translate([1.5,1.5,18.5]) roundedCube([154,154,5]);
        //translate([4,4,10]) roundedCube([148,148,8.5]);
     }
}

//cornerBox1();
//translate([0,158,0]) 
//cornerBox2();
cornerBox3();