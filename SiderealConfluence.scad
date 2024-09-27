// Sidereal Confluence

floorDepth = 0.6;
wall = 0.6;
wallFront = 1.2;
slop = 1; // 1.4;
cardThick = 12.6/40;

function sum(margin,list,stop,thick) =
    margin + thick*abs(list[stop]) + (stop? sum(margin,list,stop-1,thick) : 0);

function computeDepth(list) = sum(1 + 1,list,len(list)-1,cardThick) + wallFront;

module cardTray(label,wells) {
    slop = 1;
    wall = 1;
    margin = slop + wall;
    cardThick = 12.6/40;
    depth = computeDepth(wells);
    difference() {
        cube([92,65,depth]);
        translate([92/2,65/2,0]) scale([-1,1,1])
            linear_extrude(wallFront/2)
                text(label,halign="center",valign="center");
        translate([90,2,0]) scale([-1,1,1])
            linear_extrude(wallFront/2)
                text("dce",size=3);
        translate([92/2,65,-1]) cylinder(99,16,16,$fn=60);
        // translate([92,65/2,-1]) cylinder(99,15,15,$fn=60);
        // translate([0,65/2,-1]) cylinder(99,15,15,$fn=60);
        translate([92,0,depth/2]) rotate([0,0,45]) 
            cube([20,20,depth-wall*2],center=true);
        translate([0,0,depth/2]) rotate([0,0,45]) 
            cube([20,20,depth-wall*2],center=true);
        for (i=[0:len(wells)-1]) {
            inX = wells[i] > 0? wall :(92-69)/2;
            inY = wells[i] > 0? floorDepth : (65-45);
            translate([inX,inY,wallFront+(i?sum(margin,wells,i-1,cardThick):0)])
                cube([wells[i]>0?92-wall-wall : 69,99,
                    (cardThick*abs(wells[i]))+slop]);
        }
    }
}

module roundTokens(bays,d=27.8,heights=[19.8]) {
    difference() {
        totalWidth = (d + wall)*bays + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,heights[0]+wall*2]);
        for (i=[0:bays-1]) {
            h = len(heights)>1? heights[i] : heights[0];
            x = i * (d + wall) + wall;
            if (i!=5) {
                translate([x+d/2,d/2+1,wall]) cylinder(h=h,d=d);
                translate([x,d/2+1,wall]) cube([d,99,h]);
            }
            else {
                translate([x,wall,wall]) cube([d,99,h]);
            }
            translate([x+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}

module zethTokens() {
    d = 27.8;
    difference() {
        cube([wall*4 + d + 32 + 32,d + wall,19.8 + wall + wall]);
        translate([wall+d/2,wall+14,wall]) cylinder(h=17.6,d=d);
        translate([wall+d/2,wall+d,-1]) cylinder(h=30,d=20);
        translate([wall,wall+14,wall]) cube([d,99,17.6]);
        for (i=[0:1]) {
            translate([wall+d+wall+i*(32+wall),wall,wall]) {
                multmatrix([ [1,0,0,0], [0,1,0,0], [0,.3,1,0] ])
                    cube([32,30,12]);
                translate([14,28,-1]) cylinder(h=30,d=20);
            }
        }
    }
}

module squareTokens(bays,d=27.8,heights=[19.8]) {
    difference() {
        totalWidth = (d + wall)*bays + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,heights[0]+wall*2]);
        for (i=[0:bays-1]) {
            h = len(heights)>1? heights[i] : heights[0];
            x = i * (d + wall) + wall;
            translate([x,wall,wall]) cube([d,99,h]);
            translate([x+d/2,d,-1]) cylinder(h=99,d=d*0.75);
         }
    }
}

module faderonTokens() {
    difference() {
        d = 27.8;
        d2 = 25;
        totalWidth = ((d+wall)*3 + (d2+wall)*2) + wall;
        echo(totalWidth);
        cube([totalWidth,d + wall,13+wall*2]);
        for (i=[0:2]) {
            translate([wall+(d+wall)*i,wall,wall]) cube([d,99,i!=2?11.2:8.8]);
            translate([wall+d/2 + (d+wall)*i,d,-1]) cylinder(h=99,d=d*0.75);
        }
        o = (d+wall)*3 + wall;
        for (i=[0:1]) {
            translate([o+(d2+wall)*i,wall+(d-d2),wall]) cube([d2,99,i!=1?13:11]);
            translate([o+d2/2 + (d2+wall)*i,d,-1]) cylinder(h=99,d=d2*0.75);
        }
    }
}

