-- External Requirement Data *REQUIRED*
require("functions")
require("data")

-- Version
version = "2.0.0"

-- YimMenu Default Tabs
playerOptions = gui.get_tab("")
settingsOptions = gui.get_tab("GUI_TAB_SETTINGS")
worldOptions = gui.get_tab("GUI_TAB_WORLD")

-- New tab creation system
mainTab = createTab("Extras Addon")
insTab = mainTab:add_tab("Instructions")

getPlayerName = PLAYER.GET_PLAYER_NAME(network.get_selected_player())
-- Buttons/Checkboxes/Radio Buttons/Text/Etc.
mainInfo(mainTab)

applyCheckboxStyle(1.0, 0.0, 0.0, 0.5, 7.0, playerOptions)

vehRam = function() 
	local player_id = network.get_selected_player()
	
	if player_id == -1 then
		player_id = PLAYER.PLAYER_ID()
	end
	
	local playerPed = PLAYER.GET_PLAYER_PED(player_id)
	
	local coords = ENTITY.GET_ENTITY_COORDS(playerPed, true)
	local randomModel = vehicleModels[math.random(1, #vehicleModels)]
	local modelHash = MISC.GET_HASH_KEY(randomModel)

	if VEHICLE.IS_THIS_MODEL_A_CAR(modelHash) then
		local spawnRadius = 10.0
		local spawnX = coords.x + math.random(-spawnRadius, spawnRadius)
		local spawnY = coords.y + math.random(-spawnRadius, spawnRadius)

		local vehicle = VEHICLE.CREATE_VEHICLE(modelHash, spawnX, spawnY, coords.z, 0.0, true, false)
		if vehicle ~= 0 then
			local vehCoords = ENTITY.GET_ENTITY_COORDS(vehicle, true)
			local directionX = coords.x - vehCoords.x
			local directionY = coords.y - vehCoords.y
			local directionZ = coords.z - vehCoords.z
			directionX = directionX * returnVal
			directionY = directionY * returnVal
			ped = PED.CREATE_PED_INSIDE_VEHICLE(vehicle, 0, ENTITY.GET_ENTITY_MODEL(playerPed), -1, true, false)
			PED.CLONE_PED_TO_TARGET(playerPed, ped)
			ENTITY.SET_ENTITY_VELOCITY(vehicle, directionX, directionY, directionZ)
			VEHICLE.SET_DISABLE_MAP_COLLISION(vehicle)
			ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(vehicle)
			ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
			gui.show_message("Vehicle Ram", "Ramming " .. PLAYER.GET_PLAYER_NAME(player_id) .. " with upgraded vehicles.  Ram Velocity: " ..returnVal)
		end
	end
end
	
	
textSeparator(playerOptions, "Extras Addon - Toxic")

ramToolTip = "Rams the player with random vehicles"
sliderToolTip = "Velocity: (When enabled) sets the velocity from 1-10"
returnVal = createCheckbox("vehicleRam", playerOptions, "Vehicle Ram", ramToolTip, vehRam, -1, true, "Ram Velocity", 1, 10, sliderToolTip)
resetCheckboxStyle(playerOptions)

applyCheckboxStyle(1.0, 0.0, 0.0, 0.5, 7.0, playerOptions)
npcDrive = function()
	for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
		ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
			if ped ~= 0 and not PED.IS_PED_A_PLAYER(ped) then
				if not PED.IS_PED_DEAD_OR_DYING(ped) then
					request_control(veh, 300) 
					request_control(ped, 300)
					TASK.CLEAR_PRIMARY_VEHICLE_TASK(veh)
					target = PLAYER.GET_PLAYER_PED(network.get_selected_player())
					pos = ENTITY.GET_ENTITY_COORDS(target, true)
					if calcDistance(target, veh) > 1 then
						TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped, veh, pos.x, pos.y, pos.z, returnVal, 1, ENTITY.GET_ENTITY_MODEL(veh), 16777728, 0.0, 10)
						VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, returnVal)
						if not VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(veh)) then
							VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(veh, 5.0)
						end
					end
					gui.show_message("NPC Drive", "NPC's are driving to "..getPlayerName.." at "..returnVal * 2 .." mph")
				end
			end
	end		
end

npcDriveTip = "Makes NPC vehicles drive towards the target player"
npcSliderTip = "Speed: (When Enabled) Sets how fast the NPC's drive towards the target x2"
returnVal = createCheckbox("npcDrive", playerOptions, "NPC Drive", npcDriveTip, npcDrive, -1, true, "NPC Speed", 1, 167, npcSliderTip)
resetCheckboxStyle(playerOptions)

