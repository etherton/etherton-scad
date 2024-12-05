

rotate([0,0,45]) {
    difference() {
        cube([300,34.2+7,230]);
        translate([-1,5,-1]) cube([121,34.2,999]);
        translate([130,0,0]) rotate([0,0,-78]) cube([999,999,999]);
        translate([-5,-5,0]) cube([20,15,0.2]);
    }
    translate([-3,-3,0]) cube([20,11,0.2]);
    translate([-3,36,0]) cube([20,8,0.2]);

}

