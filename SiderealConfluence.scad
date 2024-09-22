// Sidereal Confluence

wall = 0.6;

module roundTokens(bays,d=27.8,heights=[19.8]) {
    difference() {
        totalWidth = (d + wall)*bays + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,heights[0]+wall*2]);
        for (i=[0:bays-1]) {
            h = len(heights)>1? heights[i] : heights[0];
            x = i * (d + 0.6) + 0.6;
            if (i!=5) {
                translate([x+d/2,d/2+1,wall]) cylinder(h=h,d=d);
                translate([x,d/2+1,wall]) cube([d,99,h]);
            }
            else {
                translate([x,wall,wall]) cube([d,99,h]);
            }
            translate([x+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}

module squareTokens() {
    difference() {
        d = 27.8;
        d2 = 25;
        totalWidth = ((d+wall)*3 + (d2+wall)) + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,13+wall*2]);
        for (i=[0:2]) {
            translate([wall+(d+wall)*i,wall,wall]) cube([d,99,i!=2?13:4.6]);
            translate([wall+d/2 + (d+wall)*i,d,-1]) cylinder(h=99,d=d*0.75);
        }
        translate([wall+(d+wall)*2 + (d-d2)/2,wall+(d-d2),wall+4.6])
            cube([d2,99,13-4.6]);
        o = (d+wall)*3 + wall;
        translate([o,wall+(d-d2),wall]) cube([d2,99,11.4]);
        translate([o+d2/2,d,-1]) cylinder(h=99,d=d2*0.75);
    }
}

module caylionTokens() {
    d=28;
    d2=40.4;
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

module resourceTray() {
    difference() {
        cube([88*3+wall*4,64.2,13]);
        for (i=[0:2]) {
            translate([wall+(88+wall)*i,wall,wall]) cube([88,63,99]);
            translate([wall+(88+wall)*i+20,-1,6]) cube([48,99,99]);
        }
        translate([-1,20,6]) cube([300,24.2,99]);
    }
}

module victoryPointsAndShips() {
    wells = [33,22,11,32,24,30,30];
    offsets = [0, 33+wall, 55+wall*2, 66+wall*3, 98+wall*4, 122+wall*5,
        152+wall*6, 182+wall*7];
    totalHeight = 182+wall*8;
    d=28;
    d2=27;
    difference() {
        cube([d+wall+wall,d*.55,totalHeight]);
        for (i=[0:len(wells)-1])
            translate([wall,wall,wall+offsets[i]]) {
                translate([d/2,d/2,0]) cylinder(h=wells[i],d=(i<4?d:d2),$fn=(i<4)?30:6);
                translate([0,d/2,0]) cube([d,99,wells[i]]);
            }
     }
}

// rotate([90,0,0]) roundTokens(6); // Kit - Orange

// rotate([90,0,0]) roundTokens(2); // Grand Fleet - Sky blue

// rotate([90,0,0]) squareTokens(); // Faderon - Yellow

// rotate([90,0,0]) caylionTokens(); // Caylion - Green

// rotate([90,0,0]) roundTokens(2,27.8,[19.8,17.6]); // Eni Et Service Tokens

// rotate([90,0,0]) roundTokens(2,32.0); // Zeth Tokens

//rotate([0,0,45]) resourceTray();

rotate([0,0,45]) rotate([90,0,0]) victoryPointsAndShips();

// x5 trays
/*rotate([90,0,0]) difference() {
    cube([63+wall*2,30,19.8+wall*2]);
    translate([wall,wall,wall]) cube([63,99,19.8]);
}*/
    