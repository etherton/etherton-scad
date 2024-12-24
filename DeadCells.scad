// DeadCells

wall = 0.8;
flr = 0.2 + 0.28 * 3;

// 77 x 210 x 71 total space

module well(label,yOffset,ySize) {
    translate([77/2,yOffset+ySize/2,0.2 + 0.28])
        linear_extrude(0.28*2)
        text(label,size=10,halign="center",valign="center");
    translate([wall,yOffset,flr]) cube([77-wall*2,ySize,99]);
}

module tray() {
    labels = [ "Loot", "Teeth", "Cells", "State", "Shield", "Damage", "Player" ];
    echo(len(labels)*30 + ((len(labels)+1)*wall));
    difference() {
        cube([77,len(labels)*30 + ((len(labels)+1)*wall),20]);
        for (i=[0:len(labels)-1])
            well(labels[i],wall + (30+wall) * i,30);
    }
}

module trayLid() {
    eps = 0.2;
    difference() {
        cube([77+2,216.4+2,3]);
        translate([1 - eps/2,1 - eps/2,0.2 + 0.28]) cube([77+eps,216.4+eps,99]);
    }
}

//tray();
trayLid();

module purge() {
    difference() {
        cube([77,7*30+8*wall,71-20]);
        translate([wall,wall,flr]) cube([77-wall*2,7*30+6*wall,99]);
        translate([wall,30,-1]) cube([77-wall*2,8,99]);
        translate([77/2,50,0])
            linear_extrude(0.2+0.28) scale([-1,1,1])
            text("Purge",halign="center",valign="center");
    }
}

//purge();

module groupMini() {
    w = (182 - 94 - wall - wall - wall - wall) / 2;
    h = (74 - wall - wall);
    echo(w);
    echo(h);
    difference() {
        cube([182,74,71]);
        translate([wall,wall,flr]) cube([40,74-wall*2,99]);
        translate([wall+40,wall,flr+18]) cube([10,74-wall*2,99]);
        translate([wall+50,wall,flr]) cube([94-50,74-wall*2,99]);
        
        translate([wall+94+wall,wall,20]) cube([w,h,99]);
        translate([wall+94+wall+w+wall,wall,20]) cube([w,h,99]);
        
        translate([wall,wall,flr]) cube([100,18,18]);
    }
}

//groupMini();

module smallCards() {
    w = (107 - wall*3)/2;
    echo(w);
    difference() {
        cube([107,35,71]);
        translate([wall,wall,flr]) cube([w,35-wall*2,99]);
        translate([wall+w+wall,wall,flr]) cube([w,35-wall*2,99]);
        translate([wall+w/2,-1,71]) rotate([-90,0,0]) cylinder(h=100,d=40);
        translate([wall+w/2+w+wall,-1,71]) rotate([-90,0,0]) cylinder(h=100,d=40);
    }
}

//smallCards();