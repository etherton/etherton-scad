hexHeight = 50;
hexRadius = hexHeight / 1.7320508;
trayDepth = 24;
floorDepth = 0.6; // 1;
cutoutWidth = hexHeight * 0.25;
wallThickness = 0.6;

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
    module topRightExp() {
       polygon([
        [-2*pX,0], [-3*pX,pY], [-2*pX,pY * 2], [-3*pX, pY * 3],
        [/*-inset*/-2*pX,pY * 4 + inset], [-2*pX,pY * 4 + inset], [-3*pX,pY*5],
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
        linear_extrude(trayDepth) topRightExp();
        translate([0,0,floorDepth]) 
            linear_extrude(trayDepth) 
                offset(delta=-inset) topRightExp();
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

module NumbersTray() {
    inset = 0.8;
    floorDepth = 0.8;
    width = 33;
    height = 280;
    difference() {
        cube([width,height,19.4]);
        translate([inset,inset,floorDepth]) cube([width-inset*2,height/2,99]);
        translate([inset,inset+height/2+inset,floorDepth]) cube([width-inset*2,height*0.3-inset,99]);
        translate([inset,inset+height*0.80+inset,floorDepth]) cube([width-inset*2,height*0.2-inset*3,99]);
    }
}

module hexgrid(nc,nr,bottomCutout,halfRow,hack) {
    floorDepth = 1;
    for (row=[0:nr-1]) {
        for (col=[0:nc-1]) {
            if (!halfRow || row || (col%2)) if (!hack || col) translate([
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
    shearYZ = 0.7;

    module lane(col) {
        size = trayHeight - gutter - gutter;
        M = [ [ 1  , 0  , 0  , 0   ],
              [ 0  , 1  , shearYZ, 0   ],
              [ 0  , 0  , 1  , 0   ],
              [ 0  , 0  , 0  , 1   ] ] ;
        translate([col * (chitSize + gutter) + gutter,gutter,floorDepth]) {
            cube([chitSize,size,chitSize]);
            /* for (n=[step:step:size-step]) {
                translate([0,n,-0.2]) {
                    cube([chitSize,.4,chitSize]);
                }
            } */
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
        lidDepth = lidOverlap + 6;
        lidInset3 = lidInset - 0.10; // Don't make the lid too tight
        translate([0,doTray? trayHeight + 10 : 0,0]) {
            difference() {
                cube([trayWidth,trayHeight,lidDepth]);
                translate([lidInset2,lidInset2,floorDepth])            
                    cube([trayWidth-lidInset2*2,trayHeight-lidInset2*2,lidDepth]);
                translate([lidInset3,lidInset3,6.5])
                    cube([trayWidth-lidInset3*2,trayHeight-lidInset3*2,lidOverlap]);
                /* translate([gutter,gutter,0]) intersection() {
                    cube([trayWidth - gutter*2,trayHeight-gutter*2,floorDepth]);
                    rotate([0,0,45]) 
                        for (i=[-trayWidth*2:gridStep:trayWidth*2])
                            for (j=[-trayHeight*2:gridStep:trayHeight*2])
                                translate([i,j,-floorDepth]) 
                                    cube([gridSize,gridSize,floorDepth*2]);
                }  */      
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
                    translate([1.2/2,2,0.6]) cube([chitSize,8,1.4]);
                }
                translate([(chitSize + 1.2)/2,6,-1]) scale([-1,1,1]) linear_extrude(1.6) {
                    text(text=list[i],size=sizesByLength[len(list[i])],
                    font="Liberation Serif:style=Bold",
                    halign="center",valign="center");
                }
            }
         }
    }
}

module cardtray() {
    cardWidth = 65;
    cardHeight = 91;
    difference() {
        cube([218,cardWidth*2+wallThickness*3,14]);
        for(i=[0:1]) {
            for (j=[0:1]) {
                translate([wallThickness + i * (cardHeight+wallThickness),
                    wallThickness + j * (cardWidth+wallThickness),floorDepth]) {
                    cube([cardHeight,cardWidth,99]);
                    translate([10,10,-1]) cube([cardHeight-20,cardWidth-20,10]);
                }
            }
        }
    }
}

module cardtray2() {
    cardWidth = 66;
    cardHeight = 92;
    counterWellWidth = 218 - (wallThickness*5+cardWidth*3);
    counterWellHeight = cardHeight/2 - wallThickness;
    difference() {
        cube([218,cardHeight + wallThickness*2,14]);
        for (i=[0:2]) {
            translate([wallThickness + i * (cardWidth+wallThickness),
                wallThickness,floorDepth]) {
                cube([cardWidth,cardHeight,99]);
                translate([10,10,-1])
                    cube([cardWidth-20,cardHeight-20,10]);
            }
        }
        translate([wallThickness*4+cardWidth*3,wallThickness,floorDepth]) {
            cube([counterWellWidth,counterWellHeight,99]);
            translate([0,counterWellHeight+wallThickness,0])
                cube([counterWellWidth,counterWellHeight,99]);
        }
    }
}

/////hexgrid(4,3,true,false);

// Remastered hex grid, deeper, ten wells
// hexgrid(4,3,true,true);
// hexgrid(4,3,true,true,false);

//hexgrid(4,3,true,true,true); // upper tray
// hexgrid(4,3,true,true,false); // lower tray

//translate([130,280,0]) rotate([0,0,180]) hexgrid(4,3,true,true);
//if (false) playerTray(false,true);
// big tray
// playerTray(190,100,9,1,true,false);

// special replicators tray
// playerTray(218,50,11,0,false,true);
//  current best tray
//playerTray(140,109,7,-1.2,false,true);

// new AGT player tray
//playerTray(218,92,11,-0.8,true,false);

// even smaller ships only
//playerTray(100,95,5,0,true,false);

if (false) divider(
    ["Base","BB","BC","BD","BV","CA", 
     "CS","CV","DD","Decoy","DN","F",
     "MSP","Mines","R","SC","SW","SY",
     "T","Titan","Uniq","Flag","Miner","Grav",
     "HI","Inf","Mar","Res","Home","Fleet",
     "DS","SB","Cy","Sup","Temp","MB"]);

if (false) divider(["0","II","IV","V","VII","IX","XI", "XIII", "XV",
   "Flag","Exp","Scan","SW","PD","Home","Colony","Fleet"]);

// translate([0,80,0])
// Replicators


//divider2();

//SideTray(4);
// rotate([0,0,45]) 
//NumbersTray();

//cardtray2();

//SideTray(0);

module roundedCube(vec,rad=2) {
	hull() {
		translate([rad,rad,0]) cylinder(r=rad,h=vec.z);
		translate([rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
		translate([vec.x-rad,vec.y-rad,0]) cylinder(r=rad,h=vec.z);
		translate([vec.x-rad,rad,0]) cylinder(r=rad,h=vec.z);
	}
}

shearYZ = 0.3;
 M = [ [ 1  , 0  , 0  , 0   ],
       [ 0  , 1  , shearYZ, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;
       
module factionTray(doLabel,lists,depth,margin=6,fbm=0.6) {
    ncols = len(lists);
	counterThick = 2;
	counterWidth = 16.6;
	wellSep = 2.4;
    fbm2 = fbm + fbm;
    colSize = depth - fbm2;
	width = ncols * (counterWidth+margin) + 2;
    echo(width);
	function computeWell(list,index) = list[index].y * counterThick + 0.4;
	function computeOffset(list,index) = index? 
        computeOffset(list,index-1) + computeWell(list,index-1) + wellSep : 0;
    function computeSize(list,index) = computeOffset(list,index) + computeWell(list,index);
       
    baseThick = 10; 
    if (doLabel) union() {
		for (column=[0:len(lists)-1]) {
            translate([column * (margin+counterWidth) + margin,fbm,0]) {
                colList = lists[column];
                for (row=[0:len(colList)-1]) {
                    translate([0,computeOffset(colList,row),floorDepth]) {
                        translate([-0.4,2.4+computeWell(colList,row)/2,baseThick-floorDepth-0.4])
                            rotate([0,0,90]) 
                                linear_extrude(0.4) 
                                    text(colList[row].x,margin-1.6,halign="center",valign="bottom");
                    }
                }
            }
        }
    }
	else difference() {
		roundedCube([width,depth,baseThick]);
        translate([0,0,7]) {
            inset = 0.8;
            difference() {
                roundedCube([width,depth,baseThick/2]);
                translate([inset,inset,0]) roundedCube([width-inset*2,depth-inset*2,99]);
            }
        }
		for (column=[0:len(lists)-1]) {
            translate([column * (margin+counterWidth) + margin,fbm,0]) {
                colList = lists[column];
                for (row=[0:len(colList)-1]) {
                    translate([0,computeOffset(colList,row),floorDepth]) {
                        multmatrix(M) cube([counterWidth,computeWell(colList,row),99]);
                        translate([-0.4,2.4+computeWell(colList,row)/2,baseThick-floorDepth-0.4])
                            rotate([0,0,90]) 
                                linear_extrude(0.4) 
                                    text(colList[row].x,margin-1.6,halign="center",valign="bottom");
                        for (nib=[computeWell(colList,row)-4:-4:4])
                            translate([0,nib,-0.2]) cube([counterWidth,1,1]);
                    }
                }
            }
		}
	}
}

module lid(width=92.4,depth=108) {
    inset = 0.8;
    major = max(width,depth) * 0.75;
    difference() {
        roundedCube([width,depth,10]);
        translate([inset,inset,0]) roundedCube([width-inset*2,depth-inset*2,16]);
    }
    difference() {
        roundedCube([width,depth,0.6]);
        translate([width/2,depth/2,0])
            rotate([0,0,45])
                for (i=[-major:10:major])
                    for (j=[-major:10:major])
                        translate([i,j,0]) cube([7,7,0.6]);
    }
}

module verticalCardTray() {
    difference() {
        cube([67+1.6,14,92]);
        translate([0.8,0.8,0.6]) cube([67,14-1.6,99]);
        translate([(67+1.6)/2,15/2,92])
            rotate([90,0,0]) cylinder(99,d=40,center=true);
    }
}

//verticalCardTray();

BasicTray = [ 
	[["SC",7],["DD",6],["CA",6],["BC",6],["BB",6],["DN",5],["SW",6]],
	[["BA",4],["SB",2],["DS",4],["DE",4],["TN",5],["UN",6],["SY",7],["FL",2],["LO",5]],
    [["T",6],["INF",10],["MAR",8],["HI",10],["GRA",6],["CY",3]],
	[["BD",6],["R",6],["CV",6],["BV",6],["F",10],["MINES",9]]
    ];
BasicTrayEx = [
    [["CS",16],["Miner",8],["Fleet",7]],
    [["MSP",28],["Misc",4]],
    [["Res/Ind",16],["Lo/Tem",10],["Hom",3]],
    [["Var",8],["SYS",25]]
    ];
    
    
AltTray = [
	[["SC",7],["DD",6],["CA",6],["BC",6],["BB",6],["DN",6],["Ti",1]],
	[["Bas",4],["SB",2],["DS",4],["Dec",4],["Uni",6],["SW",6],["SY",7],["Fla",2],["LOG",6]],
    [["T",6],["Inf",10],["Mar",8],["HI",10],["Gra",6],["CY",3]],
	[["MB",6],["Missile",6],["R",6],["BV",6],["F",10],["Mines",9]]];
    
ReplicatorsTray = [
    [["0",15], ["II",15],["Fl",1]],
    [["IV",15], ["V",8], ["VII",8]],
    [["IX",15], ["XI",8], ["XIII",6]],
    [["XV",6], ["Fleet",5], ["Scan",6], ["PD",12]],
    [["SW",7], ["EXP",6],["Col",12],["KEY",1]],
    [["SYS",25],["ALPHA",1]]
];

//        ["CO",8,4],    ["MS",7,4], ["Mnr",4], ["MX",4],

// total space for six is 216x293
factionTray(false,BasicTray,108);
//lid(92.4,108);

// extended tray is 293 across but only 148 of 216. leaves 168 x 293 for ???
//factionTray(true,BasicTrayEx,75);
//lid(92.4,75);
//factionTray(true,ReplicatorsTray,75);
//lid(137.6,75);

// translate([100,0,0]) 
//factionTray(AltTray,218/2,4);
