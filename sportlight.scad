//use <NopSCADlib/utils/core/global.scad>
//use <NopSCADlib/utils/core/rounded_rectangle.scad>
include <NopSCADlib/lib.scad>
use <batt_charger.scad>
use <ESP8266/ESP8266Models.scad>

rounded_square([80,60],4);
for (x=[1,-1],y=[1,-1])
translate([x*35,y*25,0]) cylinder(30,2.5,2.5);
//translate([35,25,0]) cylinder(30,2.5,2.5);
//translate([35,25,0]) cylinder(30,2.5,2.5);
//translate([35,25,0]) cylinder(30,2.5,2.5);

translate([0,-15,-5]) rotate ([0,90,0]) battery(S25R18650);

translate([-25.5,21,9]) rotate([-90,0,0]) TP4056_charger_booster();
//color ("red") translate ([-40,25.1,0]) cube([30,2,2]);
//color ("red") translate ([-40,25.1,4]) cube([30,2,2]);

WD1MOPOS = 0;
translate([19, 25, 18.6]) rotate ([90,180,0]) WemosD1M(pins=0, atorg=WD1MOPOS, usb=1);


translate ([100,100,0]) 
union() {
    
difference() {
    rounded_cube_xy([80,60,30],r=4);
    translate([2.5,2.5,2.5]) rounded_cube_xy([75,55,30],r=4);
    //translate([40,30,29.5]) rounded_square([76,56],5);
}
translate([2.5,2.5,25])
difference() {
 rounded_cube_xy([75,55,3],4);
 translate([2,2,-0.5]) rounded_cube_xy([71,51,5],4);
}
}
