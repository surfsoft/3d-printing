$fn=90;

length = 200;
width = 35;
height = 15;

module roundedRectangle(width, depth, thickness, cornerRadius) {
    cube(size=[width - (cornerRadius* 2), depth, thickness], center = true);    
    cube(size=[width, depth - (cornerRadius* 2), thickness], center = true);    
    for (x = [-1:2:1]) {
        for (y = [-1:2:1]) {
            translate([((width / 2 - cornerRadius) * x), ((depth / 2 - cornerRadius) * y), 0])
              cylinder(h=thickness, r=cornerRadius, center = true);
        }
    }
}

difference() {
    roundedRectangle(length, width, height, 5);
    translate([-60, 0, 2.5]) cube(size=[50, 15, 10], center=true);
    translate([-60, 0, -5]) cube(size=[50, 5, 5], center=true);
    translate([60, 0, 2.5]) cube(size=[50, 15, 10], center=true);
    translate([60, 0, -5]) cube(size=[50, 5, 5], center=true);
    
    for (x = [ -1:1:1]) {
        for (y = [-1:1:1]) {
        translate([ x * (length / 2) * 0.9, y * (width/3), 0]) cylinder(h=height, d=4, center=true);
        }
    }
}