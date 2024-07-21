// 4x4 tile racks for Anno 1800
// Tiles are 1.7mm thich, 40.2mm square (allocate 41.2mm space)
// 47.2mm horizontal separation
// 49.2mm vertical separation


module cutout(sc,height) {
    x = 2.5;
    linear_extrude(height) 
        offset(delta=sc) polygon([[0,x],[x,x],[x,x*2],[x*2,x*2],[x*2,x*-2],[x,x*-2],[x,-x],[0,-x]]);
}

module annoTray(cols,rows,rowHeights) {
    border = 4.5;
    trayWidth = 47.2*(cols-1)+41.2+border*2;
    trayHeight = 49.2*(rows-1)+41.2+border*2;
    thickness = 1.7 * rowHeights[1];
    
    union () {
        difference() {
            cube([trayWidth,trayHeight,thickness+1]);
            for (i=[0:(cols-1)]) {
                for (j=[0:(rows-1)]) {
                    translate([border+47.2*i,border+49.2*j,1]) {
                        cube([41.2,41.2,99]);
                        translate([2,2,-2]) cube([41.2-4,41.2-4,99]);
                    }
                }
            }
            for (j=[0:(rows-1)]) translate([0,49.2*j,rowHeights[j]*1.7+1]) 
                cube([trayWidth,j==rows-1?49.2+border:49.2,99]);
            for (i=[0:(cols-1)]) translate([border+47.2*i+5,0,1])
                cube([41.2-10,trayHeight,99]);
            for (j=[0:(rows-1)]) translate([0,border+49.2*j+5,1])
                cube([trayWidth,41.2-10,99]);
            translate([0,trayHeight/2,0]) cutout(0.2,3.2);
            /* cylinder(5,r=1,$fn=60); */
        }
        if (cols==4) translate([trayWidth,trayHeight/2,0]) cutout(0,3);
    }
}

annoTray(4,4,[2,2,2,2]);
//translate([200,0,0]) 
// annoTray(3,4,[2,6,6,6]);

