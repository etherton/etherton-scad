
module GenericLid(width,height,depth,gridStep=10,gridSize=3,thk=2,gap=0.2) {
    gridRange = width + height;
    inset = 0.5 * (thk - gap);
    union() {
        difference() {
            cube([width+thk,height+thk,depth]);
            translate([inset,inset,1]) cube([width+gap,height+gap,depth]);
            translate([thk,thk,0]) cube([width-thk,height-thk,1]);
        }
        intersection() {
            translate([thk,thk,0]) cube([width-thk,height-thk,1]);
	    union() {
              linear_extrude(1)
                 for (i=[0:gridStep:gridRange])
                    polygon([ [0,i], [i,0], [i+gridSize,0], [0,i+gridSize] ]);
              linear_extrude(1)
                for (i=[0:gridStep:gridRange])
                    polygon([ [0,height-i], [i,height], 
                        [i+gridSize,height], [0,height-i-gridSize] ]);
            }
        }
    }     
}
