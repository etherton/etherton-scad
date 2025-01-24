difference() {
$fn=120;
    translate([0,0,-2.5]) cylinder(h=5,d=34);
    translate([0,0,-5]) cylinder(h=10,d=25);
    rotate_extrude() translate([34/2, 0, 0]) circle(d=4);
    translate([-5,10,-5]) cube([10,20,10]);
}


// 32 39 25