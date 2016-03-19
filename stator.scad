include <varicap.scad>

module leg() {
    union() {
        linear_extrude (thickness) {
            difference (){
                hull() {
                    circle(washer_r);
                    translate([-(r+leg_length),0,0]) {
                        circle(washer_r);
                    }
                }
                translate([-(r+leg_length),0,0]) {
                    circle(washer_r-fit_gap);
                }
            }
        }
        translate ([-(r+leg_length),0,0]) {
            spacer ();
        }
    }
}

module stator () {
    difference () {
        union () {
            linear_extrude (thickness) {
                semicircle ();
            }
            rotate ([0,0,leg_angle_0]) leg();
            rotate ([0,0,leg_angle_1]) leg();
        }
        translate ([0,0,-fit_gap]) {
            linear_extrude (thickness + 2*fit_gap) {
                circle (washer_r + 2*slip_gap);
            }
        }
    }
}

stator ();