import spidev
import time
import os
import RPi.GPIO as GPIO
import socket

host = '192.168.0.15'
port = 3330
recv_port= 3331
s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
recv_s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
recv_s.bind(("",recv_port))

spi = spidev.SpiDev()
spi.open(0,0)
delay=1

ledRed=5
ledGreen=6
ledBlue = 13
channel = 0
switch = 24
pressure_sum = 0


count=10
avg = 0
amount = 1

def ReadChannel(channel) :
	adc = spi.xfer2([1,(8+channel)<<4,0])
	data = ((adc[1]&3)<<8) + adc[2]
	return data

def led(red,green,blue) :
	GPIO.output(ledRed,red)
	GPIO.output(ledGreen,green)
	GPIO.output(ledBlue,blue)


GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(ledRed,GPIO.OUT)
GPIO.setup(ledGreen,GPIO.OUT)
GPIO.setup(ledBlue,GPIO.OUT)
GPIO.setup(switch, GPIO.IN)

led(0,0,0)
ADDR = (host,port)


while True  :
   
  
   input_value = GPIO.input(switch)
  
   print('switch')
   print(input_value)
 
   if input_value == 1 :

        pressure = ReadChannel(channel)
	print('pressure')
	print(pressure)

	if count > 0 and pressure > 2  :
	   led(1,1,1)
	   if amount ==  1  :
 		avg = pressure 
		pressure_sum = pressure

	   else  : 
		pressure_sum = pressure + pressure_sum
		avg = pressure_sum / amount
	   amount = amount + 1		 
           count = count - 1

      	   print('amount')
	   print(amount-1)

	print('avg')
	print(avg)
	
	if count ==  0 :    
          
       	   if  pressure < 10  :
    		led(0,1,0)
		s.sendto("001/1",ADDR)
  	   elif  pressure>=10 and  pressure < avg/2  :
		led(0,0,1)
		s.sendto("001/2",ADDR)
	   elif pressure >= avg/2  :
		led(1,0,0)
		s.sendto("001/3",ADDR)
	

              
   	   bufsize=512
	   
	   data, address = recv_s.recvfrom(bufsize)
	   print(data)
	   
	   if data  == 'error' :
		led(1,0,1)
		
	   

	print('-----------------------------------------')
	time.sleep(delay)
 
s.close()      
