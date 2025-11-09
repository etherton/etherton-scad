// Millennia Tracks of Time player bits organizer

module roundedCube(vec,rad=3) {
	hull() {
		translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
		translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
		translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
		translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
	}
}

module playerBox() {
    w=83;
    h=124;
	difference() {
		roundedCube([w,124,12]);
        
		translate([(w-64)/2,90,4])
			roundedCube([64,32,99]);
		translate([(w-64)/2,75,4])
			roundedCube([64,14,99]);
            
		translate([67,62,0.6])
			cylinder(d=17,h=99);
		translate([67,62,6])
			cylinder(d=22,h=99);
            
		translate([42,62,9])
			cylinder(d=17,h=99);
		translate([22,62,9])
			cylinder(d=17,h=99);
            
        translate([9,56,2])
            roundedCube([46,12,99]);
            
        /* translate([10,41,10])
            roundedCube([82-20,18,99]); */
        
		/* translate([(w-33)/2,60,4])
			roundedCube([33,11,99]);*/
            
        translate([(w-70)/2,4,0.6])
            roundedCube([70,46,99]);
        translate([(w-50)/2,4+8,-1]) 
            roundedCube([50,46-16,99]);
            
        translate([w/2,130/2,10.6])
            linear_extrude(scale=0.95,height=2)
                square([81,128],center=true);
               
        /* translate([82/2,124,16])
            rotate([90,0,0])
                cylinder(h=10,d=20);*/
        translate([-1,h-2,10.6])
            cube([99,10,99]);
    }
}	

module playerBoxTest() {
	difference() {
		roundedCube([83,124,2]);
        translate([83/2,130/2,0.6])
            linear_extrude(scale=0.95,height=2)
                square([81,128],center=true);
        translate([-1,122,0.6])
            cube([99,10,99]);
    }
}

playerBox();
