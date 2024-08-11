// Fit four standard decks of 89x63mm cards and multiple token types.

difference() {
    cube([92+91,66+65,23]);
    translate([1,1,1]) cube([90,64,22]);
    translate([1,66,1]) cube([90,64,22]);
    translate([92,1,1]) cube([90,64,22]);
    translate([92,66,1]) cube([90,64,22]);
    translate([0,33,21]) rotate([0,90,0]) cylinder(r=20,h=5);
    translate([0,33+65,21]) rotate([0,90,0]) cylinder(r=20,h=5);
    translate([92+90,33,21]) rotate([0,90,0]) cylinder(r=20,h=5);
    translate([92+90,33+65,21]) rotate([0,90,0]) cylinder(r=20,h=5);

}