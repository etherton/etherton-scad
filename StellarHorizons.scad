// Stellar Horizons

$fn=60;
thick = 2.0;

module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

module well(x,y,z,w,h,rad = 5) {
    translate([x,y,z]) hull() {
        translate([rad,rad,rad]) sphere(r=rad);
        translate([w-rad,rad,rad]) sphere(r=rad);
        translate([rad,h-rad,rad]) sphere(r=rad);
        translate([w-rad,h-rad,rad]) sphere(r=rad);
        translate([rad,rad,99]) sphere(r=rad);
        translate([w-rad,rad,99]) sphere(r=rad);
        translate([rad,h-rad,99]) sphere(r=rad);
        translate([w-rad,h-rad,99]) sphere(r=rad);
    }
}

module smallSolarTray() {
    w=184; h = 158;
    moonDiam = 77;
    difference() {
        roundedCube([w,h,30],5);
        translate([w/4,3*h/4,-1]) { 
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,2]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4,3*h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,2]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4-moonDiam/2,3*h/4-moonDiam/2,13]) cube([moonDiam,moonDiam,99]);
        
        translate([w/4,h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,4]) cylinder(d=moonDiam,h=99);
        }
        translate([3*w/4,h/4,-1]) {
            cylinder(d=moonDiam*0.75,h=99); translate([0,0,4]) cylinder(d=moonDiam,h=99);
        }
        translate([w/2,h/2,-1]) cylinder(d=40,h=99);
        translate([w/2,h/2,15]) cylinder(d=180,h=99,$fn=6);
    } 
}


        

module resourceTray() {
    fl = 1;

    difference() {
        roundedCube([184,41 /*158*/,26],5);
        for (row=[0:3]) {
            well(1,1 + row * 39.25,fl, 24,38);
            well(26,1 + row * 39.25,fl, 30,38);
            well(57,1 + row * 39.25,fl,  39,38);
            well(97,1 + row * 39.25,fl,  42,38);
            well(140,1 + row * 39.25,fl,  43,38);
        }
    }
}

module settlementTray() { // x2
    extra = 5;
    x3 = 2+11*4 + extra;
    x5 = x3 + 13*2 + extra;
    x15 = x5 + 11*2 + extra;
    offsets = [ 
        2, 2+11, 2+11*2, 2+11*3,  // 1x (5 each)
        x3, x3 + 13, // 3x (6 each)
        x5, x5 + 11, // 5x
        x15, x15 + 11 // 15X
    ];
    five = 10.6;
    six = 12.6;
    sizes = [ five, five, five, five, six, six, five, five, five, five ];
            
    difference() {
        roundedCube([23,offsets[9] + sizes[9] + 2,10],rad=2);
        for (i=[0:9])
            translate([1,offsets[i],1]) cube([21,sizes[i],99]);
    }
}

module structureTray() { // x3
    difference() {
        roundedCube([28,101,14],rad=2);
        for (i=[0:5]) {
            translate([1,2+i*16,0.6]) cube([26,i==5?17 : 15,99]);
        }   
    }
}


//smallSolarTray();
//translate([200,0,0]) 
resourceTray();
// settlementTray(); // x2
//structureTray(); // x3