// Merchant of Venus culture storage

// First well holds factory, factory goods, and culture token (classic)
// Second well holds three market tokens and up to three racial goods (standard)
// Third well holds up to six goods tokens.

tokenThickness = 2.3;
floorThickness = 1;
wallThickness = 1.6;
eps = 0.6;
goodsHeight = 31.6 + eps;
goodsWidth = goodsHeight;
factoryDiameter = 19.0 + eps;

cultureHeight = 22.6 + eps;
cultureWidth = 46.7 + eps;

cultureHeight2 = 28.6 + eps;
cultureWidth2 = 34.8 + eps;

marketHeight = 28.8 + eps;
marketWidth = 51.2 + eps;
labelSize = 10;
labelThickness = 1;
gapHeight = 8;
fingerGap = 15;

module newTray(numRows) {
    cube([wallThickness + cultureWidth + wallThickness + marketWidth + wallThickness +
            goodsWidth + wallThickness,
            numRows*(goodsHeight + wallThickness) + wallThickness,
            floorThickness+6*tokenThickness]);
}

module cultureTray(row,label,numRacial,numGoods) {
    translate([wallThickness,wallThickness + row * (goodsHeight+wallThickness),floorThickness]) {
        // First well - Market and racial goods (standard game)
        translate([0,0,0]) {
            translate([-99,0.5*(goodsHeight-fingerGap),0])
                cube([99,fingerGap,99]);
            translate([0,0,(3 - numRacial) * tokenThickness])
                cube([goodsWidth,goodsHeight,50]);
            translate([0,0.5 * (goodsHeight - marketHeight),3 * tokenThickness])
                cube([marketWidth,marketHeight,3 * tokenThickness]);
            translate([goodsWidth + 0.5*(marketWidth-goodsWidth),0.5*goodsHeight,3 * tokenThickness - labelThickness])
                linear_extrude(labelThickness) text(text=label,size=labelSize,halign="center",valign="center");
        }
        
        // Second well - Factory token, factory good, culture token (classic)
        translate([marketWidth+wallThickness,0,0]) {
            // cut out half moon for factory token so you can press it out
            translate([0.5*cultureWidth,0.5*goodsHeight,2 * tokenThickness]) 
                intersection() {
                    cylinder(h=50,d=factoryDiameter);
                    translate([-50,4,0]) cube([99,99,99]);
                }
            // cut out full moon for factory token itself
            translate([0.5*cultureWidth,0.5*goodsHeight,3 * tokenThickness])
                cylinder(h=50,d=factoryDiameter);
            
            // cut out room for the factory good
            translate([0.5*(cultureWidth-goodsWidth),0,4 * tokenThickness]) {
                cube([goodsWidth,goodsHeight,99]);
                translate([0,goodsHeight - gapHeight,-tokenThickness]) 
                    cube([goodsWidth,gapHeight,tokenThickness]);
            }
            // cut out room for the culture token
            translate([0,0.5 * (goodsHeight - cultureHeight),5 * tokenThickness]) {
                cube([cultureWidth,cultureHeight,tokenThickness]);
                translate([0,cultureHeight - gapHeight,-tokenThickness]) 
                    cube([cultureWidth,gapHeight,tokenThickness]);
            }
            translate([0.5 * (cultureWidth - cultureWidth2),
                    0.5 * (goodsHeight - cultureHeight2),5 * tokenThickness]) {
                cube([cultureWidth2,cultureHeight2,tokenThickness]);
                translate([0,cultureHeight2 - gapHeight,-tokenThickness]) 
                    cube([cultureWidth2,gapHeight,tokenThickness]);
            }
        }
     
        // Third well - Goods tokens (both versions)
        translate([marketWidth+wallThickness+cultureWidth+wallThickness,0,0]) {
            translate([0,0,(6 - numGoods) * tokenThickness]) {
                cube([goodsWidth,goodsHeight,numGoods * tokenThickness]);
                translate([goodsWidth,0.5*(goodsHeight-fingerGap),0])
                    cube([99,fingerGap,99]);
            }
        }
    }
}

if (true) difference() {
    newTray(7);
    cultureTray(0,"7",3,6);
    cultureTray(1,"6",2,5);
    cultureTray(2,"5",3,6);
    cultureTray(3,"4",2,6);
    cultureTray(4,"3",3,6);
    cultureTray(5,"2",2,6);
    cultureTray(6,"1",2,5);
}

if (false) difference() {
    newTray(7);
    cultureTray(0,"14",2,4);
    cultureTray(1,"13",3,5);
    cultureTray(2,"12",2,6);
    cultureTray(3,"11",3,5);
    cultureTray(4,"10",3,4);
    cultureTray(5,"9",2,6);
    cultureTray(6,"8",2,6);
}
