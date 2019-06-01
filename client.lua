local CustomRestriction = {
  run   = function() end,
  stop  = function() end,
}

local greenzones = {
  ["sspd"] = {
    location = {x = 0.0, y = 0.0, z = 0.0},
    diameter = (20 * 3.14159) -- the maximum width of the sphere. this is also the width on ground level. Multiply this by 3.14159 to have a better looking sphere, It's not required to do that however.
    visabilitydistance = 25.0, -- the maximum distance from the circle's shell that the player is able to see. (reccomended distance is 25.0).
    color = {r = 255, g = 255, b = 255, a = 0} -- The color of the zone's sphere (set a to equal 0 to be transparent).
    restrictions = {
      blockattack = true, -- disables any type of attack and weapon usage.
      speedlimit  = nil, -- NOTE: Measurement is in MP/H. Change to a speed if enabled. Else change to nil to disable.
      customrestriction.loop = false,
      customrestriction.run = nil, 
      -- Works with function defined inside variables (look at line one). 
      -- Runs while/when player is inside the zone.
      -- (customrestriction.loop = true => while player is inside.) 
      -- (customrestriction.loop = false => when player goes inside.)
      -- It's recommended that the function has a parameter for passing the zone's table (this key's value)
      -- e.g. run = function(zone) end
      customrestriction.stop = nil, -- Same as above, but runs once when the player leaves the zone. This also stops the loop of the run function if it is running.
    },
  },
}

local Config = {
  
}

function ToggleGreenzone(zone)
end

Citizen.CreateThread(function()
	while true do
    local playerPed = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(playerPed, false)
    for k, v in pairs(greenzones) do
      local location = vector3(v.location.x, v.location.y, v.location.z)
      if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
          -- Enforce Restrictions.
          if (v.blockattack) then
              SetPlayerCanDoDriveBy(player, false)
              DisablePlayerFiring(player, true)
              DisableControlAction(0, 140) -- Melee R
          end
          if (v.speedlimit ~= nil && tonumber(v.speedlimit)) then
            SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), tonumber(v.speedlimit) / 2.237)
          end
          if ()
      elseif (inside_zone)
        -- Remove Restrictions.
        -- The reason why we do inside_zone == true is so that if the first if statement fails,
        -- We can restore the normal functions outside of the zone without looping through this constantly.

        -- Since the natives used to restrict attacks are called per frame, we don't need to put anything here to reset that.

        SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), 99999.9)

        -- NOTE: This doesn't increase the speed of vehicles.
        -- This only removes the cap/speedlimit that was applied while inside the restricted zone.


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
