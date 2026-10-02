local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('radio:getPlayerChannel', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT channel_id FROM player_radio WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier
        }, function(channel)
            cb(channel or Config.DefaultChannel)
        end)
    else
        cb(Config.DefaultChannel)
    end
end)

RegisterNetEvent('radio:sendMessage')
AddEventHandler('radio:sendMessage', function(channel, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local players = ESX.GetPlayers()
        for _, playerId in ipairs(players) do
            local xTarget = ESX.GetPlayerFromId(playerId)
            if xTarget then
                MySQL.Async.fetchScalar('SELECT channel_id FROM player_radio WHERE player_id = @player_id', {
                    ['@player_id'] = xTarget.identifier
                }, function(targetChannel)
                    if targetChannel == channel then
                        TriggerClientEvent('chat:addMessage', playerId, {
                            args = { 'Radio [' .. channel .. ']', message }
                        })
                    end
                end)
            end
        end
    end
end)