module caylionTokens() {
    d=28;
    d2=40.4;
    totalWidth = wall + d + (d2+wall)*3 + wall;
    echo(totalWidth);
    difference() {
        cube([totalWidth,d+wall,13 + wall*2]);
        // x2 tokens
        translate([wall,d/2+1,wall]) cube([d,99,13]);
        translate([wall+d/2,wall+d/2,wall]) cylinder(h=13,d=d);
        translate([wall+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        // votes
        for (i=[0:2]) {
            translate([wall+d+wall+(i*(d2+wall)),wall,wall]) cube([d2,99,i==2?11.2:13]);
            translate([wall+d+wall+(i*(d2+wall)+d2/2),d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}

module caylionTokens2() {
    d=28.2;
    d2=28;
    totalWidth = wall + d + (d2+wall)*3 + wall;
    echo(totalWidth);
    difference() {
        cube([totalWidth,d+wall,13 + wall*2]);
        // x2 tokens
        translate([wall,d/2+1,wall]) cube([d,99,13]);
        translate([wall+d/2,wall+d/2,wall]) cylinder(h=13,d=d);
        translate([wall+d/2,d,-1]) cylinder(h=99,d=d*0.75);
        // votes
        for (i=[0:2]) {
            translate([wall+d+wall+(i*(d2+wall)),wall,wall]) cube([d2,99,i==2?11.2:13]);
            translate([wall+d+wall+(i*(d2+wall)+d2/2),d,-1]) cylinder(h=99,d=d*0.75);
        }
    }
}
module bigResourceTray() {
    difference() {
        cube([88*3+wall*4,64.2,13]);
        for (i=[0:2]) {
            translate([wall+(88+wall)*i,wall,wall]) cube([88,63,99]);
            translate([wall+(88+wall)*i+20,-1,6]) cube([48,99,99]);
        }
        translate([-1,20,6]) cube([300,24.2,99]);
    }
}

module miscTray(x,y,z) {
    difference() {
        cube([x,y,z]);
        translate([wall,wall,wall]) cube([x-wall*2,y-wall*2,99]);
    }
}

module smallResourceTray() {
    difference() {
        cube([88*3+wall*4,64.2,9]);
        for (i=[0:3]) {
            cell = i!=3? 76 : 35.4;
            translate([wall+(76+wall)*i,wall,wall]) cube([cell,63,99]);
            if (i != 3)
                translate([wall+(76+wall)*i+20,-1,6]) cube([36,99,99]);
        }
        translate([-1,20,6]) cube([300,24.2,99]);
    }
}


module victoryPointsAndShips() {
    tokenThick = 2.13;
    wells = [15,10,5,15,  -11,-27];
    tokenSlop = 0.4;
    totalHeight = sum(wall + tokenSlop,wells,len(wells)-1,tokenThick) + wall;
    echo(totalHeight);
    d=28;
    d2=27;
    difference() {
        cube([d+wall+wall,d*.55,totalHeight]);
        for (i=[0:len(wells)-1]) {
            thisThick = tokenThick * abs(wells[i]) + tokenSlop;
            translate([wall,wall,wall+(i?sum(wall+tokenSlop,wells,i-1,tokenThick):0)]) 
        {
                translate([d/2,d/2,0]) cylinder(h=thisThick,d=(wells[i]>0?d:d2),$fn=(wells[i]>0)?60:6);
                translate([0,d/2,0]) cube([d,99,thisThick]);
            }
        }
     }
}



faderanWells = [3,5,5,7,7,7,12];
caylionWells = [3,5,5,7,7,7,-19];
imdrilWells = [3,6,8,7,7,7,6];
eniEtWells = [3,11,5,7,7,7];

yengiiWells = [3,6,7,7,7,7,-14];
kjasWells = [3,4,8,7,7,7];
kitWells = [3,7,7, 7,7,7, 13,10];
zethWells = [2,6,6, 7,7,7];

unityWells = [3,8,4,7,7,7,6];

// colonyWells = [40];

otherWells = [40, 7,7,7,20,12];

echo(computeDepth(faderanWells) + computeDepth(caylionWells) +
    /* computeDepth(imdrilWells) + */ computeDepth(eniEtWells) +
    computeDepth(yengiiWells) + computeDepth(kjasWells) +
    computeDepth(kitWells) + computeDepth(zethWells) +
    computeDepth(unityWells) + 
    computeDepth(otherWells));

//rotate([90,0,0]) cardTray("Faderan",);

//rotate([90,0,0]) cardTray("Caylion",caylionWells);
rotate([90,0,0]) cardTray("Zeth",zethWells);
//rotate([90,0,0]) cardTray("Kjas",kjasWells);
//rotate([90,0,0]) cardTray("Kit",kitWells);
//rotate([90,0,0]) cardTray("Unity",unityWells);
//rotate([90,0,0]) cardTray("Im'Dril",imdrilWells);
//rotate([90,0,0]) cardTray("Eni Et",eniEtWells);
//rotate([90,0,0]) cardTray("Yengii",yengiiWells);
// rotate([90,0,0]) cardTray("Res Team",otherWells);

// rotate([90,0,0]) squareTokens(3,27.8,[19.8,19.8,11.2]);

// rotate([90,0,0]) roundTokens(6); // Kit - Orange

// rotate([90,0,0]) roundTokens(2); // Grand Fleet - Sky blue

// rotate([90,0,0]) faderonTokens(); // Faderon - Yellow

//rotate([90,0,0]) caylionTokens2(); // Caylion - Green

// rotate([90,0,0]) roundTokens(2,27.8,[19.8,17.6]); // Eni Et Service Tokens

//rotate([90,0,0]) roundTokens(2,32.0); // Zeth Tokens

//rotate([0,0,45]) resourceTray();

// rotate([0,0,45]) smallResourceTray();

//rotate([0,0,45]) rotate([90,0,0]) victoryPointsAndShips();

 miscTray(91,91,12); // Print two of these
// miscTray(81,81,12); // ultratech and large wild
// miscTray(27.8*2+wall*3,21,27.8+wall); // dice

//rotate([90,0,0]) zethTokens();

// miscTray(81,81,13); // ultratech and large wild
//miscTray(81,81,31-13);
// miscTray(85,29.2,55); // Filler

// x5 trays
/*rotate([90,0,0]) difference() {
    cube([63+wall*2,30,19.8+wall*2]);
    translate([wall,wall,wall]) cube([63,99,19.8]);
}*/
    