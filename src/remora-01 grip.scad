include <header.scad>;

//functions
module rcube(size, radius) {
    hull() {
        translate([radius, radius]) cylinder(r = radius, h = size[2], $fn=faces);
        translate([size[0] - radius, radius]) cylinder(r = radius, h = size[2], $fn=faces);
        translate([size[0] - radius, size[1] - radius]) cylinder(r = radius, h = size[2], $fn=faces);
        translate([radius, size[1] - radius]) cylinder(r = radius, h = size[2], $fn=faces);
    }
}

module rslot(size, radius) {
    hull() {
        translate([radius, radius]) cylinder(r = radius, h = size[2], $fn=faces);
        translate([size[0] - radius, radius]) cylinder(r = radius, h = size[2], $fn=faces);
    }
}

module contacts_plate() {
    cube([contact_slot_x/2, contact_extra_material, contact_slot_z]);

    translate([0, contact_slot_y - contact_extra_material, 0]) 
        cube([contact_slot_x/2, contact_extra_material, contact_slot_z]);

     rcube([contact_slot_x, contact_slot_y, contact_slot_z], 3);
}

//contacts_plate();

module contacts_plate_cover() {
     translate([0, -1, 0]) cube([contact_slot_x/2 , contact_extra_material, case_height + wall_height]);

    translate([0, contact_slot_y - contact_extra_material + 1, 0]) 
        cube([contact_slot_x/2, contact_extra_material, case_height + wall_height]);

      translate([0, -1, 0]) rcube([contact_slot_x+1, contact_slot_y+2, case_height + wall_height], 3);
}

//contacts_plate_cover();

module contacts_plate_housing() {
       color("red") translate([base_height, first_hole_y_shift - contact_slot_y_extra, 0])  contacts_plate_cover();
}


//base with wall
module base() {
    translate([base_height, first_hole_y_shift - contact_slot_y_extra, 0]) contacts_plate();;
    
    difference() {
        color("red") cube([base_height, base_width, case_height]);
    }
}

module lid() {
   rotate([0, 180, 0]) translate([-base_height,0, -case_height - wall_height]) contacts_plate_housing();
   rotate([0, 180, 0])translate([0, first_hole_y_shift - contact_slot_y_extra, -wall_height]) contacts_plate();


    difference() {
        color("green") cube([base_height, base_width, case_height]);
    }
}

module remora() {
    base();
    //rotated lid
    rotate([0, -180, 0])translate([-base_height, 0, -case_height - wall_height]) lid();
}

module grip() {
    import ("grip.stl");
}

module large_grip() {
    translate([-44.5,98.5,17.6]) rotate([270,00,270]) grip();
    translate([-25,98.5,17.6]) rotate([270,00,270]) grip();
}

module extended_grip() {
    translate([0,0,-9.1]) large_grip();
    large_grip();
}

module remora_grip() {
    translate([0.2,-2.67,8]) cube([39.5,111.56,5]);
    difference() {
        extended_grip();
        translate([-1,0.3,-15]) cube([42,10,4]);
        translate([-1,96,-15]) cube([42,10,4]);
        translate([0,-2.67,13]) cube([42,111.56,6]);
    }
}

rotate([0,90,0]) difference() {
    remora_grip();
    remora();
}
