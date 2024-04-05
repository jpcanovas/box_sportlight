// HoldingBox from: don't rem
// V 1.2 Correction / hint from molotok3D, some minor fixes
// V 1.1- added opening helper and an optional separating wall

//wi=48;	// inner width, length & heigth
//li=68;
//h=28;
//th=2;	// wall thickness
//r=3;	// radius of rounded corners
//opening_help=true;	// make a gap to ease opening of the cover, f.ex.
//		// with a coin - girls are afraid of their finger nails ;-)
//
//// generate a separating wall inside - set to 0 for none
//separator=19;	
//separator_h=20;
//
//e=0.01;
//ri=(r>th)?r-th:e;	// needed for the cover - needs to be larger than 0 for proper results
//l=li-2*r;
//w=wi-2*r;

// size: inner width (x), length (y) and height (z)
// opening_help: make a gap to ease opening of the cover, f.ex.
//               with a coin - girls are afraid of their finger nails ;-)
// separator: generate a separating wall inside - set to 0 for none
module HoldingBox(size, th=2, r=3, opening_help=false, separator=0, separator_h=0){
    e=0.01;
    ri=(r>th)?r-th:e;
    w=size.x-2*r;
    l=size.y-2*r;
    h=size.z;
    
	difference(){
		translate([0,0,-th])hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
				translate(i)cylinder(r=r+th,h=h+th,$fn=8*r);
			}
		}
		hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2,],[w/2,-l/2],[w/2,l/2]]){
				translate(i)cylinder(r=r,h=h,$fn=8*r);
			}
		}
		translate([-w/2,l/2+r,h-2])rotate([0,90,0])cylinder(d=1.2,h=w,$fn=12);
		translate([-w/2,-l/2-r,h-2])rotate([0,90,0])cylinder(d=1.2,h=w,$fn=12);
		translate([w/2+r,l/2,h-2])rotate([90,0,0])cylinder(d=1.2,h=l,$fn=12);
		translate([-w/2-r,l/2,h-2])rotate([90,0,0])cylinder(d=1.2,h=l,$fn=12);

		// if you need some adjustment for the opening helper size or position,
		// this is the right place
		if (opening_help)translate([w/2-10,l/2+13.5,h-1.8])cylinder(d=20,h=10,$fn=32);      
	}
	if (separator>0){
		translate([separator-wi/2+0.25,-li/2-e,-e])difference(){
			cube([th,li+2*e,separator_h]);
			translate([-e,-e,separator_h-3])cube([th+2*e,2*th+2+2*e,5]);
			translate([-e,e+li-2*th-2,separator_h-3])cube([th+2+2*e,2*th+2+2*e,5]);
		}
	}
}


module HoldingCover(size, th=2, r=3){
    e=0.01;
    //ri=(r>th)?r-th:e;
    w=size.x-2*r;
    l=size.y-2*r;
    h=size.z;
    
	translate([0,0,-th])hull(){
		for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
			translate(i)cylinder(r=r+th,h=th,$fn=8*r);
		}
	}
	difference(){
		translate([0,0,-th])hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
				translate(i)cylinder(r=r,h=th+3,$fn=8*r);
			}
		}
		hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
				if (r>th){
					translate(i)cylinder(r=r-th,h=3,$fn=8*r);
				}else{
					translate(i)cylinder(r=e,h=3,$fn=8*r);
				}
			}
		}
	}
	translate([-w/2+1,l/2+r-0.2,2])rotate([0,90,0])cylinder(d=1.2,h=w-2,$fn=12);
	translate([-w/2+1,-l/2-r+0.2,2])rotate([0,90,0])cylinder(d=1.2,h=w-2,$fn=12);
	translate([w/2+r-0.2,l/2-1,2])rotate([90,0,0])cylinder(d=1.2,h=l-2,$fn=12);
	translate([-w/2-r+0.2,l/2-1,2])rotate([90,0,0])cylinder(d=1.2,h=l-2,$fn=12);
}