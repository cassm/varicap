include <varicap.scad>;

module handle () {
    difference () {
        union () {
            linear_extrude (plate_thickness) {
                hull () {
                    circle (strut_r * 1.5);
                    translate ([r,0,0]) {
                        circle (strut_r);
                    }
                }
            }
            
            linear_extrude (plate_thickness+handle_length) {
                translate ([r,0,0]) {
                    circle (strut_r);
                }
            }
            
            linear_extrude (plate_thickness*2) {
                circle (strut_r * 1.5);
            }
        }
        translate ([0,0,-fit_gap]) {
            linear_extrude (plate_thickness + 2*fit_gap) {
                square (strut_r+fit_gap, true);
            }
        }
    }
}

handle ();