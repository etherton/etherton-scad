module GenericRoundedTray(width,height,depth,gutter,trayStartsIn) {
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
}
