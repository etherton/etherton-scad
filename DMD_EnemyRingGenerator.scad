
diameter = 25; // [25,45,50]

slots = 3; // [1,2,3,4,5,6,7,8]

$fn=60;

module ring(diam,wells) {
    difference() {
        cylinder(d=diam+4,h=3);
        translate([0,0,-1]) cylinder(d=diam-11,h=5);
        translate([0,0,0.6]) cylinder(d=diam+0.2,h=5);
    }
    translate([diam/2+1.5,0,0]) {
        th = 2.4;
        wa = 0.8;
        difference() {
            translate([0,-11,0]) cube([th*3+wa*4,22,6]);
            for (i=[0:wells-1])
                translate([wa + i * (th+wa),0,10]) rotate([0,90,0]) cylinder(d=21,h=th);
        }
    }
}

ring(diameter, slots);
