// HoldingBox from: don't rem
// V 1.2 Correction / hint from molotok3D, some minor fixes
// V 1.1- added opening helper and an optional separating wall
include <batt_charger.scad>
include <button.scad>   
include <NopSCADlib/core.scad>
include <NopSCADlib/utils/core/rounded_rectangle.scad>
include <NopSCADlib/vitamins/batteries.scad>

use <ESP8266/ESP8266Models.scad>
use <HCSRC04/HC-SR04.scad>

wi=48;	// inner width, length & heigth
li=68;
h=28;
th=2;	// wall thickness
r=3;	// radius of rounded corners
opening_help=true;	// make a gap to ease opening of the cover, f.ex.
		// with a coin - girls are afraid of their finger nails ;-)

// generate a separating wall inside - set to 0 for none
separator=19;	
separator_h=20;

e=0.01;
ri=(r>th)?r-th:e;	// needed for the cover - needs to be larger than 0 for proper results
l=li-2*r;
w=wi-2*r;


module box(){
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
        
        // Corte para ver el interior
        translate ([-20,25,0]) cube([wi+0,li+0,h+10]);
        
	}
	if (separator>0){
		translate([separator-wi/2+0.25,-li/2-e,-e])difference(){
			cube([th,li+2*e,separator_h]);
			translate([-e,-e,separator_h-3])cube([th+2*e,2*th+2+2*e,5]);
			translate([-e,e+li-2*th-2,separator_h-3])cube([th+2+2*e,2*th+2+2*e,5]);
		}
        

	}
}


module cover(){
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

difference() {
    box();
    
    // Round hole for button (12mm)
    translate ([7.5,34,th+8]) rotate([0,90,90]) linear_extrude(th) circle(d=12);
}





// Cover with cuts
*difference() {
    translate([0,0,h]) rotate([180,0,0]) cover();
    
    // USB for the battery charger
    translate([w/2-2.75,h/2+4.5,h]) rotate([0,0,0]) rounded_cube_xy([3.3,9,2*th],1);
}

// Battery
#translate([-14.5,0,10]) rotate ([90,0,0]) battery(S25R18650);

// Charger board
#translate ([w/2-1-2.4,h/2+9,12+th+0.2]) rotate([0,90,0]) TP4056_charger_booster();

// On/off button
#translate ([7.5,18,th+8]) rotate([-90,0,0]) button();

// WemosD1Mini 
WD1MOPOS = 0;
#translate([10.5, -16, 15]) rotate ([0,0,180]) WemosD1M(pins=0, atorg=WD1MOPOS, usb=1);

// Ultrasonic sensor
translate([0,-22,25]) rotate([0,0,180]) HCSR04();
