w = 220;
d = 10;
nd = 5;
td = d * (nd-1);
h = 30;
th = 0.6;
sp = 20;
rotate([0,0,45]) rotate([90,0,0]) 
difference() {
    union() {
        translate([-10,0,-td/2]) cube([w+20,1.0,td * 2]);
        cube([th,h + (nd-1)*sp,(nd - 1) * d + th]);
        translate([w-th,0,0]) cube([th,h + (nd-1) * sp,(nd - 1) * d + th]);
        for (i=[0:nd-1])
            translate([0,0,d * i]) cube([w,h + i * sp,th]);
    }
    
    translate([0,h,0]) rotate([0,90,0])linear_extrude(w) polygon([ [0,0], [0,h+90], [-60,h+90]]);
        
}