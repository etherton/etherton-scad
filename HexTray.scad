hexHeight = 50;
hexRadius = hexHeight / 1.7320508;
trayDepth = 20;
floorDepth = 1;
cutoutWidth = hexHeight * 0.25;
wallThickness = 0.6;

module hexgrid(nc,nr,bottomCutout,halfRow) {
    for (row=[0:nr-1]) {
        for (col=[0:nc-1]) {
            if (!halfRow || row || (col%2)) translate([
                col * 1.5 * hexRadius,
                ((col%2)? hexRadius * 0.866025 : 0) + row * hexHeight,0]) {
                difference() {
                    cylinder(h=trayDepth,r=hexRadius,$fn=6);
                    translate([0,0,floorDepth]) {
                        cylinder(h=trayDepth,r=hexRadius-wallThickness,$fn=6);
                    }
                    for (r=[0:120:240]) {
                        rotate([0,0,r]) {
                            translate([0,0,floorDepth+cutoutWidth/2+trayDepth/2]) {
                                cube([cutoutWidth,hexRadius*2,trayDepth],true);
                            }
                        translate([0,0,floorDepth+cutoutWidth/2]) {
                            rotate([90,0,0]) {
                                cylinder(h=hexRadius*2,r=cutoutWidth/2,center=true);
                            }
                       }
                    }
                     }
                    if (bottomCutout)
                        cylinder(h=trayDepth,r=hexRadius*0.6,$fn=6);
                }
            }
        }
    }
}

chitSize = 17;

module playerTray(doLid) {
    // 140mm x 92mm is one quarter the folded game board
    trayWidth = 190;
    trayHeight = 100;
    numLanes = 9;
    gutter = (trayWidth - (chitSize * numLanes)) / (numLanes+1);
    chitThickness = 1.9;
    step = chitThickness * 1.5;
    pegSize = 2;
    sepDepth = 1.3;
    notchDepth = 1;
    notchWidth = 10.6;
    //echo(gutter);

    module lane(col) {
        size = trayHeight - gutter - gutter;
        M = [ [ 1  , 0  , 0  , -sepDepth   ],
              [ 0  , 1  , 0.7, 0   ],  // The "0.7" is the skew value; pushed along the y axis as z changes.
              [ 0  , 0  , 1  , 0.8   ],
              [ 0  , 0  , 0  , 1   ] ] ;
        translate([col * (chitSize + gutter) + gutter,gutter,floorDepth]) {
            cube([chitSize,size,chitSize]);
            /*for (n=[0:step:size-step*2]) {
                translate([0,n,-0.4]) {
                    cube([chitSize,chitThickness/2,chitSize]);
                }
            }*/
            for (n=[0:step:size-step*2]) {
                translate([0,n+3.4,3]) {
                    multmatrix(M) {
                        cube([chitSize + sepDepth*2,chitThickness/2,chitSize]);
                    }
                }
            }
        }
    }

    trayDepth = chitSize * 0.5 + floorDepth;
    difference() {
        cube([trayWidth,trayHeight,trayDepth]);
        for (l=[0:numLanes-1])
            lane(l);
        translate([trayWidth-notchDepth,trayHeight/2-notchWidth/2,0]) {
            cube([notchDepth,notchWidth,notchDepth]);
        }
        translate([0,trayHeight/2-notchWidth/2,0]) {
            cube([notchDepth,notchWidth,notchDepth]);
        }
        translate([trayWidth/2-notchWidth/2,0,0]) {
            cube([notchWidth,notchDepth,notchDepth]);
        }
        translate([trayWidth/2-notchWidth/2,trayHeight-notchDepth,0]) {
            cube([notchWidth,notchDepth,notchDepth]);
        }
    }
    
    // lid
    if (doLid) {
        lidDepth = 8;
        claspDepth = 1;
        translate([0,trayHeight + 10,0]) {
            difference() {
                cube([trayWidth,trayHeight,lidDepth]);
                translate([gutter,gutter,floorDepth]) {
                    cube([trayWidth-gutter*2,trayHeight-gutter*2,lidDepth+1]);
                }
            }
            translate([trayWidth/2-notchWidth/2,-claspDepth,0]) {
                cube([notchWidth,claspDepth,lidDepth+trayDepth]);
                translate([0,claspDepth,lidDepth+trayDepth-(notchDepth-0.2)]) {
                    cube([notchWidth,notchDepth,notchDepth-0.2]);
                }
            }
            translate([trayWidth/2-notchWidth/2,trayHeight,0]) {
                cube([notchWidth,claspDepth,lidDepth+trayDepth]);
                translate([0,-claspDepth,lidDepth+trayDepth-(notchDepth-0.2)]) {
                    cube([notchWidth,notchDepth,notchDepth-0.2]);
                }
            }
        }
    }
}




module divider(list) {
    cols = ceil(sqrt(len(list)));
    for (i=[0:len(list)-1]) {
        translate([(i % cols) * chitSize * 1.5,floor(i / cols) * chitSize,0]) {
            difference() {
                union() {
                    cube([chitSize + 1.9,15.0,0.6]);
                    translate([1.9/2,7,0.6]) cube([chitSize,6,2.2]);
                }
                translate([(chitSize + 1.9)/2,11,-1]) scale([-1,1,1]) linear_extrude(2) {
                    text(text=list[i],size=4,halign="center",valign="center");
                }
            }
         }
    }
}

/* module divider2() {
    depth = 2.4;
    for (i=[0:4]) {
        for (j=[0:4]) {
            translate([chitSize * 1.5 * i,chitSize * 1.5 * j,0]) {
                cube([chitSize+1.9,chitSize*0.75,0.6]);
                translate([1.9/2,chitSize/2,0.6]) {
                    cube([chitSize,chitSize/4,depth]);
                    translate([-1.9/2,0,depth]) {
                        cube([chitSize+1.9,chitSize/4,0.6]);
                    }
                }
            }
        }
    }
} */


// hexgrid(4,3,true,false);
// hexgrid(4,3,true,true);
//playerTray();
divider(
    ["Base","BB","BC","BD","BV","CA" /*,
     "Colony","CV","DD","Decoy","DN","F",
     "MSP","Mines","R","SC","SW","SY",
     "T","Titan","Uniq","Flag","Miner","Grav",
     "HI","Inf","Mar","Res","Home","Fleet",
     "DS","SB","Cy","Sup","Temp","MB" */]);

// translate([0,80,0])
// Replicators
/* divider(["0","II","IV","V","VII","IX","XI", "XIII", "XV",
   "Flag","Exp","Scan","SW","PD","Home","Colony","Fleet"]); */

//divider2();
            