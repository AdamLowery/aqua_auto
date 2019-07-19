
import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
from time import sleep # Import the sleep function from the time module
GPIO.setwarnings(False) # Ignore warning for now

RED_BUTTON = 38
BLUE_BUTTON = 40

GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
GPIO.setup(RED_BUTTON, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 8 to be an input initial value to low (off)
GPIO.setup(BLUE_BUTTON, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(37, GPIO.OUT) # HOSE PIPE
GPIO.setup(35, GPIO.OUT) # SPRINKLERS

#while GPIO.input(38, GPIO.HIGH):
# GPIO.output(37, GPIO.HIGH) # Turn on
while True:
    if (GPIO.input(RED_BUTTON) == False):
        print("RED Button Pressed")
        GPIO.output(37, GPIO.LOW)
        sleep(300)
        GPIO.output(37, GPIO.HIGH)


    if (GPIO.input(BLUE_BUTTON) == False):
        print("BLUE Button pressed")
        GPIO.output(35, GPIO.LOW)
        sleep(300)
        GPIO.output(35, GPIO.HIGH)

