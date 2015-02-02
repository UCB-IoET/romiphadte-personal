require("storm") -- libraries for interfacing with the board and kernel
require("cord") -- scheduler / fiber library
shield = require("starter") -- interfaces for resources on starter shield
print ("blink test ")

number=0

function increment()
   number=number+1
   if number>15 then
      number=0
   end
   assign_led()
end

function decrement()
   number=number-1
   if number<0 then
      number=15
   end
   assign_led()
end

function reset()
   number=0
   assign_led()
end

function assign_led()
   if number%2==1 then
      shield.LED.on("blue")
   else
      shield.LED.off("blue")
   end
   
   if (number/2)%2==1 then 
      shield.LED.on("green")
   else
      shield.LED.off("green")
   end

   if (number/4)%2==1 then 
       shield.LED.on("red")
   else
      shield.LED.off("red")
   end

   if (number/8)%2==1 then 
       shield.LED.on("red2")
   else
      shield.LED.off("red2")
   end
end


shield.LED.start()		-- enable LEDs
shield.Button.start()
shield.Button.whenever(2, "RISING", increment)
shield.Button.whenever(1, "RISING", decrement)
shield.Button.whenever(3, "RISING", reset)

cord.enter_loop() -- start event/sleep loop

