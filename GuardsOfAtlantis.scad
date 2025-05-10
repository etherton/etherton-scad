shearYZ = 0.95;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

module playerTray(option) {
    multmatrix(M) {
        T = 15;
        difference() {
            union() {
                difference() {
                    cube([94,18,50]);
                    translate([1,1,1]) cube([92,16,50]);
                    translate([45,-10,50]) rotate([-90,0,0]) cylinder(h=100,r=30,$fn=200);
                }
                translate([0,17,0]) difference() {
                    cube([94,14,20]);
                    if (true) {
                        translate([1,1,1]) cube([30,12,20]);
                        translate([32,1,1]) cube([30,12,20]);
                        translate([63,1,1]) cube([30,12,20]);
                   }
                    else {
                        translate([1,1,1]) cube([22,12,20]);
                        translate([24,1,1]) cube([22,12,20]);
                        translate([47,1,1]) cube([22,12,20]);
                        translate([70,1,1]) cube([23,12,20]);
                    }
                }
            }
            translate([94/2-T,0,0]) cube([T+T,17,1]);
       }
       translate([94/2-T+0.2,17,0]) cube([T+T-0.4,14+16.8,1]);
    }
    if (option <= 1) {
        translate([113,16,0]) difference() {
            union() {
                translate([-20,-12,0]) cube([20,23,4]);
                cylinder(h=4,d=30,$fn=100);
            }
            translate([0,0,1]) cylinder(h=3.2,d1=27,d2=26.2,$fn=100);
            translate([3,-50,1]) cube([99,99,99]);
        }
        if (option == 1) {
            translate([113,44,0]) difference() {
                union() {
                    translate([-20,-12,0]) cube([20,23,4]);
                    cylinder(h=4,d=30,$fn=100);
                }
                translate([0,0,1]) cylinder(h=3.2,d1=27,d2=26.2,$fn=100);
                translate([3,-50,1]) cube([99,99,99]);
            }
        }
    }
    else if (option == 2) {
        translate([94,16,20]) rotate([0,90,0]) rotate([0,0,180]) difference () {
            cylinder(h=4,d=30,$fn=100);
            translate([0,0,1]) cylinder(h=3.2,d1=27,d2=26.2,$fn=100);
            translate([3,-50,1]) cube([99,99,99]);
        }
    }
}

module cardTray(N,D) {
    multmatrix(M) {
        difference() {
            cube([94,(D+1)*N+1,50]);
            translate([45,-10,50]) rotate([-90,0,0]) cylinder(h=N*22,r=30,$fn=200);
            for (i=[0:N-1]) {
                translate([1,1+(D+1)*i,1]) cube([92,D,50]);
            }
        }
    }
}

module minionTray() {
    module c() {
        xx = 14;
        translate([xx,0,0]) difference() {
            union() {
                cylinder(h=4,d=28,$fn=100);
                translate([-xx,-14,0]) cube([xx,28,2]);
            }
            translate([0,0,1]) cylinder(h=3.2,d1=25.2,d2=24.4,$fn=100);
            translate([3,-50,1]) cube([99,99,99]);
        }
    }
    module c2() {
        c(); rotate([0,0,180]) c();    
    }
    c2();
    translate([0,28,0]) c2();
    translate([0,28*2,0]) c2();
    translate([0,28*3,0]) c2();
    translate([-1,28,0]) difference() {
        cube([2,28,50]);
        translate([0,4,0]) cube([2,20,38]);
        translate([0,14,38]) rotate([0,90,0]) cylinder(h=2,d=20,$fn=200);
    }
}

//rotate([43,0,0]) 
//scale([-1,1,1]) playerTray(0);
minionTray();
//cardTray(9,16);