// Sidereal Confluence

wall = 0.6;

module roundTokens(bays) {
    difference() {
        d = 27.8;
        totalWidth = (d + wall)*bays + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,19.8+wall*2]);
        for (i=[0:bays-1]) {
            x = i * (d + 0.6) + 0.6;
            if (i!=5) {
                translate([x+d/2,d/2+1,wall]) cylinder(h=19.8,d=d);
                translate([x,d/2+1,wall]) cube([d,99,19.8]);
            }
            else {
                translate([x,wall,wall]) cube([d,99,19.8]);
            }
            translate([x+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}

module squareTokens() {
    difference() {
        d = 27.8;
        d2 = 25;
        totalWidth = ((d+wall) + (d2+wall)) * 2 + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,15.6+wall*2]);
        for (i=[0:1]) {
            translate([wall+(d+wall)*i,wall,wall]) cube([d,99,15.6]);
            translate([wall+d/2 + (d+wall)*i,d,-1]) cylinder(h=99,d=d*0.75);
        }
        o = (d+wall) * 2 + wall;
        for (i=[0:1]) {
            translate([o+(d2+wall)*i,wall+(d-d2),wall]) cube([d2,99,!i?13.2:11.4]);
            translate([o+d2/2 + (d2+wall)*i,d,-1]) cylinder(h=99,d=d2*0.75);
        }
    }
}

module caylionTokens() {
    d=27.8;
    d2=40.2;
    totalWidth = wall + d + (d2+wall)*3 + wall;
    echo(totalWidth);
    difference() {
        cube([totalWidth,d+wall,13 + wall*2]);
        // x2 tokens
        translate([wall,d/2+1,wall]) cube([d,99,13]);
        translate([wall+d/2,wall+d/2,wall]) cylinder(h=13,d=d);
        translate([wall+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        // votes
        for (i=[0:2]) {
            translate([wall+d+wall+(i*(d2+wall)),wall,wall]) cube([d2,99,i==2?11.2:13]);
            translate([wall+d+wall+(i*(d2+wall)+d2/2),d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}

// rotate([90,0,0]) roundTokens(6); // Kit - Orange

// rotate([90,0,0]) roundTokens(2); // Grand Fleet - Sky blue

rotate([90,0,0]) squareTokens(); // Faderon - Yellow

// rotate([90,0,0]) caylionTokens(); // Caylion - Green