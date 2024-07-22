module RoundedTray(width,height,depth,gutter,trayStarts) {
    roundRadius = 10;
    difference() {
        cube([width,height,depth]);
        for (bin=[0:len(trayStarts)-2]) {
                translate([0,height-gutter,gutter]) rotate([90,0,0]) linear_extrude(height-gutter-gutter) hull() {
                    // Rounded bottoms
                    translate([trayStarts[bin]+gutter+roundRadius,roundRadius,0]) 
                        circle(roundRadius);      
                    translate([trayStarts[bin+1]-roundRadius,roundRadius,0]) 
                        circle(roundRadius);
                    // Top of the tray
                    translate([trayStarts[bin]+gutter,depth,0]) 
                        square([trayStarts[bin+1]-trayStarts[bin]-gutter,1]);
            }
        }
    }
}

RoundedTray(190,54,22,1,[0,50,100,150,190-1]);