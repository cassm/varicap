include <varicap.scad>

module leg() {
    union() {
        linear_extrude (plate_thickness) {
            difference (){
                hull() {
                    circle(strut_r);
                    translate([-(r+leg_length),0,0]) {
                        circle(strut_r);
                    }
                }
                translate([-(r+leg_length),0,0]) {
                    circle(strut_r-fit_gap);
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
            linear_extrude (plate_thickness) {
                semicircle ();
            }
            rotate ([0,0,leg_angle_0]) leg();
            rotate ([0,0,leg_angle_1]) leg();
        }
        translate ([0,0,-fit_gap]) {
            linear_extrude (plate_thickness + 2*fit_gap) {
                circle (strut_r + 2*slip_gap);
            }
        }
    }
}

stator ();