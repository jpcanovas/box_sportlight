use <NopSCADlib/utils/thread.scad>
use <NopSCADlib/vitamins/spade.scad>

module button(facets=32)
{
    color("DarkGray")
    {
        cylinder(8,d=10,$fn=facets);
        translate([0,0,13]) male_metric_thread(10.7,0.75,10);
        translate ([0,0,19]) cylinder(2,d1=12,d2=9,center=true,$fn=facets);
    }
    translate([0,0,20])color("red") cylinder(4,d=8,$fn=facets);
    

    spade6mm = [2.5, 1, 0.5, .6, 1];
    color ("Silver") {
        
        translate([3.5,0,0])
            rotate ([0,180,90]) spade (spade6mm,6);
        
        translate([-3.5,0,0])
            rotate ([0,180,90]) spade (spade6mm,6);
    }

}

*button();