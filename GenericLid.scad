
module GenericLid(width,height,depth,gridStep = 10,gridSize = 3) {
    gridRange = width + height;
    union() {
        difference() {
            cube([width+2,height+2,5]);
            translate([.9,.9,1]) cube([width+.2,height+.2,depth]);
            translate([2,2,0]) cube([width-4,height-4,1]);
        }
        intersection() {
            translate([2,2,0]) cube([width-4,height-4,1]);
            linear_extrude(1) {
                for (i=[0:gridStep:gridRange]) {
                    polygon([ [0,i], [i,0], [i+gridSize,0], [0,i+gridSize] ]);
                    polygon([ [0,height-i], [i,height], 
                        [i+gridSize,height], [0,height-i-gridSize] ]);
                }
            }
        }
    }     
}
