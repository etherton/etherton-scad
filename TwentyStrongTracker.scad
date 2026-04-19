// magnets are 6mm x 3mm
// tracker disc is 40mm

intersection() {
  cube([20,50,10],true);
  difference() {
    cylinder(h=6,d=42,$fn=300);
    translate([0,0,0.4]) cylinder(h=2.6,d=6,$fn=300);
    translate([0,0,3]) {
        cylinder(h=5,d=40.4,$fn=300);
        translate([0,20,1.5]) cube([7,20,3],true);
    }
  }
}