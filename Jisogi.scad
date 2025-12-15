// Jisogi

module drawers(size,count = 3) {
    width = size.x;
    depth = size.y;
    height = size.z;
    thick = 1.2;
    dh = (height - thick * (count + 1)) / count;
    echo(dh);
    difference() {
        cube([width,depth,height]);
        for (i=[0:count-1])
            translate([thick,thick,thick + (dh + thick) * i]) 
                cube([width-thick*2,depth,dh]);
        translate([width/2,0,0]) cylinder(d=20,h=99);
        translate([width/2,depth,0]) cylinder(d=20,h=99);

    }
}

module drawer1(size,height = 16,split = true) {
    width = size.x;
    depth = size.y;
    difference() {
        cube([width-3,depth-2.6,height]);
        difference() {
            translate([0.8,0.8,0.8]) cube([width-3-1.6,depth-2.6-1.6,height]);
            translate([(width-3)/2,0,0]) cylinder(d=21.6,h=height);
            translate([(width-3)/2,depth-2.6,0]) cylinder(d=21.6,h=height);
        }
        translate([(width-3)/2,0,0]) cylinder(d=20,h=height);
        translate([(width-3)/2,depth-2.6,0]) cylinder(d=20,h=height);
    }
    if (split)
        translate([(width-2.6)/2-0.4,21.6/2,0])
            cube([0.8,depth-21.6-2,height]);
}

module workerStorage() {
    module tube(xo,yo,di) {
        translate([xo,yo,0.8])
            cylinder(d=di,h=23);       
    }
    ofs = 14;
    difference() {
        translate([-20,-20,0]) cube([40,40,23.8]);
        tube(-ofs, ofs,25);
        tube(-ofs,-ofs,25);
        tube( ofs, ofs,25);
        tube( ofs,-ofs,25);
    }
}

module roundedCube(vec,rad) {
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
        translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
        translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
    }
}

module tokenTray(height = 22) {
    difference() {
        roundedCube([124,74,height],3);
        for (i=[0:3]) {
            for (j=[0:1]) {
                translate([12.8 + 25 * i,12.8 + j * 25,0]) {
                    cylinder(d=20,h=99);
                    translate([0,0,height-12]) cylinder(d=25.6,h=99);
                }
            }
            translate([9.6 + 25 * i,65,height-10]) cylinder(d=10.6,h=99);
            translate([18 + 25 * i,59,height-10]) cylinder(d=10.6,h=99);
        }
        translate([124-12.8,25,0]) {
            cylinder(d=20,h=99);
            translate([0,0,height-12]) cylinder(d=25.6,h=99);
        }
        translate([102,42,height-12]) cube([21,26,99]);
        //translate([104,48,0]) cube([21-4,26-12,99]);
        translate([0,50.6,height-5]) cube([999,99,99]);
    }
        
}
//d1 = [96,66,36];

/*
d1 = [90,70,36];
rotate([90,0,0]) drawers(d1,2);
translate([-50,8,0]) drawer1(d1);
translate([50,8,0]) drawer1(d1);
*/

/* 
d1 = [96,66,36];
rotate([90,0,0]) drawers(d1,2);
translate([-50,8,0]) drawer1(d1,16,true);
translate([50,8,0]) drawer1(d1,16,false);
*/

//workerStorage();

// tokenTray();
//tokenTray(13);