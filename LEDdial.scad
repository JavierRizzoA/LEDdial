/*
* LEDdial
*/

strip_h = 10;
led_h = 6;
strip_w = 16.5;
resolution = 24;
wall=8;
offset=30;
cable_hole_r=2;

$fn = 128;

function radius() = (strip_w*resolution) / (2 * PI);

module gnomon() {
    
    difference() {
        union() {
            translate([10, 0, 0]) cylinder($fn=6, h=3, r=5);
            translate([10, 0, 3]) cylinder(h=3, r1=2, r2=4.5);
            translate([10, 0, 3+3]) cylinder(h=9, r1=4.5, r2=0);
        }
        translate([10, 0, 0]) cylinder(h=2, r=1.1);
    }
}

module stick() {
    cylinder(h=8, r=1);
}

module gnomon_base() {
    union() {
        cylinder(h=.2, r=5);
        translate([0, 0, .2]) cylinder(h=5, r=1);
    }
}

module strip_holder() {
    difference() {
        cylinder(h=led_h, r=radius()+wall);
        cylinder(h=led_h, r=radius());
    }
}

module wall(height, radius, wall) {
    difference() {
        cylinder(h=height, r=radius+wall);
        cylinder(h=height, r=radius);
    }
}

module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}

module wall_sector(height, radius, angle1, angle2, wall) {
    difference() {
        sector(height, (radius+wall)*2, angle1, angle2);
        sector(height, radius*2, angle1, angle2);
    }
}

module base() {
    cylinder(h=3, r=radius());
}


module LEDdial() {
    
    difference() {
        rotate([45, 0, 0])
        translate([0, 0, radius()])
        union() {
            // Outer cylinder.
            translate([0, 0, -radius()*2-wall])
                wall(
                    radius()*2+55+wall,
                    radius(),
                    wall);
            //LED strip guides
            translate([0, 0, 3])
                wall(1, radius()-2, 3);
            translate([0, 0, 3+11])
                wall(1, radius()-2, 3);
            translate([0, 0, 30-1+3])
                wall(1, radius()-2, 3);
            translate([0, 0, 30-1+3+11])
                wall(1, radius()-2, 3);
            translate([0, 0, 30-1+3+11+11])
                wall(1, radius()-2, 3);
            
            difference() {
                //Clock face
                base();
                //Number indicators
                union() {
                    translate([0, 0, 3/2]) union() {
                        for(i = [0: 1: 12]) {
                            rotate([0, 0, i*360/12])
                                translate([-1, 40, 0])
                                    cube([2, 15, 3/2]);
                        }
                    }
                }
            }
        }
        
        union() {
            //Stick hole
            rotate([45, 0, 0])
                translate([0, 0, radius()+1])
                    cylinder(h=3, r=1.1);
            //Base        
            translate([0, 0, -100.4])
                cube([200, 200, 200], center=true);
            
            //Power cord hole
            translate([0, radius()*1.5+wall, 0])
                rotate([90, 0, 0])
                    cylinder(r=4, h=wall*2);
            
            //Holes for cables
            rotate([45, 0, 0])
                translate([0, 0, 53])
                    wall_sector(63, radius()+1, 0, -30, wall-2);
            rotate([45, 0, 0])
                translate([0, 0, 53])
                wall_sector(10, radius(), 0, -30, 1);
            rotate([45, 0, 0])
                translate([0, 0, radius()+3+2])
                    union() {
                        wall_sector(8, radius(), -10, -20, 1);
                        translate([0, 0, 29])
                            wall_sector(8, radius(), -10, -20, 1);
                        translate([0, 0, 40])
                            wall_sector(8, radius(), -10, -20, 1);
                    }
        }
    }
}


rotate([0, 0, 45]) LEDdial();
//stick();
//gnomon();