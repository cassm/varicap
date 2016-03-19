washer_r = 5;
bolt_r = 2;

num_plates = 11;
num_stators = floor(num_plates/2);
num_rotors = ceil(num_plates/2);

thickness = 2;
gap = 5;
fit_gap = 0.5;
slip_gap = 1;
handle_length = 25;
fixing_plate_size = 25;

leg_length = 10;

capacitance = 400; // pF

//TODO: account for space missing in the centre of the plates
r = sqrt((2*gap*capacitance) / ((num_plates-1)*0.2248*3.14));

module semicircle () {
    difference() {
        circle(r);
        circle(washer_r-fit_gap);
        translate([r,0,0]) {
            square(2*r, true);
        }
    }
}

module washer() {
    difference() {
        circle(washer_r);
        circle(bolt_r);
    }
}

module spacer(end) {
    
    washer_len = thickness + gap - slip_gap/2;
    bearing_len = end ? thickness*2 + gap + slip_gap/2 : thickness+gap;
    
    difference () {
        union () {
            if (end) {
                linear_extrude (washer_len) {
                    circle (washer_r * 1.5);
                }
            }
            linear_extrude (bearing_len) {
                circle (washer_r);
            }
            translate ([0,0,bearing_len - fit_gap]) {
                linear_extrude(thickness+fit_gap) {
                    square (washer_r, true);
                }
            }
        }
        
        translate ([0,0,-fit_gap]) {
            linear_extrude (thickness + fit_gap*2) {
                square (washer_r+fit_gap, true);
            }
        }
    }
}

triangle_height = sqrt((r+washer_r)*(r+washer_r)/2);
echo ("triangle height = ", triangle_height);
