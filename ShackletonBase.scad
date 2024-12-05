/* rotate([160,0,0]) { rotate([20,0,0]) difference() {
    cube([11,14,2]);
    for (i=[0:2]) for (j=[0:3]) translate([i*3.2+1.2,j*3.2+1.2,1.4]) cube([2.2,2.2,99]);
 }
translate([1.5,0,0]) rotate([90,0,90]) linear_extrude(8) polygon([[2,0], [2,1], [11,4], [11,0] ]);
 } */
 
 module roundedCube(vec) {
     r=3;
     hull() {
         translate([r,r,0]) cylinder(r=r,h=vec.z);
         translate([vec.x-r,r,0]) cylinder(r=r,h=vec.z);
         translate([r,vec.y-r,0]) cylinder(r=r,h=vec.z);
         translate([vec.x-r,vec.y-r,0]) cylinder(r=r,h=vec.z); 
     }
 } 
 
 module well(x,y,w,h) {
     translate([x,y,0.6]) {
        hull() {
            r=10;
            translate([r,r,r]) sphere(r);
            translate([w-r,r,r]) sphere(r);
            translate([r,h-r,r]) sphere(r);
            translate([w-r,h-r,r]) sphere(r);
            translate([0,0,r]) roundedCube([w,h,99]);
        }
     }
 }
 
 module astronautTray() {
     difference() {
         roundedCube([82,89,28]);
         translate([1,1,0.6]) roundedCube([26,87,99]);
         translate([28,1,0.6]) cube([26,87,99]);
         translate([55,1,0.6]) cube([26,87,99]);
     }
}
 
// astronautTray();
 
 module resourceTray() {
     difference() {
         roundedCube([82,89,28]);
         well(1,1,26,52);
         well(28,1,26,52);
         well(55,1,26,52);
         well(1,54,30,33);
         well(32,54,49,33);
         //translate([1,1,28-10.6]) roundedCube([80,52,99]);
     }
 }
 
// resourceTray();
 
module innerTray(which) {
    module radar(cx,cy,rot) {
        translate([cx,cy,19-13]) rotate([0,0,rot]) translate([25,-13/2,0]) cube([8,13,13]);
    }
    module rc(x,y,w,h) {
        translate([x,y,0.6]) roundedCube([w,h,99]);
    }
    difference() {
         roundedCube([66,98,28]);
         translate([1,1,19]) roundedCube([64,96,99]);
         translate([33,98-12,which == 3? 13 : 16]) cylinder(d=21,h=99);
         translate([33-21,98-12,13]) cylinder(d=21,h=99);
         translate([33+21,98-12,13]) cylinder(d=21,h=99);
         translate([33,0,28]) rotate([-90,0,0]) cylinder(d=24,h=4);
         if (which == 3) {
            well(2,2,62,25);
            well(2,28,62,25);
            well(2,54,62,25);
         }
         else if (which == 2) {
            well(2,2,62,44);
            well(2,47,62,77-44-1);
         }
         else if (which == 2.5) {
            rc(2,2,62,45);
            well(2,48,62,77-45-1);
         }
         else if (which == 1) {
            well(2,2,62,77);
         }
         else if (which == 6) {
             cx = 33; cy = 27;
             translate([cx,cy,0.6]) cylinder(h=99,d=60,$fn=6);
             translate([cx,cy,-1]) cylinder(h=99,d=40,$fn=6);
             well(2,54,62,25);
             radar(cx,cy,30);
             radar(cx,cy,180-30);
             radar(cx,cy,360-30);
             radar(cx,cy,180+30);
             /*translate([2,2,12]) roundedCube([13,13,7]);
             translate([66-15,2,12]) roundedCube([13,13,7]);
             translate([2,40,12]) roundedCube([13,13,7]);
             translate([66-15,40,12]) roundedCube([13,13,7]); */
         }
     }
 }
 
 innerTray(1);
//innerTray(2.5); // Moon Mining, To Mars, Space Robotics
// innerTray(6); // SkyWatch