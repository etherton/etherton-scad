



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
    module roundedWell2(x,y,label,w,h,thick = 1.2,so = 8) {
        if (len(label)) translate([x+w/2,y+h/2,thick-0.6]) linear_extrude(10) 
            text(label,halign="center",valign="center",size = so);
        translate([x,y,thick]) roundedWell(w,h);
    }
    difference() {
        roundedCube([150,170,22.4]);
        translate([1,170-41,0.6]) roundedCube([31,40,99]);
        translate([1+5,170-41+5,-1]) roundedCube([21,30,99]);
        roundedWell2(1,170-61,"d6",31,19,8);
        roundedWell2(33,170-61,"\u2665",32,60,5,20);
        roundedWell2(66,170-61,"Dice",83,60,8);
        for (i=[0:1]) {
            for (j=[0:3]) {
                translate([1+j*((150-5)/4+1),47+31*i,0.6]) roundedWell(145/4,30);
            }
        }
        roundedWell2(1,1,"Might",44,45);
        roundedWell2(46,1,"Speed",51,45);
        roundedWell2(98,1,"Status",51,45);
        
    }
}

//cubeDiceTray();

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

// cardTray2();

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

module playerTokensCard() {
    rad=3;
    td = 25.9;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    module bay(x,y) {
        translate([x,y,-1]) {
            cylinder(h=5,d=20);
            translate([0,0,1.6]) cylinder(h=5,d=td);
        }
    }
    w = 100;
    h = 66;  
    m = 0.6;
    c = (m + td/2 + w / 2) / 2;
    difference() {
        roundedCube([100,66,2.6]);
        bay(td/2+m,td/2+m);
        bay(w/2,td/2+m);
        bay(w-td/2-m,td/2+m);
        
        bay(c,h/2);
        bay(w-c,h/2);

        bay(td/2+m,h-td/2-m);
        bay(w/2,h-td/2-m);
        bay(w-td/2-m,h-td/2-m);
    }
}

// playerTokens();

module playerTokensNL() {
    rad=10;
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
        for (j=[0:0]) {
            for (i=[0:4]) {
                translate([ix+i*cx + cx,j*cy*1.8+cy/2 + iy,-1]) {
                    cylinder(h=1.6,d=20);
                    translate([0,0,1.6]) cylinder(h=5,d=td);
                }
            }
        }
        for (j=[0:0]) {
            for (i=[0:5]) {
                translate([ix+i*cx + cx/2,cy*1.4+j*cy*1.8 + iy,-1]) {
                    cylinder(h=1.6,d=20);
                    translate([0,0,1.6]) cylinder(h=5,d=td);
                }
            }
        }
        for (i=[0:5]) {
            translate([12 + 23*i,53,-1]) {
                translate([2,2,0]) cube(16);
                translate([0,0,1.6]) cube(20);
            }
        }
        for (j=[0:1]) {
            for (i=[0:4]) {
                translate([11+28*i,73.8+26.6*j,-1]) {
                    translate([2,2,0]) cube(21.4);
                    translate([0,0,1.6]) cube(25.4);
                }
            
            }
        }
    }
}


playerTokensNL();

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


module cardTray3() {
    rad=2;
    module roundedCube(vec) {
        hull() {
            translate([rad,rad,0]) cylinder(h=vec.z,r=rad);
            translate([rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,vec.y-rad,0]) cylinder(h=vec.z,r=rad);
            translate([vec.x-rad,rad,0]) cylinder(h=vec.z,r=rad);
        }
    }
    module well(x,y, w,h, step=6) {
        translate([x,y,0.6]) cube([w,h,99]);
        for (i=[0:floor((h-step)/step)]) {
            translate([x-1.2,step/2+i*step+y,13.6]) cube([w+2.4,1.8,99]);
            if (w > 50)
                translate([x+w/2-6,step/2+i*step+y,0]) cube([12,1.8,99]);
        }
    }
    difference() {
        roundedCube([159,128,30]);
        well(3,68, 101,58);
        well(3,2, 49,64);
        well(55,2, 49,64);
        well(107,2, 49,124);

     }
}

// cardTray3();

/* module cardDivider(w) {
    rad=1;
    linear_extrude(0.8) {
        offset(r=rad) {
            polygon([ [0.2+rad,0+rad], [w-0.2-rad,0+rad], [w-0.2-rad,10+rad], [w+0.5-rad,10+rad], [w+0.5-rad,30-rad], 49
            [-0.5+rad,30-rad], [-0.5+rad,10+rad], [0.2+rad,10+rad] ]);
        }
    }
} */

/* union() {
    cube([49+1.6,16,1.6]);
    translate([1,0,0]) cube([48.6,28,1.6]);
} */

/* union() {
    cube([101+1.6,15,1.6]);
    translate([1,0,0]) cube([100.6,29,1.6]);
    translate([102.6/2-5,0,0]) cube([10,29.8,1.6]);
} */

// cardDivider(50.66);
//cardDivider(103);

