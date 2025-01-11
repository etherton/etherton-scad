// SpaceCorp

// Card tray, print 3x. The eight base game player boards fit on the left.

// card size is 63.5 x 89mm



module cardTray() {
    cw = 64.5;
    ch = 95;
    wt = 0.6;

    w = 217;
    h = 97;
    ft = 0.6;
    
    module well(xo) {
        translate([xo+wt+10,wt+10,-1]) cube([cw-20,h-20,99]);
        translate([xo+wt,wt,ft]) cube([cw,h-wt-wt,99]);
    }
    difference() {
        cube([w,h,22]);
        translate([0,0,9]) cube([w - cw - wt - wt,h,99]);
        well(0);
        well(cw+wt);
        well(w-cw-wt-wt);
        translate([wt+cw+wt+cw+wt,wt,ft]) cube([w-cw*3-wt*5,h-wt-wt,99]);
    }
}

module tokenTray(alt) {
    module cylinder2(vec) {
        translate(vec) {
            cylinder(h=99,d=24.5,$fn=6);
            translate([0,0,-1]) cylinder(h=99,d=20,$fn=6);
        }
    }   
    difference() {
        cube([217,79,21]);
        for (i=[0:3]) {
            translate([0.6,10.6+19.75*i,12]) rotate([0,90,0])
                cylinder(h=51,d=20);
            translate([51.6,2.1+19.75*i,4]) cube([2,17,17]);

        }
        translate([0,0,10]) cube([54.4,99,99]);
        
        for (i=[0:2]) {
            for (j=[0:3]) {
                if (i==1) translate([55+j*26.5+3,i*26.5+3,-1])
                    cube([20,20,99]);
                translate([55+j*26.5,i*26.5,0.6])
                    cube([26,26,99]);
            }
        }
           
        x1=18.8;
        y1=11.0;
        translate([216,alt? 20 : 11.4,0]) rotate([0,0,90]) {
            cylinder2([0,y1,0.6]);
            cylinder2([0+x1,y1*2,0.6]);
            cylinder2([0+x1*2,y1,0.6]);
            if (!alt) cylinder2([0+x1*3,y1*2,0.6]);
            cylinder2([0,y1*3,0.6]);
            cylinder2([0+x1,y1*4,0.6]);           
            cylinder2([0+x1*2,y1*3,0.6]);
            if (!alt) cylinder2([0+x1*3,y1*4,0.6]);
        }
    }
}

//cardTray();
tokenTray(1);


       