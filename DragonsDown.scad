



module terrainTray() {
    chips = 12.4; // 12.2 + slop
    terrain = 12.6; // 12.4 + 
    difference() {
        cube([124,142,26]);
        //cylinder(h=26,d=144,$fn=6);
        translate([62,71,13]) rotate([0,0,30]) cylinder(h=26,d=142,$fn=6);
        
        translate([62,71-43,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62,71,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62,71+43,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62+38,71+22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62+38,71-22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62-38,71+22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
        translate([62-38,71-22,0.0]) { cylinder(d=30,h=1); translate([0,0,0.6]) cylinder(d=40.4,h=99); }
    }
}

//terrainTray();

module trayBand() {
    th = 0.5;
    difference() {
        cube([150+th*2,23+th*2,10]);
        translate([th,th,-1])cube([150,23,99]);
    }
}

//trayBand();

module roundTokenTray() {
    difference() {
        cube([2+40.4*4,128,13]);
        for (i=[0:5]) {
            for (j=[0:2]) {
                translate([i*27+14,1+(127/3)*j,13+0.6]) 
                    rotate([-90,0,0]) cylinder(d=26,h=(127/3)-1);
            }
        }
    }
    for (i=[0:5]) {
        for (j=[0:3]) {
            translate([i*27+14,(127/3)*j,13+0.6]) 
                rotate([-90,0,0]) difference() { cylinder(d=26,h=1); cylinder(d=13,h=1); }
        }
    }
}

//roundTokenTray();

module chipTray() {
    difference() {
        cube([1+40.4*4+1,128,20]);
        for (i=[0:3]) {
            for (j=[0:2]) {
                translate([1+i*40.4+20.2,1+j*(127/3),20+0.6]) 
                    rotate([-90,0,0]) cylinder(d=40.4,h=(127/3)-1,$fn=60);
            }
        }
    }
    for (i=[0:3]) {
        for (j=[0:3]) {
            translate([1+i*40.4+20.2,j*(127/3),20+0.6]) 
                rotate([-90,0,0]) difference() { cylinder(d=40.4,h=1,$fn=60); cylinder(d=27,h=1); }
        }
    }
}

// chipTray();

// roundTokenTray();


module cubeDiceTray() {
    rad=5;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    module roundedWell(w,h) {
        hull() {
            translate([rad,rad,rad]) sphere(rad);
            translate([w-rad,rad,rad]) sphere(rad);
            translate([w-rad,h-rad,rad]) sphere(rad);
            translate([rad,h-rad,rad]) sphere(rad);
            translate([rad,rad,99]) sphere(rad);
            translate([w-rad,rad,99]) sphere(rad);
            translate([w-rad,h-rad,99]) sphere(rad);
            translate([rad,h-rad,99]) sphere(rad);
        }
    }
    difference() {
        roundedCube([150,170,22.4]);
        translate([1,170-41,0.6]) roundedCube([31,40,99]);
        translate([1+5,170-41+5,-1]) roundedCube([21,30,99]);
        translate([1,170-61,0.6]) roundedWell(31,19);
        translate([33,170-61,0.6]) roundedWell(37,60);
        translate([33+37+1,170-61,0.6]) roundedWell(77,60);
        for (i=[0:1]) {
            for (j=[0:3]) {
                translate([1+j*((150-5)/4+1),47+31*i,0.6]) roundedWell(145/4,30);
            }
        }
        translate([1,1,0.6]) roundedWell(44,45);
        translate([46,1,0.6]) roundedWell(51,45);
        translate([98,1,0.6]) roundedWell(51,45);
        
    }
}

// cubeDiceTray();

module cardTray() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    difference() {
        roundedCube([136,128,45]);
        translate([1,1,0.6]) roundedCube([36,91,99]);
        translate([99,36,0.6]) roundedCube([36,91,99]);
        //translate([93,1,0.6]) roundedCube([48,40,99]);
        //translate([93,41,0.6]) roundedCube([44,40,99]);
        translate([1,93,0.6]) roundedCube([48,34,99]);
        translate([50,93,0.6]) roundedCube([48,34,99]);
        translate([87,1,0.6]) roundedCube([48,34,99]);
        translate([38,1,0.6]) roundedCube([48,34,99]);
        translate([38,36,0.6]) roundedCube([48,20,99]);
        translate([38,57,0.6]) roundedCube([48,35,99]);
        translate([87,36,0.6]) roundedCube([10,56,99]);
    }
}

// cardTray();

module tokenTray2() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }

    difference() {
        roundedCube([27*4+1,128,27]);
        for (i=[0:3]) {
            for (j=[0:3]) {
                translate([27*i+14,27*j+14,0]) { 
                    cylinder(h=0.6,d=20); translate([0,0,0.6]) cylinder(h=99,d=26.2);
                }
            }
            translate([27*i+14,107.8,0.6+13]) rotate([-90,0,0]) cylinder(h=19.2,d=26.2);
            translate([27*i+1,107.8,0.6+13]) cube([26.2,19.2,99]);
            translate([27*i+14,107.8,0.6+13]) rotate([-90,0,0]) cylinder(h=21.2,d=18);
            translate([27*i+1+4,107.8,0.6+13]) cube([18,21.2,99]);
        }
    }
}

