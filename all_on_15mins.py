#!/usr/bin/ python2.7

import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
from time import sleep # Import the sleep function from the time module
GPIO.setwarnings(False) # Ignore warning for now

GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
GPIO.setup(37, GPIO.OUT) # HOSE PIPE
GPIO.setup(35, GPIO.OUT) # SPRINKLERS

# switch on full system for 15 mins
GPIO.output(37, GPIO.LOW)
GPIO.output(35, GPIO.LOW)
sleep(300)
GPIO.output(37, GPIO.HIGH)
GPIO.output(35, GPIO.HIGH)

