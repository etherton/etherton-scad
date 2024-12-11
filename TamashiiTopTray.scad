
module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

module topTray() {
    w = 136;
    h = 196;
    cy = 40;
    th = 0.20 + 0.28;
    r = 10;
    n1 = 3;
    cx1 = (w - (n1+1)) / n1;
    n2 = 4;
    cx2 = (w - (n2+1)) / n2;
    difference() {
        roundedCube([136,196,13],r);
        for (i=[0:3]) {
            translate([1,(cy+1)*i+1,th]) {
                roundedCube([cx1,cy,99],r);
                translate([cx1+1,0,0]) roundedCube([w-cx1-3,cy,99],r);
            }
        }
        translate([0,165,th]) for (i=[0:n2-1]) translate([1+(cx2+1)*i,0,0]) roundedCube([cx2,30,99],r);
    }
    
}

topTray();