applyButtonStyle(0.2, 0.0, 0.6, 1.0, 0.1, 0.1, 0.1, 1.0, 0.0, 0.0, 1.0, 1.0, 7.0, playerOptions)
hudBreaker = function() 
	pid = network.get_selected_player()
    network.trigger_script_event(1 << pid, {1450115979, pid, 1})
    gui.show_message("HUD Breaker", "You have broken "..PLAYER.GET_PLAYER_NAME(pid).."'s HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end

hudToolTip = "Breaks the targets HUD causing them to have no HUD, breaks entering interiors, pausing the game & more."
createButton(playerOptions, "HUD Breaker", hudBreaker, hudToolTip)
resetButtonStyle(playerOptions)

playerOptions:add_sameline()

applyButtonStyle(0.2, 0.0, 0.6, 1.0, 0.1, 0.1, 0.1, 1.0, 0.0, 0.0, 1.0, 1.0, 7.0, playerOptions)
hudBreaker = function() 
	pid = network.get_selected_player()
    network.trigger_script_event(1 << pid, {1450115979, pid, 1})
    gui.show_message("HUD Breaker", "You have broken "..PLAYER.GET_PLAYER_NAME(pid).."'s HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end

hudToolTip = "Breaks the targets HUD causing them to have no HUD, breaks entering interiors, pausing the game & more."
createButton(playerOptions, "HUD Breaker", hudBreaker, hudToolTip)
resetButtonStyle(playerOptions)

playerOptions:add_sameline()

applyButtonStyle(0.2, 0.0, 0.6, 1.0, 0.1, 0.1, 0.1, 1.0, 0.0, 0.0, 1.0, 1.0, 7.0, playerOptions)
hudBreaker = function() 
	pid = network.get_selected_player()
    network.trigger_script_event(1 << pid, {1450115979, pid, 1})
    gui.show_message("HUD Breaker", "You have broken "..PLAYER.GET_PLAYER_NAME(pid).."'s HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end

hudToolTip = "Breaks the targets HUD causing them to have no HUD, breaks entering interiors, pausing the game & more."
createButton(playerOptions, "HUD Breaker", hudBreaker, hudToolTip)
resetButtonStyle(playerOptions)

playerOptions:add_sameline()

applyButtonStyle(0.2, 0.0, 0.6, 1.0, 0.1, 0.1, 0.1, 1.0, 0.0, 0.0, 1.0, 1.0, 7.0, playerOptions)
hudBreaker = function() 
	pid = network.get_selected_player()
    network.trigger_script_event(1 << pid, {1450115979, pid, 1})
    gui.show_message("HUD Breaker", "You have broken "..PLAYER.GET_PLAYER_NAME(pid).."'s HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end

hudToolTip = "Breaks the targets HUD causing them to have no HUD, breaks entering interiors, pausing the game & more."
createButton(playerOptions, "HUD Breaker", hudBreaker, hudToolTip)
resetButtonStyle(playerOptions)



textSeparator(settingsOptions, "Extras Addon - Settings")

applyCheckboxStyle(1.0, 0.0, 0.0, 0.5, 7.0, settingsOptions)
autoKick = function()
	local localPlayerID = PLAYER.PLAYER_ID()
    local hostPlayerID = NETWORK.NETWORK_GET_HOST_PLAYER_INDEX()

    if hostPlayerID == localPlayerID then      
        local localPlayerID = PLAYER.PLAYER_ID()    
        local isHost = NETWORK.NETWORK_IS_HOST()
        -- Identify modders and store their IDs
        for i = 0, 31 do
			local pid = i
			local detect = network.is_player_flagged_as_modder(pid)
			local reason = network.get_flagged_modder_reason(pid)
			
			if not NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
				kickedModders[pid] = nil
			else
				if pid ~= localPlayerID and detect and reason then
					if not detectedModders[pid] then
						detectedModders[pid] = PLAYER.GET_PLAYER_NAME(pid)
					end
					
					if not kickedModders[pid] then
						command.call("smartkick", {pid})
						gui.show_message("Auto Kick", "Automatically kicked " .. detectedModders[pid])
						kickedModders[pid] = true
					end
				end
			end
		end
    else
        gui.show_message("Auto-Kick", "You are not the host of the session")
		tag:set_enabled(false)
    end
end

autoKickToolTip = "Automatically kicks detected modders if you are the session host"
createCheckbox("autoKick", settingsOptions, "Auto-Kick Modders", autoKickToolTip, autoKick, -1, false, "N/A", 0, 0, nil)
resetCheckboxStyle(settingsOptions)
