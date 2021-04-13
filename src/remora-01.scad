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

//components volume
module power_boost_board() {
    difference() {
        rcube(power_boost, 2);
        
        //big holes
        translate([power_boost_big_hole_r + 1.2, power_boost_big_hole_r + 1.3, 0 ]) 
            cylinder(r = power_boost_big_hole_r, h = power_boost[2] * 2, $fn=faces);
        translate([power_boost_big_hole_r + 1.2, power_boost[1] - power_boost_big_hole_r - 1.3, 0 ]) 
            cylinder(r = power_boost_big_hole_r, h = power_boost[2] * 2, $fn=faces);
        
        //small holes
        translate([power_boost[0] - power_boost_small_hole_r - 1.4, power_boost_small_hole_r + 3.4, 0]) 
            cylinder(r = power_boost_small_hole_r, h = power_boost[2] * 2, $fn=faces);
        translate([power_boost[0] - power_boost_small_hole_r - 1.4, power_boost[1] - power_boost_small_hole_r - 3.4, 0 ]) 
            cylinder(r = power_boost_small_hole_r, h = power_boost[2] * 2, $fn=faces);
    }   
}

//power_boost_board();

module usb_board() {
    difference() {
        rcube(usb, 2);
        
        //small holes
        translate([1.5 + usb_hole_r, usb_hole_r + 1.5, 0 ]) 
            cylinder(r = usb_hole_r, h = power_boost[2] * 2, $fn=faces);
        translate([1.5 + usb_hole_r, usb[1] - usb_hole_r - 1.5, 0 ]) 
            cylinder(r = usb_hole_r, h = power_boost[2] * 2, $fn=faces);
        
        //port slot
        translate([0, usb[1]/2 - usb_port_slot/2 + half_component_wall_thickness, wall_height])
            cube([component_wall_thickness, usb_port_slot, wall_height]);
    }   
}

//usb_board();

module switch() {
   cube(switch);
}

//switch();

module magnet() {
   cube(magnet);
}

//magnet();

//cradles
module power_boost_cradle() {
    difference() {
        cube(power_boost_well);
        translate([half_component_wall_thickness, half_component_wall_thickness, wall_height]) power_boost_board();
        //slot for cables to go out
        translate([0, 0, wall_height])
            cube([usb_well[1], component_wall_thickness / 2, wall_height]);
        //slot for cables to come in
        translate([power_boost_well[0] / 4 + component_wall_thickness / 2, power_boost_well[1] - component_wall_thickness / 2, wall_height])
            cube([power_boost_well[0] / 2, component_wall_thickness, wall_height]);
    }
}

//power_boost_cradle();

module usb_cradle() {
    difference() {
        cube(usb_well);
        translate([component_wall_thickness, component_wall_thickness, wall_height]) usb_board();
        //usb c slot
        translate([0, usb[1]/2 - usb_port_slot/2 + component_wall_thickness, wall_height])
            cube([component_wall_thickness, usb_port_slot, wall_height]);
        //slot for the cables to go out
        translate([usb_well[0] - component_wall_thickness, usb[1]/2 - usb_port_slot/2 + component_wall_thickness, wall_height]) 
            cube([component_wall_thickness*2, usb_port_slot, wall_height]);
    }
}

//usb_cradle();

module switch_cradle() {
    difference() {
        cube(switch_well);
        translate([half_component_wall_thickness, half_component_wall_thickness, wall_height]) switch();
        //contacts slot
        translate([0, switch[1] / 2 - switch_contacts/2 + component_wall_thickness / 2, wall_height]) 
            cube([component_wall_thickness, switch_contacts, switch[2]]);
        //pin slot
        translate([switch[0], switch[1] / 2 - switch_y_travel/2 + component_wall_thickness / 2, wall_height]) 
            cube([component_wall_thickness, switch_y_travel, switch[2]]);
    }
}

//switch_cradle();

