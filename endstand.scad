include <varicap.scad>;

end_position=0;

module endstand (end) {
    union () {
        linear_extrude (thickness) {
            difference () {
                hull () {
                    circle (1.5 * washer_r);
                    fixing_point (1.5 * washer_r, leg_angle_0);
                    fixing_point (1.5 * washer_r, leg_angle_1);
                }
                circle (washer_r+slip_gap/2);
                fixing_point (washer_r-fit_gap, leg_angle_0);
                fixing_point (washer_r-fit_gap, leg_angle_1);
            }
        }
        
        end_spacer (leg_angle_0, end);
        end_spacer (leg_angle_1, end);
    }
}

module end_spacer(angle, end) {
    length = end ? thickness + (gap + slip_gap/2) - (gap - thickness)/2  : thickness + (gap*2 + slip_gap/2) - (gap - thickness)/2;
    rotate([0,0,angle]) {
        translate([-(r + leg_length),0,0]) {
            if (end == 0) {
                union () {
                    linear_extrude (length) {
                        circle(washer_r);
                    }
                    translate ([0,0,length-fit_gap]) {
                        linear_extrude(thickness + fit_gap) {
                            square(washer_r, true);
                        }
                    }
                }
            }
            else {
               difference () {
                    linear_extrude (length) {
                        circle(washer_r);
                    }
                    translate ([0,0,length-thickness-fit_gap]) {
                        linear_extrude(thickness + fit_gap*2) {
                            square(washer_r+fit_gap, true);
                        }
                    }
                }
            }
        }
    }
}

module fixing_point(diameter, angle) {
    rotate([0,0,angle]) 
        translate([-(r + leg_length),0,0]) 
            circle(diameter);
}

endstand (end_position);