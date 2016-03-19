include <varicap.scad>;

end_position=0;

module endstand (end) {
    union () {
        linear_extrude (plate_thickness) {
            difference () {
                hull () {
                    circle (1.5 * strut_r);
                    fixing_point (1.5 * strut_r, leg_angle_0);
                    fixing_point (1.5 * strut_r, leg_angle_1);
                }
                circle (strut_r+slip_gap/2);
                fixing_point (strut_r-fit_gap, leg_angle_0);
                fixing_point (strut_r-fit_gap, leg_angle_1);
            }
        }
        
        end_spacer (leg_angle_0, end);
        end_spacer (leg_angle_1, end);
    }
}

module end_spacer(angle, end) {
    length = end ? plate_thickness + (plate_gap + slip_gap/2) - (plate_gap - plate_thickness)/2  : plate_thickness + (plate_gap*2 + slip_gap/2) - (plate_gap - plate_thickness)/2;
    rotate([0,0,angle]) {
        translate([-(r + leg_length),0,0]) {
            if (end == 0) {
                union () {
                    linear_extrude (length) {
                        circle(strut_r);
                    }
                    translate ([0,0,length-fit_gap]) {
                        linear_extrude(plate_thickness + fit_gap) {
                            square(strut_r, true);
                        }
                    }
                }
            }
            else {
               difference () {
                    linear_extrude (length) {
                        circle(strut_r);
                    }
                    translate ([0,0,length-plate_thickness-fit_gap]) {
                        linear_extrude(plate_thickness + fit_gap*2) {
                            square(strut_r+fit_gap, true);
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