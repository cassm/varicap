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

module rotor(end) {
    rotate ([0,0,180]) {
        union() {  
            linear_extrude (thickness) {
                semicircle();
            }
            
            spacer(end);
        }
    }
}

module stator() {
    difference() {
        union () {
            linear_extrude (thickness) {
                semicircle();
            }
            rotate([0,0,45]) leg();
            rotate([0,0,315]) leg();
        }
        translate([0,0,-fit_gap]) {
            linear_extrude(thickness + 2*fit_gap) {
                circle(washer_r + 2*slip_gap);
            }
        }
    }
}

module fixing_point(diameter, angle) {
    rotate([0,0,angle]) 
        translate([-(r + leg_length),0,0]) 
            circle(diameter);
}

triangle_height = sqrt((r+washer_r)*(r+washer_r)/2);
echo ("triangle height = ", triangle_height);

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
            

module endstand(end) {
    union() {
        linear_extrude (thickness) {
            difference() {
                hull() {
                    circle(1.5 * washer_r);
                    fixing_point(1.5 * washer_r, 45);
                    fixing_point(1.5 * washer_r, 315);
                }
                circle(washer_r+slip_gap/2);
                fixing_point(washer_r-fit_gap, 45);
                fixing_point(washer_r-fit_gap, 315);
            }
        }
        
        end_spacer(45, end);
        end_spacer(315, end);
    }
}

module plate_set() {
    stator();
    translate([5,0,0]) {
        rotor();
    }
}

module end_pieces() {
    rotate([-0,0,90]) 
        translate ([(triangle_height * 5+fixing_plate_size/2-washer_r)/2,0,0])
            endstand(0);

    rotate([0,0,270])
        translate ([(triangle_height+fixing_plate_size/2-washer_r)/2,2*r,0])
            endstand(1);
}

module bush(end) {
    difference () {
        union() {
            linear_extrude(gap - slip_gap/2) {
                circle (washer_r * 1.5);
            }
            linear_extrude (gap + thickness + slip_gap/2) {
                circle (washer_r);
            }
        }
        
        translate ([0,0,-slip_gap/2]) {
            linear_extrude(thickness + gap + slip_gap*2) {
                square(washer_r+slip_gap/2, true);
            }
        }
        
    }
}

module spigot () {
    linear_extrude (washer_r) {
        square ([washer_r, thickness*3 + gap + slip_gap], true);
    }
}

module handle() {
    difference () {
        union() {
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
                circle(washer_r * 1.5);
            }
        }
        translate ([0,0,-fit_gap]) {
            linear_extrude (thickness + 2*fit_gap) {
                square(washer_r+fit_gap, true);
            }
        }
    }
}