module battery_cradle() {
    difference() {
        cube(battery_well);
        translate([half_component_wall_thickness, half_component_wall_thickness, wall_height]) cube(battery);
        //wires slot
        translate([battery[0], battery[1]/2 - battery_wires_slot/2 + half_component_wall_thickness, wall_height])
            cube([component_wall_thickness, battery_wires_slot, battery_well[2] - wall_height]);
    }
}

//battery_cradle();

module boards_cradle() {
    power_boost_cradle();
    translate([0, -usb_well[1] + half_component_wall_thickness, 0]) rotate([0, 0, 0]) usb_cradle();
}

//boards_cradle();

module magnet_cradle() {
    difference() {
        cube(magnet_well);
        translate([half_component_wall_thickness, half_component_wall_thickness, wall_height]) magnet();
    }
}

//magnet_cradle();

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

    difference() {
        color("red") translate([base_height, first_hole_y_shift - contact_slot_y_extra, 0])  contacts_plate_cover();
       translate([base_height, first_hole_y_shift - contact_slot_y_extra, 0]) 
        resize([contact_slot_x, contact_slot_y, contact_slot_z + case_height + wall_height])
            contacts_plate();
    }
}

//translate([00,0,0]) contacts_plate_housing();

module contacts() {
    difference() {
       contacts_plate();

       translate([contact_slot_x_extra + contact_hole_radius, contact_slot_y_extra + contact_hole_radius, 0])
           cylinder(r = contact_pin_radius, h = wall_height, $fn=faces);

        translate([contact_slot_x_extra + contact_hole_radius, contact_slot_y_extra +contact_hole_dist + contact_hole_diameter + contact_hole_radius, 0])
            cylinder(r = contact_pin_radius, h = wall_height, $fn=faces);

    }
}

//contacts();

//base with wall
module base() {
    //switch support
    translate([base_height - component_wall_thickness, switch_well[1]/2 - half_component_wall_thickness, wall_height ]) 
            cube([half_wall_thickness, switch_y_travel, 1]);

    //usb support
    translate([usb_well[1]/2 - (usb_port_slot+2)/2 + wall_thickness - component_wall_thickness, 0, wall_height])
        cube([(usb_port_slot+2), half_wall_thickness, wall_height-0.5]);

    translate([base_height, first_hole_y_shift - contact_slot_y_extra, 0]) contacts();
    
    difference() {
        color("red") cube([base_height, base_width, case_height]);
        translate([wall_thickness, wall_thickness, wall_height]) 
            cube([base_height-wall_thickness * 2, base_width-wall_thickness * 2, case_height]);
            
        //switch slot
        translate([base_height - (component_wall_thickness + wall_thickness), switch_well[1]/2 - half_component_wall_thickness, wall_height + 1]) 
            cube([component_wall_thickness + wall_thickness, switch_y_travel, case_height]);
       
        //usb slot
        rotate([90,0,0]) translate([usb_well[1]/2 - usb_port_slot/2 + wall_thickness - component_wall_thickness, wall_height*2, -wall_thickness])
           rslot([usb_port_slot, 3.2, wall_thickness], 1.5);

        //bottom wires slot
        translate([base_height - (component_wall_thickness + wall_thickness), base_width/2 - wall_thickness + component_wall_thickness, wall_height*2]) 
            cube([component_wall_thickness + wall_thickness, switch_y_travel, case_height]);
        
        //removing bits of the wall for closing the case from the top
        translate([0, 0, wall_height])
            cube([base_height, half_wall_thickness, case_height-wall_height]);
        translate([0, base_width-half_wall_thickness, wall_height])
            cube([base_height, half_wall_thickness, case_height-wall_height]);
        rotate([0, 0, 90])
            translate([0, -half_wall_thickness, wall_height])
                cube([base_width, half_wall_thickness, case_height-wall_height]);
        rotate([0, 0, 90])
            translate([0, - base_height, wall_height])
                cube([base_width, half_wall_thickness, case_height-wall_height]);
    }
}

