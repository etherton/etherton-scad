// BlackForest

module tileDisplay(rows,cols = 3,stepX=60,stepY=41,wellX=53,wellY=35,th=0.6,depth=2.2) {
    inX = (stepX - wellX) / 2;
    inY = (stepY - wellY) / 2;
    lip = 3;
    fl = 0.6;
    for (r=[0:rows-1]) {
        for (c=[0:cols-1]) {
            translate([stepX*c + inX,stepY*r + inY,0]) {
                if (r) {
                    translate([0,-inY*2,0]) 
                        cube([th,inY*2,depth+fl]);
                    translate([wellX+th,-inY*2,0]) 
                        cube([th,inY*2,depth+fl]);
                }
                if (c) {
                    translate([-inX*2,0,0]) 
                        cube([inX*2,th,depth+fl]);
                    translate([-inX*2,wellY+th,0]) 
                        cube([inX*2,th,depth+fl]);
                }
                difference() {
                    cube([wellX+th+th,wellY+th+th,depth+fl]);
                    translate([lip+th,lip+th,-1]) 
                        cube([wellX-lip*2,wellY-lip*2,99]);
                    translate([th,th,fl]) 
                        cube([wellX,wellY,depth]);
                    translate([0,wellY/2+th-8,fl]) cube([10,16,99]);
                }
            }
        }
    }
}

module playerBox() {
    th = 0.6;
    fl = 0.6;
    w = 105;
    h = 52.2;
    difference() {
        cube([w+th+th,h+th+th,8.4+11+fl]);
        translate([th*4,th*4,fl]) cube([w-th*8,h-th*8,11]);
        translate([th,th,11+fl]) cube([w,h,8.4]); // tiles
        translate([w-th-th,h/2+th,8.4+11+fl]) rotate([0,90,0]) cylinder(h=99,r=8.4);
    }
}

module wheelBrace() {
    difference() {
        cube([290,39,6]);
        for (i=[0:3])
            translate([0,3 + i*10,2]) cube([290,2.8,99]);
    }
}

//tileDisplay(2);
//tileDisplay(3);
//tileDisplay(4);
//tileDisplay(5);
//tileDisplay(7);

//playerBox();

rotate([0,0,45]) wheelBrace();