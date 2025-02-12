
fl = 0.4;
totalWidth = 140;

fo = "Liberation Sans:style=bold";

module connectorH(x,y) {
    translate([x,y,0]) cube([0.6,0.8,fl]);
    translate([x+0.2,y,0]) cube([0.6,2,fl]);
    translate([x+0.4,y+1.2,0]) cube([1,0.8,fl]);
    translate([x+1.2,y,0]) cube([0.6,2,fl]);
    translate([x+1.6,y,0]) cube([0.6,0.8,fl]);
}

module connectorV(x,y,y) {
    translate([x+2,y,0]) rotate([0,0,90]) connectorH(0,0);
}

module key(pass,r,c,ltr,conUp,conRight,xo = 0,w = 8) {
    x = c * 10 + xo;
    y = -r * 8;
    co = 1;
    ts = len(ltr)==1 && ltr!="[" && ltr!="]" ? 4 : 3;
    if (pass==0) {
        translate([x,y,0]) {
            difference() {
                union() {
                    cube([w,6,1]);
                    translate([0,0,1]) linear_extrude(1.4) polygon(
                        [[co,0],[0,co],[0,6-co],[co,6],
                        [w-co,6],[w,6-co],[w,co],[w-co,0]]);
                }
                translate([w/2,5-ts,2])
                    linear_extrude(2)
                        text(ltr,size=ts,halign="center",valign="baseline",font=fo);
                translate([1,1,0]) cube([w-2,4,1]);
            }
            translate([w/2,3,0]) cylinder(r=1,h=1,$fn=30);
        }
        if (conRight)
            connectorH(x+w,y+2);
        if (conUp)
            connectorV(x+2,y+6);
    }
    else {
        translate([x+w/2,y+(5-ts),2])
            linear_extrude(0.4)
                    text(ltr,size=ts,halign="center",valign="baseline",font=fo);
    }
}

module keyRow(pass,row,left,str,right,conUp = true) {
    if (len(left))
        key(pass,row,0,left,conUp,true,0,8 + row * 2);
    for (col=[0:len(str)-1])
        key(pass,row,col,str[col],conUp,len(right) || col != len(str)-1,row? 10 + row * 2 : 0);
    if (len(right)) {
        ro = row? 10 + row * 2 + len(str) * 10 : len(str) * 10;
        key(pass,row,0,right,conUp,false,ro,totalWidth-ro);
    }
}

module keyboard(pass) {
    keyRow(pass,0,"","`1234567890-=","del",false);
    keyRow(pass,1,"tab","QWERTYUIOP[]\\","");
    keyRow(pass,2,"caps","ASDFGHJKL;'","ret");
    keyRow(pass,3,"shift","ZXCVBNM,./","shift");
    if (pass==0) {
        connectorV(totalWidth-6,-18);
        connectorV(totalWidth-6,-10);
    }
 }
 
//keyboard(0);
keyboard(1);