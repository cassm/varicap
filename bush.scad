include <varicap.scad>;

module bush () {
    difference () {
        union () {
            linear_extrude (plate_gap - slip_gap/2) {
                circle (strut_r * 1.5);
            }
            linear_extrude (plate_gap + plate_thickness + slip_gap/2) {
                circle (strut_r);
            }
        }
        
        translate ([0,0,-slip_gap/2]) {
            linear_extrude (plate_thickness + plate_gap + slip_gap*2) {
                square (strut_r+slip_gap/2, true);
            }
        }
        
    }
}

bush ();