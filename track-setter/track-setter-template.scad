$fn=360;
radius = 505;
width  = 16.7;
height = 2.1;
angle  = 22.5;

outerRadius = radius + (width / 2);
innerRadius = radius - (width / 2);

intersection() {
    difference() {
        cylinder(r=outerRadius, h=height, center=true);    
        cylinder(r=innerRadius, h=height, center=true);
    }
    difference() {
        rotate_extrude(angle=angle) square([outerRadius, height]);
        rotate_extrude(angle=angle) square([innerRadius, height]);

    }
}

