
// Diameter of Base (in mm)
diameter = 25; // [25,45,50,60]

// Number of token slots
slots = 3; // [1,2,3,4,5,6,7,8]

// Base extra margin (in mm)
ringTolerance = 0.2; // [0,0.1,0.2,0.3,0.4,0.5,0.6]

// Token slot extra margin (in mm)
tokenTolerance = 0.1; // [0,0.1,0.2,0.3,0.4]

module ring(diam,wells) {
    difference() {
        cylinder(d=diam+4,h=3,$fn=diam*2);
        translate([0,0,-1]) cylinder(d=diam-11,h=5,$fn=diam*2);
        translate([0,0,0.6]) cylinder(d=diam+ringTolerance,h=5,$fn=diam*2);
    }
    translate([diam/2+1.5,0,0]) {
        th = 2.3 + tokenTolerance;
        wa = 0.8;
        difference() {
            translate([0,-11,0]) cube([th*wells+wa*(wells+1),22,6]);
            for (i=[0:wells-1])
                translate([wa + i * (th+wa),0,10]) rotate([0,90,0]) cylinder(d=21,h=th);
        }
    }
}

ring(diameter, slots);
