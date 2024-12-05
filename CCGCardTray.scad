// Fit four standard decks of 89x63mm cards and multiple token types.

rows = 2;
cols = 2; // if cols is larger than two, middle wells will be hard to reach
cardX = 90;
cardY = 64;
depth = 22;
cutoutRadius = 20; // must be less than half of cardY
thick = 1;
totalWidth = thick + cols * (cardX + thick);
totalHeight = thick + rows * (cardY + thick);
inset = 15; // if nonzero, cutouts in bottom of tray

difference() {
    cube([totalWidth,totalHeight,depth+thick]);
    for (r=[0:rows-1]) {
        translate([0,thick+cardY/2+r*(cardY+thick),thick+cutoutRadius])
            rotate([0,90,0]) cylinder(r=cutoutRadius,h=thick);
        translate([totalWidth-thick,thick+cardY/2+r*(cardY+thick),thick+cutoutRadius])
            rotate([0,90,0]) cylinder(r=cutoutRadius,h=thick);
        for (c=[0:cols-1]) {
            translate([thick+c*(cardX+thick),thick+r*(cardY+thick),1])
                cube([cardX,cardY,depth]);
            if (inset) 
                translate([thick+c*(cardX+thick)+inset,thick+r*(cardY+thick)+inset,0])
                cube([cardX-inset*2,cardY-inset*2,thick]);
        }
    }
}
