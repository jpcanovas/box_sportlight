use <NopSCADlib/vitamins/pcb.scad>
use <NopSCADlib/vitamins/smd.scad>

module TP4056_charger_booster()
{
    // Draw the PCB
    color("DodgerBlue")
    difference() {
        cube(size = [28,17,1.2], center = true);
        
        translate([13.05,0,0])
        cube(size = [2.1,9,1.4], center = true);
        
        translate([14,4.5,-0.9])
            linear_extrude(1.8)
                circle(r=2,$fn=16);
        translate([14,-4.5,-0.9])
            linear_extrude(1.8)
                circle(r=2,$fn=16);
        
        
        translate([-12,6.5,-0.9])
            linear_extrude(1.8)
                circle(d=1,$fn=16);  
        translate([-12,-6.5,-0.7])
            linear_extrude(1.4)
                circle(d=1,$fn=16);    
        translate([10,6.5,-0.7])
            linear_extrude(1.4)
                circle(d = 1,$fn=32);
        translate([10,-6.5,-0.7])
            linear_extrude(1.4)
                circle(d = 1,$fn=32);
        translate([10,3.5,-0.7])
            linear_extrude(1.4)
                circle(d = 1,$fn=32);
        translate([10,-3.5,-0.7])
            linear_extrude(1.4)
                circle(d = 1,$fn=32);
    }
    
    // Pads
    color("Silver")
    {
        translate([-12,6.5,0.0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);  
        }
        translate([-12,-6.5,0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);
        }
        
        translate([10,6.5,0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);
        }    
        translate([10,3.5,0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);
        }   
        translate([10,-6.5,0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);
        }    
        translate([10,-3.5,0])
        difference() {
            cube(size = [2.5,2.5,1.3], center = true);
            translate([0,0,-0.9])
                linear_extrude(1.8)
                    circle(d=1,$fn=16);
        }
    }
    
    // Charge Port
    rotate([0,180,0]) translate([11.5,0,-3.93]) usb_C();
    
    // Main chip
    translate([-2.7,0,0]) smd_soic(["SOIC8",[4.70, 3.80, 1.35], 0.7, 0.66, 1.27, 6.00,  [0.31, .50, 0.20]],"4056H");
    
    led = ["LED", [1.1, 1,  0.28], [1.0, 0.9,  0.42]];
    translate([-5.5,7,.6]) 
    {
        smd_led(led,"yellow",false);
        color("Silver")
            cube([5,1,0.05],center=true);
    }
    translate([-0.3,7,.6]) 
    {
        smd_led(led,"yellow",false);
        color("Silver")
            cube([5,1,0.05],center=true);
    }
    
    //Text
    color("White")
    {
        translate([9.75,1.3,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("B+", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([9.6,-1.3,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("B-", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
            
        translate([6,7,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("OUT+", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([6,-7,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("OUT-", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
            
        translate([-10,5.4,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("+", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([-10,-7.3,0.6]) 
        rotate([0,0,0])
            linear_extrude(height=0.001, center=true, convexity=10)
                text("-", size=1.1, font="Rajdhani:style=regular", halign="center", valign="center");
    }
}

TP4056_charger_booster();