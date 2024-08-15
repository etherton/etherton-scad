// Cards: 88x63mm; Sleeve Kings sleeves are 91x66
cardWidth = 67;
cardHeight = 92;
counterThick = 2.08;
counterSize = 26.4;
markerThick = 2.1;
markerSize = 17.2;
wallThick = 1;
floorThick = 1;
rr = 25;

function adjustC(a) =  (a * counterThick) + 0.4;

function adjustM(a) = (a * markerThick) + 0.2;

biggestMarker = [10,1,1,3];

// Largest marker storage is Eastern Empire, 10+1+1+3
markerWidth = addM(biggestMarker,0,len(biggestMarker)-1);

function addC(l,c,s) = 
    adjustC(l[c]) + wallThick + (c==s? 0 : addC(l,c+1,s));
    
function addM(l,c,s) = c==s? adjustM(l[c]) + wallThick :
    adjustM(l[c]) + wallThick + addM(l,c+1,s);
    
module bbTray(t1,t2,counterList,markerList,extraWells=2) {
    totalWidth = wallThick + cardWidth + wallThick + markerWidth + wallThick;
    totalHeight = wallThick + cardHeight + wallThick + 2.4;
    totalDepth = counterSize*0.7 + floorThick;
    echo(totalWidth, " wide by ",totalHeight, "tall");
    
    difference() {
        cube([totalWidth,totalHeight,totalDepth]);
        
        // Card well, embossed text, and cutout
        translate([wallThick,wallThick,floorThick*2]) 
            cube([cardWidth,cardHeight,totalHeight]);
        translate([wallThick+cardWidth/2,cardHeight/2+1,floorThick])
            linear_extrude(floorThick)
                text(t1,size=8,halign="center",valign="bottom");
        translate([wallThick+cardWidth/2,cardHeight/2-1,floorThick])
            linear_extrude(floorThick)
                text(t2,size=8,halign="center",valign="top");
        translate([wallThick + cardWidth/2,2,rr+floorThick*2])
            rotate([90,0,0]) 
                cylinder(r=rr,h=5);
        
        // Marker storage (horizontal)
        translate([wallThick + cardWidth + wallThick,wallThick,floorThick + counterSize - markerSize]) {
            for (i=[0:len(markerList)-1]) {
                translate([i?addM(markerList,0,i-1):0,0,0])
                    cube([adjustM(markerList[i]),markerSize,totalDepth]);
            }
        }
        
        // Large counter storage, basic then advanced
        translate([wallThick + cardWidth + wallThick,totalHeight - 
                addC(counterList,0,len(counterList)-1),floorThick]) {
            for (i=[0:len(counterList)-1]) {
                translate([0,i?addC(counterList,0,i-1):0,0])
                    cube([counterSize,adjustC(counterList[i]),counterSize]);
            }
        }
        
        // Faction counter and siege engine (and Mountain Troll)
        translate([totalWidth - adjustC(1) - wallThick,
            totalHeight - counterSize - wallThick,floorThick]) {
            for (i=[0:extraWells-1])
                translate([0,i * (-counterSize-wallThick),0]) 
                    cube([adjustC(1),counterSize,totalDepth]);
        }
    }
    
    if (false) translate([120,0,0]) {
        eps = 0.5;
        siz = 10;
        h = 15;
        linear_extrude(floorThick) polygon([
            [siz,0], [0,0], [0,siz], 
            [cardWidth-siz-eps,cardHeight-eps],
            [cardWidth-eps,cardHeight-eps], 
            [cardWidth-eps,cardHeight-eps-siz],
            ]);
        linear_extrude(h) polygon([
             [siz,0], [0,0], [0,siz]]);
        linear_extrude(h) polygon([
            [cardWidth-siz-eps,cardHeight-eps],
            [cardWidth-eps,cardHeight-eps], 
            [cardWidth-eps,cardHeight-eps-siz]]);
    }
}

which = -1;

if (which==0 || which==-1) translate([0,0,0]) bbTray("The Eastern","Empire",[7,4,5,4,1,2,6],biggestMarker);

if (which==1 || which==-1) translate([120,0,0]) bbTray("The Army of","the Night",[5,3,3,2,4,3,2,6,3], [10,1,3]);

if (which==2 || which==-1) translate([240,0,0]) bbTray("The Goblins","",[8,4,5,3,3,2,7], [12,3], 3);

if (which==3 || which==-1) translate([0,110,0]) bbTray("The Orcs","",[10,5,3,3,2,2,6], [12,3]);

if (which==4 || which==-1) translate([120,110,0]) bbTray("Fjordland","",[7,4,3,2,2,1,7], [10,1,3]);

if (which==5 || which==-1) translate([240,110,0]) bbTray("The","Oathborn",[9,5,6,2,2,6,1], [10,1,3], 3);


