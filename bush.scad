include <varicap.scad>;

module bush () {
    difference () {
        union () {
            linear_extrude (gap - slip_gap/2) {
                circle (washer_r * 1.5);
            }
            linear_extrude (gap + thickness + slip_gap/2) {
                circle (washer_r);
            }
        }
        
        translate ([0,0,-slip_gap/2]) {
            linear_extrude (thickness + gap + slip_gap*2) {
                square (washer_r+slip_gap/2, true);
            }
        }
        
    }
}

bush ();