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

resourceTray();

//cornerBox();