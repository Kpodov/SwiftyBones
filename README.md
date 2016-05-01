![SwiftyBones](https://github.com/hoffmanjon/SwiftyBones/raw/master/images/logo.png)

A Swift library for accessing the GPIO and Analog pins on the BeagleBone Black.

The idea for SwiftyBones came from the very good <a href="https://github.com/uraimo/SwiftyGPIO">SwiftyGPIO library.</a>  While the SwiftyGPIO library is a very good library for accessing the GPIO pins on the BeagleBone Black (and other boards like the Raspberry PI and C.H.I.P) it currently does not have the ability to access the analog or PWM pins which I need for a number of my projects.  My first thought was to add this functionality to the SwiftyGPIO library however I wanted to focus on the BeagleBone Black which I use for my projects.
 I also wanted to take a more protocol-oriented approach with value types as I described in my book <a href= http://amzn.to/21osHFc>Protocol-Oriented Programming with Swift.</a>