
fl = 0.4;
totalWidth = 140;

module key(pass,r,c,ltr,conUp,xo = 0,w = 8) {
    x = c * 10 + xo;
    y = -r * 8;
    co = 1;
    ts = len(ltr)==1 && ltr!="[" && ltr!="]" ? 4 : 3;
    if (pass==0) {
        translate([x,y,0]) difference() {
            union() {
                cube([w,6,1]);
                translate([0,0,1]) linear_extrude(1.4) polygon(
                    [[co,0],[0,co],[0,6-co],[co,6],
                     [w-co,6],[w,6-co],[w,co],[w-co,0]]);
            }
            translate([w/2,5-ts,2])
                linear_extrude(2)
                    text(ltr,size=ts,halign="center",valign="baseline");
        }
        if (conUp)
            translate([x+2,y+6,0]) cube([2,2,fl]);
    }
    else {
        translate([x+w/2,y+(5-ts),2])
            linear_extrude(0.4)
                    text(ltr,size=ts,halign="center",valign="baseline");
    }
}

module keyRow(pass,row,left,str,right,conUp = true) {
    if (len(left))
        key(pass,row,0,left,conUp,0,8 + row * 2);
    for (col=[0:len(str)-1])
        key(pass,row,col,str[col],conUp,row? 10 + row * 2 : 0);
    if (len(right)) {
        ro = row? 10 + row * 2 + len(str) * 10 : len(str) * 10;
        key(pass,row,0,right,conUp,ro,totalWidth-ro);
    }
    if (pass==0) translate([0,2 -row * 8,0]) 
        cube([totalWidth,2,fl]);
}

module keyboard(pass) {
    keyRow(pass,0,"","`1234567890-=","del",false);
    keyRow(pass,1,"tab","QWERTYUIOP[]\\","");
    keyRow(pass,2,"caps","ASDFGHJKL;'","ret");
    keyRow(pass,3,"shift","ZXCVBNM,./","shift");
    if (pass==0) translate([totalWidth - 6,-20,0]) cube([2,20,fl]);
 }
 
keyboard(0);
// keyboard(1);