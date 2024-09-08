hexHeight = 66; // 50;
hexRadius = hexHeight / 1.7320508;
trayDepth = 32; // 24;
floorDepth = 0.6; // 0.6; // 1;
cutoutWidth = hexHeight * 0.25;
wallThickness = 0.6; // 0.6;

module SideTray(tray=2) {
    d = trayDepth;
    pX = 0.5 * hexRadius;
    pY = (0.5 * hexHeight);
    w = 44;
    f = 1.5;
    inset = 0.8;
    module topRight() {
       polygon([
        [0,0], [pX,pY], [0,pY * 2], [pX, pY * 3],
        [-inset,pY * 4 + inset], [-2*pX,pY * 4 + inset], [-3*pX,pY*5],
        [w, pY * 5], [w, 0]]);
    }
    gutter = 18;
    module bottomRight() {
        polygon([
        [0,-gutter], [0,0], [pX,pY],
        [0,pY*2],[pX,pY*3],[0,pY*4],[pX,pY*5],[0,pY*6],
        [w,pY*6],[w,-gutter]]);
    }
    module bottomLeft() {
        polygon([
            [0,0],[pX*3,0],[pX*4,-pY],
            [pX*6,-pY],[pX*7,0],[pX*9,0],[pX*10,-pY],
            [pX*12,-pY],[pX*12,-pY-gutter],[0,-pY-gutter]]);
    }
    module bucket() {
        polygon([[0,0],[pX*4,0],[pX*3,-pY],[pX,-pY]]);
    }
    module cardTray() {
        polygon([[0,0],[pX*13,0],[pX*12,pY],[pX*13,pY*2],
        [pX*12,pY*3],[pX*13,pY*4],[0,pY*4]]);
    }
    if (tray==0) difference() {
        linear_extrude(trayDepth) topRight();
        translate([0,0,floorDepth]) 
            linear_extrude(trayDepth) 
                offset(delta=-inset) topRight();
    }
    else if (tray==1) union() {
        difference() {
            linear_extrude(trayDepth) bottomRight();
            translate([0,0,floorDepth]) 
                linear_extrude(trayDepth) 
                    offset(delta=-inset) bottomRight();
        }
        translate([pX,pY-inset/2,0]) cube([w-pX,inset,trayDepth]);
        translate([pX,pY*3-inset/2
        ,0]) cube([w-pX,inset,trayDepth]);
    }
    else if (tray==2) union() {
        trayDepth2 = 10;
        difference() {
            linear_extrude(trayDepth2) bottomLeft();
            translate([0,0,floorDepth]) 
                linear_extrude(trayDepth2) 
                    offset(delta=-inset) bottomLeft();
            translate([inset,-pY-gutter,trayDepth2]) cube([50-inset,inset*2,99]);
            translate([50+inset,-pY-gutter,10]) cube([50-inset,inset*2,99]);
            translate([100+inset,-pY-gutter,10]) cube([50-inset,inset*2,99]);
            translate([150+inset,-pY-gutter,10]) cube([50-inset,inset*2,99]);
        }
        translate([0,-pY-inset,0]) cube([pX*12,inset,trayDepth]);
        translate([50,-pY-gutter,0]) cube([inset,gutter-inset*2,trayDepth2]);
        translate([61,-pY-gutter,0]) cube([inset,gutter-inset*2,trayDepth2]);
        translate([111,-pY-gutter,0]) cube([inset,gutter-inset*2,trayDepth2]);
        translate([122,-pY-gutter,0]) cube([inset,gutter-inset*2,trayDepth2]);
   }
   else if (tray==3) {
       difference() {
            linear_extrude(trayDepth) bucket();
            translate([0,0,floorDepth]) 
                linear_extrude(trayDepth2) 
                    offset(delta=-inset) bucket();
       }
   }
   else if (tray==4) {
       difference() {
           linear_extrude(trayDepth) cardTray();
           translate([0,0,floorDepth]) 
                linear_extrude(trayDepth) 
                    offset(delta=-inset) cardTray();
           translate([20,20,0]) cube([30,pY*4-40,floorDepth]);
           translate([90,20,0]) cube([30,pY*4-40,floorDepth]);
       }
       translate([70,0,0]) cube([inset,pY*4,trayDepth]);
       translate([140,0,0]) cube([inset,pY*4,trayDepth]);
       translate([140,pY*2-inset/2,0]) cube([pX*13-140-inset,inset,trayDepth]);
    }

