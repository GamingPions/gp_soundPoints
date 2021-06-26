ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("soundPoints:Play")
AddEventHandler("soundPoints:Play", function (pos, soundFile, soundRange, SoundVolume, name)
    _source  = source
	xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("soundPoints:playSound", xPlayers[i], pos, soundFile, soundRange, SoundVolume, name)
    end
end)

RegisterNetEvent("soundPoints:stopSound")
AddEventHandler("soundPoints:stopSound", function (name)
    _source  = source
	xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
        TriggerClientEvent("soundPoints:stopSound", xPlayers[i], name)
    end
end)

RegisterNetEvent("soundPoints:low")
AddEventHandler("soundPoints:low", function(name, volume)
    _source  = source
	xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
        TriggerClientEvent("soundPoints:low", xPlayers[i], name, volume)
    end
end)

RegisterNetEvent("soundPoints:high")
AddEventHandler("soundPoints:high", function(name, volume)
    _source  = source
	xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
        TriggerClientEvent("soundPoints:low", xPlayers[i], name, volume)
    end
end)