// sticker holder

rotate([60,0,0]) {
    difference() {
        cube([100,95,20]);
        translate([1,1,1]) cube([98,99,18]);
        translate([50,95,19]) scale([1,1.8,1]) cylinder(d=85,h=3);
    }
}
rotate([90,0,0]) rotate([0,90,0]) linear_extrude(20) polygon([ [0,0], [50,0], [5,10] ]);

translate([80,0,0]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(20) polygon([ [0,0], [50,0], [5,10] ]);
