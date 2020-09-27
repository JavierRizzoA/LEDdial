# LEDdial

A clock whose hands are "shadows" projected by LEDs.

## Hardware Requirements

* [WS2812B LED strip](https://www.amazon.com/gp/product/B00JYPJAL2/)
* An Arduino or compatible board
* Breadboard
* Soldering iron
* Solid wires
* 3D printer
* Super glue

## Software Requirements

* OpenSCAD
* Arduino IDE

## Building Instructions

1. 3D print the LEDdial, and gnomon modules from LEDdial.scad. These can
   be printed without supports, however there are a lot of 45º angles in the
   LEDdial module, so it may require a finely tuned 3D printer. The gnomon can
   be any color, but I recommend to use a light color, preferably white, for the
   LEDdial, as it will improve visibility for the "shadows". The LEDdial STL is
   pretty big, so you might have to print it on a 45º angle and without a skirt.
2. Cut a piece of filament of about 8mm.
2. Glue the piece of filament to the hole on the center of the LEDdial.
3. Glue the gnomon to the other end of the stick.
4. Cut 3 segments of 24 LEDs from the LED strip and solder wires into their
   inputs.
5. Attach each of the strips into the 3 strip guides inside LEDdial. The first
   LED from the side without cables should be aligned with 9 o'clock and the
   rest of the LEDs should follow counter-clockwise.
6. Insert the strip cables into the small windows on the side of the clock and
   pull them to the back of the clock.
7. Connect all the 5v cables into the VIN/RAW pin in the Arduino.
8. Connect all the -/GND cables into the GND pin in the Arduino.
9. Connect the strips, from top to bottom, into the digital 4, 3, and 2 pins in
   the Arduino.
10. Connect a wire between the digital 5 pin and GND in the Arduino.
11. Flash the LEDdial.ino file into the Arduino board.
12. To adjust the time in the clock, disconnect the cable that is between
    digital 5 and GND. This will make the clock go faster.

## License

### The MIT License

Copyright (c) 2020 Javier Rizzo Aguirre.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
