part = "both"; // [first:Lid Only,second:Tray Only,both:Both Parts

// Token Diameter
tokenDiameter = 30.4; // [30:0.1:31]

// Lid Margin
lidMargin = 0.0; // [0:0.1:0.6]

// Make Small Test Lid?
test_size = 0; // [0:No, 1:Yes

module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
        translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
        translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
    }
}

module eliteTokens() {
    $fn=60;

    difference() {
        sp = 32;
        m = 4;
        cx = test_size? 1 : 4; cy = test_size? 1 : 3;
        roundedCube([sp*cx+m+m,sp*cy+m+m,2.6],5);
        for (j=[0:cy-1]) {
            for (i=[0:cx-1]) {
                translate([m+sp/2+sp*i,m+sp/2+sp*j,-1]) {
                    cylinder(h=3,d=20);
                    translate([0,0,1.6]) cylinder(h=5,d=tokenDiameter);
                }
            }
        }
    }
}

//eliteTokens();

module tray() {
    difference() {
        roundedCube([32*4+10,32*3+10,18],5);
        translate([1-lidMargin,1-lidMargin,16]) roundedCube([32*4+8+lidMargin*2,32*3+8+lidMargin*2,99],5);
        for (j=[0:2]) {
            for (i=[0:1]) {
                translate([1+34*i,1+35*j,0.6]) roundedCube([33,34,99],5);
            }
        }
        for (j=[0:1]) {
            for (i=[2:3]) {
                translate([1+34*i,1+52.5*j,0.6]) roundedCube([i==3?34:33,51.5,99],5);
            }
        }
        translate([-1,(32*3+10)/2,22]) rotate([0,90,0]) cylinder(h=5,d=20);
    }
}

//tray();

print_part();

module print_part() {
	if (part=="first" || test_size) eliteTokens();
	else if (part=="second") tray();
	else {
        translate([0,-60,0]) eliteTokens();
		translate([0,60,0]) tray();
	}
}

