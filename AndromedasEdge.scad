// Andromeda's Edge

wall = 0.8;
flr = 0.6; // or 0.28 + .40;

w = wall*3 + 88 + 45;
h = wall*4 + 34 + 8.4 + 13;
m = 4;

difference() {
    cube([w,h,19.6]);
    translate([wall,wall,flr]) cube([88,34,99]);
    translate([wall,wall*2+34,flr]) cube([74,8.4,99]);
    translate([wall,wall*3+34+8.4,4]) cube([74,13,99]);
    translate([wall*2+88,wall,flr+1]) cube([45,h-wall*2,99]);
    translate([wall,wall,10]) cube([88,h-wall*2,99]);
    translate([76,46.6,8.4+flr]) rotate([0,90,0]) cylinder(h=12,d=17);
    translate([w - wall - m - 18/2,wall + 18/2,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18/2,wall + 18*1.5,flr]) cylinder(h=99,d=16);
    translate([w - wall - m -18/2,wall + 18*2.5,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18 * 1.5,wall + 18/2,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18 * 1.5,wall + 18*1.5,flr]) cylinder(h=99,d=16);
    // translate([w - wall - m - 18 * 1.5,wall + 18*2.5,flr]) cylinder(h=99,d=16);
}