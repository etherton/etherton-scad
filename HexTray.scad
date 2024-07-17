hexHeight = 50;
hexRadius = hexHeight / 1.7320508;
trayDepth = 20;
floorDepth = 1;
cutoutWidth = hexHeight * 0.35;
wallThickness = 0.4;

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
                            translate([0,0,floorDepth+cutoutWidth]) {
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
                        cylinder(h=trayDepth,r=hexRadius*0.7,$fn=6);
                }
            }
        }
    }
}

module playerTray() {
    // 140mm x 92mm is one quarter the folded game board
    trayWidth = 150;
    trayHeight = 95;
    chitSize = 17; // actually 16
    numLanes = 8;
    gutter = (trayWidth - (chitSize * (numLanes-1))) / numLanes;
    chitThickness = 1.9;
    step = chitThickness * 4;
    pegSize = 2;

    module lane(col) {
        size = trayHeight - gutter - gutter;
        translate([col * (chitSize + gutter) + gutter,gutter,floorDepth]) {
            cube([chitSize,size,chitSize]);
            for (n=[0:step:size]) {
                translate([0,n,-0.4]) cube([chitSize,chitThickness,chitSize]);
                translate([(chitSize-pegSize)/2,n+step/2+chitThickness/2,-floorDepth*2]) cube([pegSize,pegSize,floorDepth*4]);
            }
        }
    }

    difference() {
        cube([trayWidth,trayHeight,chitSize * 0.7071 + floorDepth]);
        for (l=[0:numLanes-1])
            lane(l);
    }
    
    translate([trayWidth + 10,0,0]) {
        sizeX = chitSize * 0.7071;
        sizeY = chitSize * 0.7071;
        linear_extrude(chitSize - 0.5) {
            polygon([[0,0], [sizeX,0], [sizeX,sizeY]]);
        }
        translate([sizeX/2,-0.6,chitSize/2]) cube([pegSize/2.1,1,pegSize/2.1],true);
    }
}


hexgrid(4,3,true,false);
// hexgrid(4,3,true,true);
// playerTray();
        
            