
thick = 0.8;

module tray(width,height,depth,count) {
    difference() {
        cube([width*count+thick*(count+1),height+thick*2,depth+thick]);
        for (i=[0:count-1]) {
            translate([thick + (thick+width)*i,,thick,thick]) {
                cube([width,height,depth]);
                translate([width/2,-height,width/4]) 
                    rotate([-90,0,0]) 
                        cylinder(h=height*3,d=width/2);
                translate([width/4,-height,width/4]) 
                    cube([width/2,height*3,depth]);
            }
        }
    }
}

module playerTray() {
    discDiameter = 15.2 + 0.2; // tried 15.1 and 15.2, 15.2 was best
    robotDiameter = 7.9 + 0.04*12; // tried 0.04 increments between 7.9 and 8.1
    test = false;
    difference() {
        cube([60,100,6]);
        translate([5,thick,thick]) cube([35.4,35.4,6]);
        translate([15,0,thick]) cube([15,thick,6]);
        translate([53,9,2]) cylinder(h=4,d= test? 15.2 : discDiameter);
        translate([53,26,2]) cylinder(h=4,d=test? 15.1 : discDiameter);
        for (i=[0:3]) for (j=[0:3])
            translate([15*i+7.5,15*j+45,3])
                cylinder(h=5,d=test? 7.9+0.04 * (i+j*4) : robotDiameter);
        
    }
}
  
// tech tiles
// tray(35.6,35.6,31,4);

// tech cards
//tray(45,68,8,3);

playerTray();
