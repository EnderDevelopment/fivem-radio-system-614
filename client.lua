local ESX = nil
local currentChannel = Config.DefaultChannel

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    -- Load player radio channel
    ESX.TriggerServerCallback('radio:getPlayerChannel', function(channel)
        if channel then
            currentChannel = channel
        end
    end)
end)

RegisterNetEvent('radio:updateChannel')
AddEventHandler('radio:updateChannel', function(channel)
    currentChannel = channel
end)

function sendRadioMessage(message)
    TriggerServerEvent('radio:sendMessage', currentChannel, message)
end

-- Example usage
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 249) then -- N key
            local message = GetPlayerInput()
            if message then
                sendRadioMessage(message)
            end
        end
    end
end)

function GetPlayerInput()
    AddTextEntry('FMMC_KEY_TIP8', 'Enter message')
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP8', '', '', '', '', '', 128)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() == 2 then
        return nil
    end
    return GetOnscreenKeyboardResult()
end