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
                translate([6,y<10?-y:97-y,-1]) cylinder(r=5,h=99);
            }
            else {
                translate([-7,1,0]) cube([14,10,99]);
                translate([x<10?-x:99-x,6,-1]) cylinder(r=5,h=99);
            }
        }
    };

    difference() {
        cube([100,97,17]);
        
        // first column
        polyomino(true,1.5,1.5,[[0,0],[1,0],[1,2],[0,2]]);
        polyomino(false,1.5,29.5,[[0,0],[2,0],[2,1],[0,1]]);
        polyomino(false,3.5,43.5,[[0,0],[0,1],[3,1],[3,-1],[2,-1],[2,0]]);
        polyomino(false,1.4,57.5,[[0,1],[0,0],[3,0],[3,1]]);
        polyomino(true,1.5,95.5,[[0,0],[1,0],[1,-2],[0,-2]]);
      
    
        // second column
        polyomino(true,15.5,3.5,[[0,0],[0,2],[2,2],[2,1],[1,1],[1,0]]);
        polyomino(true,15.5,95.5,[[0,0],[1,0],[1,-1],[2,-1],[2,-2],[0,-2]]);
        //polyomino(true,29,95.5,[[0,0],[1,0],[1,-1],[0,-1]]);
        
        // third column
        polyomino(true,41.5,1.5,[[-1,0],[2,0],[2,1],[1,1],[1,2],[0,2],[0,1],[-1,1]]);
        polyomino(true,69,1.5,[[0,0],[1,0],[1,1],[0,1]]);
        
        // fifth column
        polyomino(false,96,15.5,[[0,-1],[0,1],[-2,1],[-2,2],[-3,2],[-3,0],[-1,0],[-1,-1]]);
        polyomino(false,96.5,29.5,[[0,0],[0,1],[-1,1],[-1,2],[-3,2],[-3,1],[-2,1],[-2,0]]);
        polyomino(false,98.5,43.5,[[0,0],[0,1],[-1,1],[-1,0]]);

        polyomino(false,98.5,57.5,[[0,1],[0,0],[-3,0],[-3,1]]);
        polyomino(true,74.5,95.5,[[-1,0],[2,0],[2,-2],[1,-2],[1,-1],[0,-1],[0,-2],[-1,-2]]);
        

        // 1x1's
        for (i=[0:6])
            translate([43.5,90-i*10,5])
                cube([13,5.8 /*i?9.4:11.2*/,99]);
        translate([43.5+13/2,27,17]) rotate([-90,0,0]) cylinder(d=17,h=80,$fn=60);
        
  /*  
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
   */     
    }
}

module tokenTray() {
    counterThick = 1.8;
    wellSep = 4;
    c = 180;
    height = 10.6;
	function computeWell(list,index) = list[index].z * counterThick + 0.4;
	function computeOffset(list,index) = index? 
        computeOffset(list,index-1) + computeWell(list,index-1) + wellSep : 0;
    function computeSize(list,index) = computeOffset(list,index) + computeWell(list,index);

    module stack(x,list) {
        for (i=[0:len(list)-1])
            translate([x,1 + computeOffset(list,i),height])
                rotate([-90,0,0]) cylinder(d=list[i].x,h=computeWell(list,i),$fn=list[i].y);
    }
// 1.85mm thick cardboard
    difference() {
        cube([100,97,height]);
        stack(12,[[19,4,12],[19,4,12],[19,4,12],[19,4,6]]);
        stack(32,[[19,4,9],[18,c,3],[18,c,3],[18,c,3],[18,c,3],[18,8,6],[19,4,9]]);
        stack(54,[[20,c,18],[20,c,15]]);
        stack(76,[[20,c,7],[20,c,7],[20,c,7]]);
        for (i=[0:3]) translate([87.5,1 + 15 * i,6]) cube(11.4);
        translate([51,68,0.6]) cube([38,counterThick*9+0.4,99]);
        translate([47,88,0.6]) cube([47,counterThick+0.4,99]);
    }
}

//polyTray();
tokenTray();

/*difference() {
    cube([100+1.6,97+1.6,5]);
    translate([0.8,0.8,0.4]) cube([100,97,17]);
}*/