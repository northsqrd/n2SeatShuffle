local isShuffleDisabled = true

CreateThread(function()
    while true do
        Wait(250)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if veh ~= 0 then
            if isShuffleDisabled and GetPedInVehicleSeat(veh, 0) == ped and GetIsTaskActive(ped, 165) then
                ClearPedTasksImmediately(ped)
                SetPedConfigFlag(ped, 184, true)
                SetPedIntoVehicle(ped, veh, 0)
            end
        end
    end
end)

local function HandleShuffleCommand()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= 0 then
        if GetPedInVehicleSeat(veh, -1) == ped and IsVehicleSeatFree(veh, 0) then
            TaskShuffleToNextVehicleSeat(ped, veh)
        elseif isShuffleDisabled then
            SetTimeout(2000, function()
                isShuffleDisabled = true
            end)
            isShuffleDisabled = false
            SetPedConfigFlag(ped, 184, false)
        end
    end
end

TriggerEvent('chat:addSuggestion', '/shuff', 'Shuffles to the driver seat if you are the passenger or to the passenger seat if you are the driver.')
TriggerEvent('chat:addSuggestion', '/shuffle', 'Shuffles to the driver seat if you are the passenger or to the passenger seat if you are the driver.')
RegisterCommand("shuff", HandleShuffleCommand)
RegisterCommand("shuffle", HandleShuffleCommand)
