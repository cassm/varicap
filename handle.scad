include <varicap.scad>;

module handle () {
    difference () {
        union () {
            linear_extrude (thickness) {
                hull () {
                    circle (washer_r * 1.5);
                    translate ([r,0,0]) {
                        circle (washer_r);
                    }
                }
            }
            
            linear_extrude (thickness+handle_length) {
                translate ([r,0,0]) {
                    circle (washer_r);
                }
            }
            
            linear_extrude (thickness*2) {
                circle (washer_r * 1.5);
            }
        }
        translate ([0,0,-fit_gap]) {
            linear_extrude (thickness + 2*fit_gap) {
                square (washer_r+fit_gap, true);
            }
        }
    }
}

handle ();