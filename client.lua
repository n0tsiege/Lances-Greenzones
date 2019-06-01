local CustomRestriction = function()
end

local greenzones = {
  ["sspd"] = {
    location = {x = 0.0, y = 0.0, z = 0.0},
    diameter = (20 * 3.14159) -- the maximum width of the sphere. this is also the width on ground level. Multiply this by 3.14159 to have a better looking sphere, It's not required to do that however.
    visabilitydistance = 25.0, -- the maximum distance from the circle's shell that the player is able to see. (reccomended distance is 25.0).
    color = {r = 255, g = 255, b = 255, a = 0} -- The color of the zone's sphere (set a to equal 0 to be transparent).
    restrictions = {
      allowattack = false, -- disables any type of attack and weapon usage.
      speedlimit  = nil, -- change to a number if enabled. else change to nil to disable.
      customrestriction = nil, -- change to a local function var name (example at the top of this script) if other restrictions need to be ran for frameworks (e.g. ESX).
    },
  },
}

function ToggleGreenzone(zone)
end

Citizen.CreateThread(function()
	while true do
			local playerPed = GetPlayerPed(-1)
			local plyCoords = GetEntityCoords(playerPed, false)
			local location = vector3(table.location.x, table.location.y, table.location.z)

			if #(plyCoords - location) < (table.diameter) - (table.diameter / 150) then
				if #(plyCoords - location) < (table.diameter) - (table.diameter / 150) - 1.5 then
          -- Inside Zone
				end
			else
        -- Exit Zone Function.
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
    local playerPed = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(playerPed, false)
    for k, v in pairs(greenzones) do
      local location = vector3(v.location.x, v.location.y, v.location.z)
      if (#(plyCoords - location) > (v.diameter) - (v.diameter / 150) - v.visabilitydistance) then
        DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 0)
      end
    end
    Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent("aop:UpdateClientAOP")
	return
end)

RegisterNetEvent("aop:InitializeAOP")
AddEventHandler("aop:InitializeAOP", function(zone)
  ToggleGreenzone(zone)
end)
