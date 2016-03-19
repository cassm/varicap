capacitance = 400; // pF
num_plates = 11;
plate_gap = 5;
plate_thickness = 2;

strut_r = 5;
handle_length = 25;
leg_length = 10;
leg_separation_angle=90;

fit_gap = 0.5;
slip_gap = 1;

num_stators = floor(num_plates/2);
num_rotors = ceil(num_plates/2);
leg_angle_0 = leg_separation_angle/2;
leg_angle_1 = 360 - leg_separation_angle/2;
r = sqrt((2*plate_gap*capacitance) / ((num_plates-1)*0.2248*3.14));
//TODO: account for space missing in the centre of the plates

module semicircle () {
    difference() {
        circle(r);
        circle(strut_r-fit_gap);
        translate([r,0,0]) {
            square(2*r, true);
        }
    }
}

module washer() {
    difference() {
        circle(strut_r);
        circle(bolt_r);
    }
}

module spacer(end) {
    
    washer_len = plate_thickness + plate_gap - slip_gap/2;
    bearing_len = end ? plate_thickness*2 + plate_gap + slip_gap/2 : plate_thickness+plate_gap;
    
    difference () {
        union () {
            if (end) {
                linear_extrude (washer_len) {
                    circle (strut_r * 1.5);
                }
            }
            linear_extrude (bearing_len) {
                circle (strut_r);
            }
            translate ([0,0,bearing_len - fit_gap]) {
                linear_extrude(plate_thickness+fit_gap) {
                    square (strut_r, true);
                }
            }
        }
        
        translate ([0,0,-fit_gap]) {
            linear_extrude (plate_thickness + fit_gap*2) {
                square (strut_r+fit_gap, true);
            }
        }
    }
}