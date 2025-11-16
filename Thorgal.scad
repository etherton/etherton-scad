// Thorgal

module polyTray() {
    module polyomino(horiz,x,y,list) {
        translate([x,y,0.6]) {
            linear_extrude(height=99)
                offset(delta=0.5)
                    scale(12)
                        polygon(list);
            if (horiz) {
                translate([1,-7,0]) cube([10,14,99]);
                translate([6,y<10?-y:71-y,-1]) cylinder(r=5,h=99);
            }
            else {
                translate([-7,1,0]) cube([14,10,99]);
                translate([x<10?-x:128-x,6,-1]) cylinder(r=5,h=99);
            }
        }
    };

    module cut(x,y,w,h) {
        translate([x,y,0.6]) cube([w,h,99]);
    };

    difference() {
        cube([128,71,17]);
        
        // first column
        polyomino(true,1.5,1.5,[[0,0],[1,0],[1,2],[0,2]]);
        polyomino(false,1.5,29.5,[[0,0],[3,0],[3,1],[0,1]]);
        polyomino(true,1.5,70,[[0,0],[1,0],[1,-2],[0,-2]]);
        
        // second column
        polyomino(true,15.5,1.5,[[0,0],[1,0],[1,1],[0,1]]);
        polyomino(true,29.5,3.5,[[0,0],[1,0],[1,2],[-1,2],[-1,1],[0,1]]);
        polyomino(true,15.5,70,[[0,0],[1,0],[1,-1],[0,-1]]);
        polyomino(true,29.5,68,[[0,0],[1,0],[1,-2],[-1,-2],[-1,-1],[0,-1]]);
        
        // fourth column
        polyomino(true,43.5,1.5,[[0,0],[1,0],[1,3],[0,3]]);
        polyomino(true,43.5,70,[[0,0],[1,0],[1,-2],[0,-2]]);
        
        // fifth column
        polyomino(true,60,7,[[0,0],[1,0],[1,1],[2,1],[2,3],[1,3],[1,2],[0,2]]);
        polyomino(true,57.5,69.5,[[0,0],[0,-3],[1,-3],[1,-1],[2,-1],[2,0]]);
        
        polyomino(true,74.5,5,[[0,0],[2,0],[2,2],[3,2],[3,3],[1,3],[1,1],[0,1]]);
        polyomino(true,100.5,1.5,[[0,0],[1,0],[1,1],[0,1]]);
        polyomino(false,126.5,15.25,[[0,-1],[0,2],[-1,2],[-1,1],[-2,1],[-2,0],[-1,0],[-1,-1]]);
        
        polyomino(true,100,69.5,[[-1,0],[-1,-2],[0,-2],[0,-1],[1,-1],[1,-2],[2,-2],[2,0]]);
        
    }
}

polyTray();