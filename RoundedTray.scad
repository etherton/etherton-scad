include <GenericLid.scad>

module RoundedTray(width,height,depth,gutter,trayStartsIn) {
    rrMax = 10;
    trayStarts = concat(concat([0],trayStartsIn), [width - gutter]);
    difference() {
        cube([width,height,depth]);
        for (bin=[0:len(trayStarts)-2]) {
            rr = min(rrMax,0.5 * (trayStarts[bin+1] - trayStarts[bin] - gutter));
            hull() {
                translate([trayStarts[bin]+gutter+rr,gutter+rr,rr+gutter]) 
                    sphere(rr);
                translate([trayStarts[bin]+gutter+rr,height-gutter-rr,rr+gutter]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,gutter+rr,rr+gutter]) 
                    sphere(rr);
                translate([trayStarts[bin+1]-rr,height-gutter-rr,rr+gutter]) 
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
        GenericLid(width,height,5);
    }
}

// RoundedTray(190,54,20,1,[0,50,120,155);
// RoundedTray(150,95,16,1,[49,98]);

// Rovers and rockets
//RoundedTray(102,68,25,2,[70]);

// Resources
// RoundedTray(102,68,25,2,[25,50,75]);

RoundedTray(102,68,25,2,[35,55,75]);