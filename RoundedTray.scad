include <GenericLid.scad>
include <GenericRoundedTray.scad>

module RoundedTray(width,height,depth,gutter,trayStarts) {
    GenericRoundedTray(width,height,depth,gutter,trayStarts);
    translate([-1,height+10,0]) {
        GenericLid(width,height,5);
    }
}

// RoundedTray(190,54,20,1,[0,50,120,155);
// RoundedTray(150,95,16,1,[49,98]);

// Rovers and rockets
//RoundedTray(102,68,25,2,[70]);

// Resources
// RoundedTray(102,68,25,2,[25,50,75]);

// Hearts
RoundedTray(102,68,25,2,[35,55,75]);
