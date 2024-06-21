griefPlayerTab:add_button("Clown Bombers", function()
    script.run_in_fiber(function(script)
        local hash = joaat("s_m_y_clown_01")
        local asset = "scr_rcbarry2"
        local explosion = "scr_exp_clown"
        local appears = "scr_clown_appears"

        request_model(hash)
        local player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        local playerPos = ENTITY.GET_ENTITY_COORDS(player, false)
        
        -- Find a safe spawn point near the player
        local spawnPos = get_safe_spawn_point_near_player(playerPos)

        local ped = PED.CREATE_PED(0, hash, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, false)
        if ped == 0 then 
            gui.show_error("Clown Bomber", "Failed to Create Ped\nMost Likely The Model Isn't Loaded\nTry Again.")
            return
        end

        gui.show_message("Clown Bomber", "Spawned as " .. tostring(ped))

        request_fx_asset(asset)
        GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
            appears,
            ped,
            0.0, 0.0, -1.0,
            0.0, 0.0, 0.0,
            0.5, false, false, false
        )

        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        PED.SET_PED_KEEP_TASK(ped, true)
        AUDIO.STOP_PED_SPEAKING(ped, true)
        WEAPON.GIVE_WEAPON_TO_PED(ped, joaat("weapon_stickybomb"), 1, false, true)
        TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, playerPos.x, playerPos.y, playerPos.z, 3.0, 0, false, 0, 0.0)

        while not PED.IS_PED_FATALLY_INJURED(ped) and ENTITY.DOES_ENTITY_EXIST(ped) do
            local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
            local targetPos = ENTITY.GET_ENTITY_COORDS(player, true)
            
            if calcDistanceFromTwoCoords(pedPos, targetPos) < 3.0 then
                request_fx_asset(asset)
                GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                    explosion,
                    pedPos.x, pedPos.y, pedPos.z,
                    0.0, 0.0, 0.0,
                    1.0,
                    false, false, false, false
                )
                FIRE.ADD_EXPLOSION(pedPos.x, pedPos.y, pedPos.z, 0, 1000.0, true, true, 1.0, false)
                ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
                ENTITY.DELETE_ENTITY(ped)
                return
            end

            if calcDistanceFromTwoCoords(targetPos, playerPos) > 3.0 then
                playerPos = targetPos
                TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, playerPos.x, playerPos.y, playerPos.z, 3.0, 0, false, 0, 0.0)
            end
            
            script:yield()
        end

        ENTITY.DELETE_ENTITY(ped)
    end)
end)
toolTip(griefPlayerTab, "Spawns a kamikaze clown to kill the player")
