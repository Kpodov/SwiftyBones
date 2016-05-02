![SwiftyBones](https://github.com/hoffmanjon/SwiftyBones/raw/master/images/logo.png)

A Swift library for interacting with the GPIO and Analog pins on the BeagleBone Black.


## Summary

The idea for SwiftyBones came from the very good <a href="https://github.com/uraimo/SwiftyGPIO">SwiftyGPIO library.</a>  While the SwiftyGPIO library is a very good library for accessing the GPIO pins on the BeagleBone Black (and other boards like the Raspberry PI and C.H.I.P) it currently does not have the ability to access the analog or PWM pins which I need for a number of my projects.  My first thought was to add this functionality to the SwiftyGPIO library however I wanted to focus on the BeagleBone Black which I use for my projects.
 I also wanted to take a more protocol-oriented approach with value types as I described in my book <a href= http://amzn.to/21osHFc>Protocol-Oriented Programming with Swift</a> therefore I decided to write the SwiftyBones library.

SwiftyBones currently supports interacting with the digital GPIO and analog (AIN0 - AIN6) pins.  I have begun work to add support for the PWM pins and will hopefully have this support in soon.

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

Once the archive is unzipped you should see the following four directorie:
-  Source:  The SwiftyBones source files
-  swiftybuild:  The swiftybuild script to help you compile your Swift projects
-  Examples:  Example projects to help you get started with SwiftyBones
-  Images:  Images needed for this README like the SwiftyBones logo

Lets take a look at what is each of these directories starting with the Source directory.

##Source Directory

The Source directory contains the Swift source files that make up the SwiftyBones library.  Currently there are three files which are:
-  SwiftyBonesCommon.swift:  This file contains common code which is required for interacting with both analog and digital GPIOs.
-  SwiftyBonesDigitalGPIO.swift:  This file contains the necessary types for interacting with the digital GPIO pins on the Beaglebone Black. 
-  SwiftyBonesAnalog.swift:  This file contains the necessary types for interacting with the Analog In pins on the Beaglebone Black.


To use SwiftyBones in your project you will need to include the SwiftyBonesCommon.swift file in the project.  You will also need to include the file that corresponds to the pins you need.  If your project uses digital GPIO then you will also need to include the SwiftyBonesDigitalGPIO.swift file.  If your project uses analog in (AIN) then you will need to include the SwiftyBonesAnalog.swift file.  If your project uses both digital GPIO and analog in, you will want to include both of the files.

##swiftybuild Directory

The swiftybuild directory contains a single script file named swiftybuild.sh.  Since SwiftyBones is built in a modular way with multiple files, I realized that it would very quickly become annoying compiling my code like this:

```
swiftc -o myexec main.swift tempSensor.swift SwiftyBones/SwiftyBonesCommon.swift SwiftyBones/SwiftyBonesDigitalGPIO.swift
```
therefore I wrote a script that would search the current directory and all subdirectories for all files that have the .swift extension and then build a swift compiler command that would contain all of the files it found.  The script does take a single optional command line argument that would be the name of the executable file if everything successfully compiled.  You would use this script like this:
```
./swiftybuild.sh  
or
./swiftybuild.sh myexec
```

The output from the first command would be an executable file named myexec if everything compiled successfully.  The second command would generate an executable named myexec if everything compiled successfully.

##Examples Directory

The example directory contain three sample projects which are:
-  BlinkingLED:  A project that shows how to use SwiftyBonesDigitalGPIO.swift to blink an LED
-  MotionSensor:  A project that shows how to use SwiftyBonesDigitalGPIO.swift and the HC-SR502 sensor to create a motion detector
-  Temperature:  A project that shows how to use SwiftyBonesAnalog.swift and the tmp36 sensor to get the current temperature

Each of these projects contain a Fritzing diagram that shows how to connect the LED or Sensor to the BeagleBone Black and also an image that was exported from Fritzing. To compile the examples simply run swiftybuild.sh in the example's directory. 
Lets look at each of these projects and see how they function.

###BlinkingLED

Lets begin by looking at the Fritzing diagram for this project. 
![LEDDiagram](https://github.com/hoffmanjon/SwiftyBones/raw/master/examples/BlinkingLed/diagrams/led_only.png)


Work-in-progress will have the readme finished shortly
 
 