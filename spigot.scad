include <varicap.scad>;

module spigot () {
    linear_extrude (strut_r) {
        square ([strut_r, plate_thickness*3 + plate_gap + slip_gap], true);
    }
}

spigot ();