![SwiftyBones](https://github.com/hoffmanjon/SwiftyBones/raw/master/images/logo.png)

A Swift library for accessing the GPIO and Analog pins on the BeagleBone Black.


## Summary

The idea for SwiftyBones came from the very good <a href="https://github.com/uraimo/SwiftyGPIO">SwiftyGPIO library.</a>  While the SwiftyGPIO library is a very good library for accessing the GPIO pins on the BeagleBone Black (and other boards like the Raspberry PI and C.H.I.P) it currently does not have the ability to access the analog or PWM pins which I need for a number of my projects.  My first thought was to add this functionality to the SwiftyGPIO library however I wanted to focus on the BeagleBone Black which I use for my projects.
 I also wanted to take a more protocol-oriented approach with value types as I described in my book <a href= http://amzn.to/21osHFc>Protocol-Oriented Programming with Swift</a> therefore I decided to write the SwiftyBones library.

SwiftyBones currently supports interacting with the digital GPIO and analog (AIN0  AIN6) pins.  I have begun work to add support for the PWM pins and will hopefully have this support in soon.

## Installation

To use this library you will need the Debian 8.3 image (kernel 4.1+) and Swift 2.2.  To install Swift you can following the instructions on the <a href= http://dev.iachieved.it/iachievedit/debian-packages-for-swift-on-arm/>iachieved.it</a> site.

The Package Manager is not available on ARM therefore you will need to download the zip archive for SwiftyBones with the following command:  
```
wget https://github.com/hoffmanjon/SwiftyBones/archive/master.zip
```

Once the archive is downloaded, you can unzip it using the following command:

```
unzip master.zip
```


Work-in-progress will have the readme finished shortly
 
 