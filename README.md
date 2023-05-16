
# EcoBin: Transforming the Way We Dispose

 In this modern day world, the current day-to-day waste disposal systems heavily rely on manual operation, requiring individuals to physically open the trash bin lid, whether using their hands or their feet. This process not only consumes time, but also creates inconvenience and gives a suboptimal user experience, leading to discomfort and dissatisfaction. The manual operation required to open the bin lid can be cumbersome and unhygienic. Moreover, individuals may hesitate to dispose of waste properly if they perceive the process as inconvenient or unpleasant. Therefore, there is a need for a more comfortable and user-friendly waste disposal system.
 
 
 The Eco Bin is an innovative and environmentally friendly automated trash bin system. It is powered by a HC-SR04 distance sensor and an Arduino microcontroller, enabling automation and enhances the user experience. 
 
 When a person approaches the bin, the distance sensor will detect their presence and send a signal to the Arduino. The Arduino will then activate a servo motor, automatically opening the bin lid. This automation eliminates the need for manual operation, significantly improving the efficiency and convenience of waste disposal. In addition to the automated operation, the Eco Bin will include a manual button for opening the bin lid, providing users with flexibility and efficiency in disposing trash.

# Hardware and Tools Requirements
* Arduino microcontroller
* HC-SR04 distance sensor
* Servo motor
* LED indicator
* Trash bin
* Jumper wires
* Power source

# Hardware Design and Implementation
During the hardware design process, we created the design using Proteus. Within Proteus, we utilized libraries from the internet for Arduino and the ultrasonic sensor. Before implementing the code, we converted the .S file to .hex and then imported the .hex file. In Proteus, we simulated the distance for the ultrasonic sensor by replacing it with a test pin connected to a variable potentiometer to modify the distance.

# Software Implementation 
During the software development and implementation phase, we utilized the Arduino application for programming and uploading code to the Arduino Uno microcontroller used in our Ecobin project. To work with assembly code, the Arduino application can be installed by following the link provided: https://www.arduino.cc/en/software.

The code incorporates several subroutines to control the HC-SR04 ultrasonic sensor, SG90 servo motor, button, and delay functionalities. At the beginning of the code, we define the SFR offset and import the "avr/io.h" file, which contains the AVR microcontroller register declarations. The main function serves as the program's primary function that is executed repeatedly. Within the main function, there are calls to the HC_SR04_sensor function and RJMP to return to the main. The HC_SR04_sensor function performs measurements using the HC-SR04 sensor. It contains instructions to set up the I/O pins of the microcontroller for connecting with the HC-SR04 sensor. After the pin configuration is completed, a high pulse signal is sent to the HC-SR04 sensor for a duration of 10 microseconds. Subsequently, the echo_PW function is called to calculate the pulse width received from the HC-SR04 sensor. Once the pulse width is obtained, data conversion and display are performed using the byte2decimal function. Finally, a delay of a few milliseconds is introduced using the delay_ms function.

Furthermore, there are additional subroutines such as a subroutine for timer-based delay and a subroutine for delay in milliseconds. These components of the code aim to control the HC-SR04 sensor and interact with the LED and servo based on the distance measurements obtained from the sensor.

# Test Results and Performance Evaluation
After testing, the program is able to perform distance measurement well. The program will react if it detects an object within a distance of less than 15cm by providing visual indicators through LED lights and opening the trash can lid using a servo. In the product process...

# Conclusion and Future Work
placeholder

# Creators
* Aldrian Raffi Wicaksono	
* Daffa Anis Fahrizi 
* Rakha Argya Zahran
* M. Farrel Athaillah N.
