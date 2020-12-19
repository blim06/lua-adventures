--(Integrated Dynamics) energy battery & (RFTools) coal generator 
--redstone signal from left face of the computer to the generator
--
-- Modules
local component = require("component")
local redstone = require("redstone")
local battery = component.energy_device
local generator = component.redstone
local max = component.energy_device.getMaxEnergyStored() 

--charges battery %
local percent = battery.getEnergyStored() / max 

if (battery.isReceiver == false) then
return "not a battery"
end
if (percent < 1) do
generator.setOutput(sides.left, 15)
print("charging: "..math.floor(percent*100))
end

if (percent = 1) then
generator.setOutput(sides.left, 0)
return "*********finished charging*********"
end
