/*  Basandome en el diseño de openpads, primero hacer una placa donde irán atornillados el sensor y las 
    luces. Por detras openpads atornillaba el portapilas para la pateria 18650 y ademas tenia una pantalla
    numérica. esa "placa", iba luego atornillada a la caja sobre soportes con agujeros con rosca.abs
    La batería va "a lo ancho", con lo que la anchura de la caja son 65mm como minimo (probablemente 70)
    La disposicion de la plca de soporte permite cierta superposicion entre el sensor y el aro led.
    
    Incluyo los stl descargados del guithub del proyecto
*/
include <NopSCADlib/core.scad>
include <NopSCADlib/utils/core/rounded_rectangle.scad>
include <NopSCADlib/vitamins/batteries.scad>
include <HoldingBox.scad>

use <HCSRC04/HC-SR04.scad>
use <ws2812b.scad>
use <ESP8266/ESP8266Models.scad>
use <batt_charger.scad>
use <wemos_d1_mini_clip.scad>
use <button.scad>

*import("C:/Users/Juan Pedro/Documents/OpenSCAD/OpenPads/Structure interne.stl");
*import("C:/Users/Juan Pedro/Documents/OpenSCAD/OpenPads/Boitier.stl");

wi=90; // outer width of box
li=70; // outer length
hi=35; // height
th=2.4; // wall thickness

// Battery support
module batt_support() {
    difference() {
        //rounded_cube_xz([22,4,14],r=3);
        cube([28,8,12]);
        translate([14,0,10]) rotate ([90,0,0]) scale([1.04,1.04,1.04]) battery(S25R18650);
    }
}

//Box
difference() {
    union() {
        HoldingBox([wi,li,hi],th=th,opening_help=true);
        
        //Supports for the battery charger board
        difference()
        {
            translate([-11,7,0])cube([4,28,5.5]);
            translate([-9,8,4])cube([2,27,1.8]);
        }
        difference()
        {
            translate([7,7,0])cube([4,28,5.5]);
            translate([7,8,4])cube([2,27,1.8]);
        }
        translate([2,10.2,4]) rotate([0,0,-90]) pillar(4);
        
        // Supports for the battery
        translate([-43,-4,0]) batt_support();
        translate([-43,21,0]) batt_support();
        translate([-43,-28,0]) batt_support();
        
        // Clips for the WemosD1 Mini
        translate ([40,-5,5]) rotate([0,0,180]) wemos_d1_mini_clip();
        
    }
    translate([-9,li/2-0.5,4]) cube([18,2,1.8]);
    
    // USB-C cutout for charge board
    translate([4.7,34,9.2]) rotate ([0,90,90]) rounded_cube_xy([3.7,9.4,2*th],1);
    
    // Hole for on/off button
    translate ([43,20,10]) rotate ([0,90,0]) cylinder(h=6,d=11.5);
    
    // Cutout for debug
    translate ([16,-110,0]) cube([60,100,70]);
}

//Cover
*translate ([0,0,hi])
difference() {
    rotate([0,180,0]) HoldingCover([wi,li,hi],th=th);
    translate([30,0,-10]) rotate([0,0,-90]) HCSR04();
    
    translate ([-5,0,-1.2]) linear_extrude(th) circle(d = 50, $fn=64);  
    // Holes for leds
    angle_offset = 360/12;
    translate([-5,0,0]) 
        for (i = [0:11])
        {
            translate([21*cos(i*angle_offset),21*sin(i*angle_offset),1.6])
                    cylinder(5,r=0.8,center=true);        
        }
    
    // Cutout for debug
    translate ([-10,-50,-10]) cube([60,100,70]);
}



// corner supports
*translate ([-wi/2+th,-hi+th,0]) cylinder(h=hi-2*th,r=3);
*translate ([wi/2-th,-hi+th,0]) cylinder(h=hi-2*th,r=3);
*translate ([wi/2-th,hi-th,0]) cylinder(h=hi-2*th,r=3);
*translate ([-wi/2+th,hi-th,0]) cylinder(h=hi-2*th,r=3);





//Internal structure
*translate([0,0,27]) 
difference() {
    union() {
        cube([wi,li,th],center=true);
        
        // Support for led ring
        translate([-21.7,-16.5,0]) cylinder(h=3,r=2);
        translate([-21.7,16.5,0]) cylinder(h=3,r=2);
        translate([11.7,-16.5,0]) cylinder(h=3,r=2);
        translate([11.7,16.5,0]) cylinder(h=3,r=2);
        
        // Battery support from above
        translate([-35,-28,-7.8]) cube([12,21,8]);
        translate([-35,7,-7.8]) cube([12,21,8]);
        
        // Support for bate charger
        //translate ([4,8,-24.5]) cylinder(h=25,r=2);
        //translate ([-4,8,-24.5]) cylinder(h=25,r=2);
    }
    
    //Cutout for HCSR04
    translate([30,0,1]) difference()
    {
        cube([20,45,5], center = true);
        translate([9,21,-3]) cylinder(h=6,r=4);
        translate([-9,21,-3]) cylinder(h=6,r=4);
        translate([9,-21,-3]) cylinder(h=6,r=4);
        translate([-9,-21,-3]) cylinder(h=6,r=4);
    };
    
    // Screw holes for HCSR04
    translate([22,20,-2]) cylinder(h=6,r=1.6);
    translate([38,20,-2]) cylinder(h=6,r=1.6);
    translate([38,-20,-2]) cylinder(h=6,r=1.6);
    translate([22,-20,-2]) cylinder(h=6,r=1.6);
    
    // Cut for ring pads
    translate([-26,0,0]) cube([8,12,5], center = true);
    
    // Screw holes for ring
    translate([-21.7,-16.5,-2]) cylinder(h=8,r=1);
    translate([-21.7,16.5,-2]) cylinder(h=8,r=1);
    translate([11.7,-16.5,-2]) cylinder(h=8,r=1);
    translate([11.7,16.5,-2]) cylinder(h=8,r=1);
}


// Battery
translate([-29,0,10]) rotate ([90,0,0]) battery(S25R18650);

//// Ultrasonic sensor
*translate([30,0,25]) rotate([0,0,-90]) HCSR04();

//// LED ring
*translate ([-5,0,30]) rotate([0,0,-90]) ws2812b_12_ring(draw_resistor = true);

// WemosD1Mini 
WD1MOPOS = 0;
translate([22, -18, 6]) rotate ([0,0,-90]) WemosD1M(pins=0, atorg=WD1MOPOS, usb=1);

// Charger board
translate ([0,22.2,5]) rotate([0,0,-90]) TP4056_charger_booster();

// ON/off button
translate ([29.5,20,10]) rotate ([0,90,0]) button(facets=20);
