ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

----------------------------------------------------------------------------------------------------
local hasEnteredMarker = false
local LastPointName, CurrentAction, CurrentActionMsg
local HasAlreadyEnteredMarker = false
local soundTimer = false
------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job2)
    ESX.PlayerData = ESX.GetPlayerData()
    Citizen.Wait(100)
end)

AddEventHandler('soundPoints:hasEnteredMarker', function(part, pointName)
	for k,v in pairs(Config.Points) do
		if v.name == pointName then
			CurrentAction     = pointName
			CurrentActionMsg  = v.lable
		end
	end
	for k,v in pairs(Config.Zones) do
		if v.name == pointName then
			playZoneSound(pointName)
		end
	end
end)

function playZoneSound(pointName)
	for k,v in pairs(Config.Zones) do
		if v.useTimer then
			if not soundTimer then
				if v.name == pointName then
					print("play sound")
					TriggerServerEvent("soundPoints:Play", v.soundPoint, v.soundFile, v.soundRange, v.SoundVolume, v.name)
					soundTimer = true
					timerPlay()
				end
			end
		else
			if v.name == pointName then
				print("play sound")
				TriggerServerEvent("soundPoints:Play", v.soundPoint, v.soundFile, v.soundRange, v.SoundVolume, v.name)
			end
		end
	end
end

function timerPlay()
	print(soundTimer)
	Citizen.Wait(Config.Timer)
	soundTimer = false
end

AddEventHandler('soundPoints:hasExitedMarker', function(part)
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if true then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentPlace, currentPointName

			for k,v in pairs(Config.Points) do
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.marker.x, v.marker.y, v.marker.z, true)
				if distance < Config.DrawDistance then
					if v.job then
						if v.job == ESX.PlayerData.job.name then
							if Config.EnableText then
								DrawText3Ds(v.marker.x, v.marker.y, v.marker.z + 0.3 , v.lable)
							end
							if Config.EnableMarker then
								DrawMarker(Config.MarkerType, v.marker.x, v.marker.y, v.marker.z-0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							end
							letSleep = false
							if distance < Config.MarkerSize.x then
								isInMarker, currentPlace, currentPointName = true, k, v.name
							end
						end
					else 
						if Config.EnableText then
							DrawText3Ds(v.marker.x, v.marker.y, v.marker.z + 0.3 , v.lable)
						end
						if Config.EnableMarker then
							DrawMarker(Config.MarkerType, v.marker.x, v.marker.y, v.marker.z-0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						end
						letSleep = false
						if distance < Config.MarkerSize.x then
							isInMarker, currentPlace, currentPointName = true, k, v.name
						end
					end	
				end
			end

			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.soundPoint, true)
				if distance < 2 then	
					letSleep = false
					if distance < Config.MarkerSize.x then
						isInMarker, currentPlace, currentPointName = true, k, v.name
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPlace ~= currentPlace or LastPointName ~= currentPointName)) then
				if
					(LastPlace and LastPointName) and
					(LastPlace ~= currentPlace or LastPointName ~= currentPointName)
				then
					TriggerEvent('soundPoints:hasExitedMarker', LastPlace, LastPointName)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastPlace                 = currentPlace
				LastPointName             = currentPointName

				TriggerEvent('soundPoints:hasEnteredMarker', currentPlace, currentPointName)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('soundPoints:hasExitedMarker', LastPlace, LastPointName)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

local SoundName = ""
local volume = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, Config.KeyActivate) then
				for k,v in pairs(Config.Points) do
					if CurrentAction == v.name then
						TriggerServerEvent("soundPoints:Play", v.soundPoint, v.soundFile, v.soundRange, v.SoundVolume, v.name)	
						volume = v.SoundVolume
					end
				end
			elseif IsControlJustReleased(0, Config.KeyStop) then
				for k,v in pairs(Config.Points) do
					if CurrentAction == v.name then
						if SoundName then
							TriggerServerEvent("soundPoints:stopSound", v.name)	
						end
					end
				end
			elseif IsControlJustReleased(0, Config.KeyReduce) then
				for k,v in pairs(Config.Points) do
					if CurrentAction == v.name then
						if SoundName then
							volume = volume + 0.05
							TriggerServerEvent("soundPoints:low", v.name, volume)	
						end
					end
				end
			elseif IsControlJustReleased(0, Config.KeyIncrease) then
				for k,v in pairs(Config.Points) do
					if CurrentAction == v.name then
						if SoundName then
							volume = volume - 0.05
							TriggerServerEvent("soundPoints:high", v.name, volume)	
						end
					end
				end
			end
		end 
	end
end)

RegisterNetEvent("soundPoints:playSound")
AddEventHandler("soundPoints:playSound", function(pos, soundFile, soundRange, SoundVolume, name)
	xSound = exports.xsound
	xSound:PlayUrlPos(name,soundFile, SoundVolume, pos, true)
	xSound:Distance(name,soundRange)
	SoundName = name
end)

RegisterNetEvent("soundPoints:stopSound")
AddEventHandler("soundPoints:stopSound", function(name)
	xSound:Destroy(name)
end)

RegisterNetEvent("soundPoints:low")
AddEventHandler("soundPoints:low", function(name, volume)
	xSound:setVolume(name, volume)
end)

RegisterNetEvent("soundPoints:high")
AddEventHandler("soundPoints:high", function(name, volume)
	xSound:setVolume(name, volume)
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end