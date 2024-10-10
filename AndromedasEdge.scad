// Andromeda's Edge

wall = 0.8;
flr = 0.6; // or 0.28 + .40;

w = wall*3 + 86 + 45;
h = wall*4 + 34 + 8.4 + 13;
m = 4;

difference() {
    cube([w,h,17]);
    translate([wall,wall,flr]) cube([86,34,99]);
    translate([wall,wall*2+34,flr]) cube([74,8.4,99]);
    translate([wall,wall*3+34+8.4,flr]) cube([74,13,99]);
    translate([wall*2+86,wall,flr+1]) cube([45,h-wall*2,99]);
    translate([wall,wall,10]) cube([86,h-wall*2,99]);
    translate([w - wall - m - 18/2,wall + 18/2,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18/2,wall + 18*1.5,flr]) cylinder(h=99,d=16);
    translate([w - wall - m -18/2,wall + 18*2.5,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18 * 1.5,wall + 18/2,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18 * 1.5,wall + 18*1.5,flr]) cylinder(h=99,d=16);
    translate([w - wall - m - 18 * 1.5,wall + 18*2.5,flr]) cylinder(h=99,d=16);
}