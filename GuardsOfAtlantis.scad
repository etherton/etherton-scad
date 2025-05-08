shearYZ = 0.9;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

module playerTray() {
    multmatrix(M) {
        difference() {
            cube([92,40,50]);
            translate([1,1,1]) cube([90,38,50]);
            translate([45,-10,50]) rotate([-90,0,0]) cylinder(h=100,r=15,$fn=200);
        }
    }
    translate([111,32,0]) difference() {
        union() {
            translate([-20,-12,0]) cube([20,20,4]);
            cylinder(h=4,d=30,$fn=100);
        }
        translate([0,0,1]) cylinder(h=3.2,d1=27,d2=26.2,$fn=100);
        translate([3,-50,1]) cube([99,99,99]);
    }
}

//rotate([42,0,0]) 
playerTray();