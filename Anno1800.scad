// 4x4 tile racks for Anno 1800
// Tiles are 1.7mm thich, 40.2mm square
// 47.2mm horizontal separation
// 49.2mm vertical separation


difference() {
    cube([47.2*3+41.2+6,49.2*3+41.2+6,3.4+1]);
    for (i=[0:3]) {
        for (j=[0:3]) {
            translate([3+47.2*i,3+49.2*j,1]) {
                cube([41.2,41.2,4]);
                translate([20.6,20.6,-2]) cylinder(h=2,d=43);
                translate([10,-10,1]) cube([20.2,20,4]);
                translate([-10,10,1]) cube([20,20.2,4]);
            }
        }
    }
}