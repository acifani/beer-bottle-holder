bottles = 3;
bottle_diameter = 75;
shell_thickness = 2.4;
holder_depth = 80;
holder_height = 25;

bottle_radius = bottle_diameter / 2;
draw_thickness = shell_thickness / 100;

for (i = [0:bottles - 1]) {
  linear_extrude(height=holder_depth) {
    offset(r=shell_thickness / 2) {
      translate([i * (bottle_diameter), 0, 0]) {
        difference() {
          // Build base cylinder + connector between bottles
          union() {
            circle(r=bottle_radius + draw_thickness);
            translate([0, -bottle_radius + holder_height - draw_thickness, 0]) {
              square([bottle_diameter, shell_thickness], center=true);
            }
          }

          union() {
            // Remove internal parts of the base cylinder
            circle(d=bottle_diameter);
            // Remove top part of the cylinder
            translate([-bottle_diameter, -bottle_radius + holder_height]) {
              square([10000, bottle_diameter + draw_thickness]);
            }
          }

          if (i == 0) {
            // Remove leftmost connector
            difference() {
              // Build offset cylinder
              circle(r=bottle_diameter);
              // Do not remove existing cylinder
              circle(r=bottle_radius + draw_thickness);
              // Do not remove right-side stuff
              translate([bottle_radius, 0, 0]) {
                square([bottle_diameter, bottle_diameter * 2], center=true);
              }
            }
          }

          if (i == bottles - 1) {
            // Remove rightmost connector
            difference() {
              circle(r=bottle_diameter);
              circle(r=bottle_radius + draw_thickness);
              translate([-bottle_radius, 0, 0]) {
                square([bottle_diameter, bottle_diameter * 2], center=true);
              }
            }
          }
        }
      }
    }
  }
}
