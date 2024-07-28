// Merchant of Venus culture storage

// Left part of tray holds factory, culture, and three market tokens.
// Right part of tray holds three stacks of various per-culture tokens

// First well holds factory, factory goods, and culture token (classic) and three market tokens
// Second well holds up to six demand tokens
// Third well holds up to six goods tokens
// Fourth well holds up to 

// First well holds factory, factory goods, and culture token (classic)
// Second well holds up to six demand tokens (standard or classic)
// Third well holds three market tokens and up to three racial goods (standard)
// fourth well holds up to six goods tokens.

tokenThickness = 2.3;
floorThickness = 3;
wallThickness = 2;
goodsHeight = 31.6;
goodsWidth = goodsHeight;
factoryDiameter = 19.0;
cultureHeight = 28.7;
cultureWidth = 46.7;
marketHeight = 28.8;
marketWidth = 51.2;
labelSize = 12;
labelThickness = 1;
gapHeight = 10;

module newTray(numRows) {
    cube([wallThickness + cultureWidth + wallThickness + marketWidth + wallThickness +
            goodsWidth + wallThickness + goodsWidth + wallThickness,
            numRows*(goodsHeight + wallThickness) + wallThickness,
            floorThickness+6*tokenThickness]);
}

module cultureTray(row,label,numRacial,numDemand,numGoods) {
    translate([wallThickness,wallThickness + row * (goodsHeight+wallThickness),floorThickness]) {
        // First well
        // cut out half moon for factory token so you can press it out
        translate([0.5*cultureWidth,0.5*goodsHeight,2 * tokenThickness]) 
            intersection() {
                cylinder(h=50,d=factoryDiameter);
                translate([-50,4,0]) cube([100,100,100]);
            }
       // cut out full moon for factory token itself
       translate([0.5*cultureWidth,0.5*goodsHeight,3 * tokenThickness])
            cylinder(h=50,d=factoryDiameter);
            
      // cut out room for the factory good
      translate([0.5*(cultureWidth-goodsWidth),0,4 * tokenThickness]) {
            cube([goodsWidth,goodsHeight,50]);
            translate([0,goodsHeight - gapHeight,-tokenThickness]) 
                cube([goodsWidth,gapHeight,tokenThickness]);
      }
      // cut out room for the culture token
      translate([0,0,5 * tokenThickness]) {
        cube([cultureWidth,goodsHeight,tokenThickness]);
        translate([0,goodsHeight - gapHeight,-tokenThickness]) 
           cube([cultureWidth,gapHeight,tokenThickness]);
      }
            
      // Second well      
      translate([cultureWidth + wallThickness + 0.5 * marketWidth,0.5 * goodsHeight,
            (3 - numRacial) * tokenThickness-labelThickness])
            linear_extrude(labelThickness) 
                text(text=label,size=labelSize,halign="center",valign="top");  
      translate([cultureWidth + wallThickness + 0.5*(marketWidth - goodsWidth),
            0,(3 - numRacial) * tokenThickness]) {
            cube([goodsWidth,goodsHeight,50]);
            translate([0,goodsHeight - gapHeight,-tokenThickness])
                cube([goodsWidth,gapHeight,tokenThickness]);
       }
      translate([cultureWidth + wallThickness,0.5 * (goodsHeight - marketHeight),
                3 * tokenThickness]) {
            cube([marketWidth,marketHeight,3 * tokenThickness]);
            translate([0,marketHeight - gapHeight,-tokenThickness])
                cube([marketWidth,gapHeight,tokenThickness]);
      }
            
      // Third well
      translate([cultureWidth + wallThickness + marketWidth + wallThickness + 0.5*goodsWidth,0.5 * goodsHeight,
            (6 - numDemand) * tokenThickness-labelThickness])
            linear_extrude(labelThickness) 
                text(text=label,size=labelSize,halign="center",valign="top");  
      translate([cultureWidth + wallThickness + marketWidth + wallThickness,
            0,(6 - numDemand) * tokenThickness])
            cube([goodsWidth,goodsHeight,numDemand * tokenThickness]);
            
      // Fourth well
      translate([cultureWidth + wallThickness + marketWidth + wallThickness + goodsWidth + wallThickness + 0.5*goodsWidth,
        0.5 * goodsHeight,(6 - numGoods) * tokenThickness-labelThickness])
            linear_extrude(labelThickness) 
                text(text=label,size=labelSize,halign="center",valign="top");  

      translate([cultureWidth + wallThickness + marketWidth + wallThickness + goodsWidth + wallThickness,
        0,(6 - numGoods) * tokenThickness])
        cube([goodsWidth,goodsHeight,numGoods * tokenThickness]);
            
    }
}


difference() {
    newTray(2);
    cultureTray(0,"6",2,6,5);
    cultureTray(1,"7",3,5,6);
}