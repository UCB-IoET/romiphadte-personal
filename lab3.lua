require("storm") -- libraries for interfacing with the board and kernel
require("cord") -- scheduler / fiber library
print ("Base  test ")

sh = require "stormsh"
LED = require("led")
Button = require("button")

cport=1525

table={}

function addToTable(from,payload)
	p=storm.mp.unpack(payload)
	for k,v in pairs(p) do
		if table[from]==nil then
			table[from]={}
		end
		if k~= "id" then
			table[from][k]=v
		end
	end
end

function svc_stdout(from_ip, from_port,msg)
	print(string.format("[STDOUT] (ip=%s, port=%d) %s", from_ip, from_port, msg))
end

function pprint(table)
	print(" ")
	for k,v in pairs(table) do
		for i,j in pairs(v) do
			if type(j)=="table" then 
				for a,b in pairs(j) do 
					print(k,i,a,b)
				end
			else
				print(k,i,j)
			end
		end
	end
	print(" ")
end


asock= storm.net.udpsocket(cport,
		function(payload, from, port)
		addToTable(from,payload)
		p=storm.mp.unpack(payload)
		--print(string.format("echo %s %d:%s",from,port,p["id"]))
		print("table is")
		pprint(table)
end)







local svc_manifest = {id="Potato"}
local msg = storm.mp.pack(svc_manifest)
storm.os.invokePeriodically(5*storm.os.SECOND, function()
storm.net.sendto(asock,msg, "ff02::1", 1525)
end)

-- start a shell so you can play more
-- start a coroutine that provides a REPL
sh.start()

-- enter the main event loop. This puts the processor to sleep
-- in between events
cord.enter_loop()
