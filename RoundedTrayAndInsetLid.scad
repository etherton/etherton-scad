use <GenericLid.scad>
use <GenericRoundedTray.scad>

module RoundedTrayAndInsetLid(width,height,depth,gutter,trayStarts) {
    lidDepth = 8;
    inset = 1;
    difference() {
        GenericRoundedTray(width,height,depth,gutter,trayStarts);
        translate([0,0,depth-lidDepth]) cube([width,inset,lidDepth]);
        translate([0,0,depth-lidDepth]) cube([inset,height,lidDepth]);
        translate([0,height-inset,depth-lidDepth]) cube([width,inset,lidDepth]);
        translate([width-inset,0,depth-lidDepth]) cube([inset,height,lidDepth]);
    }
   translate([0,height+10,0]) {
        GenericLid(width-2,height-2,lidDepth-2,gap=0.3);
   }
}

//GenericLid(102-2,68-2,6,gap=0.3);

// RoundedTray(190,54,20,1,[0,50,120,155);
// RoundedTray(150,95,16,1,[49,98]);

// Rovers and rockets
//RoundedTrayAndInsetLid(102,68,33,2,[70]);

// Resources
//RoundedTrayAndInsetLid(102,68,33,2,[25,50,75]);

// Hearts
// RoundedTrayAndInsetLid(102,68,27,2,[30,50,72]);
// GenericLid(102,68,5);

// Amoebas
// RoundedTrayAndInsetLid(90,80,20,2,[29,58]);

// Fleet numbers
//RoundedTrayAndInsetLid(130,80,20,2,[70,105]);

// Extra tray
//RoundedTrayAndInsetLid(140,36,19,2,[50,100]);

// Coins, Abandoned, Razed for Burning Banners
RoundedTrayAndInsetLid(185,80,18,2,[30,60,90,120]);
translate([91,30,0]) cube([30,2,18]);

// Dice and Counters for Burning Banners
//RoundedTrayAndInsetLid(185,80,30,2,[30,60,90,120]);
////translate([91,30,0]) cube([30,2,30]);