// tokenTray2();

module chipTray2() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }

    difference() {
        roundedCube([142,128,21 /*68-27*/]);
        for (i=[0:6]) {
            for (j=[0:2]) {
                translate([i*20.5+2,22+42*j,0.6+20.2]) rotate([0,90,0]) 
                    cylinder(h=i==6?15:19.5,d=40.4,$fn=60);
            }
        }
    }
}

// chipTray2();

module cardTray2() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    module roundedCube2(x,y,label,vec) {
        if (len(label)) translate([x+vec.x/2,y+vec.y/2,0.61]) linear_extrude(10) 
            text(label,halign="center",valign="center",size = vec.y < 20? 5 : 8);
        translate([x,y,1.21]) roundedCube(vec);
    }
    difference() {
        roundedCube([160,128,32]);
        roundedCube2(1,1,"Starting Spell",[48,13,99]); // starting spell
        roundedCube2(1,15,"Spell",[48,13,99]); // spell
        roundedCube2(1,29,"Items",[48,32,99]); // item
        roundedCube2(1,62,"",[48,7,99]); // extra
        roundedCube2(1,70,"",[48,13,99]); // extra
        roundedCube2(50,70,"",[48,13,99]); // extra
        
        roundedCube2(50,1,"Treasure",[48,35,99]); // treasure
        roundedCube2(50,37,"Deep Treasure",[48,18,99]); // deep treasure
        roundedCube2(50,56,"Mission",[48,13,99]); // mission
        
        roundedCube2(1,121,"Reference",[97,6,99]); // ref cards
        roundedCube2(1,110,"Class",[97,10,99]); // class cards
        roundedCube2(1,99,"Lineage",[97,10,99]); // lineage cards
        roundedCube2(1,84,"",[97,14,99]); // extra
       
        roundedCube2(99,1,"Misc",[60,126,99]); // extra
        /* translate([1,1,0.6]) roundedCube([36,91,99]);
        translate([99,36,0.6]) roundedCube([36,91,99]);
        //translate([93,1,0.6]) roundedCube([48,40,99]);
        //translate([93,41,0.6]) roundedCube([44,40,99]);
        translate([1,93,0.6]) roundedCube([48,34,99]);
        translate([50,93,0.6]) roundedCube([48,34,99]);
        translate([87,1,0.6]) roundedCube([48,34,99]);
        translate([38,1,0.6]) roundedCube([48,34,99]);
        translate([38,36,0.6]) roundedCube([48,20,99]);
        translate([38,57,0.6]) roundedCube([48,35,99]);
        translate([87,36,0.6]) roundedCube([10,56,99]); */
    }
}

cardTray2();

/* difference() {
    sizes = [ 25.4, 25.6, 25.8, 26 ];
    cube([120,30,2.4]);
    for (i=[0:3]) {
        translate([14+ 28*i,15,0]) { cylinder(h=1,d=20); translate([0,0,0.4]) cylinder(h=2,d=sizes[i]);
        }
    }
}*/

module playerTokens() {
    rad=20;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    difference() {
        roundedCube([160,128,2.6]);
        cx = 26.4;
        cy = 27;
        ix = 0.6;
        iy = 1.4;
        td = 25.9;
        for (j=[0:2]) {
            for (i=[0:4]) {
                translate([ix+i*cx + cx,j*cy*1.8+cy/2 + iy,-1]) {
                    cylinder(h=1.6,d=20);
                    translate([0,0,1.6]) cylinder(h=5,d=td);
                }
            }
        }
        for (j=[0:1]) {
            for (i=[0:5]) {
                translate([ix+i*cx + cx/2,cy*1.4+j*cy*1.8 + iy,-1]) {
                    cylinder(h=1.6,d=20);
                    translate([0,0,1.6]) cylinder(h=5,d=td);
                }
            }
        }
    }
}

//playerTokens();

module tokenTray3() {
    rad=3;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    difference() {
        roundedCube([142,64,14]);
        for (i=[0:4])
            translate([i*28+15,2,13.6]) rotate([-90,0,0]) cylinder(d=26,h=60);
    }
}

/* difference() {
    cylinder(h=2,d=25.6);
    translate([-14,0,0]) cube([30,25.6/2,2]);
} */

//tokenTray3();
