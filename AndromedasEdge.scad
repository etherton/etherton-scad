// Andromeda's Edge
// Extra Draft, first layer 0.2, others 0.28

wall = 0.8;
flr = 0.2 + 0.28*2;


module playerTray() {
    w = wall*3 + 87 + 44;
    h = wall*4 + 34 + 8.4 + 13;
    m = 4;
    difference() {
        cube([w,h,19.4+flr]);
        translate([wall,wall,flr]) cube([87,34,99]);
        translate([wall,wall*2+34,flr]) cube([74,8.4,99]);
        translate([wall,wall*3+34+8.4,6]) cube([74,13,99]);
        translate([wall*2+87,wall,flr+1]) cube([44,h-wall*2,99]);
        translate([wall,wall,10]) cube([74,h-wall*2,99]);
        translate([wall+72+wall,,wall+34+wall,10]) cube([30,8.4+13+wall,99]);
        //translate([75.6,46.6,8.4+flr]) rotate([0,90,0]) cylinder(h=12,d=17,$fn=60);
        translate([w - wall - m - 18/2,wall + 18/2,flr]) cylinder(h=99,d=16);
        translate([w - wall - m - 18/2,wall + 18*1.5,flr]) cylinder(h=99,d=16);
        translate([w - wall - m -18/2,wall + 18*2.5,flr]) cylinder(h=99,d=16);
        translate([w - wall - m - 18 * 1.5,wall + 18/2,flr]) cylinder(h=99,d=16);
        translate([w - wall - m - 18 * 1.5,wall + 18*1.5,flr]) cylinder(h=99,d=16);
        translate([w - wall - m - 18 * 1.5,wall + 18*2.5,flr]) cylinder(h=99,d=16);
    }
}

//playerTray();

module resourceTray() {
    wells = 5;
    h = 37 - wall*2;
    difference() {
        cube([296,h + wall*2,20+flr]);
        translate([wall,wall,flr]) cube([55,h,99]);
        translate([wall+55+wall,wall,flr]) cube([45,h,99]);
        translate([wall+55+wall+45+wall,wall,flr]) cube([45,h,99]);
        translate([wall+55+wall+45+wall+45+wall,wall,flr]) cube([65,h,99]);
        translate([wall+55+wall+45+wall+45+wall+65+wall,wall,flr]) 
            cube([296-wall*6-65-55-45-45,h,99]);
    }
}

//rotate([0,0,45]) resourceTray();

module squareCardAndPunchoutTray() {
    w = 46 * 4 + wall * 5;
    h = wall*4 + 61 + 57 + 46;
    
    difference() {
        cube([w,h,flr+11]);
        for (i=[0:3]) {
            translate([wall+(46+wall)*i,wall,flr]) cube([46,46,99]);
            translate([wall+(46+wall)*i + 10,wall+10,-1]) cube([26,26,99]);
        }
        translate([wall,46+wall*2,flr]) cube([36,70+wall,99]);
        translate([wall+36+wall,46+wall*2,flr]) cube([46,39,99]);
        translate([wall,wall+46+wall+70+wall*2,flr]) cube([46+36+wall,47,99]);
        translate([wall+36+wall,46+39+wall*3,flr]) cube([46,31,99]);
        translate([wall+36+wall+46+wall,46+wall*2,flr]) {
            cube([51,57,99]);
            translate([0,57+wall,0]) cube([51,61,99]);
        }
        translate([wall+36+wall+46+wall+51+wall,46+wall*2,flr]) {
            cube([51,57,99]);
            translate([0,57+wall,0]) cube([51,61,99]);
        }
    }
}

//squareCardAndPunchoutTray();

module hexTray() {
    module hex() {
        linear_extrude(99) polygon([
            [0,20], [0,61], [54,82], [108,61], [108,20], [54,0]]);
        translate([54,41,-1]) cylinder(h=2,d=40);
    }
    difference() {
        cube([wall*3+108*2,152+wall+wall,19.4+flr]);
        //cube([wall*4+108*3,152+wall+wall,19.4+flr]);

        // card well and finger hole
        translate([wall,81,flr]) cube([46,69,99]);
        translate([wall+46/2,81+69/2,-1]) cylinder(h=2,d=30);

        // hexes
        translate([wall,wall,flr]) hex();
        translate([wall+108+wall,wall,flr]) hex();
        translate([wall+108+wall+108+wall,wall,flr]) hex();
        translate([wall+54,wall+63,flr]) hex();
        translate([wall+54+wall+108,wall+63,flr]) hex();
        
        // large circle and scrapyard
        translate([wall+46+wall+152/2,wall+152/2,flr+13.7]) cylinder(h=99,d=152);
        translate([wall+46+wall,wall,flr+13.7+2.7]) cube([152,152,99]);
        
    }
}

//hexTray();

module tileAndCards() {
    difference() {
        cube([53+wall+wall,wall+40.4+wall+40.4+wall+45.4+wall,46]);
            translate([wall,wall,flr]) cube([30,45.4,99]);
            translate([wall+30+wall,wall,flr]) cube([13,45.4,99]);
            translate([wall+30+wall+13+wall,wall,flr]) cube([10-wall-wall,45.4,99]);
        translate([wall,wall+45.4+wall,flr]) cube([53,40.4,99]);
        translate([wall,wall+45.4+wall+40.4+wall,flr]) cube([53,40.4,99]);
    }
} 

tileAndCards();