//base with wall
module lid() {
   rotate([0, 180, 0]) translate([-base_height,0, -case_height - wall_height]) contacts_plate_housing();
   rotate([0, 180, 0])translate([0, first_hole_y_shift - contact_slot_y_extra, -wall_height]) contacts_plate();


    difference() {
        color("green") cube([base_height, base_width, case_height]);
        translate([wall_thickness, wall_thickness, wall_height]) 
            cube([base_height-wall_thickness * 2, base_width-wall_thickness * 2, case_height]);
        
        //switch slot
        translate([0, switch_well[1]/2 - half_component_wall_thickness, wall_height + 2.5]) 
            cube([component_wall_thickness + wall_thickness, switch_y_travel, case_height]);

        //contact cover slot
        translate([0, first_hole_y_shift - contact_slot_y_extra, wall_height ]) 
            cube([component_wall_thickness + wall_thickness, contact_slot_y, case_height]);

        //usb slot
        translate([base_height/2 + wall_thickness + component_wall_thickness/4, 0, (2*wall_height) - half_component_wall_thickness])
           cube([usb_port_slot+2, wall_thickness , case_height-wall_height]);
        
        //removing bits of the wall for closing the case from the top
        translate([wall_thickness, half_wall_thickness, wall_height])
            cube([base_height - 2 * wall_thickness, half_wall_thickness, case_height-wall_height]);
        translate([wall_thickness, base_width-wall_thickness, wall_height])
            cube([base_height - 2 * wall_thickness, half_wall_thickness, case_height-wall_height]);
        rotate([0, 0, 90])
            translate([wall_thickness / 2, - wall_thickness, wall_height])
                cube([base_width - wall_thickness, half_wall_thickness, case_height-wall_height]);
        rotate([0, 0, 90])
            translate([wall_thickness / 2, -base_height + half_wall_thickness, wall_height])
                cube([base_width - wall_thickness, half_wall_thickness, case_height-wall_height]);

    }
}


show_components = true;

base();

//rotate([0, -180, 0])translate([-base_height, 0, -case_height - wall_height]) lid();
rotate([0, 0, 0]) translate([-base_height -5, 0, 0]) lid();

//components
if(show_components) {

    translate([ base_height - magnet_well[0] - half_wall_compensation, base_width - magnet_well[1]*2 - wall_thickness - battery_well[0] - power_boost_well[1] + component_wall_thickness + half_component_wall_thickness, 0]) magnet_cradle();

    translate([ base_height - magnet_well[0] - half_wall_compensation, base_width  - magnet_well[1] - half_wall_compensation, 0]) magnet_cradle();

    translate([base_height - switch_well[1] / 2 - wall_thickness + component_wall_thickness / 2 - 0.2, component_wall_thickness*(3/2), 0])
        switch_cradle();

    rotate([0,0,270])
        translate([ -base_width + wall_thickness - component_wall_thickness + magnet_well[1], base_height - battery_well[1] - wall_thickness + half_component_wall_thickness, 0])
        battery_cradle();

    translate([wall_thickness - half_component_wall_thickness, base_width - magnet_well[1] - wall_thickness - battery_well[0] - power_boost_well[1]+component_wall_thickness, 0]) power_boost_cradle();
    
    rotate([0, 0, 90])translate([component_wall_thickness, -usb_well[1]-half_wall_thickness, 0]) usb_cradle();
}

difference() {
    translate([base_height + 5, 5, 0]) cylinder(r1 = contact_hole_radius, r2 = contact_pin_radius, h = contact_pin_cone_h, $fn=faces);
    translate([base_height + 5, 5, 0]) cylinder(r = contact_pin_radius, h = contact_pin_cone_h, $fn=faces);
}

difference() {
    translate([base_height + 5, 15, 0]) cylinder(r1 = contact_hole_radius, r2 = contact_pin_radius, h = contact_pin_cone_h, $fn=faces);
    translate([base_height + 5, 15, 0]) cylinder(r = contact_pin_radius, h = contact_pin_cone_h, $fn=faces);
}
