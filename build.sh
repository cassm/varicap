#! /bin/sh

# Output files are specified as amf, because I have had difficulty with getting openSCAD to export reliably to STL. Your mileage may vary.
FILETYPE="amf"

command -v openscad >/dev/null 2>&1 || { echo >&2 "Error: OpenSCAD is required, but cannot be found.  Aborting."; exit 1; }


openscad -o rotor.$FILETYPE -D 'is_end=0' rotor.scad
openscad -o end_rotor.$FILETYPE -D 'is_end=1' rotor.scad
openscad -o stator.$FILETYPE stator.scad
openscad -o endstand_0.$FILETYPE -D 'end_position=0' endstand.scad
openscad -o endstand_1.$FILETYPE -D 'end_position=1' endstand.scad
openscad -o bush.$FILETYPE bush.scad
openscad -o spigot.$FILETYPE spigot.scad
openscad -o handle.$FILETYPE handle.scad
