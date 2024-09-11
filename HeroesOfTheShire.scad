hexHeight = 67; // 50;
hexRadius = hexHeight / 1.7320508;
trayDepth = 22.6; // 24;
floorDepth = 0.6; // 0.6; // 1;
cutoutWidth = hexHeight * 0.25;
wallThickness = 0.6; // 0.6;


module hexgrid(nc,nr,bottomCutout,halfRow) {
    floorDepth = 1;
    for (row=[0:nr-1]) {
        for (col=[0:nc-1]) {
            if (row!=2||col!=1) translate([
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


module token_tray(tokenSize = 17,depth = 10,columns = 11, counts=[]) {
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
            translate([i * (tokenSize+wall) + wall + tokenR,tokenR-cutout,len(counts)? (depth+floorDepth - 1.64 * counts[i+columns]) : floorDepth])
                cylinder(h=depth,d=tokenSize);
            translate([i * (tokenSize+wall) + wall + tokenR,height-tokenR+cutout,len(counts)? (depth+floorDepth - 1.64 * counts[i]) : floorDepth ])
                cylinder(h=depth,d=tokenSize);
        }
    }
}

module single_layer_tray(tokenSize = 17, columns = 10, rows = 5) {
    tokenR = tokenSize/2;
    floorDepth = 0.6;
    wall = 1;
    depth = 1.8;
    cell = tokenSize + wall;
    f = sin(60);
    difference() {
        cube([columns*cell+wall,(rows-1)*(f*cell)+wall*2+tokenSize,floorDepth + depth]);
        translate([wall,wall,0]) {
            for (r=[0:rows-1]) {
                for (c=[0:r%2?columns-2:columns-1]) {
                    offsetX = (r%2)? tokenR*2 : tokenR;
                    translate([offsetX + cell * c,tokenR + (cell*r*f),0]) {
                        cylinder(h=depth,r=tokenR-3,center=true);
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

module scenario_tray(depths=[4,4,4,4,4,4],smallCards = 2,deckThick = 16,cardHeight=88.2,cardWidth=63) {
    trayDepth = 10;
    offsets = [ trayDepth, trayDepth - 1.8, trayDepth - 3.28,
        trayDepth - 5, trayDepth - 6.6, trayDepth - 8.2, 0 ];
    floorDepth = 0.6;
    wall = 1;
    margin = 2;
    width = cardHeight + margin + wall*2;
    height = cardWidth + margin + wall;
    totalDepth = floorDepth + trayDepth + deckThick;
    tokenSize = 17;
    tokenR = tokenSize / 2;
    cutout = 1;
    difference() {
        cube([width,height,totalDepth]);
        translate([0,0,floorDepth]) {
            translate([tokenR-cutout/2,tokenSize*1.5,offsets[depths[0]]-smallCards])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width/2-2*(tokenSize+wall),tokenR-cutout,offsets[depths[1]]])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width/2-(tokenSize+wall),tokenR-cutout,offsets[depths[2]]])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width/2,tokenR-cutout,offsets[depths[3]]])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width/2+(tokenSize+wall),tokenR-cutout,offsets[depths[4]]])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width/2+2*(tokenSize+wall),tokenR-cutout,offsets[depths[5]]])
                cylinder(h=trayDepth,d=tokenSize);
            translate([width-tokenR+cutout/2,tokenSize*1.5,offsets[depths[6]]-smallCards])
                cylinder(h=trayDepth,d=tokenSize);
           translate([(width-41)/2,tokenSize,offsets[4]-smallCards]) {
                difference() {
                    cube([41,31,trayDepth]);
                    translate([10,0,0]) cube([21,31,1.8]);
                }
            }
            if (smallCards)
                translate([(width-66)/2,tokenSize,trayDepth-smallCards])
                    cube([66,44,10]);
        }
        translate([wall,0,trayDepth]) 
            cube([cardHeight + margin,cardWidth + margin, deckThick+1]);
        translate([0,0,trayDepth])
            cube([width,tokenSize*2,deckThick+1]);
    }
    
    give = 0.2;
    tol = (wall+give)*2;
    translate([-tol/2,height+4,0]) {
        margin = (wall+give)*2;
        difference() {
            cube([tol + width,totalDepth + tol,wall + height]);
            translate([wall,wall,wall]) {
                cube([width + give*2,totalDepth + give*2,tol + height]);
                translate([width/2+give,totalDepth/2,height])
                    rotate([-90,0,0]) 
                        scale([2,3.5,1])
                            cylinder(h=totalDepth*2,d=width/3,center=true);
            }
        }
    }     
}

// Heroes terrain hexes
//hexgrid(3,3,false,false);

// Token tray
// token_tray();
// dmg trays + misc condition trays
/*
token_tray(17,9,8,[ 1,2,2,2,4, 4,4,3,
                     2,1,5,3,5, 4,5,4, ]);

// boss tokens (left) and player tokens (right)
translate([0,40,0]) token_tray(17,10,6, [6,5,  6,4,5,1,
                                         4,3,  6,4,3,3]);

// trash mob and boss turn order counters
translate([0,80,0]) token_tray(17,
        [ 6,3,4,4,4,4,3,4,4,4,4
*/

// modifiers
// +1,+1,+1, +2,+2, +3, +4, +5, +1Regen, +2Regen, +3Regen
// -1,-1,-1, -2,-2, -3, -4, -5, +1Regen, +2Regen, +4Regen
// token_tray(17,12.2,11, [ 7,7,6, 7,6, 7, 3, 3,   7,4,6,
//                          7,7,6, 7,6, 7, 3, 3,   7,4,4]);
//standee_tray();
//single_layer_tray(16.5,8,5);

// 71 total player tokens (turn order and extra hero-specific tokens)
// there are 2 extra tinker tokens because only 10 can be used at once
// tray is 11,10,11,10,11,10,11 = 74 total so they will fit
//single_layer_tray(16.5,11,7);

// scenario_tray();

// Ice
scenario_tray([4,4,5,6,5,4,4], 2, 13.5);

// fire: 16 trash mobs, 13 extra, 3 standee
// ice: 16 trash mobs, 16 extra, 3 standee
// forest: 16 trash mobs, 15 extra, 3 standee
// water: 16 trash mobs, 9 extra

// worst is 32 + 3 standees
// m m m m  
// m m m m
// m m m m
// m m m m



            
