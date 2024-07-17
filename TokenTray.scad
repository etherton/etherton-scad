//-----------
// Parameters
//-----------
myNumWells_x = 3;
myNumWells_y = 4;

// Zoo Tycoon; 3x4, 19 height, 33 well. (Token is 32x32x2.2mm
// Distant Skies: 3x4, 15 height, 25 well (Token is 24x24x2mm, stack is 13mm)

myWallThickness = 2.0;
myFloorThickness = 2.0;
myWellWidth_x = 33;
myWellWidth_y = 33;
myHeight = 19; //Includes Floor Thickness
myInset_x = 0.20 * myWellWidth_x;
myInset_y = 0.20 * myWellWidth_y;

myCutoutWidth_x = 0.7 * myWellWidth_x;
myCutoutWidth_y = 0.7 * myWellWidth_y;
myCutoutDepth_x = 0.8 * myHeight;
myCutoutDepth_y = 0.8 * myHeight;
myCutoutCurve_UpperRadius_x = 3;
myCutoutCurve_UpperRadius_y = 3;
myCutoutCurve_LowerRadius_x = 3;
myCutoutCurve_LowerRadius_y = 3;
myCutoutCurve_NumFaces = 30;

myOverlap = 1;


difference() {
	//-----
	// Base
	//-----
	cube([
		myWallThickness
			+myNumWells_x*(myWellWidth_x+myWallThickness)
		,myWallThickness
			+myNumWells_y*(myWellWidth_y+myWallThickness)
		,myHeight
	]);


	//-----
	// Well
	//-----
	for(x = [0:myNumWells_x-1]) {
		for(y = [0:myNumWells_y-1]) {
			translate([
				myWallThickness
					+x*(myWellWidth_x+myWallThickness)
				,myWallThickness
					+y*(myWellWidth_y+myWallThickness)
				,myFloorThickness
			])
			union() {
				cube([
					myWellWidth_x
					,myWellWidth_y
					,myHeight
				]);
			};
		};
	};
    
   	for(x = [0:myNumWells_x-1]) {
		for(y = [0:myNumWells_y-1]) {
			translate([
				myWallThickness + myInset_x
					+x*(myWellWidth_x+myWallThickness)
				,myWallThickness + myInset_y
					+y*(myWellWidth_y+myWallThickness)
				,0
			])
			union() {
				cube([
					myWellWidth_x - 2*myInset_x
					,myWellWidth_y - 2*myInset_y
					,myHeight
				]);
			};
		};
	};


	//---------
	// X Cutout
	//---------
	for(x = [0:myNumWells_x-1]) {
		translate([
			myWallThickness
				+myWellWidth_x/2
				-myCutoutWidth_x/2
				+x*(myWellWidth_x+myWallThickness)
			,-myOverlap
			,myHeight
				-myCutoutDepth_x
		])
		scale([
			1
			,myWallThickness
				+myNumWells_y*(myWellWidth_y+myWallThickness)
				+2*myOverlap
			,1
		])
		union() {
			difference() {
				// X Main Cutout
				cube([
					myCutoutWidth_x
					,1
					,myHeight
				]);

				// X Lower Left Curve
				difference() {
					cube([
						myCutoutCurve_LowerRadius_x
						,1
						,myCutoutCurve_LowerRadius_x
					]);

					translate([
						myCutoutCurve_LowerRadius_x
						,0
						,myCutoutCurve_LowerRadius_x
					])
					rotate([
						-90
						,0
						,0
					])
					cylinder(
						h = 1
						,r = myCutoutCurve_LowerRadius_x
						,$fn = myCutoutCurve_NumFaces
					);
				};

				// X Lower Right Curve
				translate([
					myCutoutWidth_x
						-myCutoutCurve_LowerRadius_x
					,0
					,0
				])
				difference() {
					cube([
						myCutoutCurve_LowerRadius_x
						,1
						,myCutoutCurve_LowerRadius_x
					]);

					translate([
						0
						,0
						,myCutoutCurve_LowerRadius_x
					])
					rotate([
						-90
						,0
						,0
					])
					cylinder(
						h = 1
						,r = myCutoutCurve_LowerRadius_x
						,$fn = myCutoutCurve_NumFaces
					);
				};
			};

			// X Upper Left Curve
			translate([
				-myCutoutCurve_UpperRadius_x
				,0
				,myCutoutDepth_x
					-myCutoutCurve_UpperRadius_x
			])
			difference() {
				cube([
					myCutoutCurve_UpperRadius_x
					,1
					,myCutoutCurve_UpperRadius_x
				]);

				rotate([
					-90
					,0
					,0
				])
				cylinder(
					h = 1
					,r = myCutoutCurve_UpperRadius_x
					,$fn = myCutoutCurve_NumFaces
				);
			};

			// X Upper Right Curve
			translate([
				myCutoutWidth_x
				,0
				,myCutoutDepth_x
					-myCutoutCurve_UpperRadius_x
			])
			difference() {
				cube([
					myCutoutCurve_UpperRadius_x
					,1
					,myCutoutCurve_UpperRadius_x
				]);

				translate([
					myCutoutCurve_UpperRadius_x
					,0
					,0
				])
				rotate([
					-90
					,0
					,0
				])
				cylinder(
					h = 1
					,r = myCutoutCurve_UpperRadius_x
					,$fn = myCutoutCurve_NumFaces
				);
			};
		};
	};


	//---------
	// Y Cutout
	//---------
	for(y = [0:myNumWells_y-1]) {
		translate([
			-myOverlap
			,myWallThickness
				+myWellWidth_y/2
				-myCutoutWidth_y/2
				+y*(myWellWidth_y+myWallThickness)
			,myHeight
				-myCutoutDepth_y
		])
		scale([
			myWallThickness
				+myNumWells_x*(myWellWidth_x+myWallThickness)
				+2*myOverlap
			,1
			,1
		])
		union() {
			difference() {
				// Y Main Cutout
				cube([
					1
					,myCutoutWidth_y
					,myHeight
				]);
				
				// Y Lower Near Curve
				difference() {
					cube([
						1
						,myCutoutCurve_LowerRadius_y
						,myCutoutCurve_LowerRadius_y
					]);

					translate([
						0
						,myCutoutCurve_LowerRadius_y
						,myCutoutCurve_LowerRadius_y
					])
					rotate([
						0
						,90
						,0
					])
					cylinder(
						h = 1
						,r = myCutoutCurve_LowerRadius_y
						,$fn = myCutoutCurve_NumFaces
					);
				};

				// Y Lower Far Curve
				translate([
					0
					,myCutoutWidth_y
						-myCutoutCurve_LowerRadius_y
					,0
				])
				difference() {
					cube([
						1
						,myCutoutCurve_LowerRadius_y
						,myCutoutCurve_LowerRadius_y
					]);

					translate([
						0
						,0
						,myCutoutCurve_LowerRadius_y
					])
					rotate([
						0
						,90
						,0
					])
					cylinder(
						h = 1
						,r = myCutoutCurve_LowerRadius_y
						,$fn = myCutoutCurve_NumFaces
					);
				};
			};

			// Y Upper Near Curve
			translate([
				0
				,-myCutoutCurve_UpperRadius_y
				,myCutoutDepth_y
					-myCutoutCurve_UpperRadius_y
			])
			difference() {
				cube([
					1
					,myCutoutCurve_UpperRadius_y
					,myCutoutCurve_UpperRadius_y
				]);

				rotate([
					0
					,90
					,0
				])
				cylinder(
					h = 1
					,r = myCutoutCurve_UpperRadius_y
					,$fn = myCutoutCurve_NumFaces
				);
			};

			// Y Upper Far Curve
			translate([
				0
				,myCutoutWidth_y
				,myCutoutDepth_y
					-myCutoutCurve_UpperRadius_y
			])
			difference() {
				cube([
					1
					,myCutoutCurve_UpperRadius_y
					,myCutoutCurve_UpperRadius_y
				]);

				translate([
					0
					,myCutoutCurve_UpperRadius_y
					,0
				])
				rotate([
					0
					,90
					,0
				])
				cylinder(
					h = 1
					,r = myCutoutCurve_UpperRadius_y
					,$fn = myCutoutCurve_NumFaces
				);
			};
		};
	};
};