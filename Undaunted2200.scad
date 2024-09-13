// Undaunted 2200

module trayOne() {
    depth = 20;
    height = 50;
    difference() {
        cube([88,height,depth]);
        translate([14,height-14,depth-16.4]) cylinder(h=depth,d=30.4);
        translate([44,height-14,depth-14.6]) cylinder(h=depth,d=30.4);
        translate([74,height-14,depth-14.6]) cylinder(h=depth,d=30.4);
        translate([66,-2,4]) rotate([0,0,10]) cube([20.4,20.4,depth]);
        translate([16,8,depth-14]) cylinder(h=depth,d=27,$fn=6);
        translate([46,8,depth-12]) cylinder(h=depth,d=27,$fn=6);
    }
}

module trayTwo() {
    depth = 28;
    height = 45;
    difference() {
        cube([86,height,depth]);
        translate([12,9,depth-14.6]) cylinder(h=depth,d=20.4);
        translate([12,height-9,depth-14.6]) cylinder(h=depth,d=20.4);
        translate([1,(height-9)/2,depth-9]) cube([31,9,depth]);
        translate([34,9,depth-14.6]) cylinder(h=depth,d=20.4);
        translate([34,height-9,depth-14.6]) cylinder(h=depth,d=20.4);
        translate([56,9,28-14.6]) cylinder(h=depth,d=20.4);
        translate([56,height-9,depth-14.6]) cylinder(h=depth,d=20.4);
        translate([40,(height-9)/2,depth-20]) cube([21,9,depth]);
        translate([76,height/2,depth-4]) cylinder(h=depth,d=26);
        translate([78,height/2,depth-4-12]) cylinder(h=depth,d=20.4);
    }
}

trayOne();
// trayTwo();