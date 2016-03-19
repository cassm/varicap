include <varicap.scad>;

module spigot () {
    linear_extrude (washer_r) {
        square ([washer_r, thickness*3 + gap + slip_gap], true);
    }
}

spigot ();