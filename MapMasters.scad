// Map Masters

module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

/* difference() {
    roundedCube([68,110,16],5);
    translate([0.8,0.8,0.8]) roundedCube([68-1.6,30,99],5);
    translate([0.8,31.6,0.8]) roundedCube([68-1.6,110-30-2.4,99],5);
} */

difference() {
    ra = 25.6/2;
    roundedCube([68,110,16],5);
    translate([ra,ra,6]) cylinder(r=ra+0.5,h=10);
    translate([68-ra,ra,6]) cylinder(r=ra+0.5,h=10);
    translate([ra,110-ra,6]) cylinder(r=ra+0.5,h=10);
    translate([68-ra,110-ra,6]) cylinder(r=ra+0.5,h=10);

}