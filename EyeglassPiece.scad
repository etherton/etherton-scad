module piece() {
    difference() {
        cube([12,6.4,5]);
        translate([2.0+1.2,6.4/2,0]) cylinder(30,d=2.1,$fn=20,center=true);
        translate([2.0+1.2,6.4/2,0]) cylinder(3.0,d=3,$fn=20);
        translate([0,0,4.4]) cube([1,20,20]);
        translate([0,1,4.4]) cube([5.2,4.4,1]);
        ///translate([0,1,1.4]) cube([5,4.4,2]);
        translate([6.8,-1,3.5]) cube([20,20,2]);
        translate([6.8,(6.4-1)/2,-1]) cube([20,1,20]);
        rotate([90,0,0]) translate([10,2,0]) cylinder(30,d=1.6,$fn=20,center=true);
        rotate([90,0,0]) translate([10,2,-0.8]) cylinder(1,d=2.6,$fn=20);
        rotate([90,0,0]) translate([10,2,-6.6]) cylinder(1,d=2.6,$fn=20);
        
        rotate([-90,0,0]) translate([0,-5,0])
        linear_extrude(20) {
            polygon([[0,1.5], [9,5], [11,5], 
            [12.2,4], [12,3], [11,1], [12,1], [13,0], [13,10], [0,10]]);
        }
    }
}

rotate([0,-21,0]) piece();

//translate([0,20,0]) scale([-1,1,1]) piece();