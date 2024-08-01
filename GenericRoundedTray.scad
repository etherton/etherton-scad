use <RoundedTrayHull.scad>

module GenericRoundedTray(width,height,depth,gutter,trayStartsIn) {
    rrMax = 10;
    trayStarts = concat([0], trayStartsIn, [width - gutter]);
    difference() {
        cube([width,height,depth]);
        for (bin=[0:len(trayStarts)-2])
            RoundedTrayHull(trayStarts[bin],trayStarts[bin+1],
                height,depth,gutter);
    }
}
