// Cards: 88x63mm
cardWidth = 65;
cardHeight = 90;
tokenThick = 2.08;
counterSize = 26.4;
markerSize = 17.2;
wallThick = 1;
floorThick = 2;
rr = 25;

// Every faction has 14 control markers
controlWidth = 32;

function adjust(a) = (a * tokenThick) + 0.4;

function add(l,c,s) = c==s? adjust(l[c]) + wallThick :
    adjust(l[c]) + wallThick + add(l,c+1,s);
    
module bbTray(t1,t2,bigBasicList,bigAdvancedList) {
    totalWidth = wallThick + cardWidth + wallThick + max(counterSize,controlWidth) + wallThick;
    totalHeight = wallThick + cardHeight + wallThick + 8;
    totalDepth = counterSize*0.7 + floorThick;
    
    difference() {
        cube([totalWidth,totalHeight,totalDepth]);
        
        // Card well, embossed text, and cutout
        translate([wallThick,wallThick,floorThick]) 
            cube([cardWidth,cardHeight,totalHeight]);
        translate([wallThick+cardWidth/2,cardHeight/2+1,floorThick/2])
            linear_extrude(floorThick)
                text(t1,size=8,halign="center",valign="bottom");
        translate([wallThick+cardWidth/2,cardHeight/2-1,floorThick/2])
            linear_extrude(floorThick)
                text(t2,size=8,halign="center",valign="top");
        translate([wallThick + cardWidth/2,2,rr+floorThick])
            rotate([90,0,0]) 
                cylinder(r=rr,h=5);
        
        // TEMP - remove card well
        cube([wallThick+cardWidth,totalHeight,totalDepth]);
        
        // Marker storage (horizontal)
        translate([wallThick + cardWidth + wallThick,wallThick,floorThick + counterSize - markerSize])
            cube([controlWidth,markerSize,markerSize]);
        
        // Large counter storage, basic then advanced
        translate([wallThick + cardWidth + wallThick + 0.5 * (controlWidth-counterSize),0,floorThick]) {
            translate([0,wallThick + markerSize + wallThick,0]) {
                for (i=[0:len(bigBasicList)-1]) {
                    translate([0,i?add(bigBasicList,0,i-1):0,0])
                        cube([counterSize,bigBasicList[i]*tokenThick,counterSize]);
                }
            }
            translate([0,totalHeight - add(bigAdvancedList,0,len(bigAdvancedList)-1)]) {
                for (i=[0:len(bigAdvancedList)-1]) {
                    translate([0,i?add(bigAdvancedList,0,i-1):0,0])
                    cube([counterSize,bigAdvancedList[i]*tokenThick,counterSize]);
                }
            }
        }
    }
}

bbTray("The Eastern","Empire",[1,7,4,5,1,4,1,2],[6]);

//bbTray("The Army of","the Night",[1,5,3,3,2,4,3,2,1], [6,3]);

// bbTray("The Goblins","",[1,8,4,5,3,3,2,1,1],[7]);

//bbTray("The Orcs","",[1,10,5,3,1,3,2,2],[6]);

//bbTray("Fjordland","",[1,7,4,3,1,2,2,1],[7]);

//bbTray("The","Oathborn",[1,9,5,6,2,2,1,1],[6,1]);


