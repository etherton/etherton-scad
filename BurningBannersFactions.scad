// Cards: 88x63mm; Sleeve Kings sleeves are 91x66
cardWidth = 67;
cardHeight = 92;
counterThick = 2.08;
counterSize = 26.4;
markerSize = 17.2;
markerThick = 2.1;
wallThick = 0.8;
floorThick = 1;
rr = 25;


function adjustC(a) = (a * counterThick) + 0.4;

function adjustM(a) = (a * markerThick) + 0.2;


// Largest marker storage is Eastern Empire, 10+1+1+3
markerWidth = adjustM(10) + wallThick + adjustM(1) + wallThick + adjustM(1) + wallThick + adjustM(3);

function addC(l,c,s) = c==s? adjustC(l[c]) + wallThick :
    adjustC(l[c]) + wallThick + addC(l,c+1,s);
    
function addM(l,c,s) = c==s? adjustM(l[c]) + wallThick :
    adjustM(l[c]) + wallThick + addM(l,c+1,s);
    
module bbTray(t1,t2,counterList,markerList) {
    totalWidth = wallThick + cardWidth + wallThick + markerWidth + wallThick;
    totalHeight = wallThick + cardHeight + wallThick + 2;
    totalDepth = counterSize*0.7 + floorThick;
    
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
        translate([wallThick + cardWidth + wallThick,totalHeight - addC(counterList,0,len(counterList),floorThick]) {
            translate([0,wallThick + markerSize + wallThick,0]) {
                for (i=[0:len(counterList)-1]) {
                    translate([0,i?addC(counterList,0,i-1):0,0])
                        cube([counterSize,adjustC(counterList[i]),counterSize]);
                }
            }
            translate([0,totalHeight - addC(bigAdvancedList,0,len(bigAdvancedList)-1)]) {
                for (i=[0:len(bigAdvancedList)-1]) {
                    translate([0,i?addC(bigAdvancedList,0,i-1):0,0])
                    cube([counterSize,adjustC(bigAdvancedList[i]),counterSize]);
                }
            }
        }
        
        // Faction counter and siege engine
        translate([wallThick + cardWidth + wallThick + counterSize + wallThick,wallThick + markerSize + wallThick,floorThick]) {
            translate([0,0,0]) cube([adjustC(1),counterSize,totalDepth]);
            translate([0,counterSize+wallThick,0]) cube([adjustC(1),counterSize,totalDepth]);
        }
    }
    
    translate([120,0,0]) {
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

bbTray("The Eastern","Empire",[7,4,5,4,1,2,6],[10,1,1,3]);

// bbTray("The Army of","the Night",[5,3,3,2,4,3,2,6,3], [10,1,3]);

// bbTray("The Goblins","",[8,4,5,3,3,2,1,7], [12,3]);

//bbTray("The Orcs","",[10,5,3,3,2,2,6], [12,3]);

//bbTray("Fjordland","",[7,4,3,2,2,1,7], [10,1,3]);

//bbTray("The","Oathborn",[9,5,6,2,2,1,6,1], [10,1,3]);


