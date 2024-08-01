module RoundedTrayHull(x0,x1,height,depth,gutter,rrMax = 10) {
    echo(rrMax);
    echo(x1);
    echo(x0);
    echo(gutter);
    rr = min(rrMax,0.5 * (x1 - x0 - gutter));
    hull() {
        translate([x0+gutter+rr,gutter+rr,rr+gutter]) 
            sphere(rr);
        translate([x0+gutter+rr,height-gutter-rr,rr+gutter]) 
            sphere(rr);
        translate([x1-rr,gutter+rr,rr+gutter]) 
            sphere(rr);
        translate([x1-rr,height-gutter-rr,rr+gutter]) 
            sphere(rr);
        translate([x0+gutter+rr,gutter+rr,depth]) 
            sphere(rr);
        translate([x0+gutter+rr,height-gutter-rr,depth]) 
            sphere(rr);
        translate([x1-rr,gutter+rr,depth]) 
            sphere(rr);
        translate([x1-rr,height-gutter-rr,depth]) 
            sphere(rr);
    }
}
