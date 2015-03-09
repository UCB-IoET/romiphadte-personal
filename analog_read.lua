require("storm") -- libraries for interfacing with the board and kernel
require("cord") -- scheduler / fiber library

----------------------------------------------
-- LED class
--   basic LED functions associated with a shield pin
--   assume cord.enter_loop() is active, as per stormsh
----------------------------------------------

pin="D2"

--storm.io.set_mode(storm.io.OUTPUT,storm.io[pin])

print ("initializing adc")
storm.n.adcife_init()

while true do
	--lua_call()
	--storm.io.set(0,storm.io[pin])
	--storm.io.set(1,storm.io[pin])
    print(storm.n.adcife_sample_an0())
end

cord.enter_loop()
