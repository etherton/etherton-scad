 module thing(f,rr) {
    if (f) sphere(rr);
    else { rotate([0,90,0]) cylinder(h=rr*2,r=rr,center=true); }
 }
 
module RoundedTrayHull(x0,x1,height,depth,gutter,rrMax = 10,yO = false) {

    rr = min(rrMax,0.5 * (x1 - x0 - gutter));
    hull() {
        translate([x0+gutter+rr,gutter+rr,rr+gutter]) 
            thing(yO,rr);
        translate([x0+gutter+rr,height-gutter-rr,rr+gutter]) 
            thing(yO,rr);
        translate([x1-rr,gutter+rr,rr+gutter]) 
            thing(yO,rr);
        translate([x1-rr,height-gutter-rr,rr+gutter]) 
            thing(yO,rr);
        translate([x0+gutter+rr,gutter+rr,depth]) 
            thing(yO,rr);
        translate([x0+gutter+rr,height-gutter-rr,depth]) 
            thing(yO,rr);
        translate([x1-rr,gutter+rr,depth]) 
            thing(yO,rr);
        translate([x1-rr,height-gutter-rr,depth]) 
            thing(yO,rr);
    }
}
