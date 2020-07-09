/*
 * Copyright 2020 Phil Haigh
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module topHalf() {
    difference() {
    
        union() {
            translate([0, 0, 1 + 4]) cylinder(h=8, d=10.4, center=true, $fn=3);
            cylinder(h=2, d=15, center=true, $fn=90);
        };
        translate([0, 0, -2.5]) cylinder(h=8 + 2 + 8 + 5, d=3.4, center=true, $fn=90);

    };
};


module bottomHalf() {
    difference() {
    
        union() {
            translate([0, 0, -1 -4 ]) cylinder(h=7, d=9.6, center=true, $fn=90);
            translate([0, 0, -1 -7 -7.5])
            difference() {
                cube([6.8, 5.8, 15], center=true);
                translate([0, 0, -2.5]) cube([6.8, 2, 10], center=true);    
            };
            translate([0, 2.9, -1 -7 -10 -2.4]) rotate([-9, 0, 0]) cube([6.8, 1, 5], center=true);
            translate([0, -2.9, -1 -7 -10 -2.4]) rotate([9, 0, 0]) cube([6.8, 1, 5], center=true);        };
        translate([0, 0, -2.5]) cylinder(h=8 + 2 + 8 + 5, d=3.4, center=true, $fn=90);
    };
};

module latch() {
    
    difference() {
        cylinder(h=9.5, d=21.5, center=true, $fn=90);
        cube([6.2, 7.2, 9.5], center=true);
    };
    translate([(26/2) + (6.1/2), 0, -4.75 + (5/2) ]) cube([26, 21.5, 5], center=true);
    translate([(6.1/4), (21.5/2) - 1, 0]) cube([(6.1/2), 2, 9.5], center=true);
    translate([(6.1/4), -(21.5/2) + 1, 0]) cube([(6.1/2), 2, 9.5], center=true);
    translate([14, -(21.5/2) + (9/2), -(9.5/2) -(4.8/2)]) cube([2.75, 9, 4.8], center=true);

};


topHalf();
rotate([0, 180, 0]) bottomHalf();
rotate([90, 0, 0]) latch();