        /* translate([0,0,floorDepth]) {
            linear_extrude(d) polygon([
                [inset*f,inset], [pX+inset,pY], [inset,pY*2], 
                [pX + inset, pY * 3 - inset/2], [w - inset,pY * 3 - inset/2],
                [w - inset, inset]]);
            linear_extrude(d) polygon([
                [pX + inset, pY * 3 + inset/2], [inset, pY * 4], 
                [pX + inset, pY * 5], [inset*f,pY * 6 - inset],
                [w - inset, pY * 6 - inset], [w - inset,pY * 3 + inset/2]]);
        } */
    
}

module hexgrid(nc,nr,bottomCutout,halfRow) {
    floorDepth = 1;
    for (row=[0:nr-1]) {
        for (col=[0:nc-1]) {
            if (!halfRow || row || (col!=0)) translate([
                col * 1.5 * hexRadius,
                ((col%2)? hexRadius * 0.866025 : 0) + row * hexHeight,0]) {
                difference() {
                    cylinder(h=trayDepth,r=hexRadius,$fn=6);
                    translate([0,0,floorDepth]) {
                        cylinder(h=trayDepth,r=hexRadius-wallThickness,$fn=6);
                    }
                    for (r=[120:120:240]) {
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


module token_tray(tokenSize = 17,depth = 10,columns = 11) {
    tokenR = tokenSize/2;
    cutout = 1;
    wall = 0.6;
    width = (tokenSize+wall) * columns + wall;
    height = tokenSize * 2 - cutout * 2 + 1;

    floorDepth = 0.6;
    echo(width,"x",height);
    difference() {
        cube([width,height,depth+floorDepth]);
        for (i=[0:columns-1]) {
            translate([i * (tokenSize+wall) + wall + tokenR,tokenR-cutout,floorDepth])
                cylinder(h=depth,d=tokenSize);
            translate([i * (tokenSize+wall) + wall + tokenR,height-tokenR+cutout,floorDepth])
                cylinder(h=depth,d=tokenSize);
        }
    }
}

module single_layer_tray(tokenSize = 17, columns = 10, rows = 5) {
    tokenR = tokenSize/2;
    floorDepth = 0.6;
    wall = 1;
    depth = 1.6;
    cell = tokenSize + wall;
    f = sin(60);
    difference() {
        cube([columns*cell+wall,(rows-1)*(f*cell)+wall*2+tokenSize,floorDepth + depth]);
        translate([wall,wall,0]) {
            for (r=[0:rows-1]) {
                for (c=[0:r%2?columns-2:columns-1]) {
                    offsetX = (r%2)? tokenR*2 : tokenR;
                    translate([offsetX + cell * c,tokenR + (cell*r*f),0]) {
                        cylinder(h=depth,r=tokenR-4,center=true);
                        translate([0,0,floorDepth]) cylinder(h=depth+1,r=tokenR);
                    }
                }
            }
        }
    }
}

module standee_tray(tokenDiam = 31,tokenHeight=41,depth = 7.5,columns = 5) {
    tokenR = tokenDiam/2;
    cutout = 1;
    height = tokenHeight * 2 - cutout * 2 + 1;
    wall = 0.6;
    floorDepth = 0.6;
    difference() {
        cube([(tokenDiam+wall) * columns + wall,height,depth]);
        for (i=[0:columns-1]) {
            translate([i * (tokenDiam+wall) + wall + tokenR,tokenR-cutout,floorDepth])
                cylinder(h=depth,d=tokenDiam);
            translate([i * (tokenDiam+wall) + wall + tokenR,height-tokenR+cutout,floorDepth])
                cylinder(h=depth,d=tokenDiam);
            translate([i * (tokenDiam+wall) + wall,tokenR-cutout,floorDepth])
                cube([tokenDiam,tokenHeight-tokenR,depth]);
            translate([i * (tokenDiam+wall) + wall,tokenHeight-cutout+wall,floorDepth])
                cube([tokenDiam,tokenHeight-tokenR,depth]);
        }
    }
}

// Heroes terrain hexes
//hexgrid(2,3,false,true);

// Token tray
//token_tray();
//standee_tray();
single_layer_tray();


            
