// Mini Fridge

module halfSphere(rad) { 
    difference() {
        sphere(rad);
        translate([0,0,-rad]) cube([rad*2,rad*2,rad*2],center=true);
    }
}


module body() {
    hull() {
        translate([7,64.5,0]) cylinder(h=38.8,r=7);
        translate([40.4-7,64.5,0]) cylinder(h=38.3,r=7);
        cube([40.4,1,38.8]);
    }
    translate([2,3,38.8]) cube([40.4-4,65,1]);
    translate([0,1,39.8]) {
        hull() {
            translate([7,7,0]) halfSphere(7);
            translate([40.4-7,7,0]) halfSphere(7);
            translate([7,64.0,0]) halfSphere(7);
            translate([40.4-7,64.0,0]) halfSphere(7);
        }
    }
    translate([40.4/2,44,39.8+7]) {
        cube([13,2,2]);
    }
    translate([40.4/2,55,39.8+7])
        linear_extrude(height=0.6)
            text(text="S  M  U  G",halign = "center",size=3);
}

difference() {
    rotate([90,0,0]) body();
    translate([3,-37,5]) cube([40.4-6,35,99]);
}
