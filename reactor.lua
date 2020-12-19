
--TODO:**implement mekanism induction matrix**
local component = require("component")
local reactor = component.nc_fission_reactor
local maxEnergy, maxHeat = 0.8, 0.8 --max energy and heat capacity at 80% 

local energyLevel = reactor.getEnergyStored() / reactor.getMaxEnergyStored()     --energy % in decimal
local heatLevel = reactor.getHeatLevel() / reactor.getMaxHeatLevel()            --heat % in decimal
local engyPellet = reactor.getFuelPower() * 20 * reactor.getFuelTime()          --RF per fuel 
local meltTime = reactor.getMaxHeatLevel() / (reactor.getReactorProcessHeat() * 20)  --time for reactor to meltdown

local function init() 
--checks if reactor structure is valid, prints out reactor params
    if reactor.isComplete() then
        reactor.forceUpdate()
    else
        return reactor.getProblem()
    end

print("-----------------------------------------------------------------------------------------------")
print("Fuel name: ", reactor.getFissionFuelName(), "Efficiency: ", reactor.getEfficiency(), "%, Energy/pellet: ", engyPellet, "RF") 
print("Heat Level: ", reactor.getHeatLevel(), "HU, Energy Level: ", reactor.getEnergyLevel(), "RF, Meltdown Time: ", meltdownTime())
print("-----------------------------------------------------------------------------------------------")

end

local function meltdownTime() 
    if reactor.getReactorProcessHeat() > 0 then
        return meltTime.." seconds"
    else 
        return "Safe"
    end
end

local function reactorStatus() 
    if reactor.isProcessing() then
        return "Running"
    else 
        return "Off"
end

local function main() 
    if (reactor.isProcessing() == false) and ((energyLevel < maxEnergy) or (heatLevel < maxHeat)) then
        reactor.activate()
    else (reactor.isProcessing()) and ((energyLevel >= maxEnergy) or (heatLevel >= maxHeat)) then
        reactor.deactivate()
    end
    print("Status: ", reactorStatus()", Output: ", reactor.getReactorProcessPower(), "RF, Heat diff: ", reactor.getProcessHeat(), "Heat/t, Energy: ", energyLevel*100, "%, Heat: ", heatLevel*100,"%")
    print("*********************************************************************************************")
    main()
end

init()
main()
