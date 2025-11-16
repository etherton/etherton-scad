// Thorgal

module polyTray() {
    module polyomino(horiz,x,y,list) {
        translate([x,y,0.6]) {
            linear_extrude(height=99)
                scale(13)
                    polygon(list);
            if (horiz)
                translate([1.5,-4,0]) cube([10,8,99]);
            else
                translate([-4,1.5,0]) cube([8,10,99]);
        }
    };

    module cut(x,y,w,h) {
        translate([x,y,0.6]) cube([w,h,99]);
    };

    difference() {
        cube([127,71,15]);
        
        // first column
        polyomino(true,1,1,[[0,0],[1,0],[1,2],[0,2]]);
        polyomino(false,1,29,[[0,0],[3,0],[3,1],[0,1]]);
        polyomino(true,1,70,[[0,0],[1,0],[1,-2],[0,-2]]);
        
        // second column
        polyomino(true,15,1,[[0,0],[1,0],[1,1],[0,1]]);
        polyomino(true,29,2,[[0,0],[1,0],[1,2],[-1,2],[-1,1],[0,1]]);
        polyomino(true,15,70,[[0,0],[1,0],[1,-1],[0,-1]]);
        polyomino(true,29,69,[[0,0],[1,0],[1,-2],[-1,-2],[-1,-1],[0,-1]]);
        
        // fourth column
        polyomino(true,43,1,[[0,0],[1,0],[1,3],[0,3]]);
        polyomino(true,43,70,[[0,0],[1,0],[1,-2],[0,-2]]);
        
        // fifth column
        polyomino(true,58,4,[[0,0],[1,0],[1,1],[2,1],[2,3],[1,3],[1,2],[0,2]]);
        polyomino(true,57,70,[[0,0],[0,-3],[1,-3],[1,-1],[2,-1],[2,0]]);
        
        polyomino(true,72,3,[[0,0],[2,0],[2,2],[3,2],[3,3],[1,3],[1,1],[0,1]]);
        polyomino(true,99,1,[[0,0],[1,0],[1,1],[0,1]]);
        polyomino(false,126,15,[[0,-1],[0,2],[-1,2],[-1,1],[-2,1],[-2,0],[-1,0],[-1,-1]]);
        polyomino(true,100,70,[[-1,0],[-1,-2],[0,-2],[0,-1],[1,-1],[1,-2],[2,-2],[2,0]]);
        
    }
}

polyTray();