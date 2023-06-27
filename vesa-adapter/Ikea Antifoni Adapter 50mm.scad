include <VESA Adapter.scad>

$fn=90;

vesaMountSize = 50;
spindleLength = 23.2;
spindleInnerDiameter = 18.6;
spindleScrewHoleDiameter = 3;
spindleScreHoleOffset = 3.25;
armScrewHoleDiameter = 5.5;

vesaAdapter(vesaMountSize, spindleLength, spindleInnerDiameter, spindleScrewHoleDiameter, spindleScreHoleOffset, armScrewHoleDiameter);