wall_thickness = 2;
half_wall_thickness = wall_thickness/2;
component_wall_thickness = 1;
half_component_wall_thickness = component_wall_thickness/2;
full_wall_compensation = wall_thickness + component_wall_thickness;
half_wall_compensation = half_wall_thickness + half_component_wall_thickness;
case_height = 7.5;

wall_height = 1.6;
faces = 100;
base_width = 106;
base_height = 40;

power_boost_x = 36;
power_boost_y = 22;
power_boost_z = 1.5;
power_boost_big_hole_r = 2.3 / 2;
power_boost_small_hole_r = 1.1;
power_boost = [power_boost_x, power_boost_y, power_boost_z];
power_boost_well = power_boost + [component_wall_thickness, component_wall_thickness, wall_height];

usb_x = 14.2;
usb_y = 20.5;
usb_z = 1.5;
usb_hole_r = power_boost_small_hole_r;
usb = [usb_x, usb_y, usb_z];
usb_port_slot = 9;
usb_well = usb + [component_wall_thickness*2, component_wall_thickness*2, wall_height];

battery_x = 37;
battery_y = 30;
battery_z = 5;
battery = [battery_x, battery_y, battery_z];
battery_wires_slot = 4;
battery_well = battery + [component_wall_thickness, component_wall_thickness, wall_height];

switch_x = 4.1;
switch_y = 8.8;
switch_z = 4;
switch_y_travel = 4;
switch_contacts = 6;
switch = [switch_x, switch_y, switch_z];
switch_well = switch + [component_wall_thickness, component_wall_thickness, wall_height];

magnet_x = 20;
magnet_y = 10;
magnet_z = 2;
magnet = [magnet_x, magnet_y, magnet_z*2];
magnet_well = magnet + [component_wall_thickness, component_wall_thickness, wall_height];

//contact pins case extension
first_hole_y_shift = 35.5;
contact_slot_y_extra = 2;
contact_slot_x_extra = 1.2;
contact_slot_x = 6;
contact_slot_y = 43;
contact_slot_z = wall_height;
contact_hole_diameter = 3.6;
contact_hole_radius = contact_hole_diameter/2;
contact_hole_dist = 31.8;
contact_pin_radius = 0.7;
contact_pin_cone_h = 3;
contact_extra_material = 3;