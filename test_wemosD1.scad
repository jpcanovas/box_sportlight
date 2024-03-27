// Usage example for the ESP8266 models library V1.4
use <NopSCADlib/utils/core/global.scad>
use <NopSCADlib/vitamins/battery.scad>
use <NopSCADlib/vitamins/radial.scad>

use <ESP8266/ESP8266Models.scad>
use <HCSRC04/HC-SR04.scad>
use <ws2812b.scad>
use <batt_charger.scad>
use <button.scad>

// WemosD1M and daughter boards locator functions test
WD1MOPOS = 0;
translate([0, 0, 0]) {
    WemosD1M(pins=0, atorg=WD1MOPOS, usb=1);
}
translate([40,0,0]) HCSR04();

translate([-40,0,0]) ws2812b_12_ring();

translate([-20,40,0]) TP4056_charger_booster();

translate([20,40,0]) rotate([0,90,0]) button();

batt_spring = ["batt_spring", 5, 0.5, 8, 5, 1, false, 6, "silver"];
bcontact = ["bcontact", 9.33, 9.75, 0.4, 2.86, 6, [1.6, 3, 5], [4.5, batt_spring]];
battery_def = ["S25R18650", "Cell Samsung 25R 18650 LION", 65, 18.3, 13, 10,  0, "MediumSeaGreen", [], 0, bcontact];

translate ([80,40,0]) rotate([0,90,0]) battery(battery_def);

// Electrolityc capacitor 829uF, 6.3V, 8x12mm
ECAP8x12 = ["ECAP8x12", [8, 7.5, 12], 0.5, [2.4, 2.5], 0.5, inch(0.1), [grey(20), grey(60)]];
translate ([-60,40,0]) rotate([0,90,0]) rd_electrolytic(ECAP8x12,"820uF 6.3V");