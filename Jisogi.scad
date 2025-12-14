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

module drawer1(size,height = 10.2) {
    width = size.x;
    depth = size.y;
    difference() {
        cube([width-2.6,depth-2.6,height]);
        difference() {
            translate([0.8,0.8,0.8]) cube([width-2.6-1.6,depth-2.6-1.6,height]);
            translate([(width-2.6)/2,0,0]) cylinder(d=21.6,h=height);
            translate([(width-2.6)/2,depth-2.6,0]) cylinder(d=21.6,h=height);
        }
        translate([(width-2.6)/2,0,0]) cylinder(d=20,h=height);
        translate([(width-2.6)/2,depth-2.6,0]) cylinder(d=20,h=height);
    }
    
        translate([(width-2.6)/2-0.4,21.6/2,0])
            cube([0.8,depth-21.6-2,height]);
}

//d1 = [90,70,36];
d1 = [96,66,36];

rotate([90,0,0]) drawers(d1,3);

translate([0,40,0]) drawer1(d1);