
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
    th = 0.20 + 0.28;
    r = 6;
    n1 = 3;
    cx1 = (w - (n1+1)) / n1;
    n2 = 4;
    cx2 = (w - (n2+1)) / n2;
    difference() {
        roundedCube([136,196,16],r);
        translate([1,1,th]) roundedCube([134,40,99],r);
        translate([0,42,th]) for (i=[0:n1-1]) translate([1+(cx1+1)*i,0,0]) roundedCube([cx1,40,99],r);
        translate([0,83,th]) for (i=[0:n1-1]) translate([1+(cx1+1)*i,0,0]) roundedCube([cx1,40,99],r);
        translate([0,124,th]) for (i=[0:n1-1]) translate([1+(cx1+1)*i,0,0]) roundedCube([cx1,40,99],r);
        translate([0,165,th]) for (i=[0:n2-1]) translate([1+(cx2+1)*i,0,0]) roundedCube([cx2,30,99],r);
    }
    
}

topTray();