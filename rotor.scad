include <varicap.scad>

is_end = 0;

module rotor (end) {
    rotate ([0,0,180]) {
        union() {  
            linear_extrude (thickness) {
                semicircle ();
            }
            
            spacer (end);
        }
    }
}

rotor (is_end);