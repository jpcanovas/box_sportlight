module ws2812b (draw_resistor = false)
{
    eps = 0.2;
    color("white")
        difference() {
            linear_extrude(1.6)
                    square([5, 5], center = true);
            translate([0,0,eps])
                linear_extrude(1.6+eps)
                    circle(d = 3.9,$fn=16);
        }
    
    color("white")
    translate([0,0,eps])
        linear_extrude(1.6 - 2*eps)
                circle(d = 3.9,$fn=16);
    
    color("silver")
    translate([0,0,1.42])
    difference()
    {
        linear_extrude(0.1)
            circle(d = 3.9,$fn=16);
            
        translate([0.25,-0.35,-3.25])
        scale([1.8,1.8,1.8])
        union() {
            translate([-0.5,0.95,1.8])
            linear_extrude(0.1)
                square([0.1,0.55],center = true);
            
            translate([-0.37,0.59,1.8])
            rotate([0,0,45])
                linear_extrude(0.1)
                    square([0.1,0.4],center = true);
            
            translate([0.1,0.47,1.8])
            linear_extrude(0.1)
                square([0.8,0.1],center = true);
            
            translate([0.7,0.57,1.8])
            linear_extrude(0.1)
                square([0.4,0.3],center = true);
            
            translate([-0.23,0.15,1.8])
            linear_extrude(0.1)
                square([0.1,0.6],center = true);
            
            translate([-0.3,-0.2,1.8])
            rotate([0,0,-45])
                linear_extrude(0.1)
                    square([0.1,0.25],center = true);
                    
            translate([-0.74,-0.27,1.8])
            linear_extrude(0.1)
                square([0.8,0.1],center = true);
                
            translate([-0.39,-0.55,1.8])
            linear_extrude(0.1)
                square([0.1,0.65],center = true); 
        }
    }
               
    color("black")
        translate([-0.75,-0.05,1.8])
            linear_extrude(0.1)
                square([0.65,0.65],center = true); 
    
    // Pads  
    color("silver")
            linear_extrude(0.8)
                for(side = [-1,1], end = [-1:1])
                    if (side != 0 && end != 0) {
                        translate([side*2.2,end*2.0,0])
                        square([1,0.9],center = true);                 
                    }
    if (draw_resistor)
    {
        translate([0,-3.1,0]) {
        color("silver")
            linear_extrude(0.55)
                    square([1.5, 0.9], center = true);
    
        color("brown")
            linear_extrude(0.56)
                    square([0.8, 1], center = true);
        }
    }
}

module ws2812b_12_ring (draw_resistor = true)
{
    //PCB
    
    color("Black")    
    difference() {
        linear_extrude(1.6)
            circle(d = 50, $fn=64);
        
        translate([0,0,-0.1])
        linear_extrude(1.8)
            circle(d = 35, $fn=64);
    
        // Holes at 45º
        //x = r * cos(45)
        //y = r * sin(45)
        dim = 23.5 * 0.707107;
        
        translate([dim,dim,-0.1])
        linear_extrude(1.8)
            circle(d=2, $fn=32);
        
        translate([-dim,dim,-0.1])
        linear_extrude(1.8)
            circle(d=2, $fn=32);
        
        translate([dim,-dim,-0.1])
        linear_extrude(1.8)
            circle(d=2, $fn=32);
        
        translate([-dim,-dim,-0.1])
        linear_extrude(1.8)
            circle(d=2, $fn=32);
    }
    
//    // Leds
    angle_offset = 360/12;
    for (i = [0:11])
    {
        translate([21*cos(i*angle_offset),21*sin(i*angle_offset),1.6])
            rotate([0,0,90+i*angle_offset])
                //cube([3,3,1.7],center=true);
                ws2812b(draw_resistor);
    }
    
    // Pads
    color("Silver"){
        translate([1.25,-22,0])
            cube([1,2.5,0.1], center=true);
        
        translate([3.75,-22,0])
            cube([1,2.5,0.1], center=true);
        
        translate([-1.25,-22,0])
            cube([1,2.5,0.1], center=true);
        
        translate([-3.75,-22,0])
            cube([1,2.5,0.1], center=true);
    }
    
    // Text
    color ("White")
    {
        translate([20,1,-0.1]) 
        rotate([180,0,-90])
        linear_extrude(height=0.001, center=true, convexity=10)
            text("WCMCU-2812B-12", size=1.9, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([-3.75,-19.3,-0.1]) 
        rotate([180,0,-90])
        linear_extrude(height=0.001, center=true, convexity=10)
            text("DI", size=1.2, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([-1.25,-19.3,-0.1]) 
        rotate([180,0,-90])
        linear_extrude(height=0.001, center=true, convexity=10)
            text("5V", size=1.2, font="Rajdhani:style=regular", halign="center", valign="center");
        
        translate([1.25,-19.3,-0.1]) 
        rotate([180,0,0])
        linear_extrude(height=0.001, center=true, convexity=10)
            text("GND", size=1.2, font="Rajdhani:style=regular", halign="center", valign="center");
        
         translate([3.75,-19.3,-0.1]) 
        rotate([180,0,-90])
        linear_extrude(height=0.001, center=true, convexity=10)
            text("DO", size=1.2, font="Rajdhani:style=regular", halign="center", valign="center");
        
    }
        
}

//ws2812b (draw_resistor = true);
ws2812b_12_ring(draw_resistor = true);



