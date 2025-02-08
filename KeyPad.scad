
module key(pass,r,c,ltr,con) {
    x = c * 10 + r * 2;
    y = -r * 8;
    if (pass==0) {
        translate([x,y,0]) difference() {
            cube([8,6,3.4]);
            translate([4,3,3])
                linear_extrude(2)
                    text(ltr,size=4,halign="center",valign="center");
        }
        if (con)
            translate([x+2,y+6,0]) cube([2,2,0.2]);
    }
    else {
        translate([x+4,y+3,3])
            linear_extrude(0.4)
                    text(ltr,size=4,halign="center",valign="center");
    }
}

module keyRow(pass,r,str,con = true) {
    for (c=[0:len(str)-1])
        key(pass,r,c,str[c],con);
    if (pass==0) translate([0 + r * 2,-r * 8 + 2,0]) cube([len(str) * 10,2,0.2]);
}

module keyboard(pass) {
    keyRow(pass,0,"1234567890-=",false);
    keyRow(pass,1,"QWERTYUIOP[]\\");
    keyRow(pass,2,"ASDFGHJKL;'");
    keyRow(pass,3,"ZXCVBNM,./");
 }
 
// keyboard(0);
keyboard(1);