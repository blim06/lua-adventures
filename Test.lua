--Monitoring an (Integrated Dynamics) energy battery powered by (RFTools) coal generator 
--redstone signal to control generator
--
-- Modules
local component = require("component")
local redstone = require("redstone")
local battery = component.energy_device
local generator = component.redstone
local max = component.energy_device.getMaxEnergyStored() 

--charges battery to 40%
function charge()
	-- if (battery.isEnergyReceiver == false) then
		-- return "not a battery"
	-- end
	local percent = battery.getEnergyStored() / max
	while (percent < 0.4) do
		generator.setOutput(sides.left, 15)
		print("charging: "..percent)
	end	
		
	if (battery.getEnergyStored() / max > 0.4) then
		generator.setOutput(sides.left, 0)
		return "charged 40%"	
	end		
end
