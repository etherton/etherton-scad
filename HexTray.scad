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

chitSize = 16.6;

module playerTray(trayWidth, trayHeight, numLanes, offs, doTray, doLid) {
    // 140mm x 92mm is one quarter the folded game board
    // trayWidth = 190;
    // trayHeight = 100;
    // numLanes = 9;
    gutter = (trayWidth - (chitSize * numLanes)) / (numLanes+1);
    // echo (gutter);
    chitThickness = 1.9;
    step = chitThickness * 1.5;
    sepDepth = 1;
    shearYZ = 0.6;

    module lane(col) {
        size = trayHeight - gutter - gutter;
        M = [ [ 1  , 0  , 0  , 0   ],
              [ 0  , 1  , shearYZ, 0   ],
              [ 0  , 0  , 1  , 0   ],
              [ 0  , 0  , 0  , 1   ] ] ;
        translate([col * (chitSize + gutter) + gutter,gutter,floorDepth]) {
            cube([chitSize,size,chitSize]);
            for (n=[step:step:size-step]) {
                translate([0,n,-0.2]) {
                    cube([chitSize,.4,chitSize]);
                }
            }
            for (n=[step:step:size-step*2]) {
                translate([-sepDepth,n+offs,1]) {
                    multmatrix(M) {
                        cube([chitSize + sepDepth*2,chitThickness/2,chitSize]);
                    }
                }
            }
        }
    }

    trayDepth = chitSize * 0.5 + floorDepth;
    lidInset = .8;
    lidInset2 = 1.8;
    lidOverlap = 5;
    gridStep = 10;
    gridSize = 7;
    if (doTray) difference() {
        cube([trayWidth,trayHeight,trayDepth]);
        for (l=[0:numLanes-1])
            lane(l);
        translate([0,0,trayDepth-lidOverlap]) 
            cube([lidInset,trayHeight,lidOverlap]);
        translate([0,0,trayDepth-lidOverlap]) 
            cube([trayWidth,lidInset,lidOverlap]);
        translate([0,trayHeight-lidInset,trayDepth-lidOverlap]) 
            cube([trayWidth,lidInset,lidOverlap]);
        translate([trayWidth-lidInset,0,trayDepth-lidOverlap]) 
            cube([lidInset,trayHeight,lidOverlap]);
    }
    
    // lid
    if (doLid) {
        lidDepth = lidOverlap + 6.6;
        lidInset3 = lidInset - 0.10; // Don't make the lid too tight
        translate([0,trayHeight + 10,0]) {
            difference() {
                cube([trayWidth,trayHeight,lidDepth]);
                translate([lidInset2,lidInset2,floorDepth])            
                    cube([trayWidth-lidInset2*2,trayHeight-lidInset2*2,lidDepth]);
                translate([lidInset3,lidInset3,lidDepth-lidOverlap])
                    cube([trayWidth-lidInset3*2,trayHeight-lidInset3*2,lidOverlap]);
                translate([gutter,gutter,0]) intersection() {
                    cube([trayWidth - gutter*2,trayHeight-gutter*2,floorDepth]);
                    rotate([0,0,45]) 
                        for (i=[-trayWidth*2:gridStep:trayWidth*2])
                            for (j=[-trayHeight*2:gridStep:trayHeight*2])
                                translate([i,j,-floorDepth]) 
                                    cube([gridSize,gridSize,floorDepth*2]);
                }        
            }
         }
    }
}




module divider(list) {
    cols = ceil(sqrt(len(list)));
    sizesByLength = [ 7, 5, 5, 4.5, 4.2, 3.8, 3.7 ];
    for (i=[0:len(list)-1]) {
        translate([(i % cols) * chitSize * 1.5,floor(i / cols) * chitSize,0]) {
            difference() {
                union() {
                    cube([chitSize + 1.4,12.0,0.6]);
                    translate([1.2/2,2,0.6]) cube([chitSize,8,1.8]);
                }
                translate([(chitSize + 1.2)/2,6,-1]) scale([-1,1,1]) linear_extrude(2.0) {
                    text(text=list[i],size=sizesByLength[len(list[i])],
                    halign="center",valign="center");
                }
            }
         }
    }
}

// hexgrid(4,3,true,false);
// hexgrid(4,3,true,true);
//if (false) playerTray(false,true);
// big tray
// playerTray(190,100,9,1,true,false);

//  smaller old tray
//playerTray(140,95,7,1,true,false);

// even smaller ships only
playerTray(100,95,5,0,true,false);

if (false) divider(
    ["Base","BB","BC","BD","BV","CA", 
     "CS","CV","DD","Decoy","DN","F",
     "MSP","Mines","R","SC","SW","SY",
     "T","Titan","Uniq","Flag","Miner","Grav",
     "HI","Inf","Mar","Res","Home","Fleet",
     "DS","SB","Cy","Sup","Temp","MB"]);

// translate([0,80,0])
// Replicators
/* divider(["0","II","IV","V","VII","IX","XI", "XIII", "XV",
   "Flag","Exp","Scan","SW","PD","Home","Colony","Fleet"]); */

//divider2();
            