// Andromeda's Edge
// Extra Draft, first layer 0.2, others 0.28

wall = 0.8;
flr = 0.2 + 0.28*2;


module playerTray() {
    w = wall*3 + 87 + 43;
    h = wall*4 + 34 + 8.4 + 13;
    m = 4;
    difference() {
        cube([w,h,19.4+flr]);
        translate([wall,wall,flr]) cube([87,34,99]);
        translate([wall,wall*2+34,flr]) cube([74,8.4,99]);
        translate([wall,wall*3+34+8.4,6]) cube([74,13,99]);
        translate([wall*2+87,wall,flr+1]) cube([43,h-wall*2,99]);
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
        cube([296,h + wall*2,28.4]);
        translate([wall,wall,flr]) cube([55,h,99]);
        translate([wall+55+wall,wall,flr]) cube([45,h,99]);
        translate([wall+55+wall+45+wall,wall,flr]) cube([45,h,99]);
        translate([wall+55+wall+45+wall+45+wall,wall,flr]) cube([55,h,99]);
        translate([wall+55+wall+45+wall+45+wall+55+wall,wall,flr]) cube([25,h,99]);
        translate([wall+55+wall+45+wall+45+wall+55+wall+25+wall,wall,flr]) 
            cube([296-wall*7-55-45-45-55-25,h,99]);
    }
}

// rotate([0,0,45]) resourceTray();

module cubei(vec) {
    cube(vec);
    translate([10,10,-1]) cube([vec.x-20,vec.y-20,2]);
}
    
module punchoutTray() {
    w = 46 * 4 + wall * 5;
    h = wall*3 + 61 + 57;// + 46;
    

    difference() {
        translate([0,46+wall,0]) cube([w,h,flr+12]);
        // cards
        /* for (i=[0:3]) {
            translate([wall+(46+wall)*i,wall,flr]) cubei([46,46,99]);
        } */
        translate([wall,46+wall*2,flr]) {
            cubei([36,71,99]);
            translate([0,71+wall,0]) cube([36,47,99]);
        }
        translate([wall+36+wall,46+wall*2,flr]) {
            cubei([48,39,99]);
            translate([0,39+wall,0]) cubei([48,71-wall-39,99]);
            translate([0,71+wall,0]) cube([48,47,99]);
        }
        translate([wall,wall+46+wall,flr+8.1]) cube([36+wall+48,71,99]);
                    
        translate([wall+36+wall+48+wall,46+wall*2,flr]) {
            cubei([51,57,99]);
            translate([0,57+wall,0]) cube([51,61,99]);
        }
        translate([wall+36+wall+48+wall+51+wall,46+wall*2,flr]) {
            cubei([49,57,99]);
            translate([0,57+wall,0]) cube([49,61,99]);
        }
        translate([wall+36+wall+48+wall+10,46+wall*2+15,flr+8.1])
            cube([51+wall+49-20,80,99]);
    }
}

// punchoutTray();

module squareCardTray() {
    w = 46 * 4 + wall * 5;
    h = wall*2 + 46;
    difference() {
        cube([w,h,flr+12]);
        for (i=[0:3]) {
            translate([wall+(wall+46)*i,wall,flr]) {
                cube([46,46,99]);
                translate([46/2,-20,12]) rotate([-90,0,0]) cylinder(h=99,d=24);
            }
        }
    }
}

//squareCardTray();

module factionTray() {
    w = 46 * 4 + wall * 5;
    h = 80; // 70 + wall*2;
    difference() {
        cube([w,h,flr+12]);
        translate([(w - 183) / 2, (81-71)/2, flr]) cubei([183,71,99]);
    }
}

//factionTray();

module hexTray(which) {
    module hex() {
        linear_extrude(99) polygon([
            [0,20], [0,83-20], [109/2,83], [109,83-20], [109,20], [109/2,0]]);
        translate([109/2,83/2,-1]) cylinder(h=2,d=40);
    }
    leftWidth = wall*3+109*2;
    rightWidth = 350 - leftWidth; // wall+109;
    difference() {
        translate([which==2?leftWidth+0.01:0,0,0])
            cube([which==1?leftWidth:which==2?rightWidth:leftWidth+rightWidth,
            152+wall+wall,19.4+flr]);

        // card well and finger hole
        translate([wall,wall+152-69,flr]) cube([46,69,99]);
        translate([wall+46/2,83+69/2,-1]) cylinder(h=2,d=30);

        // hexes - bottom row
        translate([wall,wall,flr]) hex();
        translate([wall+109+wall,wall,flr]) hex();
        translate([wall+109+wall+109+wall,wall,flr]) hex();
        
        // hexes - top row
        translate([wall+109/2,wall+65,flr]) hex();
        translate([wall+109/2+wall+109,wall+65,flr]) hex();
        
        // large circle and scrapyard
        translate([wall+46+wall+152/2,wall+152/2,flr+13.7]) cylinder(h=99,d=152);
        translate([wall+46+wall,wall,flr+13.7+2.7]) cube([152,152,99]);
        
        // rightmost cutouts
        translate([wall+109/2+wall+109+wall+109+wall,wall+65,-1]) {
            hex();
            translate([0,40,0]) hex();
        }
        translate([leftWidth+wall+109,wall,flr]) cube([99,200,99]);
        translate([leftWidth,0,flr+13.7+2.7]) cube([109,99,99]);
    }
}

hexTray(3);

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

//tileAndCards();

module cardTray() {
    w = 108-wall-91-wall-wall;
    echo(w);
    difference() {
        cube([108,65*2+wall*3,flr+12]);
        translate([wall,wall,flr]) cubei([91,65,99]);
        translate([wall,wall+65+wall,flr]) cubei([91,65,99]);
        translate([wall+91+wall,wall,flr]) {
            cube([w,74,99]);
            translate([0,74+wall,0]) cube([w,65*2-74,99]);
        }
    }
}

//cardTray();

module miscTray() {
    module octagon(x,y) {
        translate([x * 23,y * 23,flr]) rotate([0,0,45/2]) {
            cylinder(h=99,d=25,$fn=8);
            translate([0,0,-2]) cylinder(h=2,d=16,$fn=8);
        }
    }
    module moon(x,y) {
        translate([2+x * 17.6, y * 18.3,flr]) {
            cylinder(h=99,d=18,$fn=30);
            translate([0,0,-2]) cylinder(h=2,d=12,$fn=30);
        }
    }
    difference() {
        w = 108;
        h = 116;
        cube([w,h,flr+12]);
        for (i=[0:4]) {
            octagon(0.5,0.5+i);
            octagon(1.5,0.5+i);
        }
        v=1.4; u = 1.76;
        for (i=[0:3]) {
            moon(3.0,0.5+i*u);
            if (i!=3) moon(3.5,v+i*u);
            moon(4.0,0.5+i*u);
            if (i!=3) moon(4.5,v+i*u);
            moon(5.0,0.5+i*u);
            if (i!=3) moon(5.5,v+i*u);
        }
    }
}

//miscTray();