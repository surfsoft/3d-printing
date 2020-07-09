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

$fn = 90;

bladeDepth = 15;
outerRadius = 7.5;
innerRadius = 6;
bladeTopWidth = 10;
bowHeight = 20;
bowWidth = 30;
bowRadius = 5;
bowDepth = 3;

translate([0, 0, - bladeDepth / 2])
    difference() {
        cylinder(bladeDepth, outerRadius, outerRadius, center = true);
        cylinder(bladeDepth, innerRadius, innerRadius, center = true, $fn=3);
    }

intersection() {
    translate([0, 0, 20]) cube([40, 40, 40], center=true);
    difference() {
        union() {
            translate([0, 0, bladeTopWidth / 2]) cylinder(bladeTopWidth, outerRadius, bowDepth / 2, center = true);
            translate([0, 0, bowHeight - bowRadius]) cube([bowWidth - (bowRadius * 2), bowDepth, bowRadius * 2], center=true);
            translate([(bowWidth / 2) - bowRadius, 0, bowHeight - bowRadius]) rotate([90, 0, 0]) cylinder(bowDepth, bowRadius, bowRadius, center=true);
            translate([-(bowWidth / 2) + bowRadius, 0, bowHeight - bowRadius]) rotate([90, 0, 0]) cylinder(bowDepth, bowRadius, bowRadius, center=true);
            translate([4.2, 0, 9]) rotate([0, 30, 0]) cube([14, bowDepth, 17], center=true);
            translate([-4.2, 0, 9]) rotate([0, -30, 0]) cube([14, bowDepth, 17], center=true);
        };
        translate([0, 0, bowHeight - bowRadius]) rotate([90, 0, 0]) cylinder(bowDepth + 1, bowRadius / 2, bowRadius / 2, center=true);
    };
};
