--add coodinates to a item transfer node with me export bus 
--TODO:**implement mekanism induction matrix**
local component = require("component")
local reactor = component.nc_fission_reactor

local maxEnergy, maxHeat = 0.8, 0.5 --max energy and heat capacity at 80%           
local engyPellet = reactor.getFissionFuelPower() * 20 * reactor.getFissionFuelTime()          --RF per fuel 
local meltTime = reactor.getMaxHeatLevel() / (reactor.getReactorProcessHeat() * 20)  --time for reactor to meltdown (only works if heat diff>0)

local function meltdownTime() 
    if reactor.getReactorProcessHeat() > 0 then
        return meltTime.." seconds"
    else 
        return "Safe"
    end
end

--energy % in decimal
local function energyLevel() 
    return reactor.getEnergyStored() / reactor.getMaxEnergyStored()
end

--heat % in decimal
local function heatLevel()
    return reactor.getHeatLevel() / reactor.getMaxHeatLevel()
end

local function reactorStatus() 
    if reactor.isProcessing() then
        return "Running"
    elseif not reactor.isProcessing() then 
        return "Off"
	elseif reactor.getFissionFuelName() == "No Fuel" then
	    return reactor.getFissionFuelName()
	else
	    return reactor.getProblem()
    end
end

local function fuelTime() 
    return reactor.getFissionFuelTime() - reactor.getReactorProcessTime()
end

--checks if reactor structure is valid, prints out reactor params
local function init() 
    if reactor.isComplete() then
        reactor.forceUpdate()
    else
        return reactor.getProblem()
    end
	
print("----------------------------------------------------------------------------------------------------------------------------------")
print("Fuel name: "..reactor.getFissionFuelName(), "Efficiency: "..reactor.getEfficiency().." %","Energy/pellet: "..engyPellet.." RF", "Meltdown Time: "..meltdownTime().." seconds") 
print("----------------------------------------------------------------------------------------------------------------------------------")

end

local function main() 
    if (reactor.isProcessing() == false) and ((energyLevel() < maxEnergy) or (heatLevel() < maxHeat)) then
        reactor.activate()
    elseif (reactor.isProcessing()) and ((energyLevel() >= maxEnergy) or (heatLevel() >= maxHeat)) then
        reactor.deactivate()
    end
    print("Status: "..reactorStatus(),"Output: "..reactor.getReactorProcessPower().."RF","Heat diff: "..reactor.getReactorProcessHeat().."Heat/t", "Heat: "..math.floor(heatLevel()*100).."%", "Energy: "..math.floor(energyLevel()*100).."%", "Fuel duration: "..fuelTime().." seconds")
    print("***********************************************************************************************************************************")
    main()
end

init()
main()
