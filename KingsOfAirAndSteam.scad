// KingsOfAirAndSteam

wall = 0.8;
flr = 0.6;

// ships tray
module shipsTray() {
    cx = (210 - wall*5) / 4;
    cy = 60;
    difference() {
        cube([210,60*2+wall*3,37]);
        for (x=[0:3])
            for (y=[0:1])
                translate([wall+x*(wall+cx),wall+y*(wall+cy),flr])
                    cube([cx,cy,99]);
    }
}

//shipsTray();

// big hex stabilizers
module cornerBox() {
    difference() {
        z = 0.6;
        x1 = z * 105;
        y1 = 83 - z * (60);
        linear_extrude(14) polygon([[0,0],[105,0], [105,23], [0,83]]);
        translate([0,0,flr]) linear_extrude(14) {
            offset(delta=-wall) polygon([[0,0],[0,y1],[x1,0]]);
            offset(delta=-wall) polygon([[0,y1],[x1,0],[x1,y1]]);
            offset(delta=-wall) polygon([[0,y1],[0,83],[x1,y1]]);
            offset(delta=-wall) polygon([[x1,y1],[105,23],[105,0],[x1,0]]);
        }
    }
}

//cornerBox();

//scale([-1,1,1]) cornerBox();

function solveY(x) = (x < 105)? 106 - x/105 * 60 : (x - 105)/105 * 60 + 46;

module resourceTray() {
    difference() {
        z = 0.6;
        x1 = 35;
        x2 = 80;
        x3 = 210 - x2;
        x4 = 210 - x1;
        linear_extrude(14) polygon([[0,0],[210,0], [210,106], [105,46], [0,106]]);
        translate([0,0,flr]) linear_extrude(14) {
            offset(delta=-wall) polygon([[0,0],[x1,0],[x1,solveY(x1)],[0,solveY(0)]]);
            offset(delta=-wall) polygon([[x1,0],[x2,0],[x2,solveY(x2)],[x1,solveY(x1)]]);
            offset(delta=-wall) polygon([[x2,0],[x3,0],[x3,solveY(x3)],[105,46],[x2,solveY(x2)]]);
            offset(delta=-wall) polygon([[x3,0],[x4,0],[x4,solveY(x4)],[x3,solveY(x3)]]);
            offset(delta=-wall) polygon([[x4,0],[210,0],[210,solveY(210)],[x4,solveY(x4)]]);
        }
    }
}

//resourceTray();

//cornerBox();

module captainBox(nw) {
    gap = 0.8;
    thick = 35.4 - wall * 2 - gap;
    cell = (thick - ((nw+1) * wall)) / nw;
    echo(cell);
    difference() {
        cube([90+wall*2,thick,68+wall]);
        for (i=[0:nw-1]) {
            translate([wall,wall+i*(wall+cell),flr])
                cube([90,cell,99]);
        }
        translate([35,-1,30]) cube([20,99,99]);
        translate([45,-1,30]) rotate([-90,0,0]) cylinder(h=99,d=20);
    }
    
    translate([-wall-gap/2,40,0]) difference() {
        cube([90+wall*2+gap+wall*2,35.4,68+wall*2]);
        translate([wall,wall,flr]) cube([90+wall*2+gap,35.4-wall*2,99]);
        translate([45+wall*2+gap/2,-1,70]) rotate([-90,0,0]) cylinder(h=99,d=30);
    }
}

// captainBox(3);
//captainBox(4);

function sum(margin,list,stop) =
    margin + list[stop] + (stop? sum(margin,list,stop-1) : 0);


module moneyBox() {
    margin = 4;
    wells = [8,5,5,4,3,2];
    multmatrix([[1 ,0 ,0, 0], [0, 1, 0.4, 0], [0, 0, 1, 0]]) difference() {
        cube([103+wall*2,wall+sum(margin+wall,wells,len(wells)-1),49]);
        for(i=[0:len(wells)-1])
            translate([wall,wall+(i?sum(margin+wall,wells,i-1):0),flr]) 
                cube([103,margin+wells[i],99]);
        translate([(103+wall*2)/2,-1,48]) rotate([-90,0,0]) cylinder(h=99,d=60);
    }
}

// rotate([17,0,0]) 
//moneyBox();

// spacer
difference() {
    cube([58,30,30]);
    translate([wall,wall,-1]) cube([58-wall*2,30-wall*2,99]);
}