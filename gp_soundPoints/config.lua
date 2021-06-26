Config = {}

Config.DrawDistance               = 2 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = 27
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnableMarker = true
Config.EnableText = true

Config.KeyActivate = 38 
Config.KeyStop = 45
Config.KeyIncrease = 173
Config.KeyReduce = 172

Config.UseTimer = true
Config.Timer = 30000 -- default 5s (5000)

Config.Points = {
	{name = "mri", job = nil, lable = "\n[E] Activate - [R] Stop\n[PH] - Increase [PR] - Reduce", marker = {x=341.72, y=-576.79, z=43.28}, soundPoint = vector3(337.54,-574.29,44.24), soundFile ="https://youtu.be/d_RX_ImbFRg", soundRange = 10.0, SoundVolume = 0.05},
	{name = "x-ray", job = nil, lable = "\n[E] Activate - [R] Stop\n[PH] - Increase [PR] - Reduce", marker = {x=344.49, y=-577.8, z=43.27}, soundPoint = vector3(348.49,-579.98,43.19), soundFile ="https://youtu.be/QpXGQvQWHS0", soundRange = 10.0, SoundVolume = 0.05},
	{name = "acls", job = nil, lable = "\n[E] Activate - [R] Stop\n[PH] - Increase [PR] - Reduce", marker = {x=950.29, y=-970.09, z=39.51}, soundPoint = vector3(936.81,-969.36,44.54), soundFile ="https://www.youtube.com/watch?v=sBJirp3AuTs", soundRange =40.0, SoundVolume = 0.1}
}

Config.Zones = {
	{useTimer = true, name = "zone1", soundPoint = vector3(941.92,-988.65,38.79), soundFile ="https://youtu.be/d_RX_ImbFRg", soundRange = 10.0, SoundVolume = 0.05},
	{useTimer = false, name = "zone2", soundPoint = vector3(942.64,-974.19,39.5), soundFile ="https://youtu.be/d_RX_ImbFRg", soundRange = 10.0, SoundVolume = 0.05}
}

-- You can upload your sounds to youtube as unlisted, i think private wont work!
-- If job = nil, everyone can see the marker and trigger the sound point

--[[ ZONES IMPORTANT! READ!

If you enter the zone, the sound will start playing. If you leave the zone and go back in, the sound will restart!
If you don`t want that, i made a timer function. You can set up, how long it will take, until the sound can be restartet by entering the zone again.

You like to use the timer? set useTimer = true in the Config.Zones zone. So you can have zones which uses the timer and also zones that dont use them.
]]