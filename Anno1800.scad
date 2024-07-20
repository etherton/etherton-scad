// 4x4 tile racks for Anno 1800
// Tiles are 1.7mm thich, 40.2mm square (allocate 41.2mm space)
// 47.2mm horizontal separation
// 49.2mm vertical separation


border = 3;
trayWidth = 47.2*3+41.2+border*2;
trayHeight = 49.2*3+41.2+border*2;

difference() {
    cube([trayWidth,trayHeight,3.4+1]);
    for (i=[0:3]) {
        for (j=[0:3]) {
            translate([border+47.2*i,border+49.2*j,1]) {
                cube([41.2,41.2,4]);
                translate([2,2,-2]) cube([41.2-4,41.2-4,2]);
                // translate([10,-10,0]) cube([20.2,20,4]);
                // translate([-10,10,0]) cube([20,20.2,4]);
            }
        }
    }
    for (i=[0:3]) translate([border+47.2*i + 5,border,1])
        cube([41.2-10,trayHeight-border*2,5]);
    for (j=[0:3]) translate([border,border+49.2*j + 5,1])
        cube([trayWidth-border*2,41.2-10,5]);
    cylinder(5,r=1,$fn=60);
}