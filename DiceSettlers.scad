// Dice Settlers

floorDepth = 1;
wall = 1;
wallFront = 1.2;
slop = 1; // 1.4;
cardThick = 12.6/40;

function sum(margin,list,stop,thick) =
    margin + thick*abs(list[stop]) + (stop? sum(margin,list,stop-1,thick) : 0);

function computeDepth(list) = sum(1 + 1,list,len(list)-1,cardThick) + wallFront;

module hexTray() {
    tokenThick = 1; // 2.52; //19.6/8; // 2.4;
    wells =  [-19.6,     -48.1, -20.2,   -15.1,   -20.6];
    labels = ["01-07a","08-26","27-34","35-40","41/Sea"];
    tokenSlop = 0.4;
    totalHeight = sum(wall + tokenSlop,wells,len(wells)-1,tokenThick) + wall;
    echo(totalHeight);
    d=69;
    d2=69;
    difference() {
        cube([d+wall+wall,d*.5,totalHeight]);
        for (i=[0:len(wells)-1]) {
            echo(labels[i]);
            thisThick = tokenThick * abs(wells[i]) + tokenSlop;
            translate([wall,floorDepth,wall+(i?sum(wall+tokenSlop,wells,i-1,tokenThick):0)]) {
                translate([d/2,d/2-4,0]) 
                    cylinder(h=thisThick,d=(wells[i]>0?d:d2),$fn=(wells[i]>0)?60:6);
                translate([0,d/2-4,0]) cube([d,99,thisThick]);
                
                translate([d/2,-0.4,thisThick/2]) rotate([-90,180,0]) linear_extrude(5) 
                    text(labels[i],size=6,halign="center",valign="center");
            }
            
        }
     }
}

module cardTray() {
    multmatrix([[1 ,0 ,0, 0], [0, 1, 0, 0], [0, .4, 1, 0]])
    difference() {
        wells = [ 5, 9, 9, 6, 6, 6, 6, 6, 6, 6, 6, 6 ];
        wall = 0.6;
        depth = sum(wall, wells, len(wells)-1, 1) + wall; 
        cube([93+wall*2,60.5 + wall,depth]);
        for (i=[0:len(wells)-1]) {
            z = wall + (i? sum(wall,wells,i-1,1) : 0);
            translate([wall,wall,z]) {
                cube([93,99,wells[i]]);
                translate([31,-wall*2,0]) cube([31,wall*4,wells[i]]);
            }
        }
        translate([(93+wall*2)/2,60.5+wall,-1]) cylinder(h=depth*2,d=50);
        //translate([0,0,-1]) rotate([0,0,45]) cube([30,30,depth*3],center=true);
    }
}


//rotate([90,0,0]) hexTray();

rotate([90,0,0]) cardTray();
