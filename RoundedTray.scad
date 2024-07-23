module RoundedTray(width,height,depth,gutter,trayStarts) {
    rr = 10;
    difference() {
        cube([width,height,depth]);
        for (bin=[0:len(trayStarts)-2]) {
            hull() {
                translate([trayStarts[bin]+gutter+rr,gutter+rr,rr]) 
                    sphere(rr);
                translate([trayStarts[bin]+gutter+rr,height-gutter-rr,rr]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,gutter+rr,rr]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,height-gutter-rr,rr]) 
                    sphere(rr);
                translate([trayStarts[bin]+gutter+rr,gutter+rr,depth]) 
                    sphere(rr);
                translate([trayStarts[bin]+gutter+rr,height-gutter-rr,depth]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,gutter+rr,depth]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,height-gutter-rr,depth]) 
                    sphere(rr);

            }
        }
    }

    translate([-1,height+10,0]) {
        gridStep = 10;
        gridSize = 3;
        gridRange = width + height;
        union() {
            difference() {
                cube([width+2,height+2,5]);
                translate([.9,.9,1]) cube([width+.2,height+.2,5]);
                translate([2,2,0]) cube([width-4,height-4,1]);
            }
            intersection() {
                translate([2,2,0]) cube([width-4,height-4,1]);
                union() {
                linear_extrude(1) {
                        for (i=[0:gridStep:gridRange])
                            polygon([ [0,i], [i,0], [i+gridSize,0], [0,i+gridSize] ]);
                    }
                linear_extrude(1) {
                        for (i=[-gridRange:gridStep:gridRange])
                            polygon([ [0,i], [gridRange,i+gridRange], 
                                [gridSize+gridRange,i+gridRange], [0,i-gridSize] ]);
                    
                }    
            }
            }
        }
    }
}

RoundedTray(190,54,20,1,[0,50,120,155,190-1]);