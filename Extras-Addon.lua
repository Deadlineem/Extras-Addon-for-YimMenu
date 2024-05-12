 json = require('json')

--[[


___________         __                        
\_   _____/__  ____/  |_____________    ______
 |    __)_\  \/  /\   __\_  __ \__  \  /  ___/
 |        \>    <  |  |  |  | \// __ \_\___ \ 
/_______  /__/\_ \ |__|  |__|  (____  /____  >
        \/      \/                  \/     \/ 
     _____       .___  .___                   
    /  _  \    __| _/__| _/____   ____        
   /  /_\  \  / __ |/ __ |/  _ \ /    \       
  /    |    \/ /_/ / /_/ (  <_> )   |  \      
  \____|__  /\____ \____ |\____/|___|  /      
          \/      \/    \/           \/       

    Extras Addon for YimMenu v1.68
        Addon Version: 1.0.5
        
        Credits:  Yimura, L7Neg, 
    Loled69, Alestarov, gir489returns, 
      TheKuter, RazorGamerX, USBMenus & More!

]]--

 addonVersion = "1.0.5"

griefPlayerTab = gui.get_tab("")
dropsPlayerTab = gui.get_tab("") -- For Selected Player Options
giftPlayerTab = gui.get_tab("")

-- Function to create a text element
 function createText(tab, text)
    tab:add_text(text)
end

function sleep(seconds)
     start = os.clock()
    while os.clock() - start < seconds do
        -- Yield the CPU to avoid high CPU usage during the delay
        coroutine.yield()
    end
end

function delete_entity(ent) --discord@rostal315
    if ENTITY.DOES_ENTITY_EXIST(ent) then
        ENTITY.DETACH_ENTITY(ent, true, true)
        ENTITY.SET_ENTITY_VISIBLE(ent, false, false)
        NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(ent, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, 0.0, 0.0, -1000.0, false, false, false)
        ENTITY.SET_ENTITY_COLLISION(ent, false, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ent)
        ENTITY.DELETE_ENTITY(ent)
    end
end

function toolTip(tab, text, seperate)
    seperate = seperate or false
    if tab == "" then
        if seperate then --waiting approval
            ImGui.SameLine()
            ImGui.TextDisabled("(?)")
        end
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
      ImGui.Text(text)
            ImGui.EndTooltip()
        end
    else
        tab:add_imgui(function()
            if seperate then
                ImGui.SameLine()
                ImGui.TextDisabled("(?)")
            end
            if ImGui.IsItemHovered() then
                ImGui.BeginTooltip()
                ImGui.Text(text)
                ImGui.EndTooltip()
            end
        end)
    end
end

function newText(tab, text, size)
    size = size or 1
    tab:add_imgui(function()
        ImGui.SetWindowFontScale(size)
        ImGui.Text(text)
        ImGui.SetWindowFontScale(1)
    end)
end

function RequestControl(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
         netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

function request_control(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
         netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end

function SessionChanger(session)
    globals.set_int(1575032, session)
        if session == -1 then
            globals.set_int(1574589 + 2, -1)
        end
        sleep(0.5)
        globals.set_int(1574589, 1)
        sleep(0.5)
        globals.set_int(1574589, 0)
end

-- Extras Menu Addon for YimMenu 1.68 by DeadlineEm
 KAOS = gui.get_tab("Extras Addon")
require("Extras-data")
newText(KAOS, "Welcome to Extras Addon v"..addonVersion.." please read the information below before proceeding to use the menu options.", 1)
KAOS:add_separator()
createText(KAOS, "Some, if not most of these options are considered Recovery based options, use them at your own risk!")
KAOS:add_separator()
createText(KAOS, "This menu is a mashup of multiple menu features, some altered, some not.  It was created with the intent")
createText(KAOS, "of having as many options as possible for everything you can imagine, but to allow complete mod freedom")
createText(KAOS, "without needing to compile your own version of YimMenu yet still being able to use its base features in")
createText(KAOS, "one small dropdown tab without needing multiple lua scripts to do so.  The project is open source and I")
createText(KAOS, "encourage everyone to create this with me, lend your ideas, submit PR's, make discussions and lets make")
createText(KAOS, "YimMenu next generation!")
KAOS:add_separator()
createText(KAOS, "Credits: Yimura, L7Neg, Loled69, TeaTimeTea, CSYON, Adventure Box, gir489returns, abuazizv,")
createText(KAOS, "Alestarov, RazorGamerX, USBMenus, ShinyWasabi & the UC community")
KAOS:add_separator()
createText(KAOS, "Thanks to all my testers, your time is appreciated.  Thanks to all of the above for your scripts and")
createText(KAOS, "for your inputs on my comments, I have done alot of reading, scrolling, testing and learning from it all")
createText(KAOS, "Brought to you by - DeadlineEm & USBMenus")

-- Player Options Tab
 Pla = KAOS:add_tab("Player Options")

-- Movement Tab with Slider for Movement Speed
 Mvmt = Pla:add_tab("Movement")

runSpeed = 1
Mvmt:add_imgui(function()
    runSpeed, used = ImGui.SliderInt("Run Speed", runSpeed, 1, 10)
    out = "Speed set to "..tostring(runSpeed).."x"
    if used then
        PLAYER.SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), runSpeed/7)
        gui.show_message('Run Speed Modified!', out)
    end
    toolTip("", "Increase your Walk/Run Speed")
end)

swimSpeed = 1
Mvmt:add_imgui(function()
    swimSpeed, used = ImGui.SliderInt("Swim Speed", swimSpeed, 1, 10)
    out = "Speed set to "..tostring(swimSpeed).."x"
    if used then
        PLAYER.SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), swimSpeed/7)
        gui.show_message('Swim Speed Modified!', out)
    end
    toolTip("", "Increase your Swimming Speed")
end)

-- Fun Random Things
 Fun = Pla:add_tab("Fun Self Options")
Fun:add_text("PTFX")
 fireworkLoop3 = Fun:add_checkbox("Firework (On/Off)")

function load_fireworks()
    STREAMING.REQUEST_NAMED_PTFX_ASSET("proj_indep_firework")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("proj_indep_firework") then
        return false
    end


    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("FireworkLoop3", function()
    if fireworkLoop3:is_enabled() == true then
        if load_fireworks() then
             PlayerId = PLAYER.PLAYER_ID()
                 player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerId), true)

                -- Get random color values
                 colorR, colorG, colorB = random_color()
                test = player_coords.z - 1
                GRAPHICS.USE_PARTICLE_FX_ASSET("proj_indep_firework")
                GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_indep_firework_grd_burst", player_coords.x, player_coords.y, test, 0, 0, 0, 1, false, false, false, false)
            sleep(0.2)
        end
    end
end)
toolTip(Fun, "Toggles Firework particle effect on your player")
Fun:add_sameline()
 smokeLoop = Fun:add_checkbox("Smoke (On/Off)")
function load_smoke()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_sum2_hal")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_sum2_hal") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("SmokeLoop", function()
    if smokeLoop:is_enabled() == true then
        if load_smoke() then
             PlayerId = PLAYER.PLAYER_ID()
                 player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerId), true)

                -- Get random color values
                 colorR, colorG, colorB = random_color()
                test = player_coords.z - 2.0
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
                GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_sum2_hal_rider_death_blue", player_coords.x, player_coords.y, test, 0, 0, 0, 1, false, false, false, false)
            sleep(0.2)
        end
    end
end)
toolTip(Fun, "Toggles Smoke particle effect at your players feet")
Fun:add_sameline()
 flameLoop = Fun:add_checkbox("Flames (On/Off)")
function load_flame()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_bike_adversary")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_bike_adversary") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("FlameLoop", function()
    if flameLoop:is_enabled() == true then
        if load_flame() then
             PlayerId = PLAYER.PLAYER_ID()
                 player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerId), true)

                -- Get random color values
                 colorR, colorG, colorB = random_color()
                test = player_coords.z - 1
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_bike_adversary")
                GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_adversary_foot_flames", player_coords.x, player_coords.y, test, 0, 0, 0, 5, false, false, false, false)
            sleep(0.2)
        end
    end
end)
toolTip(Fun, "Toggles Fire 'Ghostrider' particle effect at your players feet")
Fun:add_separator()
shootCB = Fun:add_checkbox("Gun PTFX (Banknotes)")

script.register_looped("particles", function(shoot)
    if shootCB:is_enabled() then
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
             weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
             boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_PED_BONE("muz_clown", weapon, 0.0, 0.0, 0.0, 90, 0, 0, boneId, 0.8, false, false, false)
        end
    end
end)
toolTip(Fun, "Toggles a Clown particle effect on your weapon when its fired")
Fun:add_sameline()
shootCB2 = Fun:add_checkbox("Gun PTFX (Blood)")

script.register_looped("particles2", function(shootlol)
    if shootCB2:is_enabled() then
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
             weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
             boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")

            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_michael2")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_PED_BONE("scr_mich2_blood_stab", weapon, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, boneId, 2.5, false, false, false)
        end
    end
end)
toolTip(Fun, "Toggles Blood particle effect on your weapon when its fired")
Fun:add_sameline()
vehCB = Fun:add_checkbox("Rear Wheel Flames")

script.register_looped("particles3", function(wheelOne)
    if vehCB:is_enabled() then
         effect = "scr_bike_adversary"
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect) do
            STREAMING.REQUEST_NAMED_PTFX_ASSET(effect)
            wheelOne:yield()
        end
            -- weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
         vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
             class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
            if class == 8 then
                 boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, "wheel_lr") -- Rear Motorcycle Wheel
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("scr_adversary_foot_flames", vehicle, 0.0, 0.0, 0.0, 0, 0, 0, boneId, 2, false, false, false)
            else
                 boneIdOne = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, "wheel_lr") -- left rear wheel
                 boneIdTwo = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, "wheel_rr") -- right rear wheel
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("scr_adversary_foot_flames", vehicle, 0.0, 0.0, 0.0, 0, 0, 0, boneIdOne, 2, false, false, false)
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("scr_adversary_foot_flames", vehicle, 0.0, 0.0, 0.0, 0, 0, 0, boneIdTwo, 2, false, false, false)
            end 
        end
    end
end)
toolTip(Fun, "Toggles fire particle effects on your vehicles rear wheels")

 effectNames = { "Alien Impact", "Clown Appears", "Blue Sparks", "Alien Disintegration", "Firey Particles" }
 local effects <const> = {
    {"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
    {"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
    {"core", "ent_dst_elec_fire_sp", 1.0, 100},
    {"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
    {"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}

function newTimer()
     self = {
        start = os.clock(), -- Start time in seconds
        m_enabled = false,
    }

     function reset()
        self.start = os.clock()
        self.m_enabled = true
    end

     function elapsed()
        return (os.clock() - self.start) * 1000 -- Convert seconds to milliseconds
    end

     function disable() self.m_enabled = false end
     function isEnabled() return self.m_enabled end

    return {
        isEnabled = isEnabled,
        reset = reset,
        elapsed = elapsed,
        disable = disable,
    }
end


 selectedOpt = 1
 local lastEffect <const> = newTimer()

tirePTFX = Fun:add_checkbox("Tire PTFX")
Fun:add_sameline()
Fun:add_imgui(function()
    selectedOpt, selected = ImGui.Combo("Effects", selectedOpt, effectNames, #effectNames)
end)

script.register_looped("tireptfx", function(tire) 
     effect = effects[selectedOpt + 1]
     vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if tirePTFX:is_enabled() then

        if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
        VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and lastEffect.elapsed() > effect[4] then
            request_fx_asset(effect[1])
            for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
                 bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
                
                GRAPHICS.USE_PARTICLE_FX_ASSET(effect[1])
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                    effect[2],
                    vehicle,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    bone,
                    effect[3],
                    false, false, false
                )
            end
            lastEffect.reset()
        end
    end
end)
toolTip(Fun, "Show Particle Effects On Your Tires")

Fun:add_separator()
Fun:add_text("Movement Altering")
drunkLoop = false
acidTrip = false
drunkDriving = false
Fun:add_imgui(function()
    drunkLoop, enabled = ImGui.Checkbox("Make Me Drunk", drunkLoop, true)
    ImGui.SameLine()
    ImGui.TextDisabled("(?)")
    if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.Text("Makes your character move around drunk.")
        ImGui.EndTooltip()
    end
    ImGui.SameLine()
    acidTrip, enabled = ImGui.Checkbox("Show Drunk VFX", acidTrip, true)
    ImGui.SameLine()
    ImGui.TextDisabled("(?)")
    if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.Text("Shows the Drunk visual effects (Only when ``Make Me Drunk´´ is active).")
        ImGui.EndTooltip()
    end
    ImGui.SameLine()
    drunkDriving, enabled = ImGui.Checkbox("Drunk Driving", drunkDriving, true)
    ImGui.SameLine()
    ImGui.TextDisabled("(?)")
    if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.Text("Simulates Drunk Driving (Only when ``Make Me Drunk´´ is active).")
        ImGui.EndTooltip()
    end
     ped = PLAYER.PLAYER_PED_ID()
    if drunkLoop then
        script.run_in_fiber(function()
            while not STREAMING.HAS_CLIP_SET_LOADED("move_m@drunk@verydrunk") do
                STREAMING.REQUEST_CLIP_SET("move_m@drunk@verydrunk")
                coroutine.yield()
            end
            PED.SET_PED_MOVEMENT_CLIPSET(ped, "move_m@drunk@verydrunk", 1.0)
        end)
            gui.show_message("Impairment:", "You are now drunk!")
    else
        PED.RESET_PED_MOVEMENT_CLIPSET(ped, 0.0)
    end
        -- Apply drunk visual effects if the checkbox is enabled
    if acidTrip then
        script.run_in_fiber(function()
            if not drunkLoop then
                gui.show_warning("Impairment:", "Activate ``Make Me Drunk´´ before using this effect.")
                acidTrip = false
            else
            -- Apply acid trip visual effects
            -- Adjust these effects based on your preferences and available native functions
            GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk") -- Apply drunk timecycle modifier (you can change this to an acid trip modifier or stoned modifier)
            GRAPHICS.SET_TIMECYCLE_MODIFIER_STRENGTH(1.3) -- Adjust strength of distortion
            -- Add additional visual effects here (e.g., screen distortions, color shifts, etc.)
            -- You may need to experiment with different native functions to achieve the desired effect
            end
        end)
    else
        GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
    end
end)
script.register_looped("drunk driving", function(script)
    script:yield()
    -- Enable drunk driving if the checkbox is enabled
    if drunkDriving then
        if not drunkLoop then
            gui.show_warning("Impairment:", "Activate ``Make Me Drunk´´ before using this effect.")
            drunkDriving = false
        else
             vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if vehicle ~= 0 then
                -- Apply random steering inputs
                 randomSteering = math.random(-1, 1) -- Random value between -1 and 1
                VEHICLE.SET_VEHICLE_STEER_BIAS(vehicle, randomSteering)
                VEHICLE.SET_VEHICLE_STEERING_BIAS_SCALAR(vehicle, 100)
                VEHICLE.SET_VEHICLE_HANDLING_OVERRIDE(vehicle, MISC.GET_HASH_KEY(vehicle))
                sleep(0.2)
                -- Reduce vehicle control
            end
        end
    end
end)
Fun:add_button("Remove Impairments", function()
    if drunkLoop then
         ped = PLAYER.PLAYER_PED_ID()
        PED.RESET_PED_MOVEMENT_CLIPSET(ped, 0.0)
        drunkLoop = false
        gui.show_message("Impairment Removed", "You are no longer impaired. Visual and movement effects are removed.")
        -- Reset acid trip visual effects when removing drunk movement
    end
    if acidTrip then
        GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
        acidTrip = false
    end
end)
toolTip(Fun, "Removes all impairments.")

    
-- Stat Editor - Alestarov_Menu // Reset Stats Option
 Stats = Pla:add_tab("Stats")
Stats:add_text("Change Levels")
Stats:add_button("Randomize RP", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         randomizeRP = math.random(1, 1787576850) -- 1 Rp to 1787576850 Rp (lvl 1 to 8000)
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), randomizeRP, true)
        gui.show_message("Stats", "Your RP has been randomized to "..randomizeRP..", changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Randomize your RP/Level")
Stats:add_sameline()
Stats:add_button("Lvl 1", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         rpLevel = 1 -- Level 1 -- https://www.unknowncheats.me/forum/2458458-post691.html
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), rpLevel, true)
        gui.show_message("Stats", "Your level was set to 1, changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Set your level to 1")
Stats:add_sameline()
Stats:add_button("Lvl 100", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         rpLevel = 1584350 -- Level 100 -- https://www.unknowncheats.me/forum/2458458-post691.html
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), rpLevel, true)
        gui.show_message("Stats", "Your level was set to 100, changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Set your level to 100")
Stats:add_sameline()
Stats:add_button("Lvl 420", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         rpLevel = 13288350 -- Level 420 -- https://www.unknowncheats.me/forum/2458458-post691.html
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), rpLevel, true)
        gui.show_message("Stats", "Your level was set to 420, changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Set your level to 420")
Stats:add_sameline()
Stats:add_button("Lvl 1337", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         rpLevel = 75185850 -- Level 1337 -- https://www.unknowncheats.me/forum/2458458-post691.html
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), rpLevel, true)
        gui.show_message("Stats", "Your level was set to 1337, changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Set your level to 1337")
Stats:add_sameline()
Stats:add_button("Lvl 8000", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
         rpLevel = 1787576850 -- Level 8000 -- https://www.unknowncheats.me/forum/2458458-post691.html
        STATS.STAT_SET_INT(joaat(MPX .. "CHAR_SET_RP_GIFT_ADMIN"), rpLevel, true)
        gui.show_message("Stats", "Your level was set to 8000, changing session and applying RP")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Set your level to 8000")
Stats:add_separator()
Stats:add_text("Income Statistics")
Stats:add_button("Reset Income/Spent Stats", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
        STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_EVC"), 0, true)
        STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_SVC"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_JOBS"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_JOBSHARED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_SELLING_VEH"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_WEAPON_ARMOR"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_VEH_MAINTENANCE"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_STYLE_ENT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_PROPERTY_UTIL"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_JOB_ACTIVITY"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_SPENT_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "MONEY_EARN_CLUB_DANCING"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_CHIPS_WON_GD"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_CHIPS_WONTIM"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_GMBLNG_GD"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_BAN_TIME"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_CHIPS_PURTIM"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CASINO_CHIPS_PUR_GD"), 0, true)
        if PI == 0 then
            gui.show_message("Stats", "Income Stats for Player 1 have been reset to 0, changing sessions to apply.")
        else
            gui.show_message("Stats", "Income Stats for Player 2 have been reset to 0, changing sessions to apply.")
        end
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Reset your Earned income, Overall Income, Casino Chip Earnings, etc. to 0")
Stats:add_sameline()
Stats:add_button("Bank 2 Wallet", function()
    NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.get_character_index(), MONEY.NETWORK_GET_VC_BANK_BALANCE(stats.get_character_index()))
end)
toolTip(Stats, "Take all your money out of the bank")
Stats:add_sameline()
Stats:add_button("Wallet 2 Bank", function()
    NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.get_character_index(), MONEY.NETWORK_GET_VC_WALLET_BALANCE(stats.get_character_index()))
end)
toolTip(Stats, "Put all your money into the bank")
Stats:add_separator()
Stats:add_text("Character Skills")
Stats:add_button("Max All Skills", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_DRIV"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_FLY"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_LUNG"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_SHO"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STAM"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STL"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STRN"), 1000, true)
        gui.show_message("Stats", "Your character skills (Driving, Flying, etc.) have been maxed. Changing sessions to apply.")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Max your characters skills (Driving, flying, stamina, etc.)")
Stats:add_sameline()
Stats:add_button("Reset All Skills", function()
    script.run_in_fiber(function (script)
        MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_DRIV"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_FLY"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_LUNG"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_SHO"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STAM"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STL"), -1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "SCRIPT_INCREASE_STRN"), -1000, true)
        gui.show_message("Stats", "Your character skills (Driving, Flying, etc.) have been zeroed. Changing sessions to apply.")
        sleep(1)
        SessionChanger(0)
    end)
end)
toolTip(Stats, "Resets your skills to minimum values.")
Stats:add_separator()
Stats:add_text("Unlocker")
function unlock_packed_bools(from, to)
    for i = from, to do
        stats.set_packed_stat_bool(i, true)
    end
end

 current_objectives_global = 2359296
 weekly_words_global = 2737646
 objectives_state_global = 1574743

Stats:add_button("Unlock All", function() --Original script by ShinyWasabi
    script.run_in_fiber(function (script)
        function unlock_packed_bools(from, to)
    for i = from, to do
        stats.set_packed_stat_bool(i, true)
    end
end

-- Look for what reads DISABLE_DAILY_OBJECTIVES and then there should be a while loop that stops at 3.
local current_objectives_global = 2359296
local weekly_words_global = 2737646
local objectives_state_global = 1574743

wasabi_words = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Unlock All") --WasabiWords™️

wasabi_words:add_button("ShinyWasabi", function() --Original script by ShinyWasabi
    script.run_in_fiber(function (script)
        local is_player_male = (ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID()) == joaat('mp_m_freemode_01'))
        unlock_packed_bools(110, 113) --Red Check Pajamas, Green Check Pajamas, Black Check Pajamas, I Heart LC T-shirt
        unlock_packed_bools(115, 115) --Roosevelt
        unlock_packed_bools(124, 124) --Sanctus
        unlock_packed_bools(129, 129) --Albany Hermes
        unlock_packed_bools(135, 137) --Vapid Clique, Buzzard Attack Chopper, Insurgent Pick-Up
        unlock_packed_bools(3593, 3599) --'Statue Of Happiness' T-shirt, 'Pisswasser' Beer Hat, 'Benedict' Beer Hat, 'J Lager' Beer Hat, 'Patriot' Beer Hat, 'Blarneys' Beer Hat, 'Supa Wet' Beer Hat
        unlock_packed_bools(3604, 3605) --Liberator, Sovereign
        unlock_packed_bools(3608, 3609) --'Elitas' T-shirt, High Flyer Parachute Bag
        unlock_packed_bools(3616, 3616) --Please Stop Me Mask
        unlock_packed_bools(3750, 3750) --Stocking
        unlock_packed_bools(3765, 3769) --The Fleeca Job, The Prison Break, The Humane Labs Raid, Series A Funding, The Pacific Standard Job (Elite Challenges)
        unlock_packed_bools(3770, 3781) --'Death Defying' T-shirt, 'For Hire' T-shirt, 'Gimme That' T-shirt, 'Asshole' T-shirt, 'Can't Touch This' T-shirt, 'Decorated' T-shirt, 'Psycho Killer' T-shirt, 'One Man Army' T-shirt, 'Shot Caller' T-shirt, 'Showroom' T-shirt, 'Elite Challenge' T-Shirt, 'Elite Lousy' T-Shirt
        unlock_packed_bools(3783, 3802) --Fake Dix White T-Shirt, Fake Dix Gold T-Shirt, Fake Didier Sachs T-Shirt, Fake Enema T-Shirt, Fake Le Chien No2 T-Shirt, Fake Le Chien Crew T-Shirt, Fake Santo Capra T-Shirt, Fake Vapid T-Shirt, Fake Perseus T-Shirt, Fake Sessanta Nove T-Shirt, 'Vinewood Zombie' T-shirt, 'Meltdown' T-shirt, 'I Married My Dad' T-shirt, 'Die Already 4' T-shirt, 'The Shoulder Of Orion II' T-shirt, 'Nelson In Naples' T-shirt, 'The Many Wives of Alfredo Smith' T-shirt, 'An American Divorce' T-shirt, 'The Loneliest Robot' T-shirt, 'Capolavoro' T-shirt
        unlock_packed_bools(4247, 4269) --'Magnetics Script' Hat, 'Magnetics Block' Hat, 'Low Santos' Hat, 'Boars' Hat, 'Benny's' Hat, 'Westside' Hat, 'Eastside' Hat, 'Strawberry' Hat, 'S.A.' Hat, 'Davis' Hat, 'Vinewood Zombie' T-shirt, 'Knife After Dark' T-shirt, 'The Simian' T-shirt, 'Zombie Liberals In The Midwest' T-shirt, 'Twilight Knife' T-shirt, 'Butchery and Other Hobbies' T-shirt, 'Cheerleader Massacre 3' T-shirt, 'Cannibal Clown' T-shirt, 'Hot Serial Killer Stepmom' T-shirt, 'Splatter And Shot' T-shirt, 'Meathook For Mommy' T-shirt, 'Psycho Swingers' T-shirt, 'Vampires On The Beach' T-shirt
        unlock_packed_bools(4300, 4327) --Brown Corpse Bride Bobblehead, White Corpse Bride Bobblehead, Pink Corpse Bride Bobblehead, White Mask Slasher Bobblehead, Red Mask Slasher Bobblehead, Yellow Mask Slasher Bobblehead, Blue Zombie Bobblehead, Green Zombie Bobblehead, Pale Zombie Bobblehead, Possessed Urchin Bobblehead, Demonic Urchin Bobblehead, Gruesome Urchin Bobblehead, Tuxedo Frank Bobblehead, Purple Suit Frank Bobblehead, Stripped Suit Frank Bobblehead, Black Mummy Bobblehead, White Mummy Bobblehead, Brown Mummy Bobblehead, Pale Werewolf Bobblehead, Dark Werewolf Bobblehead, Gray Werewolf Bobblehead, Fleshy Vampire Bobblehead, Bloody Vampire Bobblehead, B&W Vampire Bobblehead, Halloween Loop 1, Halloween Loop 2, Franken Stange, Lurcher
        unlock_packed_bools(4333, 4335) --Nice Cap, Naughty Cap, Abominable Snowman
        unlock_packed_bools(7467, 7495) --'Accountant' T-shirt, 'Bahama Mamas' T-shirt, 'Drone' T-shirt, 'Grotti' T-shirt, 'Golf' T-shirt, 'Maisonette' T-shirt, 'Manopause' T-shirt, 'Marlowe' T-shirt, 'Meltdown' T-shirt, 'Pacific Bluffs' T-shirt, 'Prolaps' T-shirt, 'Tennis' T-shirt, 'Toe Shoes' T-shirt, 'Crest' T-shirt, 'Vanilla Unicorn' T-shirt, Pastel Blue Pajamas, Pastel Yellow Pajamas, Pastel Pink Pajamas, Pastel Green Pajamas, Vibrant Check Pajamas, Blue Check Pajamas, Red Swirl Motif Pajamas, White Graphic Pajamas, Blue Swirl Pajamas, Yellow Swirl Pajamas, Red Swirl Pajamas, Navy Pinstripe Pajamas, Bold Pinstripe Pajamas, Orange Pinstripe Pajamas
        unlock_packed_bools(7515, 7528) --Pastel Blue Smoking Jacket, Pastel Yellow Smoking Jacket, Pastel Pink Smoking Jacket, Pastel Green Smoking Jacket, Vibrant Check Smoking Jacket, Blue Check Smoking Jacket, Red Swirl Motif Smoking Jacket, White Graphic Smoking Jacket, Blue Swirl Smoking Jacket, Yellow Swirl Smoking Jacket, Red Swirl Smoking Jacket, Navy Pinstripe Smoking Jacket, Bold Pinstripe Smoking Jacket, Orange Pinstripe Smoking Jacket
        unlock_packed_bools(7551, 7551) --DCTL T-Shirt
        unlock_packed_bools(7595, 7601) --White Jock Cranley Suit, Red Jock Cranley Suit, Blue Jock Cranley Suit, Black Jock Cranley Suit, Pink Jock Cranley Suit, Gold Jock Cranley Suit, Silver Jock Cranley Suit
        unlock_packed_bools(9362, 9385) --Western Brand White T-Shirt, Western Brand Black T-Shirt, Western Logo White T-Shirt, Western Logo Black T-Shirt, Steel Horse Solid Logo T-Shirt, Steel Horse Logo T-Shirt, Steel Horse Brand White T-Shirt, Steel Horse Brand Black T-Shirt, Nagasaki White T-Shirt, Nagasaki White and Red T-Shirt, Nagasaki Black T-Shirt, Purple Helmets Black T-Shirt, Principe Black T-Shirt, Black Steel Horse Hoodie, Steel Horse Brand White T-Shirt, Western Black Hoodie, Western Logo White T-Shirt, Nagasaki White Hoodie, Nagasaki White and Red Hoodie, Nagasaki Black Hoodie, Purple Helmets Black Hoodie, Principe Logo, Crosswalk T-Shirt, R* Crosswalk T-Shirt
        unlock_packed_bools(9426, 9440) --Base5 T-Shirt, Bitch'n' Dog Food T-Shirt, BOBO T-Shirt, Bounce FM T-Shirt, Crocs Bar T-Shirt, Emotion 98.3 T-Shirt, Fever 105 T-Shirt, Flash T-Shirt, Homies Sharp T-Shirt, K-DST T-Shirt, KJAH Radio T-Shirt, K-ROSE T-Shirt, Victory Fist T-Shirt, Vinyl Countdown T-Shirt, Vivisection T-Shirt
        unlock_packed_bools(9443, 9443) --Unicorn
        unlock_packed_bools(9461, 9481) --Ballistic Equipment, LS UR T-Shirt, Non-Stop-Pop FM T-Shirt, Radio Los Santos T-Shirt, Los Santos Rock Radio T-Shirt, Blonded Los Santos 97.8 FM T-Shirt, West Coast Talk Radio T-Shirt, Radio Mirror Park T-Shirt, Rebel Radio T-Shirt, Channel X T-Shirt, Vinewood Boulevard Radio T-Shirt, FlyLo FM T-Shirt, Space 103.2 T-Shirt, West Coast Classics T-Shirt, East Los FM T-Shirt, The Lab T-Shirt, The Lowdown 91.1 T-Shirt, WorldWide FM T-Shirt, Soulwax FM T-Shirt, Blue Ark T-Shirt, Blaine County Radio T-Shirt
        unlock_packed_bools(15381, 15382) --APC SAM Battery, Ballistic Equipment
        unlock_packed_bools(15388, 15423) --Black Ammu-Nation Cap, Black Ammu-Nation Hoodie, Black Ammu-Nation T-Shirt, Black Coil Cap, Black Coil T-Shirt, Black Hawk & Little Hoodie, Black Hawk & Little Logo T-Shirt, Black Hawk & Little T-Shirt, Black Shrewsbury Hoodie, Black Vom Feuer Cap, Black Warstock Hoodie, Green Vom Feuer T-Shirt, Red Hawk & Little Cap, Warstock Cap, White Ammu-Nation T-Shirt, White Coil Hoodie, White Coil T-Shirt, White Hawk & Little Hoodie, White Hawk & Little T-Shirt, White Shrewsbury T-Shirt, White Shrewsbury Cap, White Shrewsbury Hoodie, White Shrewsbury Logo T-Shirt, White Vom Feuer Cap, White Vom Feuer Hoodie, Wine Coil Cap, Yellow Vom Feuer Logo T-Shirt, Yellow Vom Feuer T-Shirt, Yellow Warstock T-Shirt, Blue R* Class of '98, Red R* Class of '98, Noise Rockstar Logo T-Shirt, Noise T-Shirt, Razor T-Shirt, Black Rockstar Camo, White Rockstar Camo
        unlock_packed_bools(15425, 15439) --Knuckleduster Pocket T-Shirt, Rockstar Logo Blacked Out T-Shirt, Rockstar Logo White Out T-Shirt, Half-track 20mm Quad Autocannon, Weaponized Tampa Dual Remote Minigun, Weaponized Tampa Rear-Firing Mortar, Weaponized Tampa Front Missile Launchers, Dune FAV 40mm Grenade Launcher, Dune FAV 7.62mm Minigun, Insurgent Pick-Up Custom .50 Cal Minigun, Insurgent Pick-Up Custom Heavy Armor Plating, Technical Custom 7.62mm Minigun, Technical Custom Ram-bar, Technical Custom Brute-bar, Technical Custom Heavy Chassis Armor
        unlock_packed_bools(15447, 15474) --Oppressor Missiles, Fractal Livery Set, Digital Livery Set, Geometric Livery Set, Nature Reserve Livery, Naval Battle Livery, Anti-Aircraft Trailer Dual 20mm Flak, Anti-Aircraft Trailer Homing Missile Battery, Mobile Operations Center Rear Turrets, Incendiary Rounds, Hollow Point Rounds, Armor Piercing Rounds, Full Metal Jacket Rounds, Explosive Rounds, Pistol Mk II Mounted Scope, Pistol Mk II Compensator, SMG Mk II Holographic Sight, SMG Mk II Heavy Barrel, Heavy Sniper Mk II Night Vision Scope, Heavy Sniper Mk II Thermal Scope, Heavy Sniper Mk II Heavy Barrel, Combat MG Mk II Holographic Sight, Combat MG Mk II Heavy Barrel, Assault Rifle Mk II Holographic Sight, Assault Rifle Mk II Heavy Barrel, Carbine Rifle Mk II Holographic Sight, Carbine Rifle Mk II Heavy Barrel, Proximity Mines
        unlock_packed_bools(15491, 15499) --Weaponized Tampa Heavy Chassis Armor, Brushstroke Camo Mk II Weapon Livery, Skull Mk II Weapon Livery, Sessanta Nove Mk II Weapon Livery, Perseus Mk II Weapon Livery, Leopard Mk II Weapon Livery, Zebra Mk II Weapon Livery, Geometric Mk II Weapon Livery, Boom! Mk II Weapon Livery
        unlock_packed_bools(15552, 15560) --Bronze Greatest Dancer Trophy, Bronze Number One Nightclub Trophy, Bronze Battler Trophy, Silver Greatest Dancer Trophy, Silver Number One Nightclub Trophy, Silver Battler Trophy, Gold Greatest Dancer Trophy, Gold Number One Nightclub Trophy, Gold Battler Trophy
        unlock_packed_bools(18099, 18099) --The Forest
        unlock_packed_bools(18116, 18118) --The Data Breaches, The Bogdan Problem, The Doomsday Scenario (Elite Challenges)
        unlock_packed_bools(18121, 18125) --Green Wireframe Bodysuit, Orange Wireframe Bodysuit, Blue Wireframe Bodysuit, Pink Wireframe Bodysuit, Yellow Wireframe Bodysuit
        unlock_packed_bools(18134, 18137) --Hideous Krampus Mask, Fearsome Krampus Mask, Odious Krampus Mask, Heinous Krampus Mask
        unlock_packed_bools(22124, 22132) --Maisonette Los Santos T-Shirt, Studio Los Santos T-Shirt, Galaxy T-Shirt, Gefängnis T-Shirt, Omega T-Shirt, Technologie T-Shirt, Paradise T-Shirt, The Palace T-Shirt, Tony's Fun House T-Shirt
        unlock_packed_bools(22137, 22139) --Nightclub Hotspot Trophy
        unlock_packed_bools(24963, 25000) --Apocalypse Cerberus, Future Shock Cerberus, Apocalypse Brutus, Nightmare Cerberus, Apocalypse ZR380, Future Shock Brutus, Impaler, Bolt Burger Hunger T-Shirt, Apocalypse Sasquatch - Livery set, Rat-Truck, Glendale, Slamvan, Dominator, Issi Classic, Spacesuit Alien T-Shirt set, Gargoyle, Future Shock Deathbike - Light Armor w/ Shield, Blue Lights, Electric Blue Lights, Mint Green Lights, Lime Green Lights, Yellow Lights, Golden Shower Lights, Orange Lights, Red Lights, Pony Pink Lights, Hot Pink Lights, Purple Lights, Blacklight Lights, Taxi Custom, Dozer, Clown Van, Trashmaster, Barracks Semi, Mixer, Space Docker, Tractor, Nebula Bodysuit set
        unlock_packed_bools(25002, 25002) --Up-n-Atomizer
        unlock_packed_bools(25005, 25006) --Epsilon Robes, Kifflom T-Shirt
        unlock_packed_bools(25008, 25009) --The Rookie
        unlock_packed_bools(25018, 25099) --Black & White Bones Festive Sweater, Slasher Festive Sweater, Black & Red Bones Festive Sweater, Red Bones Festive Sweater, Burger Shot Festive Sweater, Red Bleeder Festive Sweater, Blue Bleeder Festive Sweater, Blue Cluckin' Festive Sweater, Green Cluckin' Festive Sweater, Blue Slaying Festive Sweater, Green Slaying Festive Sweater, Hail Santa Festive Sweater, Merry Sprunkmas Festive Sweater, Ice Cold Sprunk Festive Sweater, Albany T-Shirt, Albany Vintage T-Shirt, Annis T-Shirt, Benefactor T-Shirt, BF T-Shirt, Bollokan T-Shirt, Bravado T-Shirt, Brute T-Shirt, Buckingham T-Shirt, Canis T-Shirt, Chariot T-Shirt, Cheval T-Shirt, Classique T-Shirt, Coil T-Shirt, Declasse T-Shirt, Dewbauchee T-Shirt, Dilettante T-Shirt, Dinka T-Shirt, Dundreary T-Shirt, Emperor T-Shirt, Enus T-Shirt, Fathom T-Shirt, Gallivanter T-Shirt, Grotti T-Shirt, Hijak T-Shirt, HVY T-Shirt, Imponte T-Shirt, Invetero T-Shirt, Jobuilt T-Shirt, Karin T-Shirt, Lampadati T-Shirt, Maibatsu T-Shirt, Mamba T-Shirt, Mammoth T-Shirt, MTL T-Shirt, Obey T-Shirt, Ocelot T-Shirt, Overflod T-Shirt, Pegassi T-Shirt, Pfister T-Shirt, Progen T-Shirt, Rune T-Shirt, Schyster T-Shirt, Shitzu T-Shirt, Truffade T-Shirt, Ubermacht T-Shirt, Vapid T-Shirt, Vulcar T-Shirt, Weeny T-Shirt, Willard T-Shirt, Albany Nostalgia T-Shirt, Albany USA T-Shirt, Albany Dealership T-Shirt, Annis JPN T-Shirt, BF Surfer T-Shirt, Bollokan Prairie T-Shirt, Bravado Stylized T-Shirt, Brute Impregnable T-Shirt, Brute Heavy Duty T-Shirt, Buckingham Luxe T-Shirt, Canis USA T-Shirt, Canis American Legend T-Shirt, Canis Wolf T-Shirt, Cheval Marshall T-Shirt, Coil USA T-Shirt, Coil Raiden T-Shirt, Declasse Logo T-Shirt, Declasse Girl T-Shirt
        unlock_packed_bools(25101, 25109) --Nightmare Brutus, Apocalypse Scarab, Future Shock Scarab, Nightmare Scarab, Future Shock ZR380, Nightmare ZR380, Apocalypse Imperator, Future Shock Imperator, Nightmare Imperator
        unlock_packed_bools(25111, 25134) --Future Shock Deathbike - Reinforced Armor w/ Shield, Future Shock Deathbike - Heavy Armor w/ Shield, Future Shock Sasquatch - Livery set, Nightmare Sasquatch - Livery set, Apocalypse Cerberus - Livery set, Future Shock Cerberus - Livery set, All variants of Sasquatch - Light Armor, All variants of Sasquatch - Reinforced Armor, All variants of Sasquatch - Heavy Armor, Nightmare Cerberus - Livery set, Apocalypse Bruiser - Livery set, Future Shock Bruiser - Livery set, Nightmare Bruiser - Livery set, Apocalypse Slamvan - Livery set, All variants of Cerberus - Body Spikes, Future Shock Slamvan - Livery set, All variants of Cerberus - Light Armor, All variants of Cerberus - Reinforced Armor, All variants of Cerberus - Heavy Armor, Nightmare Slamvan - Livery set, Apocalypse Brutus - Livery set, Future Shock Brutus - Livery set, Nightmare Brutus - Livery set, Apocalypse Scarab - Livery set
        unlock_packed_bools(25136, 25179) --All variants of Bruiser - Body Spikes, Future Shock Scarab - Livery set, Nightmare Scarab - Livery set, All variants of Bruiser - Light Armor, All variants of Bruiser - Reinforced Armor, All variants of Bruiser - Heavy Armor, Apocalypse Dominator - Livery set, Future Shock Dominator - Livery set, Nightmare Dominator - Livery set, Apocalypse Impaler - Livery set, Future Shock Impaler - Livery set, Nightmare Impaler - Livery set, All variants of Slamvan - Body Spikes, Apocalypse Imperator - Livery set, Future Shock Imperator - Livery set, All variants of Slamvan - Light Armor, All variants of Slamvan - Reinforced Armor, All variants of Slamvan - Heavy Armor, Nightmare Imperator - Livery set, Apocalypse ZR380 - Livery set, Future Shock ZR380 - Livery set, Nightmare ZR380 - Livery set, Apocalypse Issi - Livery set, Future Shock Issi - Livery set, All variants of Brutus - Light Armor, All variants of Brutus - Reinforced Armor, All variants of Brutus - Heavy Armor, Nightmare Issi - Livery set, Apocalypse Deathbike - Livery set, Future Shock Deathbike - Livery set, Nightmare Deathbike - Livery set, All variants of Sasquatch - Heavy Armored Front, Apocalypse Scarab - Body Spikes set, Future Shock Scarab - Body Spikes set, Nightmare Scarab - Body Spikes set, All variants of Sasquatch - Heavy Armored Hood, All variants of Sasquatch - Mohawk Exhausts, All variants of Scarab - Light Armor, All variants of Scarab - Reinforced Armor, All variants of Scarab - Heavy Armor, All variants of Sasquatch - Dual Mohawk Exhausts, Apocalypse & Nightmare Sasquatch - Rear Spears Left, Optics Headset Mask set, All variants of Dominator - Body Spikes
        unlock_packed_bools(25181, 25237) --Apocalypse & Nightmare Sasquatch - Rear Spears Right, Apocalypse & Nightmare Sasquatch - Skull Cross, All variants of Dominator - Light Armor, All variants of Dominator - Reinforced Armor, All variants of Dominator - Heavy Armor, Apocalypse & Nightmare Sasquatch - Ram Skull Cross, Apocalypse & Nightmare Sasquatch - Blonde Doll Cross, All variants of Impaler - Body Spikes, Apocalypse & Nightmare Sasquatch - Brunette Doll Cross, Apocalypse & Nightmare Cerberus - Bastioned Ram-bars, All variants of Impaler - Light Armor, All variants of Impaler - Reinforced Armor, All variants of Impaler - Heavy Armor, All variants of Cerberus - Bolstered Hood Cage, All variants of Cerberus - Reinforced Riot Hood, All variants of Cerberus - Juggernaut Hood, Apocalypse & Nightmare Cerberus - War Spearheads, All variants of Imperator - Body Spikes, Apocalypse & Nightmare Cerberus - War Spear Kit, Apocalypse & Nightmare Cerberus - Nade Spearheads, Apocalypse & Nightmare Cerberus - Nade Spear Kit, All variants of Imperator - Light Armor, All variants of Imperator - Reinforced Armor, All variants of Imperator - Heavy Armor, Apocalypse & Nightmare Cerberus - Skull Spearheads, Apocalypse & Nightmare Cerberus - Skull Spear Kit, Apocalypse & Nightmare Cerberus - Arrow Spearheads, Apocalypse & Nightmare Cerberus - Arrow Spear Kit, All variants of ZR380 - Body Spikes, Apocalypse & Nightmare Cerberus - Tridents, Apocalypse & Nightmare Cerberus - Wasteland Ritual, All variants of ZR380 - Light Armor, All variants of ZR380 - Reinforced Armor, All variants of ZR380 - Heavy Armor, Future Shock Cerberus - Panel Detail, Future Shock Cerberus - Crane Pipes, All variants of Issi - Body Spikes, Future Shock Cerberus - Hedgehog, Future Shock Cerberus - Hedgehog MK2, Future Shock Bruiser - Heavy Plated Armored Grille / Apocalypse & Nightmare Bruiser - Diamond Heavy Armor Grille, All variants of Issi - Light Armor, All variants of Issi - Reinforced Armor, All variants of Issi - Heavy Armor, All variants of Bruiser - Twin Oval Exhaust, Cluckin' Bell Mask, All variants of Bruiser - Long Triple Rear Exhausts, All variants of Bruiser - Front & Rear Triple Exhausts, All variants of Deathbike - Light Armor, All variants of Deathbike - Reinforced Armor, All variants of Deathbike - Heavy Armor, Kinetic Mines, Apocalypse Bruiser - Skull & Cross / Nightmare Bruiser - Painted Skull & Cross, Spike Mines, Slick Mines, Sticky Mines, EMP Mines, RC Bandito
        unlock_packed_bools(25244, 25400) --Robot Bodysuit set, Hero Bodysuit set, Shapes Bodysuit set, Contours Bodysuit set, Martian Bodysuit set, Reptile Bodysuit set, Galaxy Bodysuit set, Space Creature Suits, Space Cyclops Suits, Space Horror Suits, Retro Spacesuits, Astronaut Suits, Space Traveler Suits, Character Suits: Pogo Space Monkey, Character Suits: Republican Space Ranger, Death Bird Mask set, Stalker Mask set, Raider Mask set, Marauder Mask set, Paco the Taco Mask, Burger Shot Mask, Space Rangers T-Shirt set, Space Ranger Logo T-Shirt set, Phases T-Shirt set, Rocket Splash T-Shirt set, Two Moons T-Shirt set, Freedom Isn't Free T-Shirt set, Apocalyptic Raider Top set, Apocalyptic Leather Feather Top set, Apocalyptic Mercenary Vest set, Benedict Light Beer Hoodie, Taco Bomb Hoodie, Cluckin' Bell Logo Bomb Hoodie, Patriot Beer Hoodie, Pisswasser Hoodie, Burger Shot Hoodie, Corn Dog Hoodie, Donut Hoodie, Lucky Plucker Hoodie, Logger Light Hoodie, Pizza Hoodie, Fries Hoodie, Mushrooms Hoodie, Redwood Hoodie, eCola Infectious Hoodie, Cluckin' Bell Logo Hoodie, Lemons Hoodie, Tacos Hoodie, Burger Shot Pattern Sweater, Burger Shot Logo Sweater, Burger Shot Sweater, Sprunk Sweater set, Wigwam Sweater, Taco Bomb Chili Sweater, Taco Bomb Sweater set, Cluckin' Bell Logo Bomb Sweater, Blue Cluckin' Bell Sweater, Black Cluckin' Bell Sweater, eCola Sweater set, MeTV Sweater set, Heat Sweater set, Degenatron Sweater, Pisswasser Sweater set, Bolt Burger Sweater, Lucky Plucker Logo Bomb Sweater, Lucky Plucker Sweater, Burger Shot Hockey Shirt set, Cluckin' Bell Hockey Shirt set, Wigwam Hockey Shirt, Redwood Hockey Shirt, Bean Machine Hockey Shirt, Red eCola Hockey Shirt, Black eCola Hockey Shirt, Phat Chips Hockey Shirt set, Sprunk Hockey Shirt set, Sprunk Classic Hockey Shirt, Burger Shot Black T-Shirt, Burger Shot Logo T-Shirt, Cluckin' Bell Logo T-Shirt, Cluckin' Bell Black T-Shirt, Cluckin' Bell Filled Logo T-Shirt, eCola Black T-Shirt, Lucky Plucker T-Shirt, Pisswasser T-Shirt, Sprunk T-Shirt, Taco Bomb Chili T-Shirt, Taco Bomb Black T-Shirt, Up-n-Atom Hamburgers T-Shirt, Up-n-Atom Logo T-Shirt, Wigwam T-Shirt, Degenatron ROYGBIV T-Shirt, CNT T-Shirt, Qub3d T-Shirt, Righteous Slaughter T-Shirt, Space Monkey Full T-Shirt, Space Monkey Pixel T-Shirt, Space Monkey Enemy T-Shirt, Burger Shot Bleeder T-Shirt, Heat Rises T-Shirt, Space Monkey Logo T-Shirt, Space Monkey Suit T-Shirt, Space Monkey Face T-Shirt, Space Monkey Mosaic T-Shirt, Bolt Burger Logo T-Shirt, Exsorbeo 720 T-Shirt, Heat Ball Logo T-Shirt set, Heat Logo T-Shirt set, Heat Pop Art Logo T-Shirt set, MeTV Logo T-Shirt set, MeTV 90s T-Shirt set, Burger Shot Target T-Shirt, eCola Infectious T-Shirt, Up-n-Atom White T-Shirt, Jock Cranley Patriot T-Shirt, CCC TV T-Shirt, Degenatron Logo T-Shirt, eCola White T-Shirt, eCola Pass It On T-Shirt, Tw@ T-Shirt, Chain Pants set, Chain Shorts set, Leather Stitch Pants set, Raider Pants set, Light Ups Shoes set, Flaming Skull Boots set, Skull Harness Boots set, Plated Boots set, Burger Shot Food Cap set, Apocalypse Bruiser - Double Cross Ram Skull / Nightmare Bruiser - Painted Ram Skull & Cross, Burger Shot Logo Cap, Burger Shot Bullseye Cap, Cluckin' Bell Logo Cap set, Apocalypse Bruiser - Cross & Skull Large Blade Kit / Nightmare Bruiser - Painted Skull Large Blade Kit, Cluckin' Bell Logos Cap, Hotdogs Cap set, Taco Bomb Cap set, Apocalypse Bruiser - Ram Skull Nade Kit / Nightmare Bruiser - Painted Ram Skull Nade Kit, Apocalypse Bruiser - Ram Skull Medieval Kit / Nightmare Bruiser - Painted Skull Medieval Kit, Lucky Plucker Cap set, Lucky Plucker Logos Cap set, Apocalypse Bruiser - Ram Skull Medieval Madness / Nightmare Bruiser - Painted Skull Medieval Madness, Apocalypse Bruiser - Barrels & Junk, Pisswasser Cap set, Apocalypse Bruiser - Skeleton Cage, Future Shock Bruiser - Light Cover, Future Shock Bruiser - Spare Tire, Taco Canvas Hat, Burger Shot Canvas Hat, Cluckin' Bell Canvas Hat, Hotdogs Canvas Hat, Shunt Boost, Boost Upgrade 20%, Boost Upgrade 60%, Boost Upgrade 100%, Jump Upgrade 20%, Jump Upgrade 60%, Jump Upgrade 100%
        unlock_packed_bools(25405, 25405) --Festive tint (Up-n-Atomizer)
        unlock_packed_bools(25407, 25511) --Future Shock Bruiser - Crates, Nightmare Bruiser - Large Burger, Nightmare Bruiser - Large Doughnuts, Nightmare Bruiser - Large eCola Cans, All variants of Slamvan - Rear Bumper Reinforced Armor, All variants of Slamvan - Rear Bumper Heavy Armor, Apocalypse Slamvan - Basic Spears, Apocalypse Slamvan - Battle Cross, Apocalypse Slamvan - War Cross, Apocalypse Slamvan - Battle Spears, Apocalypse Slamvan - War Spears, Nightmare Slamvan - Knife Spears, Nightmare Slamvan - Fork & Knife, Apocalypse & Nightmare Brutus - Gassed Up Bar, Apocalypse & Nightmare Brutus - Roadblock, Apocalypse & Nightmare Brutus - Junk Trunk, Apocalypse & Nightmare Brutus - Fire Spitters, Apocalypse & Nightmare Brutus - Hell Chambers, Apocalypse & Nightmare Brutus - Heavy Armored Arches, Apocalypse & Nightmare Brutus - Toothy, Apocalypse & Nightmare Brutus - Armored Spares, Apocalypse & Nightmare Brutus - Armored Supplies, Apocalypse & Nightmare Brutus - Eternally Chained, Apocalypse & Nightmare Brutus - Speared, Future Shock Scarab - Primary Full Armor, All variants of Scarab - Secondary Full Armor, All variants of Scarab - Carbon Full Armor, Future Shock Scarab - Heavy Duty Cooling / Apocalypse & Nightmare Scarab - Air Filtration Vents & Long Range Equipment, Apocalypse & Nightmare Scarab - Rusty Full Armor, Apocalypse & Nightmare Scarab - Rear War Poles, Apocalypse & Nightmare Scarab - Rear Spears, Apocalypse & Nightmare Scarab - Skull Cross, Apocalypse & Nightmare Scarab - Skull Cross w/ War Poles, Apocalypse & Nightmare Scarab - Skull Cross w/ Spears, Apocalypse & Nightmare Scarab - Load'a War Poles, Apocalypse & Nightmare Scarab - Load'a Spears, Apocalypse & Nightmare Scarab - Scarab Mega Cover set, Apocalypse & Nightmare Scarab - Armored Mega Cover set, Apocalypse & Nightmare Scarab - Cage, Apocalypse & Nightmare Scarab - Plated Cage, Future Shock Scarab - Livery Armor, Future Shock Scarab - Primary Full Armor, Future Shock Scarab - Livery Full Armor, Future Shock Scarab - Carbon Full Armor, Future Shock Scarab - Matte Full Armor, Future Shock Scarab - Futuristic Panel Armor, Future Shock Scarab - Plated Livery Full Armor, All variants of Dominator - Triple Front Exhausts, All variants of Dominator - Horn Exhausts, All variants of Dominator - Triple Rear Exhausts, Apocalypse & Nightmare Dominator - Rear Pointing War Poles, Apocalypse & Nightmare Dominator - Front Facing Axes, Apocalypse & Nightmare Dominator - Front Facing Spears, Apocalypse & Nightmare Dominator - Unholy Cross, Apocalypse & Nightmare Dominator - Brutal Unholy Cross, Apocalypse & Nightmare Dominator - Bunch of War Poles, Apocalypse & Nightmare Dominator - Front Pointing War Poles, Apocalypse & Nightmare Dominator - Skull Hood, Apocalypse & Nightmare Impaler - Got Pole?, Apocalypse & Nightmare Impaler - Getting Medieval, Apocalypse & Nightmare Impaler - Wasteland Peacock, Apocalypse & Nightmare Impaler - Shish-Kebbabed, Apocalypse & Nightmare Impaler - It's A Stick Up, Apocalypse & Nightmare Impaler - The Dark Ages, Apocalypse & Nightmare Impaler - Dolly Spearton, Apocalypse & Nightmare Impaler - War Poles, All variants of Imperator - Shakotan Exhaust, Apocalypse & Nightmare Imperator - Whole Lotta Pole, Apocalypse & Nightmare Imperator - Getting Medieval, Apocalypse & Nightmare Imperator - It's A Stick Up, Apocalypse & Nightmare Imperator - Boom On A Spear, Apocalypse & Nightmare Imperator - Village Justice, Apocalypse & Nightmare Imperator - Wasteland Peacock, Apocalypse & Nightmare Imperator - Shish-Kebbabed, Apocalypse & Nightmare Imperator - Junk Pipes, Apocalypse & Nightmare Imperator - Mega Zorst, Apocalypse & Nightmare Imperator - Ride 'Em Cowboy, Apocalypse & Nightmare Imperator - Cannibal Totem, All variants of ZR380 - Side Exhausts, All variants of ZR380 - Spike Exhausts, Apocalypse & Nightmare ZR380 - Mismatch, Future Shock ZR380 - Ray Gun Exhausts, Future Shock ZR380 - Sprint Car Wing, Future Shock ZR380 - Armor Plating Mk. 3, Future Shock ZR380 - Rear Phantom Covers, All variants of Issi - Heavy Duty Ram Bar, Apocalypse & Nightmare Issi - Spear, Apocalypse & Nightmare Issi - Left War Poles, Apocalypse & Nightmare Issi - Dolly Spearton, Apocalypse & Nightmare Issi - Right War Poles, Apocalypse & Nightmare Issi - Skull Cross, Apocalypse & Nightmare Issi - Dolly Spearton Set, Apocalypse & Nightmare Issi - Dual War Poles, Apocalypse & Nightmare Issi - Dolly Spearton W/ War Pole, Apocalypse & Nightmare Issi - Skull Cross W/ Spear, Apocalypse & Nightmare Issi - Skull Cross W/ War Pole, Apocalypse & Nightmare Issi - Skull Cross W/ Dolly, Apocalypse & Nightmare Issi - Left Spear, Apocalypse & Nightmare Issi - Right Spear, Apocalypse & Nightmare Issi - Left Skull Axe, Apocalypse & Nightmare Issi - Right Axe, Apocalypse & Nightmare Issi - Dual Spears, Apocalypse & Nightmare Issi - Spear & Axe, Apocalypse & Nightmare Issi - Axe & Spear, Apocalypse & Nightmare Issi - Dual Axes
        unlock_packed_bools(25516, 25516) --RC Tank
        unlock_packed_bools(25520, 25521) --Metal Detector
        unlock_packed_bools(26811, 26964) --Action Figures, Playing Cards
        unlock_packed_bools(28099, 28148) --Signal Jammers
        unlock_packed_bools(28222, 28222) --Pixtro and Akedo T-Shirts
        unlock_packed_bools(26968, 27088) --Impotent Rage Outfit, High Roller, Tiger Scuba, Sprunk Racing Suit, Neon Bodysuit, Extreme Strike Vest, The Chimera (Outfit), White Racing Suit, The Reconnaissance (Outfit), Blue Jock Cranley Suit, Italian Biker Suit, The Hazard (Outfit), Mid Strike Vest, Splinter Gorka Suit, The Gunfighter (Outfit), Black Plate Carrier*, Hunter Leather Fur Jacket, Chamois Plate Carrier*, Black Heavy Utility Vest, The Puff (Outfit), Ox Blood Patched Cut, Color Geo PRB Leather, Blue Tactical Blouson, Orange Big Cat*, Color Geo Sweater, Vivid Gradient Puffer, Color Diamond Sweater, Classic SN Print Sweater, Power Motocross, The Buzz (Outfit), Pegassi Racing Jacket, Woodland Camo Parka, Le Chien Print Sweater, The Pincer (Outfit), Vibrant Gradient Shortsleeve, Urban Gradient Shortsleeve, White Chevron SC Track, Slalom Motocross, Blue Savanna Shortsleeve, Green Didier Sachs Field, Candy Motocross, Tutti Frutti Pattern Sweater, The Vespucci (Outfit), Contrast Camo Service Shirt, Tropical Pattern Sweater, Black Service Shirt, SecuroServ 1 (Outfit), Black Sports Blagueurs Hoodie, Gold Shiny T-Shirt, OJ Shortsleeve, Primary Squash Hoodie, Purple Camo Bigness Hoodie, Bold Abstract Bigness Hoodie, Pink SN Hoodie, Red Boating Blazer, Multicolor Leaves Shortsleeve, Neon Leaves Güffy Hoodie, Black Dotted Shortsleeve, Drive Motocross, Red Patterned Shortsleeve, Steel Horse Satin Jacket, Orange Squash Hoodie, Regal Loose Shirt, White Güffy Hoodie, Stealth Utility Vest, Red Floral Sweater, Black & Red Bigness Jersey, The Slick (Outfit), Splat Squash Sweater, Tan Hooded Jacket, Brushstroke Combat Shirt, White & Red Bigness Jersey, Black Combat Top, Lime Longline Hoodie, Red Bold Check, Bold Camo Sand Castle Sweater, Red Combat Shirt, Red Mist XI Dark, Cyan Manor Sweater, Flecktarn Sleeveless Shirt, Forest Camo Battle Vest, LS Jardineros Dark, Liberty Cocks Dark, Angelica T-Shirt, Hinterland Ship Sweater, Wine Sleeveless Shirt, Cobble Sleeveless, Black Dense Logo Sweater*, White Flying Bravo Hoodie, Cat T-Shirt*, Color Geo T-Shirt, Bold Abstract Bigness T-Shirt, Neon Leaves Güffy T-Shirt, Black Baggy Hoodie, White Manor Zigzag T-Shirt, Double P Baseball Shirt, Aqua Camo Rolled Tee, Dark Woodland T-Shirt, White Bigness T-Shirt, Black No Retreat Tank, White Benny's T-Shirt, Red Smuggler Tank, Angels of Death Vivid Tee, Blue Hit & Run Tank, Waves T-Shirt*, Beige Turtleneck, Hinterland Nugget T-Shirt, Mustard Güffy Tank, Nagasaki White and Red Hoodie, Grotti Tee, Western Logo Black Tee, Butchery and other Hobbies, Black Ammu-Nation Hoodie*, Fake Santo Capra T-Shirt, Death Defying T-Shirt, Bahama Mamas, Showroom T-Shirt, LS UR Tee, J Lager Beer Hat, Unicorn, Gingerbread
        unlock_packed_bools(27109, 27115) --The Diamond Classic T-Shirt, The Diamond Vintage T-Shirt, Red The Diamond LS T-Shirt, Blue The Diamond Resort LS T-Shirt, Red The Diamond Resort T-Shirt, Blue D Casino T-Shirt, Red The Diamond Classic T-Shirt
        unlock_packed_bools(27120, 27145) --White The Diamond Hoodie, Black The Diamond Hoodie, Ash The Diamond Hoodie, Gray The Diamond Hoodie, Red The Diamond Hoodie, Orange The Diamond Hoodie, Blue The Diamond Hoodie, Black The Diamond Silk Robe, White The Diamond Cap, Black The Diamond Cap, White LS Diamond Cap, Black LS Diamond Cap, Red The Diamond Cap, Orange The Diamond Cap, Blue LS Diamond Cap, Green The Diamond Cap, Orange LS Diamond Cap, Purple The Diamond Cap, Pink LS Diamond Cap, White The Diamond LS Tee*, Black The Diamond LS Tee, Black The Diamond Resort LS Tee, White The Diamond Resort Tee, Black The Diamond Resort Tee, Black LS Diamond Tee, Black D Casino Tee
        unlock_packed_bools(27184, 27213) --Invade and Persuade Enemies T-Shirt, Invade and Persuade Oil T-Shirt, Invade and Persuade Tour T-Shirt, Invade and Persuade Green T-Shirt, Invade and Persuade RON T-Shirt, Street Crimes Hoods T-Shirt, Street Crimes Punks T-Shirt, Street Crimes Yokels T-Shirt, Street Crimes Bikers T-Shirt, Street Crimes Action T-Shirt, Street Crimes Boxart T-Shirt, Street Crimes Logo T-Shirt, Claim What's Yours T-Shirt, Choose Your Side T-Shirt, Street Crimes Color Gangs T-Shirt, Street Crimes Red Gangs T-Shirt, White Street Crimes Icons T-Shirt, Black Street Crimes Icons T-Shirt, Invade and Persuade Logo T-Shirt, Mission I T-Shirt, Mission II T-Shirt, Mission IV T-Shirt, Mission III T-Shirt, Invade and Persuade Boxart T-Shirt, Invade and Persuade Invader T-Shirt, Invade and Persuade Suck T-Shirt, Invade and Persuade Jets T-Shirt, Invade and Persuade Gold T-Shirt, Invade and Persuade Hero T-Shirt, Invade and Persuade Barrels T-Shirt
        unlock_packed_bools(27247, 27247) --Madam Nazar (Arcade Trophy)
        unlock_packed_bools(28158, 28158) --Navy Revolver
        unlock_packed_bools(28171, 28191) --Green Reindeer Lights Bodysuit, Ho-Ho-Ho Sweater, Traditional Festive Lights Bodysuit, Yellow Reindeer Lights Bodysuit, Neon Festive Lights Bodysuit, Plushie Grindy T-Shirt, Plushie Saki T-Shirt , Plushie Humpy T-Shirt, Plushie Smoker T-Shirt, Plushie Poopie T-Shirt, Plushie Muffy T-Shirt, Plushie Wasabi Kitty T-Shirt, Plushie Princess T-Shirt, Plushie Master T-Shirt, Pixel Pete's T-Shirt, Wonderama T-Shirt, Warehouse T-Shirt, Eight Bit T-Shirt, Insert Coin T-Shirt, Videogeddon T-Shirt, Nazar Speaks T-Shirt
        unlock_packed_bools(28194, 28196) --Silent & Sneaky, The Big Con, Aggressive (Elite Challenges)
        unlock_packed_bools(28197, 28222) --Badlands Revenge II Gunshot T-Shirt, Badlands Revenge II Eagle T-Shirt, Badlands Revenge II Pixtro T-Shirt, Badlands Revenge II Romance T-Shirt, Badlands Revenge II Bear T-Shirt, Badlands Revenge II Help Me T-Shirt & Badlands Revenge II Retro T-Shirt, Race and Chase Decor T-Shirt, Race and Chase Vehicles T-Shirt, Race and Chase Finish T-Shirt, Crotch Rockets T-Shirt, Street Legal T-Shirt & Get Truckin' T-Shirt, Wizard's Ruin Loot T-Shirt, The Wizard's Ruin Rescue T-Shirt, The Wizard's Ruin Vow T-Shirt, Thog Mighty Sword T-Shirt, Thog T-Shirt & Thog Bod T-Shirt, Space Monkey 3 T-Shirt, Space Monkey Space Crafts T-Shirt, Space Monkey Pixel T-Shirt, Space Monkey Boss Fights T-Shirt, Radioactive Space Monkey T-Shirt & Space Monkey Art T-Shirt, Monkey's Paradise T-Shirt, Retro Defender of the Faith T-Shirt, Penetrator T-Shirt, Defender of the Faith T-Shirt, Love Professor His T-Shirt & Love Professor Hers T-Shirt, Love Professor Nemesis T-Shirt, Love Professor Friendzoned T-Shirt, Love Professor Secrets T-Shirt & Love Professor Score T-Shirt, Shiny Wasabi Kitty Claw T-Shirt, Pixtro T-Shirt, Akedo T-Shirt & Arcade Trophy T-Shirt
        unlock_packed_bools(28224, 28227) --White Dog With Cone T-Shirt, Yellow Dog With Cone T-Shirt, Dog With Cone Slip-Ons & Dog With Cone Chain, Refuse Collectors Outfit, Undertakers Outfit, Valet Outfit
        unlock_packed_bools(28229, 28249) --Prison Guards, FIB Suits, Black Scuba, Gruppe Sechs Gear, Bugstars Uniforms, Maintenance Outfit, Yung Ancestors Outfit, Firefighter Outfit, Orderly Armor Outfit, Upscale Armor Outfit, Evening Armor Outfit, Reinforced: Padded Combat Outfit, Reinforced: Bulk Combat Outfit, Reinforced: Compact Combat Outfit, Balaclava Crook Outfit, Classic Crook Outfit, High-end Crook Outfit, Infiltration: Upgraded Tech Outfit, Infiltration: Advanced Tech Outfit, Infiltration: Modernized Tech Outfit, Degenatron Glitch T-Shirt
        unlock_packed_bools(28254, 28255) --Get Metal T-Shirt / Axe of Fury T-Shirt, 11 11 T-Shirt / Axe of Fury T-Shirt
        unlock_packed_bools(30230, 30251) --Movie Props, Space Interloper Outfit
        unlock_packed_bools(30254, 30295) --King Of QUB3D T-Shirt, Qubism T-Shirt, God Of QUB3D T-Shirt, QUB3D Boxart T-Shirt, Qub3d Qub3s T-Shirt, Yacht Captain Outfit, BCTR Aged T-Shirt, BCTR T-Shirt, Cultstoppers Aged T-Shirt, Cultstoppers T-Shirt, Daily Globe Aged T-Shirt, Daily Globe T-Shirt, Eyefind Aged T-Shirt, Eyefind T-Shirt, Facade Aged T-Shirt, Facade T-Shirt, Fruit Aged T-Shirt, Fruit T-Shirt, LSHH Aged T-Shirt, LSHH T-Shirt, MyRoom Aged T-Shirt, MyRoom T-Shirt, Rebel Aged T-Shirt, Rebel T-Shirt, Six Figure Aged T-Shirt, Six Figure T-Shirt, Trash Or Treasure Aged T-Shirt, Trash Or Treasure T-Shirt, Tw@ Logo Aged T-Shirt, Tw@ Logo T-Shirt, Vapers Den Aged T-Shirt, Vapers Den T-Shirt, WingIt Aged T-Shirt, WingIt T-Shirt, ZiT Aged T-Shirt, ZiT T-Shirt, Green Dot Tech Mask, Orange Dot Tech Mask, Blue Dot Tech Mask, Pink Dot Tech Mask, Lemon Sports Track Pants, Lemon Sports Track Top
        unlock_packed_bools(30524, 30557) --Grotti Aged T-Shirt, Lampadati Aged T-Shirt, Ocelot Aged T-Shirt, Overflod Aged T-Shirt, Pegassi Aged T-Shirt, Pfister Aged T-Shirt, Vapid Aged T-Shirt, Weeny Aged T-Shirt, Blue The Diamond Resort LS Aged T-Shirt, KJAH Radio Aged T-Shirt, K-Rose Aged T-Shirt, Emotion 98.3 Aged T-Shirt, KDST Aged T-Shirt, Bounce FM Aged T-Shirt, Fake Vapid Aged T-Shirt, I Married My Dad Aged T-Shirt, ToeShoes Aged T-Shirt, Vanilla Unicorn Aged T-Shirt, Steel Horse Solid Logo Aged T-Shirt, Black Western Logo Aged T-Shirt, White Nagasaki Aged T-Shirt, Black Principe Aged T-Shirt, Noise Aged T-Shirt, Noise Rockstar Logo Aged T-Shirt, Razor Aged T-Shirt, White Rockstar Camo Aged T-Shirt, LSUR Aged T-Shirt, Rebel Radio Aged T-Shirt, Channel X Aged T-Shirt, Albany Vintage Aged T-Shirt, Benefactor Aged T-Shirt, Bravado Aged T-Shirt, Declasse Aged T-Shirt, Dinka Aged T-Shirt
        unlock_packed_bools(30563, 30693) --Panther Varsity Jacket Closed, Panther Tour Jacket, Broker Prolaps Basketball Top, Panic Prolaps Basketball Top, Gussét Frog T-Shirt, Warped Still Slipping T-Shirt, Yellow Still Slipping T-Shirt, Black Rockstar T-Shirt, Black Exsorbeo 720 Logo T-Shirt, Manor PRBG T-Shirt, Manor Tie-dye T-Shirt, Open Wheel Sponsor T-Shirt, Rockstar Yellow Pattern T-Shirt, Rockstar Gray Pattern T-Shirt, Rockstar Rolling T-Shirt, Santo Capra Patterns Sweater, Rockstar Studio Colors Sweater, Bigness Jackal Sweater, Bigness Tie-dye Sweater, Bigness Faces Sweater, Broker Prolaps Basketball Shorts, Panic Prolaps Basketball Shorts, Exsorbeo 720 Sports Shorts, Bigness Tie-dye Sports Pants, Enus Yeti Forwards Cap, 720 Forwards Cap, Exsorbeo 720 Forwards Cap, Güffy Double Logo Forwards Cap, Rockstar Forwards Cap, Blue Bangles (L), Red Bangles (L), Pink Bangles (L), Yellow Bangles (L), Orange Bangles (L), Green Bangles (L), Red & Blue Bangles (L), Yellow & Orange Bangles (L), Green & Pink Bangles (L), Rainbow Bangles (L), Sunset Bangles (L), Tropical Bangles (L), Blue & Pink Glow Shades, Red Glow Shades, Orange Glow Shades, Yellow Glow Shades, Green Glow Shades, Blue Glow Shades, Pink Glow Shades, Blue & Magenta Glow Shades, Purple & Yellow Glow Shades, Blue & Yellow Glow Shades, Pink & Yellow Glow Shades, Red & Yellow Glow Shades, Blue Glow Necklace, Red Glow Necklace, Pink Glow Necklace, Yellow Glow Necklace, Orange Glow Necklace, Green Glow Necklace, Festival Glow Necklace, Carnival Glow Necklace, Tropical Glow Necklace, Hot Glow Necklace, Neon Glow Necklace, Party Glow Necklace, Sunset Glow Necklace, Radiant Glow Necklace, Sunrise Glow Necklace, Session Glow Necklace, Combat Shotgun, Perico Pistol, White Keinemusik T-Shirt, Blue Keinemusik T-Shirt, Moodymann T-Shirt, Palms Trax T-Shirt, Midnight Tint Oversize Shades, Sunset Tint Oversize Shades, Black Tint Oversize Shades, Blue Tint Oversize Shades, Gold Tint Oversize Shades, Green Tint Oversize Shades, Orange Tint Oversize Shades, Red Tint Oversize Shades, Pink Tint Oversize Shades, Yellow Tint Oversize Shades, Lemon Tint Oversize Shades, Gold Rimmed Oversize Shades, White Checked Round Shades, Pink Checked Round Shades, Yellow Checked Round Shades, Red Checked Round Shades, White Round Shades, Black Round Shades, Pink Tinted Round Shades, Blue Tinted Round Shades, Green Checked Round Shades, Blue Checked Round Shades, Orange Checked Round Shades, Green Tinted Round Shades, Brown Square Shades, Yellow Square Shades, Black Square Shades, Tortoiseshell Square Shades, Green Square Shades, Red Square Shades, Pink Tinted Square Shades, Blue Tinted Square Shades, White Square Shades, Pink Square Shades, All White Square Shades, Mono Square Shades, Green Calavera Mask, Navy Calavera Mask, Cherry Calavera Mask, Orange Calavera Mask, Purple Calavera Mask, Dark Blue Calavera Mask, Lavender Calavera Mask, Yellow Calavera Mask, Pink Calavera Mask, Neon Stitch Emissive Mask, Vibrant Stitch Emissive Mask, Pink Stitch Emissive Mask, Blue Stitch Emissive Mask, Neon Skull Emissive Mask, Vibrant Skull Emissive Mask, Pink Skull Emissive Mask, Orange Skull Emissive Mask, Dark X-Ray Emissive Mask, Bright X-Ray Emissive Mask, Purple X-Ray Emissive Mask
        unlock_packed_bools(30699, 30704) --Palms Trax LS T-Shirt, Moodymann Whatupdoe T-Shirt, Moodymann Big D T-Shirt, Keinemusik Cayo Perico T-Shirt, Still Slipping Blarneys T-Shirt, Still Slipping Friend T-Shirt
        unlock_packed_bools(31708, 31714) --CircoLoco Records - Blue EP, CircoLoco Records - Green EP, CircoLoco Records - Violet EP, CircoLoco Records - Black EP, Moodymann - Kenny's Backyard Boogie, NEZ - You Wanna?, NEZ ft. Schoolboy Q - Let's Get It
        unlock_packed_bools(31736, 31736) --The Frontier Outfit
        unlock_packed_bools(31755, 31755) --Auto Shop Race 'n Chase
        unlock_packed_bools(31760, 31764) --Faces of Death T-Shirt, Straight to Video T-Shirt, Monkey See Monkey Die T-Shirt, Trained to Kill T-Shirt, The Director T-Shirt
        unlock_packed_bools(31766, 31777) --Sprunk Forwards Cap, eCola Forwards Cap, Black Banshee T-Shirt, Blue Banshee T-Shirt, LS Customs T-Shirt, Rockstar Games Typeface T-Shirt, Wasted! T-Shirt, Baseball Bat T-Shirt, Knuckleduster T-Shirt, Rampage T-Shirt, Penitentiary Coveralls, LS Customs Coveralls
        unlock_packed_bools(31779, 31796) --The Ringleader Outfit, The Knuckles Outfit, The Breaker Outfit, The Dealer Outfit, Bearsy, Banshee Hoodie, eCola Varsity, Sprunk Varsity, LS Customs Varsity, LS Customs Tour Jacket, eCola Bodysuit, Sprunk Bodysuit, Sprunk Chute Bag, eCola Chute Bag, Halloween Chute Bag, Sprunk Chute, eCola Chute, Halloween Chute
        unlock_packed_bools(31805, 31808) --The Old Hand Outfit, The Overworked Outfit, The Longshoreman Outfit, The Underpaid Outfit
        unlock_packed_bools(31810, 31824) --Annis ZR350, Pfister Comet S2, Dinka Jester RR, Emperor Vectre, Ubermacht Cypher, Pfister Growler, Karin Calico GTF, Annis Remus, Vapid Dominator ASP, Karin Futo GTX, Dinka RT3000, Vulcar Warrener HKR, Karin Sultan RS Classic, Vapid Dominator GTT, Karin Previon
        unlock_packed_bools(31826, 31858) --Emperor Forwards Cap / Emperor Backwards Cap, Beige Knit Sneakers, Gray Emperor Classic Hoodie, Pursuit Series (Gameplay), Cyan Check Sleeveless Puffer, Dinka SPL (Wheel Mod), Blue Hayes Retro Racing, White Emperor Motors T-Shirt, Quick Fix (Gameplay), Cyan Check Puffer, Euros - Speed Trail (Livery), Never Barcode Print Hoodie, Hayes Modern Racing, Diversion (Gameplay), Gray Leather Bomber, Futo GTX - Chokusen Dorifuto (Livery), Karin Forwards Cap / Karin Backwards Cap, Cream Knit Sneakers, Private Takeover (Gameplay), Yellow Pfister Hoodie, Retro Turbofan (Wheel Mod), Red Check Sleeveless Puffer, White Hayes Retro Racing, Setup (Gameplay), Navy Emperor Motors T-Shirt, RT3000 - Stance Andreas (Livery), Red Check Puffer, Never Triangle Print Hoodie, Wingman (Gameplay), LTD Modern Racing, Jester RR - 10 Minute Car (Livery), Green Crowex Pro Racing Suit, Mustard Tan Leather Bomber
        unlock_packed_bools(31860, 31863) --Omnis Forwards Cap / Omnis Backwards Cap, Conical Turbofan (Wheel Mod), Black Knit Sneakers, Green Emperor Classic Hoodie
        unlock_packed_bools(31865, 31868) --Green Geo Sleeveless Puffer, ZR350 - Atomic Drift Team (Livery), White Globe Oil Retro Racing, Yellow Annis Rally T-Shirt
        unlock_packed_bools(31870, 31928) --Green Geo Puffer, Warrener HKR - Classic Vulcar (Livery), Life ZigZag Print Hoodie, Blue Dinka Modern Racing, Gray Benefactor Racing Suit, Orange Tan Leather Bomber, Ice Storm (Wheel Mod), Annis Forwards Cap / Annis Backwards Cap, Gray & Purple Knit Sneakers, Black Crowex Pro Racing Suit, Gray Pfister Hoodie, Calico GTF - Fukaru Rally (Livery), Black Geo Sleeveless Puffer, Green Crowex Retro Racing, Blue Xero Gas Racing Suit, Blue Annis Noise T-Shirt, Remus - Blue Lightning (Livery), Black Geo Puffer, Life Static Print Hoodie, Dark Benefactor Racing Suit, Red Dinka Modern Racing, Super Turbine (Wheel Mod), Chestnut Tan Leather Bomber, Vapid Forwards Cap / Vapid Backwards Cap, Red Xero Gas Racing Suit, Gray & Magenta Knit Sneakers, Dominator GTT - Oldschool Oval (Livery), Black Vapid Ellie Hoodie, Cream Bigness Sleeveless Puffer, Wildstyle Racing Suit, Red Globe Oil Retro Racing, Tailgater S - Crevis Race (Livery), Light Dinka T-Shirt, Cream Bigness Puffer, Modern Mesh (Wheel Mod), Never Crosshair Print Hoodie, Euros - Drift Tribe (Livery), Yellow Vapid Modern Racing, Dark Tan Leather Bomber, Forged Star (Wheel Mod), Light Dinka Forwards Cap / Light Dinka Backwards Cap, Futo GTX - Drift King (Livery), Gray & Aqua Knit Sneakers, Gray Karin Hoodie, Showflake (Wheel Mod), Purple Bigness Sleeveless Puffer, RT3000 - Atomic Motorsport (Livery), Black Crowex Retro Racing, Black Annis Noise T-Shirt, Giga Mesh (Wheel Mod), Purple Bigness Puffer, Jester RR - Yogarishima (Livery), Hiding Print Hoodie, Ubermacht Modern Racing, Mesh Meister (Wheel Mod), Ox Blood Leather Bomber, ZR350 - Kisama Chevrons (Livery), Dark Dinka Forwards Cap / Dark Dinka Backwards Cap, White & Pink Knit Sneakers
        unlock_packed_bools(31930, 31933) --Navy Vapid Ellie Hoodie, Warrener HKR - Classic Vulcar Alt (Livery), Green Aztec Sleeveless Puffer, Calico GTF - Disruption Rally (Livery)
        unlock_packed_bools(31935, 31938) --Blue Atomic Retro Racing, Remus - Annis Tech (Livery), Dark Dinka T-Shirt, Dominator GTT - Resto Mod Racer (Livery)
        unlock_packed_bools(31940, 31943) --Green Aztec Puffer, Tailgater S - Redwood (Livery), Life Binary Print Hoodie, Euros - King Scorpion (Livery)
        unlock_packed_bools(31945, 31948) --White Güffy Modern Racing, Futo GTX - Tandem Battle (Livery), Dark Nut Leather Bomber, RT3000 - Dinka Performance (Livery)
        unlock_packed_bools(31950, 31953) --White Güffy Forwards Cap / White Güffy Backwards Cap, Jester RR - Fuque (Livery), Gray & Yellow Knit Sneakers, ZR350 - Winning is Winning (Livery)
        unlock_packed_bools(31955, 31958) --Navy Karin Hoodie, Warrener HKR - Redwood Racing (Livery), Black Aztec Sleeveless Puffer, Calico GTF - Redwood Rally (Livery)
        unlock_packed_bools(31960, 31963) --Yellow Atomic Retro Racing, Remus - Atomic Motorsport (Livery), Light Vapid Ellie T-Shirt, Dominator GTT - Flame On (Livery)
        unlock_packed_bools(31965, 31968) --Black Aztec Puffer, Tailgater S - Disruption Logistics (Livery), Lucky Penny Print Hoodie, Euros - Sprunk Light (Livery)
        unlock_packed_bools(31970, 31973) --Black Güffy Modern Racing, Futo GTX - Itasha Drift (Livery), Navy Blue Leather Bomber, RT3000 - Shiny Wasabi Kitty (Livery)
        unlock_packed_bools(31975, 31978) --Black Güffy Forwards Cap / Black Güffy Backwards Cap, Jester RR - Xero Gas Rally (Livery), Grayscale Knit Sneakers, ZR350 - Annis Racing Tribal (Livery)
        unlock_packed_bools(31980, 31983) --Light Obey Hoodie, Warrener HKR - Vulcar Turbo (Livery), Cream Splinter Sleeveless Puffer, Calico GTF - Prolaps Rally (Livery)
        unlock_packed_bools(31985, 31988) --Blue Redwood Retro Racing, Remus - Shiny Wasabi Kitty (Livery), Dark Vapid Ellie T-Shirt, Dominator GTT - The Patriot (Livery)
        unlock_packed_bools(31990, 31993) --Cream Splinter Puffer, Tailgater S - Colored Camo Livery (Livery), Light Dinka Modern Racing, Euros - Candybox Gold (Livery)
        unlock_packed_bools(31995, 31998) --Dark Green Leather Bomber, Futo GTX - Stance Andreas (Livery), Hellion Forwards Cap / Hellion Backwards Cap, RT3000 - Total Fire (Livery)
        unlock_packed_bools(32000, 32003) --Gray & Cyan Knit Sneakers, Jester RR - Split Siberia (Livery), Black Ubermacht Hoodie, ZR350 - Annis Racing Tribal Alt (Livery)
        unlock_packed_bools(32005, 32008) --Dark Splinter Sleeveless Puffer, Warrener HKR - Vulcar Turbo Alt (Livery), White Logo Ruiner T-Shirt, Calico GTF - Xero Gas Rally (Livery)
        unlock_packed_bools(32010, 32013) --Dark Splinter Puffer, Remus - Fukaru Motorsport (Livery), Dark Dinka Modern Racing, Dominator GTT - 70s Street Machine (Livery)
        unlock_packed_bools(32015, 32018) --White Leather Bomber, Tailgater S - Army Camo Solid (Livery), Lampadati Forwards Cap / Lampadati Backwards Cap, Lilac Knit Sneakers
        unlock_packed_bools(32020, 32023) --Dark Obey Hoodie, Green Latin Sleeveless Puffer, Gray Vapid Truck T-Shirt, Green Latin Puffer
        unlock_packed_bools(32025, 32028) --Blue Bravado Modern Racing, Red Leather Bomber, White Knit Sneakers, Red Ubermacht Hoodie
        unlock_packed_bools(32030, 32033) --Black Latin Sleeveless Puffer, White Obey Omnis T-Shirt, Black Latin Puffer, Black Bravado Modern Racing
        unlock_packed_bools(32035, 32038) --Ice Knit Sneakers, Blue Annis Noise Hoodie, Orange Camo Sleeveless Puffer, Light Blue Vapid Truck T-Shirt
        unlock_packed_bools(32040, 32043) --Orange Camo Puffer, Imponte Modern Racing, Aqua Sole Knit Sneakers, Green Emperor Modern Hoodie
        unlock_packed_bools(32045, 32048) --Aqua Camo Sleeveless Puffer, Black Vapid USA T-Shirt, Aqua Camo Puffer, Xero Modern Racing
        unlock_packed_bools(32050, 32053) --Smoky Knit Sneakers, Gray Annis Noise Hoodie, Gradient Sleeveless Puffer, Red Obey Omnis T-Shirt
        unlock_packed_bools(32055, 32058) --Gradient Puffer, White & Gold Knit Sneakers, Dark Emperor Modern Hoodie, Red Logo Ruiner T-Shirt
        unlock_packed_bools(32060, 32063) --Orange Knit Sneakers, Light Dinka Hoodie, Blue Bravado Gauntlet T-Shirt, Pink Vibrant Knit Sneakers
        unlock_packed_bools(32065, 32074) --Gold Lampadati Hoodie, Black Bravado Gauntlet T-Shirt, Lime Highlight Knit Sneakers, Dark Dinka Hoodie, Pfister Pocket T-Shirt, Purple Fade Knit Sneakers, Karin 90s T-Shirt, Teal Knit Sneakers, Black & Lime Knit Sneakers, Cyan Fade Knit Sneakers
        unlock_packed_bools(32084, 32084) --Red Highlight Knit Sneakers
        unlock_packed_bools(32094, 32094) --Broker Forwards Cap / Broker Backwards Cap
        unlock_packed_bools(32104, 32104) --Annis Hellion 4x4 T-Shirt
        unlock_packed_bools(32114, 32114) --Pink Gradient Sleeveless Puffer
        unlock_packed_bools(32124, 32124) --Fade Broker Modern Racing
        unlock_packed_bools(32134, 32134) --Tricolor Lampadati Hoodie
        unlock_packed_bools(32144, 32144) --Mono Leather Bomber
        unlock_packed_bools(32154, 32154) --Pink Gradient Puffer
        unlock_packed_bools(32164, 32164) --Red Redwood Retro Racing
        unlock_packed_bools(32174, 32174) --Crash Out Print Hoodie
        unlock_packed_bools(32224, 32224) --Tuned For Speed Racing Suit
        unlock_packed_bools(32319, 32323) --police5 trade price
        unlock_packed_bools(34262, 34361) --LD Organics
        unlock_packed_bools(32273, 32273) --White Born x Raised T-Shirt
        unlock_packed_bools(32275, 32275) --Circoloco T-Shirt
        unlock_packed_bools(32287, 32287) --Dr. Dre
        unlock_packed_bools(32295, 32311) --Orange Goldfish, Purple Goldfish, Bronze Goldfish, Clownfish, Juvenile Gull, Sooty Gull, Black-headed Gull, Herring Gull, Brown Sea Lion, Dark Sea Lion, Spotted Sea Lion, Gray Sea Lion, Green Festive T-Shirt, Red Festive T-Shirt, Orange DJ Pooh T-Shirt, White WCC DJ Pooh T-Shirt, Blue WCC DJ Pooh T-Shirt
        unlock_packed_bools(32315, 32316) --Navy Coveralls, Gray Coveralls, Marathon Hoodie
        unlock_packed_bools(32366, 32366) --Declasse Draugur (Trade Price)
        unlock_packed_bools(34372, 34375) --Horror Pumpkin, Dinka Kanjo SJ (Trade Price), Dinka Postlude (Trade Price), Black LD Organics Cap / White LD Organics T-Shirt
        unlock_packed_bools(34378, 34411) --Junk Energy Chute Bag, Junk Energy Chute, Pumpkin T-Shirt, Pacific Standard Varsity, Pacific Standard Sweater, Cliffford Varsity, Cliffford Hoodie, The Diamond Casino Varsity, The Diamond Strike Vest, Strickler Hat, Sinsimito Cuban Shirt, CLO_E1M_O_MUM, Manor Geo Forwards Cap, Apricot Perseus Forwards Cap, Still Slipping Tie-dye Forwards Cap, Lemon Festive Beer Hat, Bigness Hand-drawn Dome, Grimy Stitched, Pale Stitched, Gray Cracked Puppet, Blushed Cracked Puppet, Green Emissive Lady Liberty, President, Gold Beat Off Earphones, White Spiked Gauntlet (L), Manor Geo Hoodie, Pumpkin Hoodie, LS Smoking Jacket, Hand-Drawn Biker Bomber, Have You Seen Me? Sweater, Still Slipping Tie-dye T-Shirt, Manor Geo Track Pants, Apricot Perseus Track Pants, Sasquatch
        unlock_packed_bools(34415, 34510) --Green Vintage Frank, Brown Vintage Frank, Gray Vintage Frank, Pale Vintage Mummy, Green Vintage Mummy, Weathered Vintage Mummy, Conquest, Death, Famine, War, Black Tech Demon, Gray Tech Demon, White Tech Demon, Green Tech Demon, Orange Tech Demon, Purple Tech Demon, Pink Tech Demon, Red Detail Tech Demon, Blue Detail Tech Demon, Yellow Detail Tech Demon, Green Detail Tech Demon, Pink Detail Tech Demon, Orange & Gray Tech Demon, Red Tech Demon, Camo Tech Demon, Aqua Camo Tech Demon, Brown Digital Tech Demon, Gold Tech Demon, Orange & Cream Tech Demon, Green & Yellow Tech Demon, Pink Floral Tech Demon, Black & Green Tech Demon, White & Red Tech Demon, Carbon Tech Demon, Carbon Teal Tech Demon, Black & White Tech Demon, Painted Tiger, Gray Painted Tiger, Gold Painted Tiger, Ornate Painted Tiger, Gray Yeti Flat Cap, Woodland Yeti Flat Cap, Green FB Flat Cap, Blue FB Flat Cap, Gray Lézard Flat Cap, Green Lézard Flat Cap, Light Plaid Lézard Flat Cap, Dark Plaid Lézard Flat Cap, White Striped Lézard Flat Cap, Red Striped Lézard Flat Cap, Brown Crevis Flat Cap, Gray Crevis Flat Cap, Black Broker Flat Cap, Burgundy Broker Flat Cap, White Beat Off Earphones, Yellow Beat Off Earphones, Salmon Beat Off Earphones, Orange Beat Off Earphones, Purple Beat Off Earphones, Pink Beat Off Earphones, Turquoise Beat Off Earphones, Blue Beat Off Earphones, Black Beat Off Earphones, Gray Beat Off Earphones, Teal Beat Off Earphones, Red Beat Off Earphones, Wild Striped Pool Sliders, Neon Striped Pool Sliders, Black SC Coin Pool Sliders, White SC Coin Pool Sliders, Black SC Pattern Pool Sliders, Pink SC Pattern Pool Sliders, Blue SC Pattern Pool Sliders, Camo Yeti Pool Sliders, Gray Camo Yeti Pool Sliders, Black Bigness Pool Sliders, Purple Bigness Pool Sliders, Camo Bigness Pool Sliders, Black Blagueurs Pool Sliders, White Blagueurs Pool Sliders, Pink Blagueurs Pool Sliders, Gray Cimicino Pool Sliders, Rouge Cimicino Pool Sliders, Navy DS Pool Sliders, Red DS Pool Sliders, Floral Güffy Pool Sliders, Green Güffy Pool Sliders, White Güffy Pool Sliders, Blue Heat Pool Sliders, Red ProLaps Pool Sliders, Black LD Organics T-Shirt, Green UFO Boxer Shorts, White UFO Boxer Shorts, Gray Believe Backwards Cap, Black Believe Backwards Cap, Glow Believe Backwards Cap
        unlock_packed_bools(34703, 34705) --White Vintage Vampire, Dark Green Vintage Vampire, Light Green Vintage Vampire
        unlock_packed_bools(34730, 34737) --Green Festive Beer Hat, Red Snowflake Beer Hat, Blue Snowflake Beer Hat, Red Holly Beer Hat, Pisswasser Festive Beer Hat, Blarneys Festive Beer Hat, Red Reindeer Beer Hat, Borfmas Beer Hat
        unlock_packed_bools(34761, 34761) --Gooch Outfit
        unlock_packed_bools(36630, 36654) --Snowman
        unlock_packed_bools(36699, 36770) --Ice Vinyl, Ice Vinyl Cut, Mustard Vinyl, Mustard Vinyl Cut, Dark Blue Vinyl, Dark Blue Vinyl Cut, Yellow SN Rooster Revere Collar, Red SC Dragon Revere Collar, Blue SC Dragon Revere Collar, Camo Roses Slab Denim, Orange Trickster Type Denim, Black VDG Cardigan, Blue DS Panthers Cardigan, Red DS Panthers Cardigan, Pink SC Baroque Cardigan, Downtown Cab Co. Revere Collar, Valentines Blazer, 420 Smoking Jacket, Yeti Year of the Rabbit T-Shirt, Gray Yeti Combat Shirt, Black Sprunk Festive, Dark Logger Festive, White Logger Festive, Green Logger Festive, Red Logger Festive, Blue Patriot Logo Festive, Black Patriot Logo Festive, Blue Patriot Festive, Red Patriot Festive, Red Pisswasser Festive, Gold Pisswasser Festive, Red Pisswasser Logo Festive, Gold Pisswasser Logo Festive, Green Pride Brew Festive, Yellow Pride Brew Festive, Yellow Holly Pride Festive, White Holly Pride Festive, Sprunk Snowflakes Festive, Broker Checkerboard T-Shirt, Yeti Ape Tucked T-Shirt, Black Bigness Ski, White Bigness Ski, Black Enema Flourish Ski, Teal Enema Flourish Ski, Magenta Enema Flourish Ski, Camo Roses Slab Forwards, Lime Leopard Slab Forwards, Red SC Dragon Embroidered, Classic DS Tiger Embroidered, Gray DS Tiger Embroidered, Black VDG Bandana Wide, Orange Trickster Type Wide, Gray Yeti Battle Pants, Broker Checkerboard Cargos, 420 Smoking Pants, Camo Roses Slab Canvas, Lime Leopard Slab Canvas, White Signs Squash Ugglies & Socks, Traditional Painted Rabbit, Twilight Painted Rabbit, Noh Painted Rabbit, Lime SC Coin Wraps, Pink SC Coin Wraps, Tan Bracelet Ensemble, Red Manor Round Brow Shades, Le Chien Whistle Necklace, Heartbreak Pendant, Rabbit, Budonk-adonk!, The Red-nosed, The Nutcracker, The GoPostal
        unlock_packed_bools(36774, 36788) --Johnny On The Spot Polo, The Gooch Mask, Snowman Outfit, Gold New Year Glasses, Silver New Year Glasses, Rainbow New Year Glasses, Yellow Holly Beer Hat, Green Reindeer Beer Hat, Zebra Dome, Purple Snakeskin Spiked, Manor Surano Jacket, Pistol Mk II - Season's Greetings (Livery), Pump Shotgun - Dildodude Camo (Livery), Micro SMG - Dildodude Camo (Livery)
        unlock_packed_bools(36809, 36809) --Nemesis T-Shirts
        unlock_packed_bools(41316, 41325) --Ghosts Exposed
        unlock_packed_bools(41593, 41593) --The Merryweather Outfit
        unlock_packed_bools(41656, 41659) --Squaddie (Trade Price), Suede Bucks Finish, Employee of the Month Finish, Uncle T Finish
        unlock_packed_bools(41671, 41671) --Manchez Scout (Trade Price)
        unlock_packed_bools(41802, 41802) --Johnny On The Spot Polo
        unlock_packed_bools(41894, 41894) --Hinterland Work T-Shirt
        unlock_packed_bools(41897, 41902) --Love Fist T-Shirt, San Andreas Federal Reserve T-Shirt, Los Santos, San Andreas T-Shirt, Heist Mask T-Shirt, Los Santos Map T-Shirt, PRB T-Shirt
        unlock_packed_bools(41915, 41980) --LS Pounders Cap, Vom Feuer Camo Cap, Western MC Cap, Red & White Ammu-Nation Cap, Santo Capra Cap, Alpine Hat, Alien Tracksuit Pants, Scarlet Vintage Devil Mask, Amber Vintage Devil Mask, Green Vintage Devil Mask, Green Vintage Witch Mask, Yellow Vintage Witch Mask, Orange Vintage Witch Mask, Green Vintage Skull Mask, White Vintage Skull Mask, Brown Vintage Skull Mask, Orange Vintage Werewolf Mask, Blue Vintage Werewolf Mask, Brown Vintage Werewolf Mask, Green Vintage Zombie Mask, Brown Vintage Zombie Mask, Teal Vintage Zombie Mask, Turkey Mask, Royal Calacas Mask, Maritime Calacas Mask, Romance Calacas Mask, Floral Calacas Mask, Stanier LE Cruiser (Trade Price), The Homie, The Retired Criminal, The Groupie, Black SC Ornate Mini Dress, Dark Manor Racing Suit, Bright Manor Racing Suit, Hinterland Bomber Jacket, Red Happy Moon T-Shirt, Black Happy Moon T-Shirt, White Happy Moon T-Shirt, Rockstar Says Relax Tucked T-Shirt, Trevor Heist Mask Tucked T-Shirt, Franklin Heist Mask Tucked T-Shirt, Michael Heist Mask Tucked T-Shirt, Bugstars Tucked T-Shirt, STD Contractors Tucked T-Shirt, Black Los Santos Tucked T-Shirt, San Andreas Republic Tucked T-Shirt, Go Go Space Monkey Tucked T-Shirt, Vom Feuer Camo Tucked T-Shirt, Black SC Ornate Tucked T-Shirt, Warstock Tucked T-Shirt, Western San Andreas Tucked T-Shirt, Ride or Die Tucked T-Shirt, Bourgeoix Tucked T-Shirt, Blêuter'd Tucked T-Shirt, Cherenkov Tucked T-Shirt, Moodymann Portrait Tucked T-Shirt, Rockstar Silver Jubilee Tucked T-Shirt, Rockstar NY Hoodie, Dollar Daggers Hoodie, Merryweather Hoodie, Go Go Space Monkey Hoodie, Rockstar Lion Crest T-Shirt, Ammu-Nation Baseball T-Shirt, Alien Hooded Tracksuit Top, Manor Benefactor Surano T-Shirt, LS Smoking Jacket
        unlock_packed_bools(41994, 41994) --Junk Energy Racing Suit
        unlock_packed_bools(41996, 41996) --??? T-Shirt
        unlock_packed_bools(42054, 42054) --Strapz Bandana
        unlock_packed_bools(42063, 42063) --The LS Panic
        unlock_packed_bools(42068, 42069) --Snowman Finish, Santa's Helper Finish
        unlock_packed_bools(42111, 42111) --The Coast Guard
        unlock_packed_bools(42119, 42123) --Yeti Outfit, Snowman Finish, Santa's Helper Finish, Skull Santa Finish, riot unlocked
        unlock_packed_bools(42125, 42125) --riot trade price
        unlock_packed_bools(42128, 42146) --eCola Festive Sweater, Sprunk Festive Sweater, 1 Party Hat, 2 Party Hat, 3 Party Hat, 4 Party Hat, 5 Party Hat, 6 Party Hat, 7 Party Hat, 8 Party Hat, 9 Party Hat, 10 Party Hat, 11 Party Hat, 12 Party Hat, 13 Party Hat, 14 Party Hat, 15 Party Hat, Bronze Party Outfit, Silver Party Outfit
        unlock_packed_bools(42148, 42149) --Snowball Launcher, DâM-FunK - Even the Score
        unlock_packed_bools(42152, 42190) --The LSDS, The McTony Security, Wooden Dragon Mask, Contrast Dragon Mask, Regal Dragon Mask, Midnight Dragon Mask, Pink Heart Shades, Red Heart Shades, Orange Heart Shades, Yellow Heart Shades, Green Heart Shades, Blue Heart Shades, Purple Heart Shades, Black Heart Shades, Fireworks Bucket Hat, Stars and Stripes Bucket Hat, Lady Liberty Bucket Hat, Green Festive Tree Hat, Red Festive Tree Hat, Brown Festive Reindeer Hat, White Festive Reindeer Hat, Bronze New Year's Hat, Gold New Year's Hat, Silver New Year's Hat, Sprunk x eCola Bodysuit, Rockstar Racing Suit, Rockstar Helmet, Coil Earth Day Tee, IR Earth Day Tee, White High Brass Tee, Black High Brass Tee, Black Lunar New Year Tee, Bigness Carnival Sports Tee, Green 420 Dress, Red Lunar New Year Dress, Carnival Sun Dress, Carnival Bandana, Bigness Carnival Bucket Hat, Black 420 Forwards Cap
        unlock_packed_bools(42217, 42217) --Cluckin' Bell Forwards Cap
        unlock_packed_bools(42233, 42234) --BOXVILLE6, BENSON2
        unlock_packed_bools(42239, 42242) --CAVALCADE3, IMPALER5, POLGAUNTLET, DORADO
        unlock_packed_bools(42244, 42247) --BALLER8, TERMINUS, BOXVILLE6, BENSON2
        unlock_packed_bools(42249, 42249) --Candy Cane
        if is_player_male then
            unlock_packed_bools(3483, 3492) --Death Defying T-Shirt (Male), For Hire T-Shirt (Male), Gimme That T-Shirt (Male), Asshole T-Shirt (Male), Can't Touch This T-Shirt (Male), Decorated T-Shirt (Male), Psycho Killer T-Shirt (Male), One Man Army T-Shirt (Male), Shot Caller T-Shirt (Male), Showroom T-Shirt (Male)
            unlock_packed_bools(6082, 6083) --Black Benny's T-Shirt, White Benny's T-Shirt
            unlock_packed_bools(6097, 6097) --I Heart LC (T-Shirt) (Male)
            unlock_packed_bools(6169, 6169) --DCTL T-Shirt (Male)
            unlock_packed_bools(6303, 6304) --Crosswalk Tee (Male), R* Crosswalk Tee (Male)
            unlock_packed_bools(15708, 15708) --Black The Black Madonna Emb. Tee (Male)
            unlock_packed_bools(15710, 15710) --The Black Madonna Star Tee (Male)
            unlock_packed_bools(15717, 15717) --White Dixon Repeated Logo Tee (Male)
            unlock_packed_bools(15720, 15720) --Black Dixon Wilderness Tee (Male)
            unlock_packed_bools(15724, 15724) --Tale Of Us Black Box Tee (Male)
            unlock_packed_bools(15728, 15728) --Black Tale Of Us Emb. Tee (Male)
            unlock_packed_bools(15730, 15730) --Black Solomun Yellow Logo Tee (Male)
            unlock_packed_bools(15732, 15732) --White Solomun Tee (Male)
            unlock_packed_bools(15737, 15737) --??? (Tattoo) (Male)
            unlock_packed_bools(15887, 15887) --Lucky 7s (Tattoo) (Male)
            unlock_packed_bools(15894, 15894) --The Royals (Tattoo) (Male)
            unlock_packed_bools(28393, 28416) --Badlands Revenge II Retro Tee (Male), Badlands Revenge II Pixtro Tee (Male), Degenatron Glitch Tee (Male), Degenatron Logo Tee (Male), The Wizard's Ruin Rescue Tee (Male), The Wizard's Ruin Vow Tee (Male), Space Monkey Art Tee (Male), Crotch Rockets Tee (Male), Street Legal Tee (Male), Get Truckin' Tee (Male), Arcade Trophy Tee (Male), Videogeddon Tee (Male), Insert Coin Tee (Male), Plushie Princess Tee (Male), Plushie Wasabi Kitty Tee (Male), Plushie Master Tee (Male), Plushie Muffy Tee (Male), Plushie Humpy Tee (Male), Plushie Saki Tee (Male), Plushie Grindy Tee (Male), Plushie Poopie Tee (Male), Plushie Smoker Tee (Male), Shiny Wasabi Kitty Claw Tee (Male), Nazar Speaks Tee (Male)
            unlock_packed_bools(28447, 28451) --11 11 Tee (Male), King Of QUB3D Tee (Male), Qubism Tee (Male), God Of QUB3D Tee (Male), QUB3D Boxart Tee (Male)
            unlock_packed_bools(28452, 28478) --Channel X Aged Tee (Male), Rebel Radio Aged Tee (Male), LSUR Aged Tee (Male), Steel Horse Solid Logo Aged Tee (Male), Black Western Logo Aged Tee (Male), White Nagasaki Aged Tee (Male), Black Principe Aged Tee (Male), Albany Vintage Aged Tee (Male), Benefactor Aged Tee (Male), Bravado Aged Tee (Male), Declasse Aged Tee (Male), Dinka Aged Tee (Male), Grotti Aged Tee (Male), Lampadati Aged Tee (Male), Ocelot Aged Tee (Male), Overflod Aged Tee (Male), Pegassi Aged Tee (Male), Pfister Aged Tee (Male), Vapid Aged Tee (Male), Weeny Aged Tee (Male), Toe Shoes Aged T-Shirt (Male), Vanilla Unicorn Aged T-Shirt (Male), Fake Vapid Aged T-Shirt (Male), I Married My Dad Aged T-Shirt (Male), White Rockstar Camo Aged Tee (Male), Razor Aged T-Shirt (Male), Noise Rockstar Logo Aged Tee (Male)
            unlock_packed_bools(30355, 30361) --Noise Aged Tee (Male), Emotion 98.3 Aged T-Shirt (Male), KDST Aged T-Shirt (Male), KJAH Radio Aged T-Shirt (Male), Bounce FM Aged T-Shirt (Male), K-Rose Aged T-Shirt (Male), Blue The Diamond Resort LS Aged Tee (Male)
            unlock_packed_bools(30407, 30410) --White Keinemusik Tee (Male), Blue Keinemusik Tee (Male), Moodymann Tee (Male), Palms Trax Tee (Male)
            unlock_packed_bools(30418, 30422) --Faces of Death Tee (Male), Straight to Video Tee (Male), Monkey See Monkey Die Tee (Male), Trained to Kill Tee (Male), The Director Tee (Male)
            unlock_packed_bools(41273, 41284) --Monkey (Tattoo) (Male), Dragon (Tattoo) (Male), Snake (Tattoo) (Male), Goat (Tattoo) (Male), Rat (Tattoo) (Male), Rabbit (Tattoo) (Male), Ox (Tattoo) (Male), Pig (Tattoo) (Male), Rooster (Tattoo) (Male), Dog (Tattoo) (Male), Horse (Tattoo) (Male), Tiger (Tattoo) (Male)
            unlock_packed_bools(41293, 41293) --Hinterland Work T-Shirt (Male)
        else
            unlock_packed_bools(3496, 3505) --Death Defying Top (Female), For Hire Top (Female), Gimme That Top (Female), Asshole Top (Female), Can't Touch This Top (Female), Decorated Top (Female), Psycho Killer Top (Female), One Man Army Top (Female), Shot Caller Top (Female), Showroom Top (Female)
            unlock_packed_bools(6091, 6092) --Black Benny's T-Shirt, White Benny's T-Shirt
            unlock_packed_bools(6106, 6106) --I Heart LC (T-Shirt) (Female)
            unlock_packed_bools(6181, 6181) --DCTL T-Shirt (Female)
            unlock_packed_bools(6316, 6317) --Crosswalk Tee (Female), R* Crosswalk Tee (Female)
            unlock_packed_bools(15719, 15719) --Black The Black Madonna Emb. Tee (Female)
            unlock_packed_bools(15721, 15721) --The Black Madonna Star Tee (Female)
            unlock_packed_bools(15728, 15728) --White Dixon Repeated Logo Tee (Female)
            unlock_packed_bools(15731, 15731) --Black Dixon Wilderness Tee (Female)
            unlock_packed_bools(15735, 15735) --Tale Of Us Black Box Tee (Female)
            unlock_packed_bools(15739, 15739) --Black Tale Of Us Emb. Tee (Female)
            unlock_packed_bools(15741, 15741) --Black Solomun Yellow Logo Tee (Female)
            unlock_packed_bools(15743, 15743) --White Solomun Tee (Female)
            unlock_packed_bools(15748, 15748) --??? (Tattoo) (Female)
            unlock_packed_bools(15898, 15898) --Lucky 7s (Tattoo) (Female)
            unlock_packed_bools(15905, 15905) --The Royals (Tattoo) (Female)
            unlock_packed_bools(28404, 28427) --Badlands Revenge II Retro Tee (Female), Badlands Revenge II Pixtro Tee (Female), Degenatron Glitch Tee (Female), Degenatron Logo Tee (Female), The Wizard's Ruin Rescue Tee (Female), The Wizard's Ruin Vow Tee (Female), Space Monkey Art Tee (Female), Crotch Rockets Tee (Female), Street Legal Tee (Female), Get Truckin' Tee (Female), Arcade Trophy Tee (Female), Videogeddon Tee (Female), Insert Coin Tee (Female), Plushie Princess Tee (Female), Plushie Wasabi Kitty Tee (Female), Plushie Master Tee (Female), Plushie Muffy Tee (Female), Plushie Humpy Tee (Female), Plushie Saki Tee (Female), Plushie Grindy Tee (Female), Plushie Poopie Tee (Female), Plushie Smoker Tee (Female), Shiny Wasabi Kitty Claw Tee (Female), Nazar Speaks Tee (Female)
            unlock_packed_bools(28458, 28462) --11 11 Tee (Female), King Of QUB3D Tee (Female), Qubism Tee (Female), God Of QUB3D Tee (Female), QUB3D Boxart Tee (Female)
            unlock_packed_bools(28463, 28478) --Channel X Aged Tee (Female), Rebel Radio Aged Tee (Female), LSUR Aged Tee (Female), Steel Horse Solid Logo Aged Tee (Female), Black Western Logo Aged Tee (Female), White Nagasaki Aged Tee (Female), Black Principe Aged Tee (Female), Albany Vintage Aged Tee (Female), Benefactor Aged Tee (Female), Bravado Aged Tee (Female), Declasse Aged Tee (Female), Dinka Aged Tee (Female), Grotti Aged Tee (Female), Lampadati Aged Tee (Female), Ocelot Aged Tee (Female), Overflod Aged Tee (Female)
            unlock_packed_bools(30418, 30421) --White Keinemusik Tee (Female), Blue Keinemusik Tee (Female), Moodymann Tee (Female), Palms Trax Tee (Female)
            unlock_packed_bools(30355, 30372) --Pegassi Aged Tee (Female), Pfister Aged Tee (Female), Vapid Aged Tee (Female), Weeny Aged Tee (Female), Toe Shoes Aged T-Shirt (Female), Vanilla Unicorn Aged T-Shirt (Female), Fake Vapid Aged T-Shirt (Female), I Married My Dad Aged T-Shirt (Female), White Rockstar Camo Aged Tee (Female), Razor Aged T-Shirt (Female), Noise Rockstar Logo Aged Tee (Female), Noise Aged Tee (Female), Emotion 98.3 Aged T-Shirt (Female), KDST Aged T-Shirt (Female), KJAH Radio Aged T-Shirt (Female), Bounce FM Aged T-Shirt (Female), K-Rose Aged T-Shirt (Female), Blue The Diamond Resort LS Aged Tee (Female)
            unlock_packed_bools(30429, 30433) --Faces of Death Tee (Female), Straight to Video Tee (Female), Monkey See Monkey Die Tee (Female), Trained to Kill Tee (Female), The Director Tee (Female)
            unlock_packed_bools(41285, 41296) --Monkey (Tattoo) (Female), Dragon (Tattoo) (Female), Snake (Tattoo) (Female), Goat (Tattoo) (Female), Rat (Tattoo) (Female), Rabbit (Tattoo) (Female), Ox (Tattoo) (Female), Pig (Tattoo) (Female), Rooster (Tattoo) (Female), Dog (Tattoo) (Female), Horse (Tattoo) (Female), Tiger (Tattoo) (Female)
            unlock_packed_bools(41304, 41304) --Hinterland Work T-Shirt (Female)
        end
        stats.set_packed_stat_int(7315, 6) --WEAPON_STONE_HATCHET
        stats.set_packed_stat_int(18981, 4) --WEAPON_DOUBLEACTION
        stats.set_packed_stat_int(18982, 3) --Parts of the TM-02 Khanjali (tracks, remote grenade launcher and turret end/muzzle brake)
        stats.set_packed_stat_int(18983, 3) --Parts of the RCV (plow, door and water hose)
        stats.set_packed_stat_int(18984, 3) --Parts of the Chernobog (door, dual headlight set and wheels)
        stats.set_packed_stat_int(18985, 3) --Parts of the Thruster (exhaust, small rotors and handlebars/joysticks)
        stats.set_packed_stat_int(18986, 3) --Parts of the Avenger (wing, nose camera and rotor blade)
        stats.set_packed_stat_int(22050, 5) --Oppressor MK2 Trade Price
        stats.set_packed_stat_int(22051, 50) --Carved Wooden Box (Nightclub)
        stats.set_packed_stat_int(22052, 100) --Ammo Box
        stats.set_packed_stat_int(22053, 20) --Meth
        stats.set_packed_stat_int(22054, 80) --Weed
        stats.set_packed_stat_int(22055, 60) --Passports
        stats.set_packed_stat_int(22056, 40) --Crumpled Cash
        stats.set_packed_stat_int(22057, 10) --Impotent Rage Statue
        stats.set_packed_stat_int(22058, 20) --Gold Business Battle Trophy (Nightclub)
        stats.set_packed_stat_int(22063, 20) --Dinka Go Go Monkey Blista
        stats.set_packed_stat_int(41237, 10) --Taxi Livery
        stats.set_int('MPPLY_CREW_NO_HEISTS_0', 2)
        stats.set_int('MPPLY_CREW_NO_HEISTS_1', 5)
        stats.set_int('MPPLY_CREW_NO_HEISTS_2', 5)
        stats.set_int('MPPLY_CREW_NO_HEISTS_3', 5)
        stats.set_int('MPPLY_CREW_NO_HEISTS_4', 5)
        stats.set_int('MPPLY_GANGOPS_LOYALTY2', -1)
        stats.set_int('MPPLY_GANGOPS_LOYALTY3', -1)
        stats.set_int('MPPLY_GANGOPS_CRIMMASMD2', -1)
        stats.set_int('MPPLY_GANGOPS_CRIMMASMD3', -1)
        stats.set_int('MPPLY_GANGOPS_SUPPORT', -1)
        stats.set_int('MPPLY_GANGOPS_ALLINORDER', -1)
        stats.set_int('MPPLY_GANGOPS_LOYALTY', -1)
        stats.set_int('MPPLY_GANGOPS_CRIMMASMD', -1)
        stats.set_int('MPPLY_XMASLIVERIES0', -1)
        stats.set_int('MPPLY_XMASLIVERIES1', -1)
        stats.set_int('MPPLY_XMASLIVERIES2', -1)
        stats.set_int('MPPLY_XMASLIVERIES3', -1)
        stats.set_int('MPPLY_XMASLIVERIES4', -1)
        stats.set_int('MPPLY_XMASLIVERIES5', -1)
        stats.set_int('MPPLY_XMASLIVERIES6', -1)
        stats.set_int('MPPLY_XMASLIVERIES7', -1)
        stats.set_int('MPPLY_XMASLIVERIES8', -1)
        stats.set_int('MPPLY_XMASLIVERIES9', -1)
        stats.set_int('MPPLY_XMASLIVERIES10', -1)
        stats.set_int('MPPLY_XMASLIVERIES11', -1)
        stats.set_int('MPPLY_XMASLIVERIES12', -1)
        stats.set_int('MPPLY_XMASLIVERIES13', -1)
        stats.set_int('MPPLY_XMASLIVERIES14', -1)
        stats.set_int('MPPLY_XMASLIVERIES15', -1)
        stats.set_int('MPPLY_XMASLIVERIES16', -1)
        stats.set_int('MPPLY_XMASLIVERIES17', -1)
        stats.set_int('MPPLY_XMASLIVERIES18', -1)
        stats.set_int('MPPLY_XMASLIVERIES19', -1)
        stats.set_int('MPPLY_XMASLIVERIES20', -1)
        stats.set_int('MPX_HOLDUPS_BITSET', -1)
        stats.set_int('MPX_CHAR_ABILITY_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_ABILITY_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_ABILITY_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_WEAP_UNLOCKED', -1)
        stats.set_int('MPX_CHAR_WEAP_UNLOCKED2', -1)
        stats.set_int('MPX_CHAR_WEAP_ADDON_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_WEAP_ADDON_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_WEAP_ADDON_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_WEAP_ADDON_4_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_UNLOCKED', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_UNLOCKED2', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_UNLOCKED3', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_UNLOCKED4', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_UNLOCKED5', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_4_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_5_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_6_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_7_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_8_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_9_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_10_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_11_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_12_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_13_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_14_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_15_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_16_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_17_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_18_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_19_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_WEAP_ADDON_20_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_HAIRCUT_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK1', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK2', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK3', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK4', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK5', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK6', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK7', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK8', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK9', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK10', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK11', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK12', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK13', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK14', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK15', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK16', -1)
        stats.set_int('MPX_CHAR_HAIR_UNLCK17', -1)
        stats.set_int('MPX_CHAR_FM_HEALTH_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_HEALTH_2_UNLCK', -1)
        stats.set_int('MPX_CRDEADLINE', 5)
        stats.set_int('MPX_CHAR_CREWUNLOCK_1_FM_EQUIP', -1)
        stats.set_int('MPX_CHAR_CREWUNLOCK_2_FM_EQUIP', -1)
        stats.set_int('MPX_CHAR_CREWUNLOCK_3_FM_EQUIP', -1)
        stats.set_int('MPX_CHAR_CREWUNLOCK_4_FM_EQUIP', -1)
        stats.set_int('MPX_CHAR_CREWUNLOCK_5_FM_EQUIP', -1)
        stats.set_int('MPX_CHAR_KIT_1_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_2_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_3_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_4_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_5_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_6_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_7_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_8_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_9_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_10_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_11_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_12_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_13_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_14_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_15_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_16_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_17_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_18_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_19_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_20_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_21_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_22_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_23_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_24_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_25_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_26_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_27_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_28_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_29_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_30_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_30_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_31_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_32_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_33_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_34_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_35_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_36_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_37_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_38_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_39_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_40_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_KIT_41_FM_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_ABILITY_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_ABILITY_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_ABILITY_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_4_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_5_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_6_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_7_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_8_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_9_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_10_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CLOTHES_11_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_VEHICLE_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_VEHICLE_2_UNLCK', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_0', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_1', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_2', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_3', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_4', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_5', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_6', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_7', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_8', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_9', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_10', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_11', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_12', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_13', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_14', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_15', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_16', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_17', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_18', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_19', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_20', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_21', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_22', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_23', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_24', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_25', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_26', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_27', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_28', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_29', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_30', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_31', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_32', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_33', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_34', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_35', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_36', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_37', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_38', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_39', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_40', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_41', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_42', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_43', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_44', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_45', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_46', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_47', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_48', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_49', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_50', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_51', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_52', -1)
        stats.set_int('MPX_TATTOO_FM_UNLOCKS_53', -1)
        stats.set_int('MPX_RANKAP_UNLK_0', -1)
        stats.set_int('MPX_RANKAP_UNLK_1', -1)
        stats.set_int('MPX_RANKAP_UNLK_2', -1)
        stats.set_int('MPX_RANKAP_UNLK_3', -1)
        stats.set_int('MPX_CHAR_CREWUNLOCK_1_UNLCK', -1)
        stats.set_int('MPX_PISTOL_ENEMY_KILLS', 600) -- Weapon Tints for Pistol
        stats.set_int('MPX_CMBTPISTOL_ENEMY_KILLS', 600) -- Weapon Tints for Combat Pistol
        stats.set_int('MPX_APPISTOL_ENEMY_KILLS', 600) -- Weapon Tints for AP Pistol
        stats.set_int('MPX_MICROSMG_ENEMY_KILLS', 600) -- Weapon Tints for Micro SMG
        stats.set_int('MPX_SMG_ENEMY_KILLS', 600) -- Weapon Tints for SMG
        stats.set_int('MPX_ASLTSMG_ENEMY_KILLS', 600) -- Weapon Tints for Assault SMG
        stats.set_int('MPX_ASLTRIFLE_ENEMY_KILLS', 600) -- Weapon Tints for Assault Rifle
        stats.set_int('MPX_CRBNRIFLE_ENEMY_KILLS', 600) -- Weapon Tints for Carbine Rifle
        stats.set_int('MPX_ADVRIFLE_ENEMY_KILLS', 600) -- Weapon Tints for Advanced Rifle
        stats.set_int('MPX_MG_ENEMY_KILLS', 600) -- Weapon Tints for MG
        stats.set_int('MPX_CMBTMG_ENEMY_KILLS', 600) -- Weapon Tints for Combat MG
        stats.set_int('MPX_PUMP_ENEMY_KILLS', 600) -- Weapon Tints for Pump Shotgun
        stats.set_int('MPX_SAWNOFF_ENEMY_KILLS', 600) -- Weapon Tints for Sawed-Off Shotgun
        stats.set_int('MPX_ASLTSHTGN_ENEMY_KILLS', 600) -- Weapon Tints for Assault Shotgun
        stats.set_int('MPX_SNIPERRFL_ENEMY_KILLS', 600) -- Weapon Tints for Sniper Rifle
        stats.set_int('MPX_HVYSNIPER_ENEMY_KILLS', 600) -- Weapon Tints for Heavy Sniper
        stats.set_int('MPX_GRNLAUNCH_ENEMY_KILLS', 600) -- Weapon Tints for Grenade Launcher
        stats.set_int('MPX_RPG_ENEMY_KILLS', 600) -- Weapon Tints for Rocket Launcher
        stats.set_int('MPX_MINIGUNS_ENEMY_KILLS', 600) -- Weapon Tints for Minigun
        stats.set_int('MPX_SR_WEAPON_BIT_SET', 262143)
        stats.set_bool('MPX_SR_TIER_1_REWARD', true)
        stats.set_bool('MPX_SR_INCREASE_THROW_CAP', true)
        stats.set_bool('MPX_SR_TIER_3_REWARD', true)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_0', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_1', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_2', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_3', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_4', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_5', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_6', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_7', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_8', 3)
        stats.set_int('MPX_PILOT_SCHOOL_MEDAL_9', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_0', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_1', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_2', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_3', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_4', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_5', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_6', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_7', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_8', 3)
        stats.set_int('MPX_PILOT_SCHOOL_LASTMEDAL_9', 3)
        stats.set_int('MPX_CRPILOTSCHOOL', 1)
        stats.set_int('MPX_PILOT_CHECKPOINTCOUNT_9', 27)
        stats.set_float('MPX_PILOT_ELAPSEDTIME_0', 58.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_1', 10.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_2', 2.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_3', 10.0)
        stats.set_float('MPX_PILOT_ELAPSEDTIME_4', 19.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_5', 600.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_6', 25.0)
        stats.set_float('MPX_PILOT_LANDINGDISTANCE_7', 1.0)
        stats.set_float('MPX_PILOT_ELAPSEDTIME_8', 160.0)
        stats.set_float('MPX_PILOT_ELAPSEDTIME_9', 145.0)
        stats.set_float('MPX_PILOT_LASTELAPSEDTIME_0', 58.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_1', 10.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_2', 2.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_3', 10.0)
        stats.set_float('MPX_PILOT_LASTELAPSEDTIME_4', 19.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_5', 600.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_6', 25.0)
        stats.set_float('MPX_PILOT_LASTLANDDISTANCE_7', 1.0)
        stats.set_float('MPX_PILOT_LASTELAPSEDTIME_8', 160.0)
        stats.set_float('MPX_PILOT_LASTELAPSEDTIME_9', 145.0)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_0', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_1', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_2', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_3', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_4', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_5', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_6', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_7', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_8', true)
        stats.set_bool('MPX_PILOT_ASPASSEDLESSON_9', true)
        stats.set_int('MPX_CAR_CLUB_REP', 997430)
        stats.set_bool('MPPLY_MELEECHLENGECOMPLETED', true)
        stats.set_bool('MPPLY_HEADSHOTCHLENGECOMPLETED', true)
        stats.set_int('MPX_CHAR_HEIST_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_VEHICLE_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_VEHICLE_2_UNLCK', -1)
        stats.set_int('MPX_CRHEIST', 50)
        stats.set_int('MPX_CR_BANKHEIST1', 10)
        stats.set_int('MPX_CR_COUNTHEIST1', 10)
        stats.set_int('MPX_HEIST_COMPLETION', 26)
        stats.set_int('MPX_HEIST_TOTAL_TIME', 86400000)
        stats.set_int('MPX_HEISTS_ORGANISED', 50)
        stats.set_int('MPX_RACES_WON', 50)
        stats.set_int('MPX_CHAR_FM_PACKAGE_1_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_2_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_3_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_4_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_5_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_6_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_7_COLLECT', -1)
        stats.set_int('MPX_CHAR_FM_PACKAGE_8_COLLECT', -1)
        stats.set_int('MPX_CHAR_NO_FM_PACKAGES_COL', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_1_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_2_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_3_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_4_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_5_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_6_UNLCK', -1)
        stats.set_int('MPX_CHAR_FM_CARMOD_7_UNLCK', -1)
        stats.set_int('MPX_NUMBER_SLIPSTREAMS_IN_RACE', 110)
        stats.set_int('MPX_NUMBER_TURBO_STARTS_IN_RACE', 90)
        stats.set_int('MPX_USJS_FOUND', 50)
        stats.set_int('MPX_USJS_COMPLETED', 50)
        stats.set_int('MPPLY_TIMES_RACE_BEST_LAP', 101)
        stats.set_int('MPX_AWD_FMRALLYWONDRIVE', 25)
        stats.set_int('MPX_AWD_FMWINSEARACE', 25)
        stats.set_int('MPX_AWD_FMWINAIRRACE', 25)
        stats.set_int('MPX_AWD_FM_RACES_FASTEST_LAP', 101)
        stats.set_int('MPX_SCRIPT_INCREASE_STAM', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_STRN', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_FLY', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_STL', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_LUNG', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_DRIV', 100)
        stats.set_int('MPX_SCRIPT_INCREASE_SHO', 100)
        stats.set_int('MPX_AWD_DANCE_TO_SOLOMUN', 360)
        stats.set_int('MPX_AWD_DANCE_TO_TALEOFUS', 360)
        stats.set_int('MPX_AWD_DANCE_TO_DIXON', 360)
        stats.set_int('MPX_AWD_DANCE_TO_BLKMAD', 360)
        stats.set_int('MPX_NIGHTCLUB_HOTSPOT_TIME_MS', 40320000)
        stats.set_int('MPX_CASINO_DECORATION_GIFT_1', -1)
        stats.set_bool('MPX_COMPLETE_H4_F_USING_VETIR', true)
        stats.set_bool('MPX_COMPLETE_H4_F_USING_LONGFIN', true)
        stats.set_bool('MPX_COMPLETE_H4_F_USING_ANNIH', true)
        stats.set_bool('MPX_COMPLETE_H4_F_USING_ALKONOS', true)
        stats.set_bool('MPX_COMPLETE_H4_F_USING_PATROLB', true)
        stats.set_int("MPX_ARENAWARS_AP_LIFETIME", 5055000)
        stats.set_int("MPX_ARENAWARS_AP_TIER", 1000)
        stats.set_int("MPX_ARENAWARS_AP", 10040)
        stats.set_int("MPX_ARENAWARS_SKILL_LEVEL", 20)
        stats.set_int("MPX_ARENAWARS_SP", 210)
        stats.set_int("MPX_ARENAWARS_SP_LIFETIME", 210)
        stats.set_int("MPX_ARENAWARS_MATCHES_PLYD", 52500)
        stats.set_int("MPX_ARENAWARS_MATCHES_PLYDT", 52500)
        stats.set_int("MPX_ARENAWARS_CARRER_WINS", 72500)
        stats.set_int("MPX_ARENAWARS_CARRER_WINT", 32500)
        stats.set_int("MPX_ARN_LIFETIME_KILLS", 260000)
        stats.set_int("MPX_ARN_LIFETIME_DEATHS", 20000)
        stats.set_int("MPX_ARN_SPECTATOR_KILLS", 5000)
        stats.set_int("MPX_ARN_W_PASS_THE_BOMB", 11000)
        stats.set_int("MPX_ARN_W_DETONATION", 11000)
        stats.set_int("MPX_ARN_W_ARCADE_RACE", 11000)
        stats.set_int("MPX_ARN_W_CTF", 11000)
        stats.set_int("MPX_ARN_W_TAG_TEAM", 11000)
        stats.set_int("MPX_ARN_W_DESTR_DERBY", 11000)
        stats.set_int("MPX_ARN_W_CARNAGE", 11000)
        stats.set_int("MPX_ARN_W_MONSTER_JAM", 12000)
        stats.set_int("MPX_ARN_W_GAMES_MASTERS", 11000)
        stats.set_int("MPX_ARN_L_PASS_THE_BOMB", 100)
        stats.set_int("MPX_ARN_L_DETONATION", 100)
        stats.set_int("MPX_ARN_L_ARCADE_RACE", 100)
        stats.set_int("MPX_ARN_L_CTF", 100)
        stats.set_int("MPX_ARN_L_TAG_TEAM", 200)
        stats.set_int("MPX_ARN_L_DESTR_DERBY", 100)
        stats.set_int("MPX_ARN_L_CARNAGE", 100)
        stats.set_int("MPX_ARN_L_MONSTER_JAM", 1005)
        stats.set_int("MPX_ARN_L_GAMES_MASTERS", 100)
        stats.set_int("MPX_ARN_VEH_MONSTER3", 90000)
        stats.set_int("MPX_ARN_VEH_MONSTER4", 500)
        stats.set_int("MPX_ARN_VEH_MONSTER5", 500)
        stats.set_int("MPX_ARN_VEH_CERBERUS", 500)
        stats.set_int("MPX_ARN_VEH_CERBERUS2", 500)
        stats.set_int("MPX_ARN_VEH_CERBERUS3", 500)
        stats.set_int("MPX_ARN_VEH_BRUISER", 500)
        stats.set_int("MPX_ARN_VEH_BRUISER2", 500)
        stats.set_int("MPX_ARN_VEH_BRUISER3", 500)
        stats.set_int("MPX_ARN_VEH_SLAMVAN4", 500)
        stats.set_int("MPX_ARN_VEH_SLAMVAN5", 500)
        stats.set_int("MPX_ARN_VEH_SLAMVAN6", 500)
        stats.set_int("MPX_ARN_VEH_BRUTUS", 500)
        stats.set_int("MPX_ARN_VEH_BRUTUS2", 500)
        stats.set_int("MPX_ARN_VEH_BRUTUS3", 500)
        stats.set_int("MPX_ARN_VEH_SCARAB", 500)
        stats.set_int("MPX_ARN_VEH_SCARAB2", 500)
        stats.set_int("MPX_ARN_VEH_SCARAB3", 500)
        stats.set_int("MPX_ARN_VEH_DOMINATOR4", 500)
        stats.set_int("MPX_ARN_VEH_DOMINATOR5", 500)
        stats.set_int("MPX_ARN_VEH_DOMINATOR6", 500)
        stats.set_int("MPX_ARN_VEH_IMPALER2", 500)
        stats.set_int("MPX_ARN_VEH_IMPALER3", 500)
        stats.set_int("MPX_ARN_VEH_IMPALER4", 500)
        stats.set_int("MPX_ARN_VEH_ISSI4", 500)
        stats.set_int("MPX_ARN_VEH_ISSI5", 500)
        stats.set_int("MPX_ARN_VEH_ISSI6", 500)
        stats.set_int("MPX_ARN_VEH_IMPERATOR", 500)
        stats.set_int("MPX_ARN_VEH_IMPERATOR2", 500)
        stats.set_int("MPX_ARN_VEH_IMPERATOR3", 500)
        stats.set_int("MPX_ARN_VEH_ZR380", 500)
        stats.set_int("MPX_ARN_VEH_ZR3802", 500)
        stats.set_int("MPX_ARN_VEH_ZR3803", 500)
        stats.set_int("MPX_ARN_VEH_DEATHBIKE", 500)
        stats.set_int("MPX_ARN_VEH_DEATHBIKE2", 400)
        stats.set_int("MPX_ARN_VEH_DEATHBIKE3", 400)
        stats.set_int("MPX_AWD_WATCH_YOUR_STEP", 20)
        stats.set_int("MPX_AWD_TOWER_OFFENSE", 50)
        stats.set_int("MPX_AWD_THROUGH_A_LENS", 60)
        stats.set_int("MPX_AWD_SPINNER", 80)
        stats.set_int("MPX_AWD_YOUMEANBOOBYTRAPS", 25)
        stats.set_int("MPX_AWD_MASTER_BANDITO", 20)
        stats.set_int("MPX_AWD_SITTING_DUCK", 30)
        stats.set_int("MPX_AWD_CROWDPARTICIPATION", 80)
        stats.set_int("MPX_AWD_KILL_OR_BE_KILLED", 60)
        stats.set_int("MPX_AWD_MASSIVE_SHUNT", 60)
        stats.set_int("MPX_AWD_YOURE_OUTTA_HERE", 220)
        stats.set_int("MPX_AWD_ARENA_WAGEWORKER", 6785341)
        stats.set_int("MPX_AWD_TIME_SERVED", 474020)
        stats.set_int("MPX_AWD_CAREER_WINNER", 36340)
        stats.set_int("MPX_ARN_SPECTATOR_DRONE", 60)
        stats.set_int("MPX_ARN_SPECTATOR_CAMS", 60)
        stats.set_int("MPX_ARN_SMOKE", 50)
        stats.set_int("MPX_ARN_DRINK", 65)
        stats.set_int("MPX_ARN_SPEC_BOX_TIME_MS", 10800000)
        stats.set_int("MPX_AWD_TOP_SCORE", 1045020)
        stats.set_int("MPX_AWD_READY_FOR_WAR", 50)
        stats.set_int("MPX_AWD_WEVE_GOT_ONE", 60)
        stats.set_int("MPX_ARN_W_THEME_SCIFI", 10)
        stats.set_int("MPX_ARN_W_THEME_APOC", 10)
        stats.set_int("MPX_ARN_W_THEME_CONS", 10)
        stats.set_int("MPX_ARN_BS_TRINKET_SAVED", -1) -- Unlock trinket and stickers.
        stats.set_bool("MPX_AWD_UNSTOPPABLE", true)
        stats.set_bool("MPX_AWD_CONTACT_SPORT", true)
        stats.set_bool("MPX_AWD_BEGINNER", true)
        stats.set_bool("MPX_AWD_FIELD_FILLER", true)
        stats.set_bool("MPX_AWD_ARMCHAIR_RACER", true)
        stats.set_bool("MPX_AWD_LEARNER", true)
        stats.set_bool("MPX_AWD_SUNDAY_DRIVER", true)
        stats.set_bool("MPX_AWD_THE_ROOKIE", true)
        stats.set_bool("MPX_AWD_BUMP_AND_RUN", true)
        stats.set_bool("MPX_AWD_GEAR_HEAD", true)
        stats.set_bool("MPX_AWD_DOOR_SLAMMER", true)
        stats.set_bool("MPX_AWD_HOT_LAP", true)
        stats.set_bool("MPX_AWD_ARENA_AMATEUR", true)
        stats.set_bool("MPX_AWD_PAINT_TRADER", true)
        stats.set_bool("MPX_AWD_SHUNTER", true)
        stats.set_bool("MPX_AWD_JOCK", true)
        stats.set_bool("MPX_AWD_WARRIOR", true)
        stats.set_bool("MPX_AWD_T_BONE", true)
        stats.set_bool("MPX_AWD_MAYHEM", true)
        stats.set_bool("MPX_AWD_WRECKER", true)
        stats.set_bool("MPX_AWD_CRASH_COURSE", true)
        stats.set_bool("MPX_AWD_ARENA_LEGEND", true)
        stats.set_bool("MPX_AWD_PEGASUS", true)
        stats.set_packed_stat_bool(25010, true) -- Skip arena wall help.
        stats.set_packed_stat_bool(25014, true) -- Skip arena wall tutorial.
        stats.set_bool('MPX_AWD_DEADEYE', true) -- Badlands Revenge II -- Dead Eye
        stats.set_bool('MPX_AWD_PISTOLSATDAWN', true) -- Badlands Revenge II -- Pistols At Dawn
        stats.set_bool('MPX_AWD_TRAFFICAVOI', true) -- Race and Chase -- Beat the Traffic
        stats.set_bool('MPX_AWD_CANTCATCHBRA', true) -- Race and Chase -- All Wheels
        stats.set_bool('MPX_AWD_WIZHARD', true) -- The Wizard's Ruin -- Feelin' Grogy
        stats.set_bool('MPX_AWD_APEESCAPE', true) -- Space Monkey 3: Bananas Gone Bad -- Ape Escape
        stats.set_bool('MPX_AWD_MONKEYKIND', true) -- Space Monkey 3: Bananas Gone Bad -- Monkey Mind
        stats.set_bool('MPX_AWD_AQUAAPE', true) -- Monkey Paradise -- Aquatic Ape
        stats.set_bool('MPX_AWD_KEEPFAITH', true) -- Defender of the Faith -- Keeping The Faith
        stats.set_bool('MPX_AWD_TRUELOVE', true) -- The Love Professor -- True Love
        stats.set_bool('MPX_AWD_NEMESIS', true) -- The Love Professor -- Nemesis
        stats.set_bool('MPX_AWD_FRIENDZONED', true) -- The Love Professor -- Friendzoned
        stats.set_bool('MPX_SCGW_WON_NO_DEATHS', true) -- Street Crimes: Gang Wars Edition -- Win a game without taking any damage
        stats.set_bool('MPX_IAP_CHALLENGE_0', true) -- Invade and Persuade II -- Score over 2,000,000 in a single playthrough
        stats.set_bool('MPX_IAP_CHALLENGE_1', true) -- Invade and Persuade II -- Collect 88 barrels in a single playthrough
        stats.set_bool('MPX_IAP_CHALLENGE_2', true) -- Invade and Persuade II -- Kill 100 animals in a single playthrough
        stats.set_bool('MPX_IAP_CHALLENGE_3', true) -- Invade and Persuade II -- Travel 3,474,000km on the moon
        stats.set_bool('MPX_IAP_CHALLENGE_4', true) -- Invade and Persuade II -- Finish any level of Invade and persuade with over 7 livee
        stats.set_bool('MPX_AWD_KINGOFQUB3D', true) -- QUB3D -- King Of QUB3D
        stats.set_bool('MPX_AWD_QUBISM', true) -- QUB3D -- Qubism
        stats.set_bool('MPX_AWD_GODOFQUB3D', true) -- QUB3D -- God Of QUB3D
        stats.set_bool('MPX_AWD_QUIBITS', true) -- QUB3D -- Qubits
        stats.set_bool('MPX_AWD_ELEVENELEVEN', true) -- Axe Of Fury -- 11 11
        stats.set_bool('MPX_AWD_GOFOR11TH', true) -- Axe Of Fury -- Crank It To 11
        stats.set_bool('MPX_AWD_STRAIGHT_TO_VIDEO', true) -- Camhedz -- Straight To Video
        stats.set_bool('MPX_AWD_MONKEY_C_MONKEY_DO', true) -- Camhedz -- Monkey See Monkey Do
        stats.set_bool('MPX_AWD_TRAINED_TO_KILL', true) -- Camhedz -- Trained to Kill
        stats.set_bool('MPX_AWD_DIRECTOR', true) -- Camhedz -- The Director
        stats.set_int('MPX_AWD_SHARPSHOOTER', 40) -- Badlands Revenge II -- Sharpshooter
        stats.set_int('MPX_AWD_RACECHAMP', 40) -- Race and Chase -- Race Champion
        stats.set_int('MPX_AWD_BATSWORD', 1000000) -- The Wizard's Ruin -- Platinum Sword
        stats.set_int('MPX_AWD_COINPURSE', 950000) -- The Wizard's Ruin -- Platinum Sword -- Coin Purse
        stats.set_int('MPX_AWD_ASTROCHIMP', 3000000) -- Space Monkey 3: Bananas Gone Bad -- Astrochimp
        stats.set_int('MPX_AWD_MASTERFUL', 40000) -- Penetrator -- Masterful
        stats.set_int('MPX_SCGW_NUM_WINS_GANG_0', 55) -- Street Crimes: Gang Wars Edition -- Win 20 games with character 1
        stats.set_int('MPX_SCGW_NUM_WINS_GANG_1', 56) -- Street Crimes: Gang Wars Edition -- Win 20 games with character 2
        stats.set_int('MPX_SCGW_NUM_WINS_GANG_2', 57) -- Street Crimes: Gang Wars Edition -- Win 20 games with character 3
        stats.set_int('MPX_SCGW_NUM_WINS_GANG_3', 58) -- Street Crimes: Gang Wars Edition -- Win 20 games with character 4
        stats.set_int('MPX_IAP_MAX_MOON_DIST', 2147483647) -- Invade and Persuade II -- Travel 3,474,000km on the moon
        stats.set_int('MPX_LAST_ANIMAL', 108) -- Invade and Persuade II -- Kill 100 animals in a single playthrough
        stats.set_int('MPX_CH_ARC_CAB_CLAW_TROPHY', -1) -- Kitty Claw Trophy
        stats.set_int('MPX_CH_ARC_CAB_LOVE_TROPHY', -1) -- The Love Professor Trophy
        stats.set_int('MPX_AWD_FACES_OF_DEATH', 50) -- Camhedz -- Faces Of Death
        stats.set_int("MPX_AWD_COLD_CALLER", 50)
        stats.set_int("MPX_AWD_PRODUCER", 60)
        stats.set_int("MPX_AWD_CONTRACTOR", 50)
        stats.set_int("MPX_FIXER_SC_VEH_RECOVERED", 100)
        stats.set_int("MPX_FIXER_SC_VAL_RECOVERED", 100)
        stats.set_int("MPX_FIXER_SC_GANG_TERMINATED", 100)
        stats.set_int("MPX_FIXER_SC_VIP_RESCUED", 100)
        stats.set_int("MPX_FIXER_SC_ASSETS_PROTECTED", 100)
        stats.set_int("MPX_FIXER_SC_EQ_DESTROYED", 100)
        stats.set_int("MPX_FIXER_COUNT", 600)
        stats.set_int("MPX_FIXER_EARNINGS", 26340756)
        stats.set_int("MPX_PAYPHONE_BONUS_KILL_METHOD", -1)
        stats.set_int("MPX_FIXER_HQ_OWNED", 1) -- Trade Price for buffalo4
        stats.set_int("MPX_FIXER_GENERAL_BS", -8577) -- Trade price for champion/baller7
        stats.set_int("MPX_FIXER_COMPLETED_BS", -1) -- Complete all The Contract missions.
        stats.set_bool("MPX_AWD_TEEING_OFF", true)
        stats.set_bool("MPX_AWD_PARTY_NIGHT", true)
        stats.set_bool("MPX_AWD_BILLIONAIRE_GAMES", true)
        stats.set_bool("MPX_AWD_HOOD_PASS", true)
        stats.set_bool("MPX_AWD_STUDIO_TOUR", true)
        stats.set_bool("MPX_AWD_DONT_MESS_DRE", true)
        stats.set_bool("MPX_AWD_BACKUP", true)
        stats.set_bool("MPX_AWD_SHORTFRANK_1", true)
        stats.set_bool("MPX_AWD_SHORTFRANK_2", true)
        stats.set_bool("MPX_AWD_SHORTFRANK_3", true)
        stats.set_bool("MPX_AWD_CONTR_KILLER", true)
        stats.set_bool("MPX_AWD_DOGS_BEST_FRIEND", true)
        stats.set_bool("MPX_AWD_MUSIC_STUDIO", true)
        stats.set_bool("MPX_AWD_SHORTLAMAR_1", true)
        stats.set_bool("MPX_AWD_SHORTLAMAR_2", true)
        stats.set_bool("MPX_AWD_SHORTLAMAR_3", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_SETUP", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_STRAND", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_PARTY", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_PARTY_2", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_PARTY_F", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_BILL", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_BILL_2", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_BILL_F", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_HOOD", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_HOOD_2", true)
        stats.set_bool("MPX_BS_IMANI_D_APP_HOOD_F", true)
        stats.set_packed_stat_bool(32312, true)
        stats.set_int('MPX_REV_NV_KILLS', 50) -- Navy Revolver Kills
        stats.set_int("MPX_XM22_FLOW", -1) -- Acid Lab Unlock
        stats.set_int("MPX_XM22_MISSIONS", -1) -- Acid Lab Unlock
        stats.set_int("MPX_AWD_CALLME", tunables.get_int(654710993)) -- Acid Lab Equipment Unlock
        stats.set_int("MPX_H3_VEHICLESUSED", -1) -- Trade Price for Diamond Casino Heist Finale.
        stats.set_int("MPX_H4_H4_DJ_MISSIONS", -1) -- Trade Price for weevil
        stats.set_int("MPX_H4_PROGRESS", -1) -- Trade Price for winky
        stats.set_int("MPX_TUNER_GEN_BS", -1) -- Trade Price for tailgater2
        stats.set_int("MPX_ULP_MISSION_PROGRESS", -1) -- Trade Price greenwood/conada
        stats.set_int("MPX_SUM23_AVOP_PROGRESS", -1) -- Trade Price Raiju
        stats.set_int("MPX_GANGOPS_FLOW_BITSET_MISS0", -1) -- Trade Price for deluxo/akula/riot2/stromberg/chernobog/barrage/khanjali/volatol/thruster
        stats.set_bool("MPX_AWD_TAXISTAR", true) -- Trade Price for taxi
        stats.set_bool("MPPLY_AWD_HST_ORDER", true)
        stats.set_bool("MPPLY_AWD_HST_SAME_TEAM", true)
        stats.set_bool("MPPLY_AWD_HST_ULT_CHAL", true)
        stats.set_int("MPPLY_HEISTFLOWORDERPROGRESS", -1)
        stats.set_int("MPPLY_HEISTNODEATHPROGREITSET", -1)
        stats.set_int("MPPLY_HEISTTEAMPROGRESSBITSET", -1)
        stats.set_int("MPX_AT_FLOW_VEHICLE_BS", -1) -- Trade price for dune4/dune5/wastelander/blazer5/phantom2/voltic2/technical2/boxville5/ruiner2
        stats.set_int("MPX_LFETIME_HANGAR_BUY_COMPLET", 50) -- Trade price for microlight/rogue/alphaz1/havok/starling/molotok/tula/bombushka/howard/mogul/pyro/seabreeze/nokota/hunter
        stats.set_int("MPX_SALV23_GEN_BS", -1) -- polgauntlet trade price
        stats.set_int("MPX_SALV23_SCOPE_BS", -1) -- police5 trade price
        stats.set_int("MPX_MOST_TIME_ON_3_PLUS_STARS", 300000) -- police4 trade price
        stats.set_int("MPX_LOWRIDER_FLOW_COMPLETE", 1)
        stats.set_int("MPX_AT_FLOW_MISSION_PROGRESS", 50)
        stats.set_int("MPX_AT_FLOW_IMPEXP_NUM", 50)
        stats.set_int("MPX_AT_FLOW_BITSET_MISSIONS0", -1)
        stats.set_int("MPX_WVM_FLOW_MISSION_PROGRESS", 50)
        stats.set_int("MPX_WVM_FLOW_IMPEXP_NUM", 50)
        stats.set_int("MPX_WVM_FLOW_BITSET_MISSIONS0", -1)
        stats.set_int("MPX_WVM_FLOW_VEHICLE_BS", -1)
        stats.set_int("MPX_GANGOPS_FLOW_MISSION_PROG", -1)
        stats.set_int("MPX_GANGOPS_FLOW_IMPEXP_NUM", 50)
        stats.set_int("MPX_WAM_FLOW_VEHICLE_BS", -1)
        stats.set_int("MPX_GANGOPS_FLOW_PASSED_BITSET", -1)
        stats.set_int("MPX_VCM_FLOW_PROGRESS", -1)
        stats.set_int("MPX_TUNER_FLOW_BS", -1)
        stats.set_int("MPX_TUNER_MIS_BS", -1)
        stats.set_int("MPX_TUNER_COMP_BS", -1)
        stats.set_int("MPX_GANGOPS_FM_MISSION_PROG", -1)
        stats.set_int("MPX_GANGOPS_FM_BITSET_MISS0", -1)
        stats.set_bool("MPX_UNLOCKED_MESSAGE_FLEECA", true)
        stats.set_bool("MPX_CARMEET_PV_CHLLGE_CMPLT", true)
        --Make it think you've beat all the heists as leader.
        stats.set_int("MPX_HEIST_SAVED_STRAND_0", tunables.get_int('ROOT_ID_HASH_THE_FLECCA_JOB'))
        stats.set_int("MPX_HEIST_SAVED_STRAND_0_L", 5)
        stats.set_int("MPX_HEIST_SAVED_STRAND_1", tunables.get_int('ROOT_ID_HASH_THE_PRISON_BREAK'))
        stats.set_int("MPX_HEIST_SAVED_STRAND_1_L", 5)
        stats.set_int("MPX_HEIST_SAVED_STRAND_2", tunables.get_int('ROOT_ID_HASH_THE_HUMANE_LABS_RAID'))
        stats.set_int("MPX_HEIST_SAVED_STRAND_2_L", 5)
        stats.set_int("MPX_HEIST_SAVED_STRAND_3", tunables.get_int('ROOT_ID_HASH_SERIES_A_FUNDING'))
        stats.set_int("MPX_HEIST_SAVED_STRAND_3_L", 5)
        stats.set_int("MPX_HEIST_SAVED_STRAND_4", tunables.get_int('ROOT_ID_HASH_THE_PACIFIC_STANDARD_JOB'))
        stats.set_int("MPX_HEIST_SAVED_STRAND_4_L", 5)
        stats.set_int("MPX_LIFETIME_BUY_COMPLETE", 1025)
        stats.set_int("MPX_LIFETIME_BUY_UNDERTAKEN", 1025)
        stats.set_int("MPX_LIFETIME_SELL_COMPLETE", 1025)
        stats.set_int("MPX_LIFETIME_SELL_UNDERTAKEN", 1025)
        stats.set_int("MPX_LIFETIME_CONTRA_EARNINGS", 25000000) --Contraband Earnings
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET1", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA1", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET1", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA1", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET2", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA2", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET2", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA2", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET3", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA3", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET3", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA3", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET4", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA4", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET4", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA4", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET5", 1025)
        stats.set_int("MPX_LFETIME_BIKER_BUY_UNDERTA5", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET5", 1025)
        stats.set_int("MPX_LFETIME_BIKER_SELL_UNDERTA5", 1025)
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS0", 25000000)
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS1", 25000000)
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS2", 25000000)
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS3", 25000000)
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS4", 25000000)
        stats.set_int("MPX_LFETIME_BIKER_BUY_COMPLET6", 10) --Allow buying of Stank Breath acid name.
        stats.set_int("MPX_LFETIME_BIKER_SELL_COMPLET6", 10) --Allow buying of Squatch Bait acid name.
        stats.set_packed_stat_int(41241, 5) --Allow buying of Chair Shot acid name.
        stats.set_int("MPX_LIFETIME_BKR_SELL_EARNINGS6", 1000000) --Allow buying of Fck Your Sleep acid name.
        stats.set_packed_stat_int(7666, 25) --Fill CEO office with money
        unlock_packed_bools(7553, 7594) --Fill CEO office with junk
        stats.set_packed_stat_int(9357, 4) --Fill Clubhouse with money
        unlock_packed_bools(9400, 9414) --Fill Clubhouse with junk
        stats.set_int("MPX_XMAS2023_ADV_MODE_WINS", 6) --Unlock Christmas 2023 liveries.
        stats.set_int("MPPLY_XMAS23_PLATES0", 3) -- ECola & Sprunk Plates
        stats.set_int("MPX_COUNT_HOTRING_RACE", 20) -- Liveries for hotring
        stats.set_int("MPX_FINISHED_SASS_RACE_TOP_3", 20) -- Trade price for hotring/everon2
        for i = 0, 2 do --Unlock all daily rewards.
            local objective = globals.get_int(current_objectives_global + (1 + (0 * 5569)) + 681 + 4243 + (1 + (i * 3)))
            globals.set_int(objectives_state_global + 1 + (1 + (i * 1)), objective)
        end
        globals.set_int(objectives_state_global, 1)
        globals.set_int(weekly_words_global + (1 + (0 * 6)) + 1, globals.get_int(weekly_words_global + (1 + (0 * 6)) + 2)) --Unlock Weekly Objective
        gui.show_message('WasabiWordsTM', 'Clichés Subverted')
	end)
end)
toolTip(Stats, "Unlocks everything in the game, untouched script by ShinyWasabi")

-- Autorun Drops
 Money = KAOS:add_tab("Money Options")
-- Drops = Money:add_tab("Drops")


--Drops:add_separator()
--Drops:add_text("You CAN run multiple at once (like Robot bubblegum/Alien)")
--Drops:add_text("Select a Player from the list and toggle");

-- Teleports tab - Credits to USBMenus https://github.com/Deadlineem/Extras-Addon-for-YimMenu/issues/9#issuecomment-1955881222

 Tel = Pla:add_tab("Teleports")

-- Define your array with names and IDs
 properties = {
    {name = "Safehouse", id = 40}, {name = "Office", id = 475}, {name = "Arena", id = 643}, {name = "Bunker", id = 557}, {name = "Arcade", id = 740},
    {name = "Auto Shop", id = 779}, {name = "Agency", id = 826}, {name = "Clubhouse", id = 492}, {name = "Hangar", id = 569}, {name = "Facility", id = 590},
    {name = "Night Club", id = 614}, {name = "Freakshop", id = 847}, {name = "Salvage Yard", id = 867}, {name = "Eclipse Garage", id = 856}, {name = "Yacht", id = 455},
    {name = "Kosatka", id = 760},
    -- Add more properties as needed
    -- Cayo Drainage = 768
}

 function findNearestBlip(propertyId)
     ped = PLAYER.PLAYER_PED_ID()
     minDistanceSquared = math.huge
     nearestBlipId = nil
     iterator = propertyId
     blipId = HUD.GET_FIRST_BLIP_INFO_ID(iterator)
    while blipId ~= 0 do
         blipCoords = HUD.GET_BLIP_COORDS(blipId)
         distanceSquared = MISC.GET_DISTANCE_BETWEEN_COORDS(ped, blipCoords.x, blipCoords.y, blipCoords.z, 1, 0, false)
        if distanceSquared < minDistanceSquared and blipId ~= propertyId then
            minDistanceSquared = distanceSquared
            nearestBlipId = blipId
        end
        blipId = HUD.GET_NEXT_BLIP_INFO_ID(iterator)
    end
    return nearestBlipId
end


 function addBlips(array)
    for k in pairs(array) do
        array[k] = nil
    end
    for _, property in ipairs(properties) do
         ped = PLAYER.PLAYER_PED_ID()
         nearestBlipId = findNearestBlip(property.id)
        if nearestBlipId then
             blipCoords = HUD.GET_BLIP_COORDS(nearestBlipId)
            if property.id == 760 then
                table.insert(array, {property.name, blipCoords.x, blipCoords.y, blipCoords.z + 8})
            elseif property.id == 740 then
                table.insert(array, {property.name, blipCoords.x + 10, blipCoords.y - 5, blipCoords.z})
            else
                table.insert(array, {property.name, blipCoords.x, blipCoords.y, blipCoords.z})
            end
        end
    end
end

 locationIndex = 0
 locationTypeIndex = 0

locationTypes = {"Custom", "Owned"}

customCoords = {
    {"Eclipse Towers Front Door", -774.77, 312.19, 85.70},
    {"Casino", 922.223938, 49.779373, 80.764793},
    {"LS Customs", -370.269958, -129.910370, 38.681633},
    {"Eclipse Towers", -773.640869, 305.234619, 85.705841},
    {"Record A Studios", -835.250427, -226.589691, 37.267345},
    {"Luxury Autos", -796.260986, -245.412369, 37.079193},
    {"Suburban", -1208.171387, -782.429016, 17.157467},
    {"Mask Shop", -1339.069946, -1279.114502, 4.866990},
    {"Poisonby's", -719.559692, -157.998932, 36.998993},
    {"Benny's", -205.040863, -1305.484009, 31.369892},
}

ownedCoords = {}

locations = {customCoords, ownedCoords}

Tel:add_imgui(function()
    addBlips(ownedCoords)
    copyLocation = ImGui.Button("Copy Location To Clipboard")
    toolTip("", "Copies your current location to the clipboard for adding custom coordinates to the menu.")
    locationTypeIndex, locationTypeSelected = ImGui.Combo("Location Type", locationTypeIndex, locationTypes, #locationTypes)
    toolTip("", "Select a Location Type (Custom Locations | Owned Properties)")
    locationNames = {}
    for i, location in ipairs(locations[locationTypeIndex + 1]) do
        table.insert(locationNames, location[1])
    end
    locationIndex, locationSelected = ImGui.ListBox("Locations", locationIndex, locationNames, #locationNames)
    if locationSelected then
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), locations[locationTypeIndex + 1][locationIndex + 1][2], locations[locationTypeIndex + 1][locationIndex + 1][3], locations[locationTypeIndex + 1][locationIndex + 1][4] - 1, true, false, false, false)
    end
    toolTip("", "Click to teleport to this location")
    if copyLocation then
        coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        coordsString = coords.x.. ", ".. coords.y.. ", ".. coords.z
        gui.show_message("Clipboard", "Copied ".. coordsString.. " to clipboard.")
        ImGui.SetClipboardText(coordsString)
    end
end)
 Yim_Actions = Pla:add_tab("Samurai's Yim_Actions")
 anim_index = 0
 scenario_index = 0
 npc_index = 0
 switch = 0
 filteredAnims = {}
 filteredScenarios = {}
 searchQuery = ""
 is_typing = false
 searchBar = true
 x = 0
 counter = 0
 clumsy = false
 rod = false
plyrProps = {}
npcProps = {}
selfPTFX = {}
npcPTFX = {}
spawned_npcs = {}
is_playing_anim = false
is_playing_scenario = false
disableProps = false
npc_godMode = false
 disableTooltips = false
 phoneAnim = false
 sprintInside = false
 lockPick = false
 manualFlags = false
 controllable = false
 looped = false
 upperbody = false
 freeze = false
 usePlayKey = false
script.register_looped("game input", function()
        if is_typing then
            PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
        end
        if PAD.IS_USING_KEYBOARD_AND_MOUSE() then
            stopButton = "[G]"
        else
            stopButton = "[DPAD LEFT]"
        end
end)
 function updatefilteredAnims()
    filteredAnims = {}
    for _, anim in ipairs(animlist) do
        if string.find(string.lower(anim.name), string.lower(searchQuery)) then
            table.insert(filteredAnims, anim)
        end
    end
    table.sort(animlist, function(a, b)
        return a.name < b.name
    end)
end
 function displayFilteredAnims()
    updatefilteredAnims()
     animNames = {}
    for _, anim in ipairs(filteredAnims) do
        table.insert(animNames, anim.name)
    end
    anim_index, used = ImGui.ListBox("##animlistbox", anim_index, animNames, #filteredAnims)
end
 function updateNpcs()
    filteredNpcs = {}
    for _, npc in ipairs(npcList) do
            table.insert(filteredNpcs, npc)
    end
    table.sort(filteredNpcs, function(a, b)
        return a.name < b.name
    end)
end
 function displayNpcs()
    updateNpcs()
     npcNames = {}
    for _, npc in ipairs(filteredNpcs) do
        table.insert(npcNames, npc.name)
    end
    npc_index, used = ImGui.Combo("##npcList", npc_index, npcNames, #filteredNpcs)
end
 function setmanualflag()
    if looped then
        flag_loop = 1
    else
        flag_loop = 0
    end
    if freeze then
        flag_freeze = 2
    else
        flag_freeze = 0
    end
    if upperbody then
        flag_upperbody = 16
    else
        flag_upperbody = 0
    end
    if controllable then
        flag_control = 32
    else
        flag_control = 0
    end
    flag = flag_loop + flag_freeze + flag_upperbody + flag_control
end
 function setdrunk()
    script.run_in_fiber(function()
        while not STREAMING.HAS_CLIP_SET_LOADED("MOVE_M@DRUNK@VERYDRUNK") do
            STREAMING.REQUEST_CLIP_SET("MOVE_M@DRUNK@VERYDRUNK")
            coroutine.yield()
        end
        PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
    end)
end
 function sethoe()
    script.run_in_fiber(function()
        while not STREAMING.HAS_CLIP_SET_LOADED("move_f@maneater") do
            STREAMING.REQUEST_CLIP_SET("move_f@maneater")
            coroutine.yield()
        end
        PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), "move_f@maneater", 1.0)
    end)
end
 function setcrouched()
    script.run_in_fiber(function()
        while not STREAMING.HAS_CLIP_SET_LOADED("move_ped_crouched") do
            STREAMING.REQUEST_CLIP_SET("move_ped_crouched")
            coroutine.yield()
        end
        PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), "move_ped_crouched", 0.3)
    end)
end
 function setlester()
    script.run_in_fiber(function()
        while not STREAMING.HAS_CLIP_SET_LOADED("move_heist_lester") do
            STREAMING.REQUEST_CLIP_SET("move_heist_lester")
            coroutine.yield()
        end
        PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), "move_heist_lester", 0.4)
    end)
end
 function setballistic()
    script.run_in_fiber(function()
        while not STREAMING.HAS_CLIP_SET_LOADED("anim_group_move_ballistic") do
            STREAMING.REQUEST_CLIP_SET("anim_group_move_ballistic")
            coroutine.yield()
        end
        PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), "anim_group_move_ballistic", 1)           
    end)
end
function resetCheckBoxes()
    disableTooltips = false
    phoneAnim = false
    lockPick = false
    sprintInside = false
    clumsy = false
    rod = false
    disableProps = false
    manualFlags = false
    controllable = false
    looped = false
    upperbody = false
    freeze = false
    usePlayKey = false
end
script.register_looped("onlineStatus", function(onlineStatus)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        is_online = true
    else
        is_online = false
    end
    onlineStatus:yield()
end)
script.register_looped("Ragdoll Loop", function(script)
    script:yield()
    if clumsy then
        if PED.IS_PED_RAGDOLL(PLAYER.PLAYER_PED_ID()) then
            script:sleep(2500)
            return
        end
        PED.SET_PED_RAGDOLL_ON_COLLISION(PLAYER.PLAYER_PED_ID(), true)
    elseif rod then
        if PAD.IS_CONTROL_PRESSED(0, 252) then
            PED.SET_PED_TO_RAGDOLL(PLAYER.PLAYER_PED_ID(), 1500, 0, 0, false)
        end
    end
    script:yield()
end)
script.register_looped("follow ped", function(follow)
    for k, v in ipairs(spawned_npcs) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
            if ENTITY.IS_ENTITY_DEAD(v) then
                follow:sleep(3000)
                PED.DELETE_PED(v)
                table.remove(spawned_npcs, k)
            elseif PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and not PED.IS_PED_SITTING_IN_ANY_VEHICLE(v) then
                veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                if VEHICLE.IS_VEHICLE_SEAT_FREE(veh, 0, 0) then
                    seat = 0
                else
                    seat = tostring(k)
                end
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
                TASK.TASK_ENTER_VEHICLE(v, veh, 20000, seat, 2.0, 16, 0)
                follow:sleep(2000)
            elseif PED.IS_PED_SITTING_IN_ANY_VEHICLE(v) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                TASK.CLEAR_PED_TASKS(v)
                TASK.TASK_LEAVE_VEHICLE(v, veh, 0)
                TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(v, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
            end
        end
        follow:yield()
    end
    
    if VEHICLE.IS_THIS_MODEL_A_BIKE(ENTITY.GET_ENTITY_MODEL(veh)) then
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 424, true)
    end
end)
Yim_Actions:add_imgui(function()
    if searchBar then
        ImGui.PushItemWidth(270)
        searchQuery, used = ImGui.InputTextWithHint("##searchBar", "Search", searchQuery, 32)
        if ImGui.IsItemActive() then
            is_typing = true
        else
            is_typing = false
        end
    end
    ImGui.BeginTabBar("Samurai's Yim_Actions", ImGuiTabBarFlags.None)
    if ImGui.BeginTabItem("Animations") then
        ImGui.PushItemWidth(345)
        displayFilteredAnims()
        info = filteredAnims[anim_index + 1]
        ImGui.Separator()
        manualFlags, used = ImGui.Checkbox("Edit Flags", manualFlags, true)
        helpmarker(false, "Allows you to customize how the animation plays.\nExample: if an animation is set to loop but you want it to freeze, activate this then choose your desired settings.")
        ImGui.SameLine()
        disableProps, used = ImGui.Checkbox("Disable Props", disableProps, true)
        helpmarker(false, "Choose whether to play animations with props or not. Check or Un-check this before playing the animation.")
        if manualFlags then
            ImGui.Separator()
            controllable, used = ImGui.Checkbox("Allow Control", controllable, true)
            helpmarker(false, "Allows you to keep control of your character and/or vehicle. If paired with 'Upper Body Only', you can play animations and walk/run/drive around.")
            ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
            looped, used = ImGui.Checkbox("Loop", looped, true)
            helpmarker(false, "Plays the animation forever until you manually stop it.")
            upperbody, used = ImGui.Checkbox("Upper Body Only", upperbody, true)
            helpmarker(false, "Only plays the animation on you character's upperbody (from the waist up).")
            ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
            freeze, used = ImGui.Checkbox("Freeze", freeze, true)
            helpmarker(false, "Freezes the animation at the very last frame. Useful for ragdoll/sleeping/dead animations.")
        end
        function cleanup()
            script.run_in_fiber(function()
                TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                STREAMING.REMOVE_ANIM_DICT(info.dict)
                STREAMING.REMOVE_NAMED_PTFX_ASSET(info.ptfxdict)
                if plyrProps[1] ~= nil then
                    for k, v in ipairs(plyrProps) do
                        script.run_in_fiber(function(script)
                            if ENTITY.DOES_ENTITY_EXIST(v) then
                                PED.DELETE_PED(v)
                            end
                            if ENTITY.DOES_ENTITY_EXIST(v) then
                                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v)
                                script:sleep(100)
                                ENTITY.DELETE_ENTITY(v)
                            end
                        end)
                        table.remove(plyrProps, k)
                    end
                end
                if selfPTFX[1] ~= nil then
                    for k, v in ipairs(selfPTFX) do
                        script.run_in_fiber(function()
                            GRAPHICS.STOP_PARTICLE_FX_LOOPED(v)
                        end)
                        table.remove(selfPTFX, k)
                    end
                end
            end)
        end
        if ImGui.Button("   Play   ") then
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
             heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
             forwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
             forwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
             boneIndex = PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), info.boneID)
             bonecoords = PED.GET_PED_BONE_COORDS(PLAYER.PLAYER_PED_ID(), info.boneID)
            if manualFlags then
                setmanualflag()
            else
                flag = info.flag
            end
            playSelected(PLAYER.PLAYER_PED_ID(), selfprop1, selfprop2, selfloopedFX, selfSexPed, boneIndex, coords, heading, forwardX, forwardY, bonecoords, "self", plyrProps, selfPTFX)
            is_playing_anim = true
        end
        ImGui.SameLine()
        if ImGui.Button("   Stop   ") then
            if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                cleanup()
                 veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
            else
                cleanup()
                 current_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), current_coords.x, current_coords.y, current_coords.z, true, false, false)
            end
            is_playing_anim = false
        end
        widgetToolTip(false, "TIP: You can also stop animations by pressing [G] on keyboard or [DPAD LEFT] on controller.")
        ImGui.SameLine()
         errCol = {}
        if plyrProps[1] ~= nil then
            errCol = {104, 247, 114, 0.2}
        else
            errCol = {225, 0, 0, 0.5}
        end
        if Button("Remove Attachments", {104, 247, 114, 0.6}, {104, 247, 114, 0.5}, errCol) then
            all_objects = entities.get_all_objects_as_handles()
            for _, v in ipairs(all_objects) do
                script.run_in_fiber(function()
                    modelHash = ENTITY.GET_ENTITY_MODEL(v)
                    attachedObject = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(PLAYER.PLAYER_PED_ID(), modelHash)
                    if ENTITY.DOES_ENTITY_EXIST(attachedObject) then
                        ENTITY.DETACH_ENTITY(attachedObject)
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(attachedObject)
                        TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                    end
                end)
            end
            all_peds = entities.get_all_peds_as_handles()
            for _, p in ipairs(all_peds) do
                script.run_in_fiber(function()
                    pedHash = ENTITY.GET_ENTITY_MODEL(p)
                    attachedPed = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(PLAYER.PLAYER_PED_ID(), pedHash)
                    if ENTITY.DOES_ENTITY_EXIST(attachedPed) then
                        ENTITY.DETACH_ENTITY(attachedPed)
                        TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                        TASK.CLEAR_PED_TASKS(attachedPed)
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(attachedPed)
                    end
                end)
            end
            is_playing_anim = false
            if plyrProps[1] ~= nil then
                for k, _ in ipairs(plyrProps) do
                    plyrProps[k] = nil
                end
            else
                gui.show_error("YimActions", "There are no objects or peds attached.")
            end
        end
        widgetToolTip(false, "Detaches all props.")
        ImGui.Separator()
        ImGui.Text("Ragdoll Options:")
        ImGui.Spacing()
        clumsy, used = ImGui.Checkbox("Clumsy", clumsy, true)
        if clumsy then
            rod = false
        end
        widgetToolTip(false, "Makes You Ragdoll When You Collide With Any Object.\n(Doesn't work with Ragdoll On Demand)")
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        rod, used = ImGui.Checkbox("Ragdoll On Demand", rod, true)
        if rod then
            clumsy = false
        end
        widgetToolTip(false, "Press [X] On Keyboard or [LT] On Controller To Instantly Ragdoll. The Longer You Hold The Button, The Longer You Stay On The Ground.\n(Doesn't work with Clumsy)")
        ImGui.Spacing()
        ImGui.Text("Movement Options:")
        ImGui.Spacing()
         isChanged = false
        switch, isChanged = ImGui.RadioButton("Normal", switch, 0)
        if isChanged then
            PED.RESET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), 0.0)
            isChanged = false
        end
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        switch, isChanged = ImGui.RadioButton("Drunk", switch, 1)
        widgetToolTip(false, "Works Great With Ragdoll Options.")
        if isChanged then setdrunk() end
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        switch, isChanged = ImGui.RadioButton("Hoe", switch, 2)
        if isChanged then sethoe() end
        switch, isChanged = ImGui.RadioButton("Crouch", switch, 3)
        widgetToolTip(false, "You can pair this with the default stealth action [LEFT CTRL].")
        if isChanged then setcrouched() end
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        switch, isChanged = ImGui.RadioButton("Lester", switch, 4)
        if isChanged then setlester() end
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        switch, isChanged = ImGui.RadioButton("Heavy", switch, 5)
        if isChanged then setballistic() end
        ImGui.Separator()
        ImGui.Text("Play Animations On NPCs:")
        ImGui.SameLine()
        coloredText("[Work In Progress]", {247, 185, 104, 0.78})
        ImGui.PushItemWidth(200)
        displayNpcs()
        ImGui.PopItemWidth()
        ImGui.SameLine()
         npcData = filteredNpcs[npc_index + 1]
        function cleanupNPC()
            script.run_in_fiber(function()
                for _, v in ipairs(spawned_npcs) do
                    TASK.CLEAR_PED_TASKS(v)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
                end
                if npcProps[1] ~= nil then
                    for k, v in ipairs(npcProps) do
                        script.run_in_fiber(function(script)
                            if ENTITY.DOES_ENTITY_EXIST(v) then
                                PED.DELETE_PED(v)
                            end
                            if ENTITY.DOES_ENTITY_EXIST(v) then
                                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v)
                                script:sleep(100)
                                ENTITY.DELETE_ENTITY(v)
                            end
                        end)
                        table.remove(npcProps, k)
                    end
                end
                if ENTITY.DOES_ENTITY_EXIST(npcSexPed) then
                    PED.DELETE_PED(npcSexPed)
                end
                if npcPTFX[1] ~= nil then
                    for key, value in ipairs(npcPTFX) do
                        script.run_in_fiber(function()
                            GRAPHICS.STOP_PARTICLE_FX_LOOPED(value)
                        end)
                        table.remove(npcPTFX, key)
                    end
                end
                STREAMING.REMOVE_ANIM_DICT(info.dict)
                STREAMING.REMOVE_NAMED_PTFX_ASSET(info.ptfxdict)
            end)
        end
        npc_godMode, used = ImGui.Checkbox("Invincible", npc_godMode, true)
        widgetToolTip(false, "Spawn NPCs in godmode.")
        if ImGui.Button("Spawn") then
            script.run_in_fiber(function(script)
                 pedCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                 pedHeading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                 pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
                 pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
                while not STREAMING.HAS_MODEL_LOADED(npcData.hash) do
                    STREAMING.REQUEST_MODEL(npcData.hash)
                    coroutine.yield()
                end
                npc = PED.CREATE_PED(npcData.group, npcData.hash, 0.0, 0.0, 0.0, 0.0, true, false)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(npc, pedCoords.x + pedForwardX * 1.4, pedCoords.y + pedForwardY * 1.4, pedCoords.z, true, false, false)
                ENTITY.SET_ENTITY_HEADING(npc, pedHeading - 180)
                table.insert(spawned_npcs, npc)
                npcNetID2 = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(npc)
                controlled = entities.take_control_of(npc, 300)
                script:sleep(500)
                entToNet(npcNetID2)
                TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(npc, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(npc, true)
                if npc_godMode then
                    ENTITY.SET_ENTITY_INVINCIBLE(npc, true)
                end
            end)
        end
        ImGui.SameLine()
        if ImGui.Button("Delete") then
            cleanupNPC()
            script.run_in_fiber(function()
                for k, v in ipairs(spawned_npcs) do
                    ENTITY.DELETE_ENTITY(v)
                    table.remove(spawned_npcs, k)
                end
            end)
        end
        ImGui.SameLine()
        if ImGui.Button(" Play On NPC ") then
            if spawned_npcs[1] ~= nil then
                for _, v in ipairs(spawned_npcs) do
                    if ENTITY.DOES_ENTITY_EXIST(v) then
                         npcCoords = ENTITY.GET_ENTITY_COORDS(v, false)
                         npcHeading = ENTITY.GET_ENTITY_HEADING(v)
                         npcForwardX = ENTITY.GET_ENTITY_FORWARD_X(v)
                         npcForwardY = ENTITY.GET_ENTITY_FORWARD_Y(v)
                         npcBoneIndex = PED.GET_PED_BONE_INDEX(v, info.boneID)
                         npcBboneCoords = PED.GET_PED_BONE_COORDS(v, info.boneID)
                        if manualFlags then
                            setmanualflag()
                        else
                            flag = info.flag
                        end
                        playSelected(v, npcprop1, npcprop2, npcloopedFX, npcSexPed, npcBoneIndex, npcCoords, npcHeading, npcForwardX, npcForwardY, npcBboneCoords, "npc", npcProps, npcPTFX)
                    end
                end
            else
                gui.show_error("Yim_Actions", "Spawn an NPC first!")
            end
        end
        ImGui.SameLine()
        if ImGui.Button("Stop NPC") then
            cleanupNPC()
            for _, v in ipairs(spawned_npcs) do
                script.run_in_fiber(function()
                    TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(v, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
                    if PED.IS_PED_IN_ANY_VEHICLE(v, false) then
                         veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                        PED.SET_PED_INTO_VEHICLE(v, veh, 0)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
                    end
                end)
            end
        end
        event.register_handler(menu_event.ScriptsReloaded, function()
            PED.RESET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), 0.0)
            PED.SET_PED_RAGDOLL_ON_COLLISION(PLAYER.PLAYER_PED_ID(), false)
            if is_playing_anim then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                STREAMING.REMOVE_NAMED_PTFX_ASSET(info.ptfxdict)
                STREAMING.REMOVE_ANIM_DICT(info.dict)
                if selfPTFX ~= nil then
                    for k, v in ipairs(selfPTFX) do
                        GRAPHICS.STOP_PARTICLE_FX_LOOPED(v)
                        table.remove(selfPTFX, k)
                    end
                end
            -- //fix player clipping through the ground after ending low-positioned anims//
                 current_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                     veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
                else
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), current_coords.x, current_coords.y, current_coords.z, true, false, false)
                end
                is_playing_anim = false
                if plyrProps[1] ~= nil then
                    for k, v in ipairs(plyrProps) do
                        if ENTITY.DOES_ENTITY_EXIST(v) then
                            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v)
                            script:sleep(100)
                            ENTITY.DELETE_ENTITY(v)
                        end
                        table.remove(plyrProps, k)
                    end
                end
            end
            if spawned_npcs[1] ~= nil then
                cleanupNPC()
                for k, v in ipairs(spawned_npcs) do
                    if ENTITY.DOES_ENTITY_EXIST(v) then
                        ENTITY.DELETE_ENTITY(v)
                    end
                    table.remove(plyrProps, k)
                end
            end
        end)
        event.register_handler(menu_event.MenuUnloaded, function()
            PED.RESET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), 0.0)
            PED.SET_PED_RAGDOLL_ON_COLLISION(PLAYER.PLAYER_PED_ID(), false)
            if is_playing_anim then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                STREAMING.REMOVE_NAMED_PTFX_ASSET(info.ptfxdict)
                STREAMING.REMOVE_ANIM_DICT(info.dict)
                if selfPTFX ~= nil then
                    for k, v in ipairs(selfPTFX) do
                        GRAPHICS.STOP_PARTICLE_FX_LOOPED(v)
                        table.remove(selfPTFX, k)
                    end
                end
            -- //fix player clipping through the ground after ending low-positioned anims//
                 current_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                     veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
                else
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), current_coords.x, current_coords.y, current_coords.z, true, false, false)
                end
                is_playing_anim = false
                if plyrProps[1] ~= nil then
                    for k, v in ipairs(plyrProps) do
                        if ENTITY.DOES_ENTITY_EXIST(v) then
                            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v)
                            script:sleep(100)
                            ENTITY.DELETE_ENTITY(v)
                        end
                        table.remove(plyrProps, k)
                    end
                end
            end
            if spawned_npcs[1] ~= nil then
                for k, v in ipairs(spawned_npcs) do
                    if ENTITY.DOES_ENTITY_EXIST(v) then
                        ENTITY.DELETE_ENTITY(v)
                    end
                    table.remove(spawned_npcs, k)
                end
            end
        end)
        ImGui.EndTabItem()
    end
    if ImGui.BeginTabItem("Scenarios") then
        ImGui.PushItemWidth(335)
         function updatefilteredScenarios()
            filteredScenarios = {}
            for _, scene in ipairs(ped_scenarios) do
                if string.find(string.lower(scene.name), string.lower(searchQuery)) then
                    table.insert(filteredScenarios, scene)
                end
            end
        end
         function displayFilteredScenarios()
            updatefilteredScenarios()
             scenarioNames = {}
            for _, scene in ipairs(filteredScenarios) do
                table.insert(scenarioNames, scene.name)
            end
            scenario_index, used = ImGui.ListBox("##scenarioList", scenario_index, scenarioNames, #filteredScenarios)
        end
        displayFilteredScenarios()
        ImGui.Separator()
        if ImGui.Button("   Play    ") then
            if is_playing_anim then
                script.run_in_fiber(function()
                    TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                    ENTITY.DELETE_ENTITY(prop1)
                    ENTITY.DELETE_ENTITY(prop2)
                    GRAPHICS.STOP_PARTICLE_FX_LOOPED(loopedFX)
                    if ENTITY.DOES_ENTITY_EXIST(sexPed) then
                        PED.DELETE_PED(sexPed)
                    end
                end)
            end
             data = filteredScenarios[scenario_index+1]
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
             heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
             forwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
             forwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
            if data.name == "Cook On BBQ" then
                script.run_in_fiber(function()
                    while not STREAMING.HAS_MODEL_LOADED(286252949) do
                        STREAMING.REQUEST_MODEL(286252949)
                        coroutine.yield()
                    end
                    bbq = OBJECT.CREATE_OBJECT(286252949, coords.x + (forwardX), coords.y + (forwardY), coords.z, true, true, false)
                    ENTITY.SET_ENTITY_HEADING(bbq, heading)
                    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(bbq)
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                    TASK.TASK_START_SCENARIO_IN_PLACE(PLAYER.PLAYER_PED_ID(), data.scenario, -1, true)
                    is_playing_scenario = true
                end)
            else
                script.run_in_fiber(function()
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                    TASK.TASK_START_SCENARIO_IN_PLACE(PLAYER.PLAYER_PED_ID(), data.scenario, -1, true)
                    is_playing_scenario = true
                    if ENTITY.DOES_ENTITY_EXIST(bbq) then
                        ENTITY.DELETE_ENTITY(bbq)
                    end
                end)
            end
        end
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() 
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        if ImGui.Button("   Stop   ") then
            if is_playing_scenario then
                script.run_in_fiber(function(script)
                    busyspinner("Stopping scenario...", 3)
                    TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                    is_playing_scenario = false
                    script:sleep(1000)
                    HUD.BUSYSPINNER_OFF()
                    if ENTITY.DOES_ENTITY_EXIST(bbq) then
                        ENTITY.DELETE_ENTITY(bbq)
                    end
                end)
            end
        end
        widgetToolTip(false, "TIP: You can also stop scenarios by pressing [G] on keyboard or [DPAD LEFT] on controller.")
        ImGui.Separator()
        ImGui.Text("Play Scenarios On NPCs:")
        ImGui.SameLine()
        coloredText("[Work In Progress]", {247, 185, 104, 0.78})
        ImGui.PushItemWidth(200)
        displayNpcs()
        ImGui.PopItemWidth()
        ImGui.SameLine()
         npcData = filteredNpcs[npc_index + 1]
        npc_godMode, used = ImGui.Checkbox("Invincible", npc_godMode, true)
        widgetToolTip(false, "Spawn NPCs in godmode.")
        if ImGui.Button("Spawn") then
             pedCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
             pedHeading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
             pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
             pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
            script.run_in_fiber(function(script)
                while not STREAMING.HAS_MODEL_LOADED(npcData.hash) do
                    STREAMING.REQUEST_MODEL(npcData.hash)
                    coroutine.yield()
                end
                npc = PED.CREATE_PED(npcData.group, npcData.hash, 0.0, 0.0, 0.0, 0.0, true, false)
                ENTITY.SET_ENTITY_INVINCIBLE(npc, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(npc, pedCoords.x + pedForwardX * 1.4, pedCoords.y + pedForwardY * 1.4, pedCoords.z, true, false, false)
                ENTITY.SET_ENTITY_HEADING(npc, pedHeading - 180)
                table.insert(spawned_npcs, npc)
                npcNetID2 = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(npc)
                controlled = entities.take_control_of(npc, 300)
                entToNet(npcNetID2)
                TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(npc, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(npc, true) --keeps them from acting like pussies and running away.
                -- TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(npc, true) --complements the previous native but in this case it stops them from following the player.
            end)
        end
        ImGui.SameLine()
        if ImGui.Button("Delete") then
            script.run_in_fiber(function()
                if ENTITY.DOES_ENTITY_EXIST(npc) then
                    PED.DELETE_PED(npc)
                end
                for k, v in ipairs(spawned_npcs) do
                    if ENTITY.DOES_ENTITY_EXIST(v) then
                        ENTITY.DELETE_ENTITY(v)
                    end
                    table.remove(spawned_npcs, k)
                end
            end)
        end
        ImGui.SameLine()
        if ImGui.Button(" Play On NPC ") then
            if spawned_npcs[1] ~= nil then
                if is_playing_anim then
                    cleanupNPC()
                end
                 data = filteredScenarios[scenario_index+1]
                for _, v in ipairs(spawned_npcs) do
                     npcCoords = ENTITY.GET_ENTITY_COORDS(v, false)
                     npcHeading = ENTITY.GET_ENTITY_HEADING(v)
                     npcForwardX = ENTITY.GET_ENTITY_FORWARD_X(v)
                     npcForwardY = ENTITY.GET_ENTITY_FORWARD_Y(v)
                    if data.name == "Cook On BBQ" then
                        script.run_in_fiber(function()
                            while not STREAMING.HAS_MODEL_LOADED(286252949) do
                                STREAMING.REQUEST_MODEL(286252949)
                                coroutine.yield()
                            end
                            bbq = OBJECT.CREATE_OBJECT(286252949, npcCoords.x + (npcForwardX), npcCoords.y + (npcForwardY), npcCoords.z, true, true, false)
                            ENTITY.SET_ENTITY_HEADING(bbq, npcHeading)
                            OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(bbq)
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
                            TASK.TASK_START_SCENARIO_IN_PLACE(v, data.scenario, -1, true)
                            is_playing_scenario = true
                        end)
                    else
                        script.run_in_fiber(function()
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
                            TASK.TASK_START_SCENARIO_IN_PLACE(v, data.scenario, -1, true)
                            is_playing_scenario = true
                            if ENTITY.DOES_ENTITY_EXIST(bbq) then
                                ENTITY.DELETE_ENTITY(bbq)
                            end
                        end)
                    end
                end
            else
                gui.show_error("YimActions", "Spawn an NPC first!")
            end
        end
        ImGui.SameLine()
        if ImGui.Button("Stop NPC") then
            if is_playing_scenario then
                script.run_in_fiber(function(script)
                    busyspinner("Stopping scenario...", 3)
                    for _, v in ipairs(spawned_npcs) do
                        TASK.CLEAR_PED_TASKS(v)
                        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(v, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
                    end
                    is_playing_scenario = false
                    if ENTITY.DOES_ENTITY_EXIST(bbq) then
                        ENTITY.DELETE_ENTITY(bbq)
                    end
                    script:sleep(800)
                    HUD.BUSYSPINNER_OFF()
                end)
            end
        end
        event.register_handler(menu_event.ScriptsReloaded, function()
            if is_playing_scenario then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                is_playing_scenario = false
                if ENTITY.DOES_ENTITY_EXIST(bbq) then
                    ENTITY.DELETE_ENTITY(bbq)
                end
                if spawned_npcs[1] ~= nil then
                    for k, v in ipairs(spawned_npcs) do
                        if ENTITY.DOES_ENTITY_EXIST(v) then
                            ENTITY.DELETE_ENTITY(v)
                        end
                        table.remove(spawned_npcs, k)
                    end
                end
            end
        end)
        event.register_handler(menu_event.MenuUnloaded, function()
            if is_playing_scenario then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                is_playing_scenario = false
                if ENTITY.DOES_ENTITY_EXIST(bbq) then
                    ENTITY.DELETE_ENTITY(bbq)
                end
                if spawned_npcs[1] ~= nil then
                    for k, v in ipairs(spawned_npcs) do
                        if ENTITY.DOES_ENTITY_EXIST(v) then
                            ENTITY.DELETE_ENTITY(v)
                        end
                        table.remove(spawned_npcs, k)
                    end
                end
            end
        end)
        ImGui.EndTabItem()
    end
     function progressBar()
        x = x + 0.01
        if x > 1 then
            x = 1
            progessMessage = "Settings Successfully Reset."
        else
            progessMessage = "Please Wait..."
        end
    end
     function displayProgressBar()
        ImGui.Text(progessMessage)
        progressBar()
        ImGui.ProgressBar(x, 250, 25)
    end
    if ImGui.BeginTabItem("Settings") then
        searchBar = false
        ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.SameLine()
        ImGui.Text("     ")
        disableTooltips, used = ImGui.Checkbox("Disable Tooltips", disableTooltips, true)
        widgetToolTip(false, "Well, it disables this thing.")
        phoneAnim, used = ImGui.Checkbox("Enable Phone Animations", phoneAnim, true)
        helpmarker(false, "Restores the disabled phone animations from Single Player.")
        sprintInside, used = ImGui.Checkbox("Sprint Inside Interiors", sprintInside, true)
        helpmarker(false, "Allows you to sprint at full speed inside interiors that do not allow it like the Casino.")
        lockPick, used = ImGui.Checkbox("Use Lockpick Animation", lockPick, true)
        helpmarker(false, "When stealing vehicles, your character will use the lockpick animation instead of breaking the window.")
        usePlayKey, used = ImGui.Checkbox("Use Hotkeys For Animations", usePlayKey, true)
        if not disableTooltips then
            ImGui.SameLine(); ImGui.TextDisabled("(?)")
            if ImGui.IsItemHovered() then
                ImGui.SetNextWindowBgAlpha(0.75)
                ImGui.BeginTooltip()
                ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
                ImGui.TextWrapped("Select an animation from the list then use [DELETE] on Keyboard or [X] on Controller to play it while the menu is closed. You can also select the previous/next animation by pressing [PAGE DOWN] to go down the list and [PAGE UP] to go up.\nNOTE: For these hotkeys to work, you have to open Yim_Actions GUI at least once. Browsing the list while the menu is closed is currently not supported for controller.")
                ImGui.PopTextWrapPos()
                coloredText("EXPERIMENTAL: This is the only way to use hotkeys with YimMenu at the moment. This was annoying to implement and it will likely be buggy. If it causes issues for you, disable it from Settings. The stop animation hotkey won't be affected.", {240, 3, 50, 0.8})
                ImGui.EndTooltip()
            end
        end
        ImGui.Spacing() ImGui.SameLine() ImGui.Spacing() ImGui.Spacing() ImGui.SameLine() ImGui.Spacing()
        ImGui.Separator()
        if Button("Reset Settings", {142, 0, 0, 1}, {142, 0, 0, 0.7}, {142, 0, 0, 0.5}) then
            ImGui.OpenPopup("##Progress Bar")
        end
        widgetToolTip(false, "Revert saved settings and disable all checkboxes.")
        ImGui.SetNextWindowBgAlpha(0)
        if ImGui.BeginPopupModal("##Progress Bar", ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoScrollWithMouse | ImGuiWindowFlags.AlwaysAutoResize) then
                displayProgressBar()
                resetConfig(default_config)
                if x == 1 then
                    counter = counter + 1
                    if counter > 100 then
                        ImGui.CloseCurrentPopup()
                        counter = 0
                        x = 0
                        resetCheckBoxes()
                    else return
                    end
                end
            ImGui.EndPopup()
        end
        ImGui.EndTabItem()
    else
        searchBar = true
    end
end)
script.register_looped("side features", function(script)
    script:yield()
    if phoneAnim then
        if is_online then
            if not ENTITY.IS_ENTITY_DEAD(PLAYER.PLAYER_PED_ID()) then
                PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 242, false)
                PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 243, false)
                PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 244, false)
                MOBILE.CELL_SET_INPUT(5)
            end
        end
    else
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 242, true)
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 243, true)
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 244, true)
    end
    if sprintInside then
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 427, true)
    else
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 427, false)
    end
    if lockPick then
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 426, true)
    else
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 426, false)
    end
end)
script.register_looped("scenario hotkey", function(hotkey)
    hotkey:yield()
    if is_playing_scenario then
        if PAD.IS_CONTROL_PRESSED(0, 47) then
            script.run_in_fiber(function(script)
                busyspinner("Stopping scenario...", 3)
                TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
                TASK.CLEAR_PED_TASKS(npc)
                TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(npc, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                script:sleep(1000)
                HUD.BUSYSPINNER_OFF()
                if ENTITY.DOES_ENTITY_EXIST(bbq) then
                    ENTITY.DELETE_ENTITY(bbq)
                end
                is_playing_scenario = false
            end)
        end
    end
end)

function helpmarker(colorFlag, text, color)
    if not disableTooltips then
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.SetNextWindowBgAlpha(0.75)
            ImGui.BeginTooltip()
            if colorFlag == true then
                coloredText(text, color)
            else
                ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
                ImGui.TextWrapped(text)
                ImGui.PopTextWrapPos()
            end
            ImGui.EndTooltip()
        end
    end
end

function widgetToolTip(colorFlag, text, color)
    if not disableTooltips then
        if ImGui.IsItemHovered() then
            ImGui.SetNextWindowBgAlpha(0.75)
            ImGui.BeginTooltip()
            if colorFlag == true then
                coloredText(text, color)
            else
                ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
                ImGui.TextWrapped(text)
                ImGui.PopTextWrapPos()
            end
            ImGui.EndTooltip()
        end
    end
end

script.register_looped("animation hotkey", function(script)
    script:yield()
    if is_playing_anim then
        if spawned_npcs[1] ~= nil then
            if PAD.IS_CONTROL_PRESSED(0, 47) then
                for k, v in ipairs(spawned_npcs) do
                    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                         veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                        cleanup()
                        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
                        cleanupNPC()
                        PED.SET_PED_INTO_VEHICLE(v, veh, 0)
                    else
                        cleanup()
                        cleanupNPC()
                         current_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
                         npc_coords = ENTITY.GET_ENTITY_COORDS(v)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), current_coords.x, current_coords.y, current_coords.z, true, false, false)
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, npc_coords.x, npc_coords.y, npc_coords.z, true, false, false)
                        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(v, PLAYER.PLAYER_PED_ID(), 0.5, 0.5, 0.0, -1, -1, 1.4, true)
                        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(v, true)
                    end
                end
                is_playing_anim = false
            end
        else
            if PAD.IS_CONTROL_PRESSED(0, 47) then
                cleanup()
                is_playing_anim = false
            end
        end
    end
    if usePlayKey and info ~= nil then
        if PAD.IS_CONTROL_PRESSED(0, 317) then
            anim_index = anim_index + 1
            info = filteredAnims[anim_index + 1]
            if info == nil then
                anim_index = 0
                info = filteredAnims[anim_index + 1]
                gui.show_message("Current Animation:", info.name)
            end
            if info ~= nil then
                gui.show_message("Current Animation:", info.name)
            end
            script:sleep(200) -- average inter-key interval is about what, 250ms? this should be enough.
        elseif PAD.IS_CONTROL_PRESSED(0, 316) and anim_index > 0 then -- prevent going to index 0 which breaks the script.
            anim_index = anim_index - 1
            info = filteredAnims[anim_index + 1]
            gui.show_message("Current Animation:", info.name)
            script:sleep(200)
        elseif PAD.IS_CONTROL_PRESSED(0, 316) and anim_index == 0 then
                info = filteredAnims[anim_index + 1]
                gui.show_warning("Current Animation:", info.name.."\n\nYou have reached the top of the list.")
                script:sleep(400)
        end
        if PAD.IS_CONTROL_PRESSED(0, 256) then
            if not is_playing_anim then
                if info ~= nil then
                     coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                     heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                     forwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
                     forwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
                     boneIndex = PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), info.boneID)
                     bonecoords = PED.GET_PED_BONE_COORDS(PLAYER.PLAYER_PED_ID(), info.boneID)
                    if manualFlags then
                        setmanualflag()
                    else
                        flag = info.flag
                    end
                    playSelected(PLAYER.PLAYER_PED_ID(), sexPed, boneIndex, coords, heading, forwardX, forwardY, bonecoords)
                    script:sleep(200)
                end
            else
                PAD.SET_CONTROL_SHAKE(0, 500, 250)
                gui.show_message("Yim_Actions", "Press "..stopButton.." to stop the current animation before playing the next one.")
                script:sleep(800)
            end
        end
    end
end)
-- CasinoPacino - gir489returns
casino_gui = Money:add_tab("Casino")

blackjack_cards              = 114
blackjack_decks              = 846
blackjack_table_players      = 1774
blackjack_table_players_size = 8

three_card_poker_table           = 747
three_card_poker_table_size      = 9
three_card_poker_cards           = 114
three_card_poker_current_deck    = 168
three_card_poker_anti_cheat      = 1036
three_card_poker_anti_cheat_deck = 799
three_card_poker_deck_size       = 55

roulette_master_table   = 122
roulette_outcomes_table = 1357
roulette_ball_table     = 153

slots_random_results_table = 1346
slots_slot_machine_state   = 1636

prize_wheel_win_state   = 278
prize_wheel_prize       = 14
prize_wheel_prize_state = 45

gb_casino_heist_planning            = 1963945
gb_casino_heist_planning_cut_offset = 1497 + 736 + 92

fm_mission_controller_cart_grab       = 10253
fm_mission_controller_cart_grab_speed = 14
fm_mission_controller_cart_autograb   = true

casino_heist_approach      = 0
casino_heist_target        = 0
casino_heist_last_approach = 0
casino_heist_hard          = 0
casino_heist_gunman        = 0
casino_heist_driver        = 0
casino_heist_hacker        = 0
casino_heist_weapons       = 0
casino_heist_cars          = 0
casino_heist_masks         = 0

casino_gui:add_text("Lucky Wheel")
casino_gui:add_button("Give Podium Vehicle", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 18)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_sameline()
casino_gui:add_button("Give Mystery Prize", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 11)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_sameline()
casino_gui:add_button("Give $50,000", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 19)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_sameline()
casino_gui:add_button("Give 25,000 Chips", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 15)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_button("Give 15,000RP", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 17)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_sameline()
casino_gui:add_button("Give Discount", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 4)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)
casino_gui:add_sameline()
casino_gui:add_button("Give Clothing", function ()
    script.run_in_fiber(function (script)
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_lucky_wheel")) ~= 0 then
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize), 8)
            locals.set_int("casino_lucky_wheel", (prize_wheel_win_state) + (prize_wheel_prize_state), 11) 
        end
    end)
end)

casino_gui:add_separator()
casino_gui:add_text("Slots")
bypass_casino_bans = casino_gui:add_checkbox("Bypass Casino Cooldown")
casino_gui:add_sameline()
rig_slot_machine = casino_gui:add_checkbox("Rig Slot Machines")
casino_gui:add_text("THIS IS DETECTED AND BANNABLE USE IT WITH EXTREME CAUTION!")
casino_gui:add_separator()
 
casino_gui:add_text("Poker") --If his name is Al Pacino and he said, "It's not Al anymore, it's Dunk!", then his name should now be Dunk Pacino.
force_poker_cards = casino_gui:add_checkbox("Force all Players Hands to Royal Flush")
casino_gui:add_sameline()
set_dealers_poker_cards = casino_gui:add_checkbox("Force Dealer's Hand to Bad Beat")
set_dealers_poker_cards:set_enabled(true)
 
function set_poker_cards(player_id, players_current_table, card_one, card_two, card_three)
    locals.set_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (1) + (player_id * 3), card_one)
    locals.set_int("three_card_poker", (three_card_poker_anti_cheat) + (three_card_poker_anti_cheat_deck) + (1) + (1 + (players_current_table * three_card_poker_deck_size)) + (1) + (player_id * 3), card_one)
    locals.set_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (2) + (player_id * 3), card_two)
    locals.set_int("three_card_poker", (three_card_poker_anti_cheat) + (three_card_poker_anti_cheat_deck) + (1) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (player_id * 3), card_two)
    locals.set_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (3) + (player_id * 3), card_three)
    locals.set_int("three_card_poker", (three_card_poker_anti_cheat) + (three_card_poker_anti_cheat_deck) + (1) + (1 + (players_current_table * three_card_poker_deck_size)) + (3) + (player_id * 3), card_three)
end
 
function get_cardname_from_index(card_index)
    if card_index == 0 then
        return "Rolling"
    end
 
     card_number = math.fmod(card_index, 13)
     cardName = ""
     cardSuit = ""
 
    if card_number == 1 then
        cardName = "Ace"
    elseif card_number == 11 then
        cardName = "Jack"
    elseif card_number == 12 then
        cardName = "Queen"
    elseif card_number == 13 then
        cardName = "King"
    else
        cardName = tostring(card_number)
    end
 
    if card_index >= 1 and card_index <= 13 then
        cardSuit = "Clubs"
    elseif card_index >= 14 and card_index <= 26 then
        cardSuit = "Diamonds"
    elseif card_index >= 27 and card_index <= 39 then
        cardSuit = "Hearts"
    elseif card_index >= 40 and card_index <= 52 then
        cardSuit = "Spades"
    end
 
    return cardName .. " of " .. cardSuit
end
 
casino_gui:add_separator()
casino_gui:add_text("Blackjack")
casino_gui:add_text("Dealer's face down card: ")
casino_gui:add_sameline()
dealers_card_gui_element = casino_gui:add_input_string("##dealers_card_gui_element")
 
casino_gui:add_button("Set Dealer's Hand To Bust", function()
    script.run_in_fiber(function (script)
         player_id = PLAYER.PLAYER_ID()
        while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 3, 0) ~= player_id do 
            network.force_script_host("blackjack")
            gui.show_message("CasinoPacino", "Taking control of the blackjack script.") --If you see this spammed, someone if fighting you for control.
            script:yield()
        end
         blackjack_table = locals.get_int("blackjack", blackjack_table_players + 1 + (player_id * 8) + 4) --The Player's current table he is sitting at.
        if blackjack_table ~= -1 then
            locals.set_int("blackjack", blackjack_cards + blackjack_decks + 1 + (blackjack_table * 13) + 1, 11)
            locals.set_int("blackjack", blackjack_cards + blackjack_decks + 1 + (blackjack_table * 13) + 2, 12)
            locals.set_int("blackjack", blackjack_cards + blackjack_decks + 1 + (blackjack_table * 13) + 3, 13)
            locals.set_int("blackjack", blackjack_cards + blackjack_decks + 1 + (blackjack_table * 13) + 12, 3)
        end
    end)
end)
 
casino_gui:add_separator()
casino_gui:add_text("Roulette")
force_roulette_wheel = casino_gui:add_checkbox("Activate Roulette Rig")

 player_id = PLAYER.PLAYER_ID()

        casVal = 1
        casino_gui:add_imgui(function()
            casVal, used2 = ImGui.SliderInt("Betting Number", casVal, 1, 36)
            if used2 then
                valz = casVal
            end
        end)
        
casino_gui:add_separator()
casino_gui:add_text("Using these options are risky, especially if you use the cooldown bypass")
 
script.register_looped("Casino Pacino Thread", function (script)
    if force_poker_cards:is_enabled() then
         player_id = PLAYER.PLAYER_ID()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("three_card_poker")) ~= 0 then
            while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 3, 0) ~= player_id do 
                network.force_script_host("three_card_poker")
                gui.show_message("CasinoPacino", "Taking control of the three_card_poker script.") --If you see this spammed, someone if fighting you for control.
                script:sleep(500)
            end
             players_current_table = locals.get_int("three_card_poker", three_card_poker_table + 1 + (player_id * 9) + 2) --The Player's current table he is sitting at.
            if (players_current_table ~= -1) then -- If the player is sitting at a poker table
                 player_0_card_1 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (1) + (0 * 3))
                 player_0_card_2 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (2) + (0 * 3))
                 player_0_card_3 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (3) + (0 * 3))
                if player_0_card_1 ~= 50 or player_0_card_2 ~= 51 or player_0_card_3 ~= 52 then --Check if we need to overwrite the deck.
                     total_players = 0
                    for player_iter = 0, 31, 1 do
                         player_table = locals.get_int("three_card_poker", three_card_poker_table + 1 + (player_iter * 9) + 2)
                        if player_iter ~= player_id and player_table == players_current_table then --An additional player is sitting at the user's table.
                            total_players = total_players + 1
                        end
                    end
                    for playing_player_iter = 0, total_players, 1 do
                        set_poker_cards(playing_player_iter, players_current_table, 50, 51, 52)
                    end
                    if set_dealers_poker_cards:is_enabled() then
                        set_poker_cards(total_players + 1, players_current_table, 1, 8, 22)
                    end
                end
            end
        end
    end
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("blackjack")) ~= 0 then
         dealers_card = 0
         blackjack_table = locals.get_int("blackjack", blackjack_table_players + 1 + (PLAYER.PLAYER_ID() * 8) + 4) --The Player's current table he is sitting at.
        if blackjack_table ~= -1 then
            dealers_card = locals.get_int("blackjack", blackjack_cards + blackjack_decks + 1 + (blackjack_table * 13) + 1) --Dealer's facedown card.
            dealers_card_gui_element:set_value(get_cardname_from_index(dealers_card))
        else
            dealers_card_gui_element:set_value("Not sitting at a Blackjack table.")
        end
    else
        dealers_card_gui_element:set_value("Not in Casino.")
    end
    if force_roulette_wheel:is_enabled() then
          player_id = PLAYER.PLAYER_ID()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casinoroulette")) ~= 0 then
            while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 3, 0) ~= player_id do 
                network.force_script_host("casinoroulette")
                gui.show_message("CasinoPacino", "Taking control of the casinoroulette script.") --If you see this spammed, someone if fighting you for control.
                script:sleep(500)
            end
            for tabler_iter = 0, 6, 1 do
                locals.set_int("casinoroulette", (roulette_master_table) + (roulette_outcomes_table) + (roulette_ball_table) + (tabler_iter), casVal)
                gui.show_message("CasinoPacino Activated!", "Winning Number: "..casVal)
            end
        end
    end

    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_slots")) ~= 0 then
         needs_run = false
        if rig_slot_machine:is_enabled() then
            for slots_iter = 3, 195, 1 do
                if slots_iter ~= 67 and slots_iter ~= 132 then
                    if locals.get_int("casino_slots", (slots_random_results_table) + (slots_iter)) ~= 6 then
                        needs_run = true
                    end
                end
            end
        else
             sum = 0
            for slots_iter = 3, 195, 1 do
                if slots_iter ~= 67 and slots_iter ~= 132 then
                    sum = sum + locals.get_int("casino_slots", (slots_random_results_table) + (slots_iter))
                end
            end
            needs_run = sum == 1146
        end
        if needs_run then
            for slots_iter = 3, 195, 1 do
                if slots_iter ~= 67 and slots_iter ~= 132 then
                     slot_result = 6
                    if rig_slot_machine:is_enabled() == false then
                        math.randomseed(os.time()+slots_iter)
                        slot_result = math.random(0, 7)
                    end
                    locals.set_int("casino_slots", (slots_random_results_table) + (slots_iter), slot_result)
                end
            end
        end
    end
    if bypass_casino_bans:is_enabled() then
        STATS.STAT_SET_INT(joaat("MPPLY_CASINO_CHIPS_WON_GD"), 0, true)
    end
    if gui.is_open() and casino_gui:is_selected() then
        casino_heist_approach = stats.get_int("MPX_H3OPT_APPROACH")
        casino_heist_target = stats.get_int("MPX_H3OPT_TARGET")
        casino_heist_last_approach = stats.get_int("MPX_H3_LAST_APPROACH")
        casino_heist_hard = stats.get_int("MPX_H3_HARD_APPROACH")
        casino_heist_gunman = stats.get_int("MPX_H3OPT_CREWWEAP")
        casino_heist_driver = stats.get_int("MPX_H3OPT_CREWDRIVER")
        casino_heist_hacker = stats.get_int("MPX_H3OPT_CREWHACKER")
        casino_heist_weapons = stats.get_int("MPX_H3OPT_WEAPS")
        casino_heist_cars = stats.get_int("MPX_H3OPT_VEHS")
        casino_heist_masks = stats.get_int("MPX_H3OPT_MASKS")
    end
    if HUD.IS_PAUSE_MENU_ACTIVE() then
        PAD.DISABLE_CONTROL_ACTION(0, 348, true)
        PAD.DISABLE_CONTROL_ACTION(0, 204, true)
    end
    if fm_mission_controller_cart_autograb then
        if locals.get_int("fm_mission_controller", fm_mission_controller_cart_grab) == 3 then
            locallocals.set_int("fm_mission_controller", fm_mission_controller_cart_grab, 4)
        elseif locals.get_int("fm_mission_controller", fm_mission_controller_cart_grab) == 4 then
            locals.set_float("fm_mission_controller", fm_mission_controller_cart_grab + fm_mission_controller_cart_grab_speed, 2)
        end
    end
end)

casino_gui:add_button("Broadcast Msg", function()
    if dealers_card_gui_element:get_value() ~= "Not in Casino." then
        if force_roulette_wheel:is_enabled() then
            network.send_chat_message("[Casino Rig]: Make sure you own a Casino Penthouse OR you are in a CEO with someone who does AND that you have 50k+ chips before playing!")
            network.send_chat_message("[Casino Rig]: Roulette tables are rigged at the casino!  Come to the casino for easy money!")
        else
            gui.show_message("Error", "Roulette Rig is not enabled, enable it first!")
        end
    else
        gui.show_message("Error", "You need to be in the casino near the tables to use this")
    end
end)
casino_gui:add_sameline()
casino_gui:add_button("How To Bet", function()
    if dealers_card_gui_element:get_value() ~= "Not in Casino." then
        if force_roulette_wheel:is_enabled() then
            if casVal == -1 then 
                 casVal = "00"
                network.send_chat_message("[Casino Rig]: Max your bet, put 1 chip on "..casVal.." THEN stack as many chips as you can on the corresponding '2 to 1' in the same row as the winning number")
            else
                network.send_chat_message("[Casino Rig]: Max your bet, put 1 chip on "..casVal.." THEN stack as many chips as you can on the corresponding '2 to 1' in the same row as the winning number")
            end
        else
            gui.show_message("Error", "Roulette Rig is not enabled, enable it first!")
        end
    else
        gui.show_message("Error", "You need to be in the casino near the tables to use this")
    end
end)
casino_gui:add_sameline()
casino_gui:add_button("Alt Betting Info", function()
    if dealers_card_gui_element:get_value() ~= "Not in Casino." then
        if force_roulette_wheel:is_enabled() then
            network.send_chat_message("[Casino Rig]: You can optionally stack as many chips as you can on the corresponding '1st 12, 2nd 12 or 3rd 12' in the same row as the winning number instead of '2 to 1'")
        else
            gui.show_message("Error", "Roulette Rig is not enabled, enable it first!")
        end
    else
        gui.show_message("Error", "You need to be in the casino near the tables to use this")
    end
end)

casino_gui:add_separator()
casino_gui:add_text("Everything except for Slot rig works for everyone.")
-- Instant Money Loops - Pessi v2
local TransactionManager <const> = {};
TransactionManager.__index = TransactionManager

function TransactionManager:New()
     self = setmetatable({}, TransactionManager);
-- hashes for other loops in case you wanted to change the ones I added, or add more options.
    self.m_transactions = {
        {label = "15M (Bend Job Limited)", hash = 0x176D9D54},
        {label = "15M (Bend Bonus Limited)", hash = 0xA174F633},
        {label = "7M (Gang Money Limited)", hash = 0xED97AFC1},
        {label = "3.6M (Casino Heist Money Limited)", hash = 0xB703ED29},
        {label = "2.5M (Gang Money Limited)", hash = 0x46521174},
        {label = "2.5M (Island Heist Money Limited)", hash = 0xDBF39508},
        {label = "2M (Heist Awards Money Limited)", hash = 0x8107BB89},
        {label = "2M (Tuner Robbery Money Limited)", hash = 0x921FCF3C},
        {label = "2M (Business Hub Money Limited)", hash = 0x4B6A869C},
        {label = "1M (Avenger Operations Money Limited)", hash = 0xE9BBC247},
        {label = "1M (Daily Objective Event Money Limited)", hash = 0x314FB8B0},
        {label = "1M (Daily Objective Money Limited)", hash = 0xBFCBE6B6},
        {label = "680K (Betting Money Limited)", hash = 0xACA75AAE},
        {label = "500K (Juggalo Story Money Limited)", hash = 0x05F2B7EE},
        {label = "310K (Vehicle Export Money Limited)", hash = 0xEE884170},
        {label = "200K (DoomsDay Finale Bonus Money Limited)", hash = 0xBA16F44B},
        {label = "200K (Action Figures Money Limited)",  hash = 0x9145F938},
        {label = "200K (Collectibles Money Limited)",    hash = 0xCDCF2380},
        {label = "190K (Vehicle Sales Money Limited)",   hash = 0xFD389995}
    }

    return self;
end

function TransactionManager:GetPrice(hash, category)
    return tonumber(NETSHOPPING.NET_GAMESERVER_GET_PRICE(hash, category, true))
end

function TransactionManager:TriggerTransaction(hash, amount)
    globals.set_int(4537212 + 1, 2147483646)
    globals.set_int(4537212 + 7, 2147483647)
    globals.set_int(4537212 + 6, 0)
    globals.set_int(4537212 + 5, 0)
    globals.set_int(4537212 + 3, hash)
    globals.set_int(4537212 + 2, amount or self:GetPrice(hash, 0x57DE404E))
    globals.set_int(4537212, 1)
end

 millLoop = Money:add_tab("Loops")
millLoop:add_text("Money Loops (SEVERELY RISKY!)")
 oneMillLoop = millLoop:add_checkbox("1M Loop")
script.register_looped("onemLoop", function(script)
    script:yield()
    if oneMillLoop:is_enabled() == true then
        onemLoop = not onemLoop
        if onemLoop then
            TransactionManager:TriggerTransaction(0x615762F1)
                script:yield();
            gui.show_message("Money Loop", "1 Mill loop running, enjoy the easy money!")
        end
    end
end)
toolTip(millLoop, "Runs a $1,000,000 loop, will run until its deactivated, does not add to earned or overall income.")
millLoop:add_sameline()
 twofiveMillLoop = millLoop:add_checkbox("2.5M Loop")
script.register_looped("twofmLoop", function(script)
    script:yield()
    if twofiveMillLoop:is_enabled() == true then
        twofmLoop = not twofmLoop
        if twofmLoop then
            TransactionManager:TriggerTransaction(0xDBF39508)
                script:yield();
            gui.show_message("Money Loop", "2.5 Mill loop running, enjoy the easy money!")
        end
    end
end)
toolTip(millLoop, "Runs a $2,500,000 loop, (does not seem to loop)")
millLoop:add_sameline()
 threeSixMillLoop = millLoop:add_checkbox("3.6M Loop")
script.register_looped("threesmLoop", function(script)
    script:yield()
    if threeSixMillLoop:is_enabled() == true then
        threesmLoop = not threesmLoop
        if threesmLoop then
            TransactionManager:TriggerTransaction(0xB703ED29)
                script:yield();
            gui.show_message("Money Loop", "3.6 Mill loop running, enjoy the easy money!")
        end
    end
end)
toolTip(millLoop, "Runs a $3,600,000 loop, (does not seem to loop)")
millLoop:add_sameline()
 sevenMillLoop = millLoop:add_checkbox("7M Loop")
script.register_looped("sevenmLoop", function(script)
    script:yield()
    if sevenMillLoop:is_enabled() == true then
        sevenmLoop = not sevenmLoop
        if sevenmLoop then
            TransactionManager:TriggerTransaction(0xED97AFC1)
                script:yield();
            gui.show_message("Money Loop", "7 Mill loop running, enjoy the easy money!")
        end
    end
end)
toolTip(millLoop, "Runs a $7,000,000 loop, (does not seem to loop)")
millLoop:add_sameline()
 fifteenMillLoop = millLoop:add_checkbox("15M Loop")
script.register_looped("fifteenMLoop", function(script)
    script:yield()
    if fifteenMillLoop:is_enabled() == true then
        fifteenMLoop = not fifteenMLoop
        if fifteenMLoop then
            TransactionManager:TriggerTransaction(0x176D9D54)
                script:yield();
            gui.show_message("Money Loop", "15 Mill loop running, enjoy the easy money!")
        end
    end
end)
toolTip(millLoop, "Runs a $15,000,000 loop, (seems to loop sometimes, or in certain sessions?)")

moneyRemover = Money:add_tab("Money Remover")

removerInput = moneyRemover:add_input_int("Ballistic Equipment")

moneyRemover:add_button("Set Amount", function()
    if removerInput:get_value() <= 500 then
        gui.show_error("Money Remover", "Amount Must Be Greater Than 500")
    else
        globals.set_int(262145 + 20498, removerInput:get_value())
        gui.show_message("Money Remover", "Amount Successfully Set")
    end
end)
toolTip(moneyRemover, "Sets the Ballistic Equipment price to the value above, once set, purchase the ballistic equipment inside your interaction menu")
toolTip(moneyRemover, "'Health and Ammo -> Ballistic Equipment Services -> Request Ballistic Equipment'")

-- Object Spawner (Can be used negatively!) (Originally from Kuter Menu)

-- Function to convert object names to hashes using joaat()
 function getObjectHashes(names)
     hashes = {}
    for _, name in ipairs(names) do
         hash = joaat(name)
        table.insert(hashes, hash)
    end
    return hashes
end

-- Get object hashes
 objectHashes = getObjectHashes(objectNames)

 Obje = KAOS:add_tab("Object Options")
 Objets = Obje:add_tab("Spawner")

 orientationPitch = 0
 orientationYaw = 0
 orientationRoll = 0
 spawnDistance = { x = 0, y = 0, z = 0 }
 defaultOrientationPitch = 0
 defaultOrientationYaw = 0
 defaultOrientationRoll = 0
 defaultSpawnDistance = { x = 0, y = 0, z = 0 }

 defaultObjSpawnDistance = 3.0  -- Adjust this distance as needed
 objSpawnDistance = 3.0  -- Adjust this distance as needed

 previewAlpha = 175
 defaultPreviewAlpha = 175

-- Function to reset sliders to default values
 function resetSliders()
    orientationPitch = defaultOrientationPitch
    orientationYaw = defaultOrientationYaw
    orientationRoll = defaultOrientationRoll
    spawnDistance.x = defaultSpawnDistance.x
    spawnDistance.y = defaultSpawnDistance.y
    spawnDistance.z = defaultSpawnDistance.z
    objSpawnDistance = defaultObjSpawnDistance
    previewAlpha = defaultPreviewAlpha
end

--[[
---@class Preview
Preview = {handle = 0, modelHash = 0}
Preview.__index = Preview

---@param modelHash Hash
---@return Preview
function Preview.new(modelHash)
     self = setmetatable({}, Preview)
    self.modelHash = modelHash
    return self
end

---@param pos v3
function Preview:create(pos, heading)
    if self:exists() then return end
    self.handle = VEHICLE.CREATE_VEHICLE(self.modelHash, pos.x, pos.y, pos.z, heading, false, false, false)
    ENTITY.SET_ENTITY_ALPHA(self.handle, 153, true)
    ENTITY.SET_ENTITY_COLLISION(self.handle, false, false)
    ENTITY.SET_CAN_CLIMB_ON_ENTITY(self.handle, false)
end--]]


Objets:add_imgui(function()
    orientationPitch, used = ImGui.SliderInt("Pitch", orientationPitch, 0, 360)
    toolTip("", "Change the Pitch of the object (Side to Side Axis)")
    orientationYaw, used = ImGui.SliderInt("Yaw", orientationYaw, 0, 360)
    toolTip("", "Change the Yaw of the object (Vertical Axis)")
    orientationRoll, used = ImGui.SliderInt("Roll", orientationRoll, 0, 360)
    toolTip("", "Change the Roll of the object (Front to Back Axis)")
end)
Objets:add_imgui(function()
    spawnDistance.x, used = ImGui.SliderFloat("Spawn Distance X", spawnDistance.x, -25, 25)
    toolTip("", "Change the X coordinates of where the object spawns (Left/Right depending on direction you are facing)")
    spawnDistance.y, used = ImGui.SliderFloat("Spawn Distance Y", spawnDistance.y, -25, 25)
    toolTip("", "Change the Y coordinates of where the object spawns (Forward/Backwards depending on direction you are facing)")
    spawnDistance.z, used = ImGui.SliderFloat("Spawn Distance Z", spawnDistance.z, -25, 25)
    toolTip("", "Change the Z coordinates of where the object spawns (Up/Down)")
    objSpawnDistance, sdChanged = ImGui.SliderFloat("Distance", objSpawnDistance, 0, 25)
    toolTip("", "Distance between the object and the player.")
end)

Objets:add_imgui(function()
    previewAlpha, alphaChanged = ImGui.SliderInt("Preview Alpha", previewAlpha, 0, 255)
end)

-- Save default values
defaultOrientationPitch = orientationPitch
defaultOrientationYaw = orientationYaw
defaultOrientationRoll = orientationRoll
defaultSpawnDistance.x = spawnDistance.x
defaultSpawnDistance.y = spawnDistance.y
defaultSpawnDistance.z = spawnDistance.z

-- Reset Sliders button
Objets:add_button("Reset Sliders", function()
    resetSliders()
end)
toolTip(Objets, "Resets the positioning sliders to the default values")

Objets:add_separator()
-- Objects hashes/names, add to this list (top of file) to have more objects in your listbox on YimMenu
 adultesItems = {}

for i, hash in ipairs(objectHashes) do
    table.insert(adultesItems, { hash = hash, nom = objectNames[i] })
end

 selectedObjectIndex = 0

Objets:add_text("Object Spawner")

-- Add search input field
 searchQuery = ""
Objets:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    searchQuery, used = ImGui.InputText("Search Objects", searchQuery, 128)
     if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)
toolTip(Objets, "Search for an object to spawn (Example: container or cage)")

 filteredItems = {}

-- Function to update filtered items based on search query
 function updateFilteredItems()
    filteredItems = {}
    for _, item in ipairs(adultesItems) do
        if string.find(string.lower(item.nom), string.lower(searchQuery)) then
            table.insert(filteredItems, item)
        end
    end
end

-- Function to display the filtered list
 function displayFilteredList()
    updateFilteredItems()

     itemNames = {}
    for _, item in ipairs(filteredItems) do
        table.insert(itemNames, item.nom)
    end
    selectedObjectIndex, used = ImGui.ListBox("", selectedObjectIndex, itemNames, #filteredItems)
end

Objets:add_imgui(displayFilteredList)

Objets:add_separator()

spawnedObjects = {}
names = {}

previewObjects = Objets:add_checkbox("Preview")
toolTip(Objets, "Show a Preview Of The Object Before Spawning It")

previewSpawned = false

previewObject = nil

previousPreview = nil

script.register_looped("objectsPreview", function()
    if not Objets:is_selected() then
        previewObjects:set_enabled(false)
    end
    if previewObjects:is_enabled() then
         selectedObjectInfo = filteredItems[selectedObjectIndex + 1]
        if selectedObjectInfo then
            -- Get the player's ped handle
             playerPed = PLAYER.GET_PLAYER_PED(network.get_selected_player())

            -- Get the player's current position and orientation
             playerPos = ENTITY.GET_ENTITY_COORDS(playerPed, true)
             playerHeading = ENTITY.GET_ENTITY_HEADING(playerPed)
             forwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(playerPed)

            -- Calculate the spawn distance and offset
             spawnOffsetX = objSpawnDistance * forwardVector.x
             spawnOffsetY = objSpawnDistance * forwardVector.y

            -- Calculate the spawn position based on the offset
             spawnX = playerPos.x + spawnOffsetX
             spawnY = playerPos.y + spawnOffsetY
             spawnZ = playerPos.z  -- Adjust the height if needed

            -- Spawn the object at the calculated position
             objectHash = selectedObjectInfo.hash  -- Replace with the object hash or model name
            while not STREAMING.HAS_MODEL_LOADED(objectHash) do
                STREAMING.REQUEST_MODEL(objectHash)
                coroutine.yield()
            end
            if previewObject ~= objectHash and previewObject ~= nil then
                delete_entity(previewObject)
                previewSpawned = false
            end
            if not previewSpawned then
                 spawnedObject = OBJECT.CREATE_OBJECT(objectHash, spawnX, spawnY, spawnZ, true, true, false)
                ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(spawnedObject)
                ENTITY.SET_ENTITY_ROTATION(spawnedObject, 0, 0, playerHeading, 2, true)  -- Adjust rotation if needed
                ENTITY.SET_ENTITY_ALPHA(spawnedObject, 175, true)
                ENTITY.SET_ENTITY_COLLISION(spawnedObject, false, false)
                ENTITY.SET_CAN_CLIMB_ON_ENTITY(spawnedObject, false)
                previewSpawned = true
                previewObject = spawnedObject
            end
            ENTITY.SET_ENTITY_COORDS(previewObject, spawnX + spawnDistance.x, spawnY + spawnDistance.y, spawnZ + spawnDistance.z, true, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(previewObject, orientationRoll, orientationYaw, playerHeading + orientationPitch, 2, true)
            ENTITY.SET_ENTITY_ALPHA(previewObject, previewAlpha, true)
            --gui.show_message("Preview", "Moved ".. selectedObjectInfo.nom.. " to ".. tostring(spawnX).. ", ".. tostring(spawnY))
            previousPreview = objectHash
        else
            gui.show_message("Object Spawner", "Selected object not found.")
        end
    else
        if previewObject ~= nil then if ENTITY.DOES_ENTITY_EXIST(previewObject) then delete_entity(previewObject) end end
        previewSpawned = false
        previewObject = nil
        previousPreview = nil
    end
end)

Objets:add_sameline()

Objets:add_imgui(function()
    --objSpawnDistance, sdChanged = ImGui.SliderFloat("Distance", objSpawnDistance, 0, 25)
end)

Objets:add_button("Spawn Selected", function()
    script.run_in_fiber(function()
         selectedObjectInfo = filteredItems[selectedObjectIndex + 1]
        if selectedObjectInfo then
            -- Get the player's ped handle
             playerPed = PLAYER.GET_PLAYER_PED(network.get_selected_player())
            playerName = PLAYER.GET_PLAYER_NAME(network.get_selected_player())

            -- Get the player's current position and orientation
             playerPos = ENTITY.GET_ENTITY_COORDS(playerPed, true)
             playerHeading = ENTITY.GET_ENTITY_HEADING(playerPed)
             forwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(playerPed)

            -- Calculate the spawn distance and offset
             spawnOffsetX = objSpawnDistance * forwardVector.x
             spawnOffsetY = objSpawnDistance * forwardVector.y

            -- Calculate the spawn position based on the offset
             spawnX = playerPos.x + spawnOffsetX
             spawnY = playerPos.y + spawnOffsetY
             spawnZ = playerPos.z - 1.15  -- Adjust the height if needed

            -- Spawn the object at the calculated position
             objectHash = selectedObjectInfo.hash  -- Replace with the object hash or model name
            while not STREAMING.HAS_MODEL_LOADED(objectHash) do
                STREAMING.REQUEST_MODEL(objectHash)
                coroutine.yield()
            end
             spawnedObject = OBJECT.CREATE_OBJECT(objectHash, spawnX + spawnDistance.x, spawnY + spawnDistance.y, spawnZ + spawnDistance.z, true, true, false)
            ENTITY.SET_ENTITY_ROTATION(spawnedObject, orientationRoll, orientationYaw, playerHeading + orientationPitch, 2, true)  -- Adjust rotation if needed
            --gui.show_message("Preview", "Moved ".. selectedObjectInfo.nom.. " to ".. tostring(spawnX).. ", ".. tostring(spawnY))
             net_id = NETWORK.OBJ_TO_NET(spawnedObject)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(net_id, true)
            gui.show_message("Object Spawner", "Spawned object "..selectedObjectInfo.nom.." on "..playerName)
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(spawnedObject)
            table.insert(spawnedObjects, spawnedObject)
            table.insert(names, selectedObjectInfo.nom)
        else
            gui.show_message("Object Spawner", "Selected object not found.")
        end
    end)
end)
toolTip(Objets, "Spawn the selected item on the selected players position, if no player is targeted, it spawns on you")

objects = 0

Objets:add_imgui(function()
    for i, object in ipairs(spawnedObjects) do
        if not ENTITY.DOES_ENTITY_EXIST(object) then
            delete_entity(object)
            table.remove(spawnedObjects, i)
            table.remove(names, i)
        end
    end
    if #names == 0 then
        objects = ImGui.Combo("", 0, {"Empty"}, 1)
        toolTip("", "Spawned Objects Will Be Here")
    else
        objects = ImGui.Combo("", objects, names, #names)
        toolTip("", "List Of Spawned Objects")
        gui.show_message("Spawned Objects", tostring(objects).. " + ".. tostring(names[objects + 1]).. " ".. ENTITY.GET_ENTITY_MODEL(spawnedObjects[objects + 1]))
    end
    ImGui.SameLine()
    if ImGui.Button("Delete") then
        gui.show_message("Delete", "Deleted ".. spawnedObjects[objects + 1])
        delete_entity(spawnedObjects[objects + 1])
        table.remove(spawnedObjects, objects + 1)
        table.remove(names, objects + 1)
        --if names[objects] == nil then objects = objects - 1 end
    end
    if #spawnedObjects ~= 0 then toolTip("", "Delete This Spawned Object") else toolTip("", "Deletes A Spawned Object") end
    if #names > 0 then
        objLoc = ENTITY.GET_ENTITY_COORDS(spawnedObjects[objects + 1], false)
        rot = ENTITY.GET_ENTITY_ROTATION(spawnedObjects[objects + 1], 2)
        objLocX, objLocY, objLocZ = objLoc.x, objLoc.y, objLoc.z
        roll, pitch, yaw = rot.x, rot.y, rot.z
        objLocX, xChanged = ImGui.SliderFloat("X", objLocX, objLocX - 1, objLocX + 1)
        if xChanged then
            ENTITY.SET_ENTITY_COORDS(spawnedObjects[objects + 1], objLocX, objLoc.y, objLoc.z, true, false, false, false)
        end
        objLocY, yChanged = ImGui.SliderFloat("Y", objLocY, objLocY - 1, objLocY + 1)
        if yChanged then
            ENTITY.SET_ENTITY_COORDS(spawnedObjects[objects + 1], objLoc.x, objLocY, objLoc.z, true, false, false, false)
        end
        objLocZ, zChanged = ImGui.SliderFloat("Z", objLocZ, objLocZ - 1, objLocZ + 1)
        if zChanged then
            ENTITY.SET_ENTITY_COORDS(spawnedObjects[objects + 1], objLoc.x, objLoc.y, objLocZ, true, false, false, false)
        end
        pitch, pitchChanged = ImGui.SliderFloat("Pitch ", pitch, -180, 180)
        if pitchChanged then
            ENTITY.SET_ENTITY_ROTATION(spawnedObjects[objects + 1], rot.x, pitch, rot.z, 2, false)
        end
        yaw, yawChanged = ImGui.SliderFloat("Yaw ", yaw, -180, 180)
        if yawChanged then
            ENTITY.SET_ENTITY_ROTATION(spawnedObjects[objects + 1], rot.x, rot.y, yaw, 2, false)
        end
        roll, rollChanged = ImGui.SliderFloat("Roll ", roll, -180, 180)
        if rollChanged then
            ENTITY.SET_ENTITY_ROTATION(spawnedObjects[objects + 1], roll, rot.y, rot.z, 2, false)
        end
    end
end)

-- Vehicle Options Tab
 Veh = KAOS:add_tab("Vehicle Options")

flatbedScript = Veh:add_tab("FlatbedScript")
attached_vehicle = {}
 debug = false
--  validModel = false
 modelOverride = false
flatbedScript:add_imgui(function()
     vehicleHandles = entities.get_all_vehicles_as_handles()
     flatbedModel = 1353720154
     current_vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
     vehicle_model = ENTITY.GET_ENTITY_MODEL(current_vehicle)
     playerPosition = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
     playerForwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
     playerForwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
--  closestVehicle = VEHICLE.GET_CLOSEST_VEHICLE(playerPosition.x, playerPosition.y, playerPosition.z, 10.0, 0, 70) --doesn't return cop cars or occupied PVs.
    for _, veh in ipairs(vehicleHandles) do
        script.run_in_fiber(function(script)
             detectPos = vec3:new(playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z)
             vehPos = ENTITY.GET_ENTITY_COORDS(veh, false)
             vDist = SYSTEM.VDIST(detectPos.x, detectPos.y, detectPos.z, vehPos.x, vehPos.y, vehPos.z)
            if vDist <= 5 then
                closestVehicle = veh
            else
                script:sleep(50)
                closestVehicle = nil
                return
            end
        end)
    end
     closestVehicleModel = ENTITY.GET_ENTITY_MODEL(closestVehicle)
     is_car = VEHICLE.IS_THIS_MODEL_A_CAR(closestVehicleModel)
     is_bike = VEHICLE.IS_THIS_MODEL_A_BIKE(closestVehicleModel)
     closestVehicleName = vehicles.get_vehicle_display_name(closestVehicleModel)
    if vehicle_model == flatbedModel then
        is_in_flatbed = true
    else
        is_in_flatbed = false
    end
    if closestVehicleName == "" then
        displayText = "No nearby vehicles found!"
    elseif tostring(closestVehicleName) == "Flatbed" then
        displayText = "You can not tow another flatbed truck."
    else
        displayText = ("Closest Vehicle: "..tostring(closestVehicleName))
    end
    if attached_vehicle[1] ~= nil then
        displayText = "Towing..."
    end
    if modelOverride then
        validModel = true
    else
        validModel = false
    end
    if is_car then
        validModel = true
    end
    if is_bike then
        validModel = true
    end
    if closestVehicleModel == 745926877 then --Buzzard
        validModel = true
    end
    if is_in_flatbed then
        ImGui.Text(displayText)
        towPos, used = ImGui.Checkbox("Show Towing Position", towPos, true)
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
            ImGui.Text("Marks the position at which the script\ndetects nearby vehicles.")
            ImGui.EndTooltip()
        end
        towEverything, used = ImGui.Checkbox("Tow Everything", towEverything, true)
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
            ImGui.Text("By default, the script is limited to cars,\ntrucks and bikes only. This option\nremoves that limit.")
            ImGui.EndTooltip()
        end
        if towEverything then
            modelOverride = true
        else
            modelOverride = false
        end
        if ImGui.Button("   Tow    ") then
            if attached_vehicle[1] == nil then
                if validModel and closestVehicleModel ~= flatbedModel then
                    script.run_in_fiber(function()
                        controlled = entities.take_control_of(closestVehicle, 300)
                        if controlled then
                            flatbedHeading = ENTITY.GET_ENTITY_HEADING(current_vehicle)
                            flatbedBone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(current_vehicle, "chassis_dummy")
                             vehicleClass = VEHICLE.GET_VEHICLE_CLASS(closestVehicle)
                            if vehicleClass == 1 then
                                zAxis = 0.9
                                yAxis = -2.3
                            elseif vehicleClass == 2 then
                                zAxis = 0.993
                                yAxis = -2.17046
                            elseif vehicleClass == 6 then
                                zAxis = 1.00069420
                                yAxis = -2.17046
                            elseif vehicleClass == 7 then
                                zAxis = 1.009
                                yAxis = -2.17036
                            elseif vehicleClass == 15 then
                                zAxis = 1.3
                                yAxis = -2.21069
                            elseif vehicleClass == 16 then
                                zAxis = 1.5
                                yAxis = -2.21069
                            else
                                zAxis = 1.1
                                yAxis = -2.0
                            end
                            ENTITY.SET_ENTITY_HEADING(closestVehicleModel, flatbedHeading)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(closestVehicle, current_vehicle, flatbedBone, 0.0, yAxis, zAxis, 0.0, 0.0, 0.0, true, true, false, false, 1, true, 1)
                            table.insert(attached_vehicle, closestVehicle)
                        else
                            gui.show_error("Flatbed Script", "Failed to take control of the vehicle!")
                        end
                    end)
                end
                if closestVehicle ~= nil and closestVehicleModel ~= flatbedModel and not validModel then
                    gui.show_message("Flatbed Script", "You can only tow cars, trucks and bikes.")
                end
                if closestVehicle ~= nil and closestVehicleModel == flatbedModel then
                    gui.show_message("Flatbed Script", "Sorry but you can not tow another flatbed truck.")
                end
            else
                gui.show_error("Flatbed Script", "You are already towing a vehicle.")
            end
        end
        ImGui.SameLine()
        if ImGui.Button(" Detach ") then
            for _, v in ipairs(vehicleHandles) do
                script.run_in_fiber(function()
                     modelHash = ENTITY.GET_ENTITY_MODEL(v)
                     attachedVehicle = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()), modelHash)
                    controlled = entities.take_control_of(attachedVehicle, 300)
                    if ENTITY.DOES_ENTITY_EXIST(attachedVehicle) then
                        if controlled then
                            ENTITY.DETACH_ENTITY(attachedVehicle)
                            ENTITY.SET_ENTITY_COORDS(attachedVehicle, playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z, false, false, false, false)
                            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(attached_vehicle, 5.0)
                        end
                    end
                end)
            end
            for key, value in ipairs(attached_vehicle) do
                script.run_in_fiber(function()
                     modelHash = ENTITY.GET_ENTITY_MODEL(value)
                     attachedVehicle = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()), modelHash)
                    if ENTITY.DOES_ENTITY_EXIST(attachedVehicle) then
                        ENTITY.DETACH_ENTITY(attachedVehicle)
                        ENTITY.SET_ENTITY_COORDS(attachedVehicle, playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z, false, false, false, false)
                        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(attached_vehicle, 5.0)
                    end
                end)
                table.remove(attached_vehicle, key)
            end
        end
    else
        ImGui.Text("Get inside a flatbed truck to use the script.")
        if ImGui.Button("Spawn Flatbed Truck") then
            script.run_in_fiber(function(script)
                 try = 0
                while not STREAMING.HAS_MODEL_LOADED(flatbedModel) do
                    STREAMING.REQUEST_MODEL(flatbedModel)
                    script:yield()
                    if try > 100 then
                        return
                    else
                        try = try + 1
                    end
                end
                fltbd = VEHICLE.CREATE_VEHICLE(flatbedModel, playerPosition.x, playerPosition.y, playerPosition.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()), true, false, false)
                -- script:sleep(200)
                PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), fltbd, -1)
                ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(fltbd)
            end)
        end
    end
    ImGui.TextDisabled("_")
    if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
        debug = not debug
    end
    if debug then
        ImGui.Separator()
        if ImGui.Button("debug") then
            for _, veh in ipairs(vehicleHandles) do
                script.run_in_fiber(function(script)
                     detectPos = vec3:new(playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z)
                     vehPos = ENTITY.GET_ENTITY_COORDS(veh, false)
                     vDist = SYSTEM.VDIST(detectPos.x, detectPos.y, detectPos.z, vehPos.x, vehPos.y, vehPos.z)
                     vHash =  ENTITY.GET_ENTITY_MODEL(veh)
                    vehicleClass = VEHICLE.GET_VEHICLE_CLASS(closestVehicle)
                end)
            end
            log.debug(tostring(closestVehicle))
            -- log.debug(tostring(vDist))
            log.debug(tostring(vehicleClass))
        end
    end
end)
script.register_looped("flatbed script", function(script)
    -- script:yield()
     vehicleHandles = entities.get_all_vehicles_as_handles()
     current_vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
     vehicle_model = ENTITY.GET_ENTITY_MODEL(current_vehicle)
     flatbedHeading = ENTITY.GET_ENTITY_HEADING(current_vehicle)
     flatbedBone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(current_vehicle, "chassis")
     playerPosition = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
     playerForwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
     playerForwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
    for _, veh in ipairs(vehicleHandles) do
         detectPos = vec3:new(playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z)
         vehPos = ENTITY.GET_ENTITY_COORDS(veh, false)
         vDist = SYSTEM.VDIST(detectPos.x, detectPos.y, detectPos.z, vehPos.x, vehPos.y, vehPos.z)
        if vDist <= 5 then
            closestVehicle = veh
        end
    end
     closestVehicleModel = ENTITY.GET_ENTITY_MODEL(closestVehicle)
     is_car = VEHICLE.IS_THIS_MODEL_A_CAR(closestVehicleModel)
     is_bike = VEHICLE.IS_THIS_MODEL_A_BIKE(closestVehicleModel)
     validModel = false
    if modelOverride then
        validModel = true
    else
        validModel = false
    end
    if is_car then
        validModel = true
    end
    if is_bike then
        validModel = true
    end
    if closestVehicleModel == 745926877 then --Buzzard
        validModel = true
    end
    if closestVehicleModel == 1353720154 then
        validModel = false
    end
    if vehicle_model == 1353720154 then
        is_in_flatbed = true
    else
        is_in_flatbed = false
    end
    if is_in_flatbed and attached_vehicle[1] == nil then
        if PAD.IS_CONTROL_PRESSED(0, 73) and validModel and closestVehicleModel ~= flatbedModel then
            script:sleep(200)
            controlled = entities.take_control_of(closestVehicle, 350)
            if controlled then
                 vehicleClass = VEHICLE.GET_VEHICLE_CLASS(closestVehicle)
                if vehicleClass == 1 then
                    zAxis = 0.9
                    yAxis = -2.3
                elseif vehicleClass == 2 then
                    zAxis = 0.993
                    yAxis = -2.17046
                elseif vehicleClass == 6 then
                    zAxis = 1.00069420
                    yAxis = -2.17046
                elseif vehicleClass == 7 then
                    zAxis = 1.009
                    yAxis = -2.17036
                elseif vehicleClass == 15 then
                    zAxis = 1.3
                    yAxis = -2.21069
                elseif vehicleClass == 16 then
                    zAxis = 1.5
                    yAxis = -2.21069
                else
                    zAxis = 1.1
                    yAxis = -2.0
                end
                ENTITY.SET_ENTITY_HEADING(closestVehicleModel, flatbedHeading)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(closestVehicle, current_vehicle, flatbedBone, 0.0, yAxis, zAxis, 0.0, 0.0, 0.0, false, true, true, false, 1, true, 1)
                table.insert(attached_vehicle, closestVehicle)
                script:sleep(200)
            else
                gui.show_error("Flatbed Script", "Failed to take control of the vehicle!")
            end
        end
        if PAD.IS_CONTROL_PRESSED(0, 73) and closestVehicle ~= nil and not validModel then
            gui.show_message("Flatbed Script", "You can only tow cars, trucks and bikes.")
            script:sleep(400)
        end
        if PAD.IS_CONTROL_PRESSED(0, 73) and closestVehicleModel == flatbedModel then
            script:sleep(400)
            gui.show_message("Flatbed Script", "Sorry but you can not tow another flatbed truck.")
        end
    elseif is_in_flatbed and attached_vehicle[1] ~= nil then
        if PAD.IS_CONTROL_PRESSED(0, 73) then
            script:sleep(200)
             vehicleHandles = entities.get_all_vehicles_as_handles()
            for _, v in ipairs(vehicleHandles) do
                 modelHash = ENTITY.GET_ENTITY_MODEL(v)
                 attachedVehicle = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(current_vehicle, modelHash)
                controlled = entities.take_control_of(attachedVehicle, 350)
                if ENTITY.DOES_ENTITY_EXIST(attachedVehicle) then
                    if controlled then
                        ENTITY.DETACH_ENTITY(attachedVehicle)
                        ENTITY.SET_ENTITY_COORDS(attachedVehicle, playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z, 0, 0, 0, 0)
                        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(attached_vehicle, 5.0)
                    end
                end
            end
            for key, value in ipairs(attached_vehicle) do
                 modelHash = ENTITY.GET_ENTITY_MODEL(value)
                 attachedVehicle = ENTITY.GET_ENTITY_OF_TYPE_ATTACHED_TO_ENTITY(PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()), modelHash)
                    if ENTITY.DOES_ENTITY_EXIST(attachedVehicle) then
                        ENTITY.DETACH_ENTITY(attachedVehicle)
                        ENTITY.SET_ENTITY_COORDS(attachedVehicle, playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z, 0, 0, 0, 0)
                        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(attached_vehicle, 5.0)
                    end
                table.remove(attached_vehicle, key)
            end
            script:sleep(200)
        end
    end
end)
script.register_looped("TowPos Marker", function()
    if towPos then
        if is_in_flatbed and attached_vehicle[1] == nil then
             playerPosition = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
             playerForwardX = ENTITY.GET_ENTITY_FORWARD_X(PLAYER.PLAYER_PED_ID())
             playerForwardY = ENTITY.GET_ENTITY_FORWARD_Y(PLAYER.PLAYER_PED_ID())
             detectPos = vec3:new(playerPosition.x - (playerForwardX * 10), playerPosition.y - (playerForwardY * 10), playerPosition.z)
            GRAPHICS.DRAW_MARKER_SPHERE(detectPos.x, detectPos.y, detectPos.z, 2.5, 180, 128, 0, 0.115)
        end
    end
end)

 tokyodrift = Veh:add_tab("Tokyo Drift")
script.register_looped("vars", function(vars)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        is_online = true
    else
        is_online = false
    end
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        current_vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        is_car = VEHICLE.IS_THIS_MODEL_A_CAR(ENTITY.GET_ENTITY_MODEL(current_vehicle))
    end
    vars:yield()
end)
 ShiftDrift = false
 DriftIntensity = 0
 DriftTires = false
 function resettokyodrift()
    DriftTires = false
    ShiftDrift = false
    DriftIntensity = 0
    shiftDriftToggled = false
end
tokyodrift:add_imgui(function()
manufacturer = VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(current_vehicle))
mfr_name = (manufacturer:lower():gsub("^%l", string.upper))
vehicle_name = vehicles.get_vehicle_display_name(ENTITY.GET_ENTITY_MODEL(current_vehicle))
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and is_car then
        ImGui.Text("Vehicle: "..mfr_name.." "..vehicle_name)
        ImGui.Spacing()
        ShiftDrift, shiftDriftToggled = ImGui.Checkbox("Activate Tokyo Drift", ShiftDrift, true)
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
            ImGui.Text("Hold [Left Shift] to drift")
            ImGui.EndTooltip()
        end
        if shiftDriftToggled then
            if not ShiftDrift then
                DriftTires = false
            end
        end
        DriftTires, driftTyresToggled = ImGui.Checkbox("Use Low Grip Tires", DriftTires, true)
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
            ImGui.Text("This will use GTA 5's low grip tires instead.")
            ImGui.EndTooltip()
        end
        if not DriftTires then
            ImGui.Spacing()
            ImGui.Text("Intensity:")
            ImGui.PushItemWidth(250)
            DriftIntensity, DriftIntensityUsed = ImGui.SliderInt("##Intensity", DriftIntensity, 0, 3)
            if ImGui.IsItemHovered() then
                ImGui.BeginTooltip()
                ImGui.Text("0: No Grip (very stiff).\n1: Balanced (Recommended).\n2: Weak Drift.\n3: Weakest Drift.")
                ImGui.EndTooltip()
            end
            ImGui.PopItemWidth()
        end
    elseif PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and not is_car then
        ImGui.Text("Tokyo Drift only works on cars and trucks.")
    else
        ImGui.Text("Get in a vehicle before using the script!")
    end
    ImGui.Spacing() ImGui.Spacing() ImGui.Spacing() ImGui.Spacing() ImGui.Spacing() ImGui.Spacing()
    ImGui.Separator()
    if ImGui.Button("-- Credits --") then
        ImGui.OpenPopup("Credits")
    end
    ImGui.SetNextWindowPos(600, 400, ImGuiCond.Appearing)
    ImGui.SetNextWindowBgAlpha(0.6)
    if ImGui.BeginPopupModal("Credits", true, ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoMove) then
        ImGui.Text("Original script [Shift-Drift], made by Harmless05\nand tweaked by SAMURAI (xesdoog).")
        ImGui.Text("Visit Harmless's profile on Github:")
        ImGui.Indent()
        ImGui.TextColored(0.25, 0.65, 0.96, 0.8, "https://github.com/Harmless05")
        ImGui.Unindent()
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
            ImGui.Text("Click to copy link")
            ImGui.EndTooltip()
        end
        if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
            ImGui.SetClipboardText("https://github.com/Harmless05")
            gui.show_message("Tokyo Drift", "Copied \"https://github.com/Harmless05\" to clipboard!")
            log.info("Copied \"https://github.com/Harmless05\" to clipboard!")
        end
        -- ImGui.Text("Checkout Harmless-Scripts:")
        -- ImGui.BulletText("https://github.com/YimMenu-Lua/Harmless-Scripts")
        -- if ImGui.IsItemHovered() then
        --     ImGui.BeginTooltip()
        --     ImGui.Text("Click to copy link")
        --     ImGui.EndTooltip()
        -- end
        -- if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
        --     ImGui.SetClipboardText("https://github.com/YimMenu-Lua/Harmless-Scripts")    <-- Crashes my game for some reason! The profile link is fine but clicking the YimMenu-Lua repo link crashes my game???🤨
        --     gui.show_message("TokyoDrift Credits", "Copied \"https://github.com/YimMenu-Lua/Harmless-Scripts\" to clipboard!")
        -- end
        ImGui.EndPopup()
    end
end)
event.register_handler(menu_event.MenuUnloaded, function()
    resettokyodrift()
end)
event.register_handler(menu_event.ScriptsReloaded, function()
    resettokyodrift()
end)
script.register_looped("Drift Loop", function(script)
    script:yield()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        if is_car and DriftTires and PAD.IS_CONTROL_PRESSED(0, 21) then
            VEHICLE.SET_DRIFT_TYRES(current_vehicle, true)
        else
            VEHICLE.SET_DRIFT_TYRES(current_vehicle, false)
        end
        script:yield()
        if is_car and ShiftDrift and PAD.IS_CONTROL_PRESSED(0, 21) and not DriftTires then
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(current_vehicle, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(current_vehicle, DriftIntensity)
        else
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(current_vehicle, false)
        end
    end
end)
 -- Global Player Options
 
  Global = KAOS:add_tab("Global")
 
 -- Global RP Loop Options
  PRGBGLoop = false
 Global:add_text("Global Friendly Options")
 rpLoop = Global:add_checkbox("Drop RP (On/Off)")
 
     script.register_looped("PRGBGLoop", function()
     if rpLoop:is_enabled() == true then
          model = joaat("vw_prop_vw_colle_prbubble")
          pickup = joaat("PICKUP_CUSTOM_SCRIPT")
          money_value = 0
         gui.show_message("WARNING", "15 or more players may cause lag or RP to not drop.")
         STREAMING.REQUEST_MODEL(model)
         while STREAMING.HAS_MODEL_LOADED(model) == false do
             sleep(1)
         end
     
         if STREAMING.HAS_MODEL_LOADED(model) then
              PlayerId = PLAYER.PLAYER_ID()
              player_count = PLAYER.GET_NUMBER_OF_PLAYERS() - 1 -- Minus 1 player (yourself) from the drop count.
             gui.show_message("Global", "Dropping figurines to ".. player_count.." Players in the session.")
 
             for i = 0, 31 do
                 if i ~= PlayerId then
                      player_id = i
                     
                      coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                      objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                         pickup,
                         coords.x - 0,
                         coords.y + 0,
                         coords.z + 0.4,
                         3,
                         money_value,
                         model,
                         true,
                         false
                     )
                     ENTITY.SET_ENTITY_VISIBLE(objectIdSpawned, true, false)
                      net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
                     NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
                     
                     ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(objectIdSpawned)
                 end
             end
         end
         --sleep(0.2) -- Sets the timer in seconds for how long this should pause before sending another figure
     end
     end)
toolTip(Global, "Drops Princess Robot Figurines for the entire session (Slightly glitchy)")
Global:add_sameline()       
 goodRP = Global:add_checkbox("Fast RP")
script.register_looped("goodRP", function()
    if goodRP:is_enabled() == true then
        for p = 0, 31 do
            if p ~= PLAYER.PLAYER_ID() then
                for i = 20, 24 do 
                    network.trigger_script_event(1 << p, {968269233 , p, 1, 4, i, 1, 1, 1, 1})
                     player_count = PLAYER.GET_NUMBER_OF_PLAYERS()
                    gui.show_message("Fast RP", "Giving massive amounts of RP to "..player_count.." players in the session")
                end
            end
        end
    end
end)
toolTip(Global, "Floods the entire session with RP (about 1-3 levels per second)")
Global:add_sameline()
 goodMoney = Global:add_checkbox("Money")
    script.register_looped("goodMoney", function()
        if goodMoney:is_enabled() == true then
            for i = 0, 31 do
                pid = i
                 PlayerId = PLAYER.PLAYER_ID()
                if pid ~= PlayerId then
                    for n = 0, 10 do
                        for l = -10, 10 do
                            network.trigger_script_event(1 << pid, {968269233 , pid, 1, l, l, n, 1, 1, 1})
                            gui.show_message("Money", "Giving money (max 225k) to "..player_count.." players in the session")
                        end
                    end
                end
            end
        end
        sleep(0.2)
    end)
toolTip(Global, "Supposed to give the entire session money and rp")
--[[ Global Sound Spam Options -- Temporarily Disabled as it causes you to crash on use
Global:add_separator()
Global:add_text("Sound Spams")
 soundIndex = 0
 isPlaying = false

useLoopedG = false
 useLoopedG = Global:add_checkbox("Loop?")
 searchQuery = ""
 filteredSoundNames = {}
 selectedFilteredSoundIndex = 0

 function updateFilteredSoundNames()
    filteredSoundNames = {}
    for _, sound in ipairs(sounds) do
        if string.find(string.lower(sound.SoundName), string.lower(searchQuery)) then
            table.insert(filteredSoundNames, sound.SoundName)
        end
    end
end

-- Function to display the list of sound names
 function displaySoundNamesList()
    updateFilteredSoundNames()
    if selectedFilteredSoundIndex > #filteredSoundNames then
        selectedFilteredSoundIndex = 0
    end
    selectedFilteredSoundIndex, _ = ImGui.Combo("Select Sound", selectedFilteredSoundIndex, filteredSoundNames, #filteredSoundNames)
end

-- Add search input field and sound selection
Global:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    searchQuery, _ = ImGui.InputText("Search Sounds", searchQuery, 128)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end

    displaySoundNamesList()

    if ImGui.Button("Play") then
        isPlaying = true
         selectedSoundName = filteredSoundNames[selectedFilteredSoundIndex + 1]
        for i = 0, 31 do
             playerIndex = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(i)
                 selectedSound = sounds[1]
                for _, sound in ipairs(sounds) do
                    if sound.SoundName == selectedSoundName then
                        selectedSound = sound
                        break
                    end
                end
                AUDIO.PLAY_SOUND_FROM_ENTITY(AUDIO.GET_SOUND_ID(), selectedSound.AudioName, playerIndex, selectedSound.AudioRef, true, 999999999)
                gui.show_message("Sound Spam", "Playing "..selectedSound.SoundName.." on the entire session.")
        end
    end
end)


Global:add_sameline()
Global:add_button("Stop  Sounds", function()
    isPlaying = false
    --for i=-1,100 do
    -- soundId = AUDIO.PLAY_SOUND_FROM_ENTITY(AUDIO.GET_SOUND_ID(), selectedSound.AudioName, playerIndex, selectedSound.AudioRef, true, 999999999)
        AUDIO.STOP_SOUND(soundId)
        AUDIO.RELEASE_SOUND_ID(soundId)
    --end
end)]]

-- Global Particle Effects
Global:add_separator()
Global:add_text("PTFX")
 fireworkLoop = Global:add_checkbox("Fireworks (On/Off)")

function load_fireworks()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("proj_indep_firework")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("proj_indep_firework") then
        return false
    end
    
    STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_indep_fireworks")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_indep_fireworks") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 200), math.random(0, 255), math.random(0, 255)
end

script.register_looped("FireworkLoop", function()
    if fireworkLoop:is_enabled() == true then
        if load_fireworks() then
             PlayerId = PLAYER.PLAYER_ID()
            for i = 0, 31 do
                if i ~= PlayerId then
                     player_id = i
                     player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                    -- Get random color values
                     colorR, colorG, colorB = random_color()
                    player_coords.z = player_coords.z - 1
                    setExp1 = player_coords.z + 25
                    setExp2 = player_coords.z + 35
                    -- Play the explosion particle effect with random color
                    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_indep_fireworks")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_indep_firework_trailburst", player_coords.x, player_coords.y, player_coords.z, 0, 0, 0, math.random(1, 5), false, false, false, false)
                    sleep(0.05)
                    GRAPHICS.USE_PARTICLE_FX_ASSET("proj_indep_firework")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_indep_firework_grd_burst", player_coords.x, player_coords.y, setExp1, 0, 0, 0, math.random(1, 5), false, false, false, false)
                    
                    GRAPHICS.USE_PARTICLE_FX_ASSET("proj_indep_firework_v2")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xmas_firework_burst_fizzle", player_coords.x, player_coords.y, setExp2, 0, 0, 0, math.random(1, 5), false, false, false, false)
                end
            end
        end
    end
end)
toolTip(Global, "Shoots a sequence of firework effects from every player in the session")
Global:add_sameline()
 flameLoopGlobal = Global:add_checkbox("Flames (On/Off)")
function load_flame()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_bike_adversary")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_bike_adversary") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("FlameLoopGlobal", function()
    if flameLoopGlobal:is_enabled() == true then
        if load_flame() then
             PlayerId = PLAYER.PLAYER_ID()
            for i = 0, 31 do
                if i ~= PlayerId then
                     player_id = i
                     player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                    -- Get random color values
                     colorR, colorG, colorB = random_color()
                    test = player_coords.z - 1
                    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_bike_adversary")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_adversary_foot_flames", player_coords.x, player_coords.y, test, 0, 0, 0, 5, false, false, false, false)
                end
            end
            sleep(0.2)
        end
    end
end)
toolTip(Global, "Gives every player in the session the 'Ghost Rider' flame effect")
Global:add_sameline()
 lightningLoopGlobal = Global:add_checkbox("Lightning (On/Off)")
function load_lightning()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("des_tv_smash")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("des_tv_smash") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("lightningLoopGlobal", function()
    if lightningLoopGlobal:is_enabled() == true then
        if load_lightning() then
             PlayerId = PLAYER.PLAYER_ID()
            for i = 0, 31 do
                if i ~= PlayerId then
                     player_id = i
                     player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                    -- Get random color values
                     colorR, colorG, colorB = random_color()
                    test = player_coords.z
                    GRAPHICS.USE_PARTICLE_FX_ASSET("des_tv_smash")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("ent_sht_electrical_box_sp", player_coords.x, player_coords.y, test, 0, 0, 0, 5, false, false, false, false)
                end
            end
            sleep(0.2)
        end
    end
end)
toolTip(Global, "Gives the entire session a Lightning/Electricity effect")
Global:add_sameline()
 snowLoopGlobal = Global:add_checkbox("Snow (On/Off)")
function load_snow()

    STREAMING.REQUEST_NAMED_PTFX_ASSET("proj_xmas_snowball")
    
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("proj_xmas_snowball") then
        return false
    end

    return true
end

function random_color()
    return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

script.register_looped("snowLoopGlobal", function()
    if snowLoopGlobal:is_enabled() == true then
        if load_snow() then
             PlayerId = PLAYER.PLAYER_ID()
            for i = 0, 32 do
                if i ~= PlayerId then
                     player_id = i
                     player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                    -- Get random color values
                     colorR, colorG, colorB = random_color()
                    test = player_coords.z
                    GRAPHICS.USE_PARTICLE_FX_ASSET("proj_xmas_snowball")
                    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("exp_grd_snowball", player_coords.x, player_coords.y, test, 0, 0, 0, 5, false, false, false, false)
                end
            end
            sleep(0.2)
        end
    end
end)
toolTip(Global, "Gives the entire session the effect of being hit with snowballs")
-- Global Explode
Global:add_separator()
Global:add_text("Troll Options")
 hornsCB = Global:add_checkbox("Horns")
script.register_looped("horns", function(hornsTest)
    if hornsCB:is_enabled() then
         vehicles = entities.get_all_vehicles_as_handles()
        for i, vehicle in ipairs(vehicles) do
            if request_control(vehicle) then
                VEHICLE.START_VEHICLE_HORN(vehicle, 1000, 0, true)
                AUDIO.USE_SIREN_AS_HORN(vehicle, true)
            end
        end
        hornsTest:yield()
    end
    sleep(0.2)
end)
toolTip(Global, "Makes all vehicle horns go off constantly.")
Global:add_separator()
Global:add_text("Toxic Options")
Global:add_button("Boat Skin Crash", function()
    script.run_in_fiber(function (pedpacrash)
        gui.show_message("Boat Skin", "Giving everyone the boat skin.")
        PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), -74.94, -818.58, 327)
         spped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
         ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
        for n = 0 , 5 do
             object_hash = joaat("prop_byard_rowboat4")
            STREAMING.REQUEST_MODEL(object_hash)
              while not STREAMING.HAS_MODEL_LOADED(object_hash) do
                pedpacrash:yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
            pedpacrash:sleep(1000)
            for i = 0 , 20 do
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 144, 1.0)
                PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
            end
            pedpacrash:sleep(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    
             object_hash2 = joaat("prop_byard_rowboat4")
            STREAMING.REQUEST_MODEL(object_hash2)
            while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
                pedpacrash:yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, 0,0,500, false, false, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spped, 0xFBAB5776, 1000, false)
            pedpacrash:sleep(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(spped)
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 144, 1.0)
            end
            pedpacrash:sleep(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    end)
end)
toolTip(Global, "Give everyone the boat skin! (Parachute Crash w/ Boat as a parachute, fairly effective) will crash the entire session, does not work on some modders.")
Global:add_sameline()
Global:add_button("Fragment crash", function()
    script.run_in_fiber(function (fragcrash)
     PlayerId = PLAYER.PLAYER_PED_ID()
        for i = 0, 31 do
            if i ~= PlayerId then
                 players = i
                fraghash = joaat("prop_fragtest_cnst_04")
                STREAMING.REQUEST_MODEL(fraghash)
                 TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(selPlayer), false)
                 crashstaff1 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff1, 1, false)
                 crashstaff2 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff2, 1, false)
                 crashstaff3 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff3, 1, false)
                 crashstaff4 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff4, 1, false)
                for v = 0, 100 do   
                     TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                    fragcrash:sleep(10)
                    delete_entity(crashstaff1)
                    delete_entity(crashstaff2)
                    delete_entity(crashstaff3)
                    delete_entity(crashstaff4)
                end
            end
        end
    end)
    script.run_in_fiber(function (fragcrash2)
     PlayerId = PLAYER.PLAYER_ID()
        for i = 0, 31 do
            if i ~= PlayerId then
                 players = i
                 TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(players), false)
                fraghash = joaat("prop_fragtest_cnst_04")
                STREAMING.REQUEST_MODEL(fraghash)
                for v=1,10 do
                 
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    delete_entity(object)
                     object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
                    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
                    fragcrash2:sleep(100)
                    delete_entity(object)
                end
            end
        end
    end)
end)
toolTip(Global, "Fragment crash the entire session")
Global:add_sameline()
Global:add_button("HUD Breaker", function()
for p = 0, 31 do
     pid = p
    if p ~= PLAYER.PLAYER_ID() then
        for i = -1, 1 do
            network.trigger_script_event(1 << pid, {1450115979, pid, i})
        end
    end
end
    gui.show_message("HUD Breaker", "You have broken the entire sessions HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end)
toolTip(Global, "Breaks the HUD for every player in the session, causes their missions to break in freemode, removes their HUD, prevents pausing and prevents entering properties as it removes the entrace markers")
Global:add_sameline()
 clownJetAttack = Global:add_checkbox("Clown Jet Attack")
    script.register_looped("clownJetAttack", function(clownJetsOne)
        if clownJetAttack:is_enabled() == true then
            for i = 0, 31 do
                if i ~= PLAYER.PLAYER_ID() then
                     player = i
                     players = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
                     playerName = PLAYER.GET_PLAYER_NAME(players)
                     coords = ENTITY.GET_ENTITY_COORDS(players, true)
                     heading = ENTITY.GET_ENTITY_HEADING(players)
                     spawnDistance = 250.0 * math.sin(math.rad(heading))
                     spawnHeight = 10.0 -- Adjust this value to set the height at which the jet spawns
                     isRoad, roadCoords = PATHFIND.GET_NTH_CLOSEST_VEHICLE_NODE_WITH_HEADING(coords.x + spawnDistance, coords.y + spawnDistance, coords.z, 1, coords, heading, 0, 9, 3.0, 2.5)
                     clown = joaat("s_m_y_clown_01")
                     jet = joaat("Lazer")
                     weapon = -1121678507

                    STREAMING.REQUEST_MODEL(clown)
                    STREAMING.REQUEST_MODEL(jet)
                    STREAMING.REQUEST_MODEL(weapon)

                    while not STREAMING.HAS_MODEL_LOADED(clown) or not STREAMING.HAS_MODEL_LOADED(jet) do    
                        STREAMING.REQUEST_MODEL(clown)
                        STREAMING.REQUEST_MODEL(jet)
                        clownJetsOne:yield()
                    end

                    -- Calculate the spawn position for the jet in the air
                     jetSpawnX = coords.x + math.random(-1000, 1000)
                     jetSpawnY = coords.y + math.random(-1000, 1000)
                     jetSpawnZ = coords.z + math.random(100, 1200)
                    
                     colors = {27, 28, 29, 150, 30, 31, 32, 33, 34, 143, 35, 135, 137, 136, 36, 38, 138, 99, 90, 88, 89, 91, 49, 50, 51, 52, 53, 54, 92, 141, 61, 62, 63, 64, 65, 66, 67, 68, 69, 73, 70, 74, 96, 101, 95, 94, 97, 103, 104, 98, 100, 102, 99, 105, 106, 71, 72, 142, 145, 107, 111, 112,}
                     jetVehicle = VEHICLE.CREATE_VEHICLE(jet, jetSpawnX, jetSpawnY, jetSpawnZ, heading, true, false, false)
                    if jetVehicle ~= 0 then
                         primaryColor = colors[math.random(#colors)]
                         secondaryColor = colors[math.random(#colors)]

                        -- Set vehicle colors
                        VEHICLE.SET_VEHICLE_COLOURS(jetVehicle, primaryColor, secondaryColor)
                        -- Spawn clowns inside the jet
                        for seat = -1, -1 do
                             ped = PED.CREATE_PED(0, clown, jetSpawnX, jetSpawnY, jetSpawnZ, heading, true, true)
                            
                            if ped ~= 0 then
                                 group = joaat("HATES_PLAYER")
                                PED.ADD_RELATIONSHIP_GROUP("clowns", group)
                                ENTITY.SET_ENTITY_CAN_BE_DAMAGED_BY_RELATIONSHIP_GROUP(ped, false, group)
                                PED.SET_PED_CAN_BE_TARGETTED(ped, false)
                                WEAPON.GIVE_WEAPON_TO_PED(ped, weapon, 999999, false, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 31, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
                                PED.SET_PED_INTO_VEHICLE(ped, jetVehicle, seat)
                                TASK.TASK_COMBAT_PED(ped, players, 0, 16)
                                ENTITY.SET_ENTITY_MAX_HEALTH(ped, 1000)
                                ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
                                ENTITY.SET_ENTITY_MAX_HEALTH(jetVehicle, 1000)
                                ENTITY.SET_ENTITY_HEALTH(jetVehicle, 1000, 0)
                                PED.SET_AI_WEAPON_DAMAGE_MODIFIER(10000)
                                WEAPON.SET_WEAPON_DAMAGE_MODIFIER(1060309761, 10000)
                            else
                                gui.show_error("Failed", "Failed to create ped")
                            end
                        end
                    else
                        gui.show_error("Failed", "Failed to create jet")
                    end
                
                    if jetVehicle == 0 then 
                        gui.show_error("Failed", "Failed to Create Jet")
                    else
                        gui.show_message("Griefing", "Clown Lazers spawned!  Lock-on Acquired! Target: "..PLAYER.GET_PLAYER_NAME(player).." Spawning jets every 15 seconds.")
                    end
                end
            end
            -- Release the resources associated with the spawned entities
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(jetVehicle)
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
            sleep(15)
        end
    end)
toolTip(Global, "Spawns Rainbos colored jets with clowns as pilots on the entire session, loops and runs every 15 seconds.")
 explosionLoop = false
explosionLoop = Global:add_checkbox("Explosion (On/Off)")

script.register_looped("explosionLoop", function()
    if explosionLoop:is_enabled() == true then
         explosionType = 1  -- Adjust this according to the explosion type you want (1 = GRENADE, 2 = MOLOTOV, etc.)
         explosionFx = "explosion_barrel"
         PlayerId = PLAYER.PLAYER_ID()

        for i = 0, 31 do
            if i ~= PlayerId then
                 player_id = i
                 coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                gui.show_message("Global (Toxic)", "Exploding " .. PLAYER.GET_PLAYER_NAME(player_id) .. " repeatedly")
                
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000.0, true, false, 0, false)
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)

                -- Optionally, you can play an explosion sound here using AUDIO.PLAY_SOUND_FROM_COORD
            end
        end

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before exploding another player
    end
end)
toolTip(Global, "Explode the entire session")
Global:add_sameline()
 ramGlobal = Global:add_checkbox("Vehicle Sandwich (On/Off)")

script.register_looped("ramGlobal", function()
    if ramGlobal:is_enabled() then
     PlayerId = PLAYER.PLAYER_ID()
         for i = 0, 31 do
            if i ~= PlayerId then
                 player_id = i
                    if NETWORK.NETWORK_IS_PLAYER_ACTIVE(player_id) then
                         coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                        -- Get a random vehicle model from the list (make sure 'vehicleModels' is defined)
                         randomModel = vehicleModels[math.random(1, #vehicleModels)]

                        -- Convert the string vehicle model to its hash value
                         modelHash = MISC.GET_HASH_KEY(randomModel)

                        -- Create the vehicle without the last boolean argument (keepTrying)
                         vehicle = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z + 20, 0.0, true, true, false)
                        -- Set vehicle orientation
                        ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 0, 0, 2, true)
                         networkId = NETWORK.VEH_TO_NET(vehicle)
                        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle) then
                            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
                        end

                        if vehicle then
                            -- Set the falling velocity (adjust the value as needed)
                            ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -100000000)
                            -- Optionally, you can play a sound or customize the ramming effect here
                            VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(vehicle, true)
                        end
                        
                         vehicle2 = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z - 20, 0.0, true, true, false)
                        -- Set vehicle orientation
                        ENTITY.SET_ENTITY_ROTATION(vehicle2, 0, 0, 0, 2, true)
                         networkId = NETWORK.VEH_TO_NET(vehicle2)
                        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle2) then
                            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
                        end

                        if vehicle2 then
                            -- Set the falling velocity (adjust the value as needed)
                            ENTITY.SET_ENTITY_VELOCITY(vehicle2, 0, 0, 100000000)
                            -- Optionally, you can play a sound or customize the ramming effect here
                            VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(vehicle2, true)
                        end

                        gui.show_message("Grief", "Ramming " .. PLAYER.GET_PLAYER_NAME(player_id) .. " with vehicles")

                        -- Use these lines to delete the vehicle after spawning. 
                        -- Needs some type of delay between spawning and deleting to function properly
                        
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(vehicle)
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(vehicle2)
                    end
            end
        end

        -- Sets the timer in seconds for how long this should pause before ramming another player
        --sleep(0.2)
    end
end)
toolTip(Global, "Sandwich the entire session with vehicles")
-- Global Crashes
Global:add_sameline()
 crashGlobal = Global:add_checkbox("PR Crash All (On/Off)")

script.register_looped("crashGlobal", function()
    if crashGlobal:is_enabled() then
     PlayerId = PLAYER.PLAYER_ID()
         for i = 0, 31 do
            if i ~= PlayerId then
                 player_id = i
                 model = joaat("vw_prop_vw_colle_prbubble")
                 pickup = joaat("PICKUP_CUSTOM_SCRIPT")
                 money_value = 100000000000

                STREAMING.REQUEST_MODEL(model)

                if STREAMING.HAS_MODEL_LOADED(model) then
                gui.show_message("Global (Toxic)", "Crashing " .. PLAYER.GET_PLAYER_NAME(player_id) .. " with figurines")
                     coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                     objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                        pickup,
                        coords.x,
                        coords.y,
                        coords.z + 0.5,
                        3,
                        money_value,
                        model,
                        true,
                        false
                    )

                     net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
                    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
                    
                    ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(objectIdSpawned)
                end
                 sleep(0.1) -- Sets the timer in seconds for how long this should pause
            end
        end
    end
end)
toolTip(Global, "Spawn overpriced Princess Robot Figurines to crash all players in the session")
-- Global Weapons
Global:add_separator()
Global:add_text("Global Weapons Options")
Global:add_button("Give All Weapons to Players", function()
     player_count = PLAYER.GET_NUMBER_OF_PLAYERS()

    for i = 0, 31 do
         playerID = i
         ent = PLAYER.GET_PLAYER_PED(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                 weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, 9999, false, true)
            end
        end
    end
     msg = "I have given the entire lobby all weapons.  This only lasts until you switch sessions, enjoy!"
    network.send_chat_message(msg, false)
    gui.show_message("Global", "Successfully given all weapons to all players")
end)
toolTip(Global, "Gives all weapons to the entire session and also announces that you have done so")
Global:add_sameline()
Global:add_button("Remove All Weapons from Players", function()
     player_count = PLAYER.GET_NUMBER_OF_PLAYERS()

    for i = 0, 31 do
         playerID = i
         ent = PLAYER.GET_PLAYER_PED(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                 weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.REMOVE_WEAPON_FROM_PED(ent, weaponHash)
            end
        end
    end
     msg = "I have removed all weapons from the entire lobby.  This only lasts until you switch sessions, have fun!"
    network.send_chat_message(msg, false)
    gui.show_message("Global", "Successfully removed all weapons from all players")
end)
toolTip(Global, "Removes all weapons from the entire session and also anounces that you have done so")
-- Story Mode Options

StoryCharacters = KAOS:add_tab("Story Mode")

    mCash = 0
    StoryCharacters:add_imgui(function()
        mCash, used = ImGui.SliderInt("Michael's Cash", mCash, 1, 2147483646)
        out = "Michael's cash set to $"..tostring(mCash)
        if used then
            STATS.STAT_SET_INT(joaat("SP0_TOTAL_CASH"), mCash, true)
            gui.show_message('Story Mode Cash Updated!', out)
        end
    end)
    
    fCash = 0
    StoryCharacters:add_imgui(function()
        fCash, used = ImGui.SliderInt("Franklin's Cash", fCash, 1, 2147483646)
        out = "Franklins's cash set to $"..tostring(fCash)
        if used then
            STATS.STAT_SET_INT(joaat("SP1_TOTAL_CASH"), fCash, true)
            gui.show_message('Story Mode Cash Updated!', out)
        end
    end)
    
    tCash = 0
    StoryCharacters:add_imgui(function()
        tCash, used = ImGui.SliderInt("Trevor's Cash", tCash, 1, 2147483646)
        out = "Trevor's cash set to $"..tostring(tCash)
        if used then
            STATS.STAT_SET_INT(joaat("SP2_TOTAL_CASH"), tCash, true)
            gui.show_message('Story Mode Cash Updated!', out)
        end
    end)
    StoryCharacters:add_separator()
    mStats = 0
    StoryCharacters:add_imgui(function()
        mStats, used = ImGui.SliderInt("Michael's Stats", mStats, 0, 100)
        out = "Michael's Stats set to "..tostring(mStats).."/100"
        if used then
            STATS.STAT_SET_INT(joaat("SP0_SPECIAL_ABILITY"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_STAMINA"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_STRENGTH"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_LUNG_CAPACITY"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_WHEELIE_ABILITY"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_FLYING_ABILITY"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_SHOOTING_ABILITY"), mStats, true)
            STATS.STAT_SET_INT(joaat("SP0_STEALTH_ABILITY"), mStats, true)
            gui.show_message('Story Mode Stats Updated!', out)
        end
    end)
    
    fStats = 0
    StoryCharacters:add_imgui(function()
        fStats, used = ImGui.SliderInt("Franklin's Stats", fStats, 0, 100)
        out = "Franklin's Stats set to "..tostring(fStats).."/100"
        if used then
            STATS.STAT_SET_INT(joaat("SP1_SPECIAL_ABILITY"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_STAMINA"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_STRENGTH"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_LUNG_CAPACITY"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_WHEELIE_ABILITY"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_FLYING_ABILITY"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_SHOOTING_ABILITY"), fStats, true)
            STATS.STAT_SET_INT(joaat("SP1_STEALTH_ABILITY"), fStats, true)
            gui.show_message('Story Mode Stats Updated!', out)
        end
    end)
    
    tStats = 0
    StoryCharacters:add_imgui(function()
        tStats, used = ImGui.SliderInt("Trevor's Stats", tStats, 0, 100)
        out = "Trevor's Stats set to "..tostring(tStats).."/100"
        if used then
            STATS.STAT_SET_INT(joaat("SP2_SPECIAL_ABILITY"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_STAMINA"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_STRENGTH"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_LUNG_CAPACITY"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_WHEELIE_ABILITY"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_FLYING_ABILITY"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_SHOOTING_ABILITY"), tStats, true)
            STATS.STAT_SET_INT(joaat("SP2_STEALTH_ABILITY"), tStats, true)
            gui.show_message('Story Mode Stats Updated!', out)
        end
    end)
    
-- Weapons Tab

 Weapons = KAOS:add_tab("Weapons")

Weapons:add_button("Remove All Weapons", function()
         playerID = network.get_selected_player()
         ent = PLAYER.GET_PLAYER_PED(playerID)
        out = "Successfully removed all weapons from "..PLAYER.GET_PLAYER_NAME(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                 weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.REMOVE_WEAPON_FROM_PED(ent, weaponHash)
                gui.show_message('Weapons', out)
                
            end
        end
end)
toolTip(Weapons, "Removes all weapons from the selected player")
Weapons:add_sameline()
Weapons:add_button("Give All Weapons", function()
         playerID = network.get_selected_player()
         ent = PLAYER.GET_PLAYER_PED(playerID)
        out = "Successfully given all weapons to "..PLAYER.GET_PLAYER_NAME(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                 weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, 9999, false, true)
                gui.show_message('Weapons', out)
                
            end
        end
end)
toolTip(Weapons, "Gives all weapons to the selected player")
Weapons:add_separator()
Weapons:add_text("Weapon Drops")
Weapons:add_button("Drop Random Weapon", function()
         weaponName = weaponNamesString[math.random(1, #weaponNamesString)]
         money_value = 0
         player_id = network.get_selected_player()
         model = weaponModels[math.random(1, #weaponModels)]

         modelHash = joaat(model)
        STREAMING.REQUEST_MODEL(modelHash)
        while STREAMING.HAS_MODEL_LOADED(modelHash) == false do
            script:yield()
        end
        if STREAMING.HAS_MODEL_LOADED(modelHash) then
            gui.show_message("Weapon Drop Started", "Dropping " .. weaponName .. " on "..PLAYER.GET_PLAYER_NAME(player_id))
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
             objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                joaat("PICKUP_" .. string.upper(weaponName)),
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                modelHash,
                true,
                false
            )

             net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
end)
toolTip(Weapons, "Drops random weapons on the selected player as pickup items")
Weapons:add_separator()


-- Business Management
 Business = KAOS:add_tab("Business Manager")

 agency = Business:add_tab("Agency")

MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end

 contract_id = {3, 4, 12, 28, 60, 124, 252, 508, 2044, 4095, -1}
 contract_names = {"The Nightclub", "The Marina", "Nightlife Leak", "The Country Club", "Guest List", "High Society Leak", "Davis", "The Ballas", "The South Central Leak", "Studio Time", "Don't Fuck With Dre"}
 selectedContractIndex = 0
 selectedContractID = contract_id[selectedContractIndex + 1]

agency:add_text("Agency Contract Selection")

-- Display the listbox
 contractChanged = false

agency:add_imgui(function()
    selectedContractIndex, used = ImGui.ListBox("##ContractList", selectedContractIndex, contract_names, #contract_names) -- Display the listbox
    if used then
        selectedContractID = contract_id[selectedContractIndex + 1]
    end

    if ImGui.Button("Select Contract") then
         contractIndexToUse = selectedContractIndex + 1  -- Adjusted index for contract names
         contractIDToUse = contract_id[contractIndexToUse]
        STATS.STAT_SET_INT(joaat(MPX .. "FIXER_STORY_BS"), contractIDToUse, true)
        gui.show_message("Agency", "Contract: " .. contract_names[contractIndexToUse] .. " ID: " .. contractIDToUse .. " Selected")
    end
end)
toolTip(agency, "Sets the selected contract as the one you are currently playing")
agency:add_sameline()

agency:add_button("Complete Preps", function()
    STATS.STAT_SET_INT(joaat(MPX .. "FIXER_GENERAL_BS"), -1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "FIXER_COMPLETED_BS"), -1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "FIXER_STORY_COOLDOWN_POSIX"), -1, true)
end)
toolTip(agency, "Completes the preps of your current contract")
agency:add_sameline()
agency:add_button("Skip Cooldown", function()
    STATS.STAT_SET_INT(joaat(MPX .. "FIXER_STORY_COOLDOWN"), -1, true)
end)
toolTip(agency, "Skips the cooldown between playing contracts")
agency:add_separator()
agency:add_text("Money")
 agencySafe = agency:add_checkbox("Agency Safe Loop")
script.register_looped("agencyloop", function(script)
    script:yield()
    if agencySafe:is_enabled() == true then
        gui.show_message("Business Manager", "Supplying Agency Safe with money")
        STATS.STAT_SET_INT(joaat(MPX .. "FIXER_COUNT"), 500, true)
        STATS.STAT_SET_INT(joaat(MPX .. "FIXER_PASSIVE_PAY_TIME_LEFT"), -1, true)
        sleep(0.5)
    end
end)
toolTip(agency, "Fills your agency safe with money")
 bunker = Business:add_tab("Bunker")

bunker:add_button("Unlock All Shooting Range", function()
MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_1"), 690, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_2"), 1860, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_3"), 2690, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_4"), 2660, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_5"), 2650, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_HIGHSCORE_6"), 450, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_TARGETS_HIT"), 269, true)
    STATS.STAT_SET_INT(joaat(MPX .. "SR_WEAPON_BIT_SET"), -1, true)
    STATS.STAT_SET_BOOL(joaat(MPX .. "SR_TIER_1_REWARD"), true, true)
    STATS.STAT_SET_BOOL(joaat(MPX .. "SR_TIER_3_REWARD"), true, true)
    STATS.STAT_SET_BOOL(joaat(MPX .. "SR_INCREASE_THROW_CAP"), true, true)
end)
toolTip(bunker, "Sets all shooting range missions to completed @ 3 stars")
 bResearch = bunker:add_checkbox("Instant Research Cooldown (Looped)")
MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
script.register_looped("bunkerResearch", function()
    if bResearch:is_enabled() == true then
        STATS.STAT_SET_INT(joaat(MPX .. "GR_RESEARCH_PRODUCTION_TIME"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "GR_RESEARCH_UPGRADE_EQUIPMENT_REDUCTION_TIME"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "GR_RESEARCH_UPGRADE_STAFF_REDUCTION_TIME"), 0, true)
        gui.show_message("Bunker", "Research is moving fast, feel free to walk away")
        gui.show_message("Bunker", "Optionally, you can access the PC and pay to fast track")
    end
end)
toolTip(bunker, "Speeds up research, toggle with resupply, optionally access the pc and fast track it")
bunker:add_sameline()
 bSupplies = bunker:add_checkbox("Resupply Bunker (Looped)")
script.register_looped("autoGetBunkerCargo", function(script)
    script:yield()
    if bSupplies:is_enabled() == true then
        autoGetBunkerCargo = not autoGetBunkerCargo
        if autoGetBunkerCargo then
            globals.set_int(1662873 + 1 + 5, 1)
            if bResearch:is_enabled() == true then
                gui.show_message("Bunker", "Resupplying your supplies for your research")
            else
                gui.show_message("Bunker", "Resupplying your bunker supplies, please wait...")
                sleep(0.5)
            end
        end
    end
end)
toolTip(bunker, "Instantly resupplies your bunker supplies")
 Hangar = Business:add_tab("Hangar")

hStock = Hangar:add_checkbox("Resupply Hangar Cargo (Looped)")
script.register_looped("autoGetHangarCargo", function(script)
  MPX = PI
        PI = stats.get_int("MPPLY_LAST_MP_CHAR")
        if PI == 0 then
            MPX = "MP0_"
        else
            MPX = "MP1_"
        end
    script:yield()
    if hStock:is_enabled() == true then
        autoGetHangarCargo = not autoGetHangarCargo
        if autoGetHangarCargo then
            stats.set_bool_masked(MPX .. "DLC22022PSTAT_BOOL3", true, 9)
            gui.show_message("Hangar", "Restocking hangar cargo, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(Hangar, "Instantly supplies your hangar with random cargo")
 mcBus = Business:add_tab("Motorcycle Club")

mcBus:add_button("MC President (On/Off)", function()
    -- -1 is off, 0 is on
    playerID = PLAYER.PLAYER_ID()
    g = 1886967 + (playerID * 609) + 10
    gb1 = globals.get_int(g + 1)
    gb2 = globals.get_int(g + 430)
    if gb1 == playerID and gb2 == 1 then
        globals.set_int(g + 1, -1)
        globals.set_int(g + 430, -1)
        gui.show_message("Motorcycle Club", "You are no longer an MC President")
    else
        globals.set_int(g + 1, playerID)
        globals.set_int(g + 430, 1)
        gui.show_message("Motorcycle Club", "You are now an MC President")
    end
end)
toolTip(mcBus, "Register as an MC President")
mcBus:add_text("Resuppliers")
acidLab = mcBus:add_checkbox("Resupply Acid Lab (Looped)")
script.register_looped("autoGetAcidCargo", function(script)
    script:yield()
    if acidLab:is_enabled() == true then
        autoGetAcidCargo = not autoGetAcidCargo
        if autoGetAcidCargo then
            globals.set_int(1662873 + 1 + 6, 1)
            gui.show_message("Acid Lab", "Resupplying your acid lab stock, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Acid Lab supplies")
mcBus:add_sameline()
docForge = mcBus:add_checkbox("Resupply Document Forge (Looped)")
script.register_looped("autoGetDocForgeCargo", function(script)
    script:yield()
    if docForge:is_enabled() == true then
        autoGetDocForgeCargo = not autoGetDocForgeCargo
        if autoGetDocForgeCargo then
            globals.set_int(1662873 + 1 + 1, 1)
            gui.show_message("Document Forge", "Resupplying your document forge, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Document Forge supplies")
weed = mcBus:add_checkbox("Resupply Weed (Looped)")
script.register_looped("autoGetWeedCargo", function(script)
    script:yield()
    if weed:is_enabled() == true then
        autoGetWeedCargo = not autoGetWeedCargo
        if autoGetWeedCargo then
            globals.set_int(1662873 + 1 + 2, 1)
            gui.show_message("Weed Farm", "Resupplying your weed farm, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Weed Farm supplies")
mcBus:add_sameline()
meth = mcBus:add_checkbox("Resupply Meth (Looped)")
script.register_looped("autoGetMethCargo", function(script)
    script:yield()
    if meth:is_enabled() == true then
        autoGetMethCargo = not autoGetMethCargo
        if autoGetMethCargo then
            globals.set_int(1662873 + 1 + 3, 1)
            gui.show_message("Meth Lab", "Resupplying your meth lab, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Meth Lab supplies")
mcBus:add_sameline()
cocaine = mcBus:add_checkbox("Resupply Cocaine (Looped)")
script.register_looped("autoGetCokeCargo", function(script)
    script:yield()
    if cocaine:is_enabled() == true then
        autoGetCokeCargo = not autoGetCokeCargo
        if autoGetCokeCargo then
            globals.set_int(1662873 + 1 + 4, 1)
            gui.show_message("Cocaine Lockup", "Resupplying your cocaine lockup, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Cocaine Lockup supplies")
fakeCash = mcBus:add_checkbox("Resupply Counterfeit Cash (Looped)")
script.register_looped("autoGetCashCargo", function(script)
    script:yield()
    if fakeCash:is_enabled() == true then
        autoGetCashCargo = not autoGetCashCargo
        if autoGetCashCargo then
            globals.set_int(1662873 + 1 + 0, 1)
            gui.show_message("Counterfeit Cash", "Resupplying your counterfeit cash, please wait...")
            sleep(0.5)
        end
    end
end)
toolTip(mcBus, "Resupply your Counterfeit Cash supplies")
mcBus:add_separator()
mcBus:add_button("Resupply All", function()
globals.set_int(1662873 + 1 + 6, 1)
globals.set_int(1662873 + 1 + 6, 1)
globals.set_int(1662873 + 1 + 6, 1) -- Acid Lab Supplies
gui.show_message("Acid Lab", "Resupplying your Acid Lab")
globals.set_int(1662873 + 1 + 5, 1)
globals.set_int(1662873 + 1 + 5, 1)
globals.set_int(1662873 + 1 + 5, 1) -- Bunker Supplies
gui.show_message("Bunker", "Resupplying your Bunker")
globals.set_int(1662873 + 1 + 1, 1)
globals.set_int(1662873 + 1 + 1, 1)
globals.set_int(1662873 + 1 + 1, 1) -- Document Forge Supplies
gui.show_message("Document Forge", "Resupplying your Document Forge")
globals.set_int(1662873 + 1 + 2, 1)
globals.set_int(1662873 + 1 + 2, 1)
globals.set_int(1662873 + 1 + 2, 1) -- Weed Farm Supplies
gui.show_message("Weed Farm", "Resupplying your Weed Farm")
globals.set_int(1662873 + 1 + 3, 1)
globals.set_int(1662873 + 1 + 3, 1)
globals.set_int(1662873 + 1 + 3, 1) -- Meth Lab Suplies
gui.show_message("Meth Lab", "Resupplying your Meth Lab")
globals.set_int(1662873 + 1 + 4, 1)
globals.set_int(1662873 + 1 + 4, 1)
globals.set_int(1662873 + 1 + 4, 1) -- Cocaine Lockup Supplies
gui.show_message("Cocaine Lockup", "Resupplying your Cocaine Lockup")
end)
toolTip(mcBus, "Resupplies all your supplies for all businesses")
mcBus:add_sameline()
mcBus:add_button("Fast Production", function()
    globals.set_int(262145 + 17599, 25500) -- prod time for weed
    globals.set_int(262145 + 17600, 25500) -- prod time for meth
    globals.set_int(262145 + 17601, 25500) -- prod time for cocaine
    globals.set_int(262145 + 17602, 25500) -- prod time for document forge
    globals.set_int(262145 + 17603, 25500) -- prod time for cash
    --globals.set_int(262145 + 17632, 10000)
    gui.show_message("Production Speed", "Production speed has been sped up for all businesses")
    gui.show_message("Production Speed", "Production speed increase will not start until workers finish the first product, keep it supplied to fill the product bar")
end)
toolTip(mcBus, "Activates fast production for all MC businesses (read top right for info after pressing the button)")
mcBus:add_sameline()
mcBus:add_button("Raise Sale Prices", function()
    globals.set_int(262145 + 17632, 15000) -- price for weed
    globals.set_int(262145 + 17631, 60000) -- price for meth
    globals.set_int(262145 + 17630, 100000) -- price for cocaine
    globals.set_int(262145 + 17628, 20000) -- price for document forge
    globals.set_int(262145 + 17629, 30000) -- price for cash
    --globals.set_int(262145 + 17632, 10000)
    gui.show_message("Production Value", "Production sale value has been increased for all businesses")
end)
toolTip(mcBus, "Raises the sale price for all MC Businesses to over 1 million each")
mcBus:add_separator()
mcBus:add_text("Motorcycle Club Name Changer")
 mcName = ""
mcBus:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    mcName, used = ImGui.InputText("MC name", mcName, 256)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)
toolTip(mcBus, "Change your MC Name to whatever you want")
checkBoxes = {}
labels = {"R* Verified Icon", "R* Icon", "R* Created Icon", "Lock Icon", "Copyright"}
values = {"&#166;", "&#8721;", "&#8249;", "&#937;", "&#169;"}

for i, label in ipairs(labels) do
    checkBox = mcBus:add_checkbox(labels[i])
    if #labels ~= i then
        mcBus:add_sameline()
    end
    table.insert(checkBoxes, checkBox)
    toolTip(mcBus, "Toggle an icon to use with your MC Name")
end

mcBus:add_button("Change MC Name", function()
    MPX = PI
    PI = stats.get_int("MPPLY_LAST_MP_CHAR")
    if PI == 0 then
        MPX = "MP0_"
    else
        MPX = "MP1_"
    end
    script.run_in_fiber(function (script)
        for i, checkBox in ipairs(checkBoxes) do
            if checkBox:is_enabled() then
                if labels[i] == "Copyright" then
                    STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME"), values[i].. " ", true)
                    STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME2"), mcName, true)
                     MCnTwo = STATS.STAT_GET_STRING(joaat(MPX .. "MC_GANG_NAME2"), -1)
                    gui.show_message("Motorcycle Club", "Your MC name has been changed to ".. mcName .. " game returns ".. labels[i].. " ".. MCnTwo.. ". Changing sessions to apply")
                    SessionChanger(0)
                    return
                else
                    STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME"), mcName, true)
                    STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME2"), values[i].. " ", true)
                     MCnOne = STATS.STAT_GET_STRING(joaat(MPX .. "MC_GANG_NAME"), -1)
                    gui.show_message("Motorcycle Club", "Your MC name has been changed to ".. mcName .. " game returns ".. labels[i].. " - ".. MCnOne.. ". Changing sessions to apply")
                    SessionChanger(0)
                    return
                end
            end
        end
        STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME"), "", true)
        STATS.STAT_SET_STRING(joaat(MPX .. "MC_GANG_NAME2"), mcName, true)
         MCnTwo = STATS.STAT_GET_STRING(joaat(MPX .. "MC_GANG_NAME2"), -1)
        gui.show_message("Motorcycle Club", "Your MC name has been changed to ".. mcName .. " game returns "..MCnTwo..". Changing sessions to apply")
        SessionChanger(0)
    end)
end)
toolTip(mcBus, "Apply changes and switch sessions.")
script.register_looped("mcNameCB", function(mcName)
    cbE = 0
    for i, checkBox in ipairs(checkBoxes) do
        if checkBox:is_enabled() then
            cbE = cbE + 1
        end
        if cbE > 1 then
            checkBox:set_enabled(false)
            gui.show_message("Icons", "you can only select one checkbox")
        end
    end
end)

 arcade = Business:add_tab("Arcade")

MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end

 arcadeSafe = arcade:add_checkbox("Arcade Safe Loop")
script.register_looped("arcadeloop", function(script)
    script:yield()
    if arcadeSafe:is_enabled() == true then
        gui.show_message("Business Manager", "Supplying Arcade Safe with money")
        STATS.STAT_SET_INT(joaat(MPX .. "ARCADE_SAFE_CASH_VALUE"), 2000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "ARCADE_PAY_TIME_LEFT"), -1, true)
        sleep(0.5)
    end
end)
toolTip(arcade, "Fills your arcade safe with money")
-- Nightclub Loop - L7Neg
 Club = Business:add_tab("Nightclub")

MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end

nClub = Club:add_checkbox("Nightclub Safe Loop")
script.register_looped("nightclubloop", function(script)
    script:yield()
    if nClub:is_enabled() == true then
        gui.show_message("Business Manager", "Supplying 50k/s to Nightclub Safe")
        STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true)
        STATS.STAT_SET_INT(joaat(MPX .. "CLUB_PAY_TIME_LEFT"), -1, true)
        sleep(0.5)
    end
end)
toolTip(Club, "Fills your nightclub safe with money")
Club:add_separator()
Club:add_button("Max Club Popularity", function()
    STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true)
end)
toolTip(Club, "Max your nightclubs popularity")
 CEO = Business:add_tab("CEO")

CEO:add_button("Register as CEO", function()
    -- -1 is off, 0 is on
    playerID = PLAYER.PLAYER_ID()
    g = 1886967 + (playerID * 609) + 10
    gb1 = globals.get_int(g + 1)
    gb2 = globals.get_int(g + 430)
    if gb1 == playerID and gb2 == 0 then
        globals.set_int(g + 1, -1)
        globals.set_int(g + 430, -1)
        gui.show_message("CEO", "You are no longer a CEO")
    else
        globals.set_int(g + 1, playerID)
        globals.set_int(g + 430, 0)
        gui.show_message("CEO", "You are now a CEO")
    end
end)
toolTip(CEO, "Register as a CEO")
 setName = ""
CEO:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    setName, used = ImGui.InputText("org name", setName, 256)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)
toolTip(CEO, "Change your CEO name to whatever you want.")

checkBoxes = {}
labels = {"R* Verified Icon", "R* Icon", "R* Created Icon", "Lock Icon", "Copyright"}
values = {"&#166;", "&#8721;", "&#8249;", "&#937;", "&#169;"}

for i, label in ipairs(labels) do
    checkBox = CEO:add_checkbox(labels[i])
    if #labels ~= i then
        CEO:add_sameline()
    end
    table.insert(checkBoxes, checkBox)
    toolTip(CEO, "Toggle an icon to use with your CEO Name")
end

CEO:add_button("Change CEO Name", function()
    MPX = PI
    PI = stats.get_int("MPPLY_LAST_MP_CHAR")
    if PI == 0 then
        MPX = "MP0_"
    else
        MPX = "MP1_"
    end
    script.run_in_fiber(function (script)
        for i, checkBox in ipairs(checkBoxes) do
            if checkBox:is_enabled() then
                if labels[i] == "Copyright" then
                    STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME"), values[i].. " ", true)
                    STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME2"), setName, true)
                     MCnTwo = STATS.STAT_GET_STRING(joaat(MPX .. "GB_OFFICE_NAME2"), -1)
                    gui.show_message("Motorcycle Club", "Your CEO name has been changed to ".. setName .. " game returns ".. labels[i].. " ".. MCnTwo.. ". Changing sessions to apply")
                    SessionChanger(0)
                    return
                else
                    STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME"), setName, true)
                    STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME2"), values[i].. " ", true)
                     MCnOne = STATS.STAT_GET_STRING(joaat(MPX .. "GB_OFFICE_NAME"), -1)
                    gui.show_message("CEO", "Your CEO name has been changed to ".. setName .. " game returns ".. labels[i].. " - ".. MCnOne.. ". Changing sessions to apply")
                    SessionChanger(0)
                    return
                end
            end
        end
        STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME"), "", true)
        STATS.STAT_SET_STRING(joaat(MPX .. "GB_OFFICE_NAME2"), setName, true)
         MCnTwo = STATS.STAT_GET_STRING(joaat(MPX .. "GB_OFFICE_NAME2"), -1)
        gui.show_message("CEO", "Your CEO name has been changed to ".. setName .. " game returns "..MCnTwo..". Changing sessions to apply")
        SessionChanger(0)
    end)
end)
toolTip(CEO, "Apply changes and switch sessions")
-- YimCEO -- Alestarov_Menu
 yimCEO = CEO:add_tab("YimCEO")

cratevalue = 10000
yimCEO:add_imgui(function()
    cratevalue, used = ImGui.SliderInt("Crate Value", cratevalue, 10000, 5000000)
    if used then
        globals.set_int(262145 + 15991, cratevalue)
    end
end)
toolTip(yimCEO, "Set your desired crate value")
yCEO = yimCEO:add_checkbox("Enable YimCeo")
toolTip(yimCEO, "Set value, Enable yimCEO then click show computer and go to Special cargo > Sell")
yimCEO:add_button("Show computer", function()
    SCRIPT.REQUEST_SCRIPT("apparcadebusinesshub")
    SYSTEM.START_NEW_SCRIPT("apparcadebusinesshub", 8344)
end)
toolTip(yimCEO, "Click to show Master Computer (may need to click twice)")
script.register_looped("yimceoloop", function(script)
    cratevalue = globals.get_int(262145 + 15991)
    globals.set_int(262145 + 15756, 0)
    globals.set_int(262145 + 15757, 0)
    script:yield()

    while true do
        script:sleep(1000)  -- Adjust the sleep duration as needed

        if yCEO:is_enabled() == true then
        gui.show_message("YimCEO Enabled!", "Enjoy the bank roll!")
            if locals.get_int("appsecuroserv", 2) == 1 then
                script:sleep(500)
                locals.set_int("appsecuroserv", 740, 1)
                script:sleep(200)
                locals.set_int("appsecuroserv", 739, 1)
                script:sleep(200)
                locals.set_int("appsecuroserv", 558, 3012)
                script:sleep(1000)
            end 
            if locals.get_int("gb_contraband_sell", 2) == 1 then
                locals.set_int("gb_contraband_sell", 543 + 595, 1)
                locals.set_int("gb_contraband_sell", 543 + 55, 0)
                locals.set_int("gb_contraband_sell", 543 + 584, 0)
                locals.set_int("gb_contraband_sell", 543 + 7, 7)
                script:sleep(500)
                locals.set_int("gb_contraband_sell", 543 + 1, 99999)
            end
            if locals.get_int("gb_contraband_buy", 2) == 1 then
                locals.set_int("gb_contraband_buy", 601 + 5, 1)
                locals.set_int("gb_contraband_buy", 601 + 191, 6)
                locals.set_int("gb_contraband_buy", 601 + 192, 4)
                gui.show_message("Warehouse full!")
            end
        end
    end
end)

yimCEO:add_separator()
yimCEO:add_text("Fast CEO yimCEO (How To)")
yimCEO:add_separator()
yimCEO:add_text("SWITCH TO INVITE ONLY LOBBY BEFORE USING!")
yimCEO:add_text("1) Click 'Enable YimCeo'")
yimCEO:add_text("2) Select the desired crate value (10k to 5m)")
yimCEO:add_text("3) Click 'Show computer', select 'Special Cargo', click 'Sell Cargo' and wait")
yimCEO:add_text("4) Use the 'Stats' tab to reset your stats and change sessions to apply")
yimCEO:add_text("IF it tells you your warehouse is empty, turn it off stock 1 item in crates and run it again after.")
yimCEO:add_separator()
yimCEO:add_text("You need to manually click Special/Sell Cargo each time.")
yimCEO:add_text("You may also get up to 500k more than 5m sometimes.")

--Required Stats--

FMC2020 = "fm_mission_controller_2020"
HIP = "heist_island_planning"

-- Editor Stuff // Mashup Scripts L7Neg/Alestarov
 heistEditor = KAOS:add_tab("Heist Editor")
    MPX = PI
    PI = stats.get_int("MPPLY_LAST_MP_CHAR")
    if PI == 0 then
        MPX = "MP0_"
    else
        MPX = "MP1_"
    end

heistTab = heistEditor:add_tab("Apartment Heists")

player = PLAYER.PLAYER_PED_ID()
coords = ENTITY.GET_ENTITY_COORDS(player, true)

heistIndex = 0

function tp(x, y, z, pitch, yaw, roll)
    player = PLAYER.PLAYER_PED_ID()
    ENTITY.SET_ENTITY_COORDS(player, x, y, z - 1, true, false, false, false)
    ENTITY.SET_ENTITY_ROTATION(player, pitch, yaw, roll, 0, true)
end

function MPX()
    return "MP" .. stats.get_int("MPPLY_LAST_MP_CHAR") .. "_"
end

function cuts(cut)
    script.run_in_fiber(function(cuts)
        control = 2
        enter = 201 --enter
        cancel = 202 --cancel
        globals.set_int(1928233 + 1 + 1, 100 - (cut * 4))
        globals.set_int(1928233 + 1 + 2, cut)
        globals.set_int(1928233 + 1 + 3, cut)
        globals.set_int(1928233 + 1 + 4, cut)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(control, enter, 1)
        cuts:sleep(1000)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(control, cancel, 1)
        cuts:sleep(1000)
        globals.set_int(1930201 + 3008 + 1, cut)
    end)
end

function fleecaCut()
    script.run_in_fiber(function(fleecaCuts)
        control = 2
        enter = 201 --enter
        cancel = 202 --cancel
        globals.set_int(1928233 + 1 + 1, 100 - (7453 * 2))
        globals.set_int(1928233 + 1 + 2, 7453)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(control, enter, 1)
        fleecaCuts:sleep(1000)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(control, cancel, 1)
        fleecaCuts:sleep(1000)
        globals.set_int(1930201 + 3008 + 1, 7453)
    end)
end

function bringTeam()
    script.run_in_fiber(function(bringteam)
        for i = 1, 3 do
            if (ENTITY.DOES_ENTITY_EXIST(PLAYER.GET_PLAYER_PED(i)) and calcDistance(player, PLAYER.GET_PLAYER_PED(i)) >= 20 and PLAYER.GET_PLAYER_TEAM(i) == PLAYER.GET_PLAYER_TEAM(PLAYER.PLAYER_ID())) then
                command.call( "bring", {i})
                bringteam:yield()
            end
        end
    end)
end

function calcDistance(player, target)
    pos = ENTITY.GET_ENTITY_COORDS(player, true)
    tarpos = ENTITY.GET_ENTITY_COORDS(target, true)
     dx = pos.x - tarpos.x
     dy = pos.y - tarpos.y
     dz = pos.z - tarpos.z
     distance = math.sqrt(dx*dx + dy*dy + dz*dz)
    return distance
end

function calcDistanceFromCoords(player, target)
    pos = ENTITY.GET_ENTITY_COORDS(player, true)
     dx = pos.x - target[1]
     dy = pos.y - target[2]
     dz = pos.z - target[3]
     distance = math.sqrt(dx*dx + dy*dy + dz*dz)
    return distance
end

function calcDistanceFromTwoCoords(pos, tarpos)
     dx = pos.x - tarpos.x
     dy = pos.y - tarpos.y
     dz = pos.z - tarpos.z
     distance = math.sqrt(dx*dx + dy*dy + dz*dz)
    return distance
end

unlockHeist = heistTab:add_checkbox("Play Unavailable Heists")
toolTip(heistTab, "Lets you play the grayed-out heists on apartment planning screen")

heistTab:add_imgui(function()
    if unlockHeist:is_enabled() then
        ImGui.Text("Heist will still be grayed out but you can now play it")
    end
end)

heistTab:add_button("Complete All Setups", function()
    locals.set_int(MPX .. "HEIST_PLANNING_STAGE", -1)
end)
toolTip(heistTab, "Complete setups for current heist")

heistTab:add_button("Bring Team", function()
    bringTeam()
end)
toolTip(heistTab, "Bring every player on your team to you")

heistTab:add_sameline()

heistTab:add_button("Bring Everyone", function()
    script.run_in_fiber(function(bringall)
        for i = 0, 3 do
            gui.show_message("Distance", tostring(calcDistance(player, PLAYER.GET_PLAYER_PED(i))))
            if (ENTITY.DOES_ENTITY_EXIST(PLAYER.GET_PLAYER_PED(i)) and calcDistance(player, PLAYER.GET_PLAYER_PED(i)) >= 50) then
                command.call( "bring", {i})
                bringall:yield()
            end
        end
    end)
end)
toolTip(heistTab, "Bring everyone to you")

heistTab:add_button("Spawn Tailgater", function()
    script.run_in_fiber(function(script)
        player = PLAYER.PLAYER_PED_ID()
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        while not STREAMING.HAS_MODEL_LOADED(joaat("tailgater")) do
            STREAMING.REQUEST_MODEL(joaat("tailgater"))
            script:yield()
        end
        vehicle = VEHICLE.CREATE_VEHICLE(joaat("tailgater"), coords.x, coords.y, coords.z, ENTITY.GET_ENTITY_HEADING(player), true, false, false)
        PED.SET_PED_INTO_VEHICLE(player ,vehicle, -1)
    end)
end)
toolTip(heistTab, "Spawns a tailgater(4-door)")

heistTab:add_sameline()

heistTab:add_button("TP To Objective", function()
    command.call("objectivetp", {})
end)
toolTip(heistTab, "Teleport yourself to the current objective")

heistTab:add_button("Life Count +5", function()
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("fm_mission_controller_2020")) ~= 0 then 
        network.force_script_host("fm_mission_controller_2020")
        c_tlives_v = locals.get_int("fm_mission_controller_2020", 55004 + 873 + 1)
        locals.set_int("fm_mission_controller_2020", 55004 + 873 + 1, c_tlives_v + 5)
    end
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("fm_mission_controller")) ~= 0 then 
        network.force_script_host("fm_mission_controller")
        globals.set_int(4718592 + 3318 + 1 + 38, 1)
        c_tlives_v = locals.get_int("fm_mission_controller", 26154 + 1325 + 1)
        locals.set_int("fm_mission_controller", 26154 + 1325 + 1, c_tlives_v + 5)
    end
end)
toolTip(heistTab, "Increase the life count by 5")

shootEnemies = heistTab:add_checkbox("Kill Enemies")
toolTip(heistTab, "Shoots every enemy ped within 150m")

heistTab:add_imgui(function()
    --PAD.DISABLE_ALL_CONTROL_ACTIONS(2)
    PAD.DISABLE_CONTROL_ACTION(2, 237, true)

    objectiveText = globals.get_string(1574764 + 16)
    tpdValk = false
    tpdParkingLot = false
    heistIndex = ImGui.Combo("Heist", heistIndex, {"Fleeca Job", "Prison Break", "Humane Labs", "Series A Funding", "Pacific Standard"}, 5, 5)
    toolTip("", "Heist you wish to edit")
    if heistIndex == 0 then -- fleeca
        ImGui.Text("Fastest as Hacker")
        if (ImGui.Button("15 Million Cuts")) then
            fleecaCut()
        end
        toolTip("", "Set every players cut to 15 million\nMust be hovering over your cut before clicking")
        if ImGui.Button("Bypass Hack") then
            locals.set_int("fm_mission_controller", 11776 + 24, 7)
        end
        toolTip("", "Instantly finish hacking")
        if ImGui.Button("Bypass Drill") then
            locals.get_float("fm_mission_controller", 10067 + 11, 100)
        end
        toolTip("", "Instantly finish drilling")
    end
    if heistIndex == 1 then -- prison break
        ImGui.Text("Fastest as Prison Officer")
        if (ImGui.Button("15 Million Cuts")) then
            cuts(2142)
        end
        toolTip("", "Set every players cut to 15 million\nMust be hovering over your cut before clicking")
        if (ImGui.Button("TP Prison Bus")) then
            script.run_in_fiber(function(pbus)
                for i, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
                    player = PLAYER.PLAYER_PED_ID()
                    blip = HUD.GET_BLIP_FROM_ENTITY(vehicle)
                    if (ENTITY.GET_ENTITY_MODEL(vehicle) == joaat("pbus") and blip == 133955592) then
                        PED.SET_PED_INTO_VEHICLE(player, vehicle, -1)
                        pbus:sleep(100)
                        PED.SET_PED_COORDS_KEEP_VEHICLE(player, -774.57, 288.42, 85.79)
                    end
                end
            end)
        end
        toolTip("", "Teleports the prison bus infront of the eclipse towers apartment")
    end
    if heistIndex == 2 then -- humane labs
        ImGui.Text("Fastest as Ground Team")
        if ImGui.Button("15 Million Cuts") then
            cuts(1587)
        end
        toolTip("", "Set every players cut to 15 million\nMust be hovering over your cut before clicking")
        if ImGui.Button("TP Valkeryie") then
            for i, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
                if (ENTITY.GET_ENTITY_MODEL(vehicle) == joaat("valkyrie")) then
                    player = PLAYER.PLAYER_PED_ID()
                    PED.SET_PED_INTO_VEHICLE(player, vehicle, 2)
                    PED.SET_PED_COORDS_KEEP_VEHICLE(player, -774.57, 288.42, 85.79)
                end
            end
        end
        toolTip("", "Teleports the valkyrie infront of the eclipse towers apartment")
        if ImGui.Button("Tunnel") then
            player = PLAYER.PLAYER_PED_ID()
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 3521.90, 3724.84, -9.47, true, false, false)
        end
    end
    if heistIndex == 3 then -- series a funding
        if ImGui.Button("15 Million Cuts") then
            cuts(2121)
        end
        toolTip("", "Set every players cut to 15 million\nMust be hovering over your cut before clicking")
    end
    if heistIndex == 4 then -- pacific standard
        if (ImGui.Button("15 Million Cuts")) then
            cuts(1000)
        end
        toolTip("", "Set every players cut to 15 million\nMust be hovering over your cut before clicking")
    end
end)

heistTab:add_imgui(function()
    if (ImGui.TreeNode("READ ME - IMPORTANT!")) then
        ImGui.Text("For completing setups")
        ImGui.Text("if you are in the planning screen after the cutscene")
        ImGui.Text("you can click it then scroll up down left or right")
        ImGui.Text("and it should kick you out of the screen and complete the setups")
        ImGui.Separator()
        ImGui.Text("For 15 million cuts")
        ImGui.Text("hover over your cut and click the button")
    end
    toolTip("", "Important information for using this script")
end)

script.register_looped("heistTabLoop", function(heistTabScript)
    if unlockHeist:is_enabled() then
        globals.set_int(1933381 + 420, 31)
    end

    if  shootEnemies:is_enabled() then
         pedtable = entities.get_all_peds_as_handles()
        for _, peds in pairs(pedtable) do
             selfpos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
             ped_pos = ENTITY.GET_ENTITY_COORDS(peds, false)
            if (PED.GET_RELATIONSHIP_BETWEEN_PEDS(peds, PLAYER.PLAYER_PED_ID()) == 4 or PED.GET_RELATIONSHIP_BETWEEN_PEDS(peds, PLAYER.PLAYER_PED_ID()) == 5 or HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(peds)) == 1 or HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(peds)) == 49 or ENTITY.GET_ENTITY_MODEL(peds) == joaat("S_M_Y_Swat_01") or ENTITY.GET_ENTITY_MODEL(peds) == joaat("S_M_Y_Cop_01") or ENTITY.GET_ENTITY_MODEL(peds) == joaat("S_F_Y_Cop_01") or ENTITY.GET_ENTITY_MODEL(peds) == joaat("S_M_Y_Sheriff_01") or ENTITY.GET_ENTITY_MODEL(peds) == joaat("S_F_Y_Sheriff_01")) and peds ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_DEAD_OR_DYING(peds,true)  and PED.IS_PED_A_PLAYER(peds) ~= 1 and calcDistance(PLAYER.PLAYER_PED_ID(), peds) <= 100 then 
                if PED.IS_PED_IN_ANY_VEHICLE(peds, true) then
                    request_control(peds)
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(peds)
                    ped_pos = ENTITY.GET_ENTITY_COORDS(peds, false)
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(ped_pos.x, ped_pos.y, ped_pos.z + 1, ped_pos.x, ped_pos.y, ped_pos.z, 1000, true, 2526821735, PLAYER.PLAYER_PED_ID(), false, true, 1.0)
                else
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(ped_pos.x, ped_pos.y, ped_pos.z + 1, ped_pos.x, ped_pos.y, ped_pos.z, 1000, true, 2526821735, PLAYER.PLAYER_PED_ID(), false, true, 1.0)
                end
            end
        end
    end


end)

 casinoHeist = heistEditor:add_tab("Casino Editor")
casinoHeist:add_text("Casino Heist Setups")

casinoHeist:add_button("Silent & Sneaky", function()
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_APPROACH"), 1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3_LAST_APPROACH"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_TARGET"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET1"), 127, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_DISRUPTSHIP"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_KEYLEVELS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWWEAP"), 4, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWDRIVER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWHACKER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_VEHS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_WEAPS"), 1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET0"), 262399, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_MASKS"), 2, true)
    gui.show_message("Casino Heist", "Setup Silent & Sneaky applied")
end)
casinoHeist:add_sameline()
casinoHeist:add_button("Big Con", function()
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_APPROACH"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3_LAST_APPROACH"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_TARGET"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET1"), 799, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_DISRUPTSHIP"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_KEYLEVELS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWWEAP"), 4, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWDRIVER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWHACKER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_VEHS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_WEAPS"), 0, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET0"), 913623, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_MASKS"), 2, true)
    gui.show_message("Casino Heist", "Setup Big Con applied")
    gui.show_message("Casino Heist", "Big Con may not work, use S&S or Aggressive setups.")
end)
casinoHeist:add_sameline()
casinoHeist:add_button("Aggressive", function()
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_APPROACH"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3_LAST_APPROACH"), 1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_TARGET"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET1"), 799, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_DISRUPTSHIP"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_KEYLEVELS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWWEAP"), 4, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWDRIVER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_CREWHACKER"), 5, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_VEHS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_WEAPS"), 1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET0"), 1835223, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_MASKS"), 2, true)
    gui.show_message("Casino Heist", "Setup Aggressive applied")
end)

casinoHeist:add_separator()

casinoHeist:add_button("Complete Preps", function() 
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_DISRUPTSHIP"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_KEYLEVELS"), 2, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_VEHS"), 3, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_WEAPS"), 0, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET0"), -1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_BITSET1"), -1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H3OPT_COMPLETEDPOSIX"), -1, true)
    gui.show_message("Casino Heist", "Preps Completed!")
end)

casinoHeist:add_sameline()
casinoHeist:add_button("Skip Cooldown", function()
    STATS.STAT_SET_INT(joaat(MPX .. "H3_COMPLETEDPOSIX"), -1, true)
    STATS.STAT_SET_INT(joaat(MPX .. "MPPLY_H3_COOLDOWN"), -1, true)
end)
 deleteNPCs = casinoHeist:add_checkbox("Delete Mission NPC's")
    script.register_looped("deleteNPCsLoopScript", function(script)
        if deleteNPCs:is_enabled() then
            for index, ped in ipairs(entities.get_all_peds_as_handles()) do 
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, true)
                PED.DELETE_PED(ped)
                sleep(0.1)
                PED.DELETE_PED(ped)
                sleep(0.1)
                PED.DELETE_PED(ped)
                sleep(0.1)
                PED.DELETE_PED(ped)
                sleep(0.1)
                gui.show_message("Casino Heist", "Deleting All NPC's from the mission.")
            end
        end
    end)
casinoHeist:add_separator()
casinoHeist:add_text("How to:")
casinoHeist:add_text("Click Skip cooldown (if applicable), then pay the 25k")
casinoHeist:add_text("After that back off the board and press a preset.")

-- Cayo Heist Editor - converted from L7Negs Ultimate Menu for Kiddions and some features like remove CCTV from Alestarov.
 cayoHeist = heistEditor:add_tab("Cayo Perico Editor")

cayoHeist:add_text("Non-Legit Presets")

cayoHeist:add_button("Panther/Gold (Hard)", function()
    MPX = PI
    PI = stats.get_int("MPPLY_LAST_MP_CHAR")
    if PI == 0 then
        MPX = "MP0_"
    else
        MPX = "MP1_"
    end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 1191817, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Panther Hard Mode has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)
cayoHeist:add_sameline()
cayoHeist:add_button("Diamond/Gold (Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 1191817, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Diamond Hard Mode has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Bonds/Gold (Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 1191817, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Bonds Hard Mode has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Necklace/Gold (Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 1191817, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Necklace Hard Mode has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Tequila/Gold (Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 1191817, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Tequila Hard Mode has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)
cayoHeist:add_separator()
cayoHeist:add_text("Legit Presets")

cayoHeist:add_button("Panther/Gold (L. Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 5, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        -- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        
        -- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
        
        -- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        
        -- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 45375, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_V"), 10406, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), 16875, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), 25312, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), 22500, true)
        globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
        --globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
        --globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
        --globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
        --globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
        
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Panther Hard Mode (Legit) has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Diamond/Gold (L. Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 3, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        -- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        
        -- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
        
        -- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        
        -- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 45375, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_V"), 10406, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), 16875, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), 25312, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), 22500, true)
        --globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
        globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
        --globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
        --globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
        --globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
        
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Diamond Hard Mode (Legit) has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Bonds/Gold (L. Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 2, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        -- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        
        -- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
        
        -- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        
        -- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 45375, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_V"), 10406, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), 16875, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), 25312, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), 22500, true)
        --globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
        --globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
        globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
        --globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
        --globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
        
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Bonds Hard Mode (Legit) has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Necklace/Gold (L. Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 1, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        -- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        
        -- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
        
        -- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        
        -- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 45375, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_V"), 10406, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), 16875, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), 25312, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), 22500, true)
        --globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
        --globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
        --globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
        globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
        --globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
        
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Necklace Hard Mode (Legit) has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Tequila/Gold (L. Hard)", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEAPONS"), 5, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TARGET"), 0, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4CNF_APPROACH"), -1, true)
        -- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I"), 0, true)
        
        -- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
        
        -- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_SCOPED"), 0, true)
        
        -- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), 45375, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_CASH_V"), 10406, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), 16875, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), 25312, true)
        --STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), 22500, true)
        --globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
        --globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
        --globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
        --globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
        globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
        
        STATS.STAT_SET_INT(joaat(MPX .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(MPX .. "H4_PLAYTHROUGH_STATUS"), 32, true)
    
    gui.show_message("Cayo Heist", "Tequila Hard Mode (Legit) has been set up!")
    gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_separator()
cayoHeist:add_text("Press this after clicking one of the above presets")
cayoHeist:add_button("Reset Kosatka Board", function()
        locals.set_int(HIP, 1544, 2)
        gui.show_message("Cayo Heist", "Planning board has been reset!")
end)

cayoHeist:add_separator()
cayoHeist:add_text("During Heist")
cayoHeist:add_button("Skip Drainage Cut", function()
    locals.set_int(FMC2020, 29118, 6)
    gui.show_message("Cayo Heist", "Bypassed Drainage Cut")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Skip Fingerprint Scanner", function()
   locals.set_int(FMC2020, 24333, 5)
   gui.show_message("Cayo Heist", "Bypassed Fingerprint Scanner")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Skip Glass Cut", function()
    locals.get_float(FMC2020, 30357 + 3, 100.0)
    gui.show_message("Cayo Heist", "Bypassed Plasma Cutter")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Remove All CCTV's", function()
    for _, ent in pairs(entities.get_all_objects_as_handles()) do
        for __, cam in pairs(CamList) do
            if ENTITY.GET_ENTITY_MODEL(ent) == cam then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)
                ENTITY.DELETE_ENTITY(ent)
                gui.show_message("Cayo Heist", "Deleted all mission Cameras")
            end
        end
    end
end)
CamList = {
    joaat("prop_cctv_cam_01a"), joaat("prop_cctv_cam_01b"), joaat("prop_cctv_cam_02a"), joaat("prop_cctv_cam_03a"),
    joaat("prop_cctv_cam_04a"), joaat("prop_cctv_cam_04c"), joaat("prop_cctv_cam_05a"), joaat("prop_cctv_cam_06a"),
    joaat("prop_cctv_cam_07a"), joaat("prop_cs_cctv"), joaat("p_cctv_s"), joaat("hei_prop_bank_cctv_01"),
    joaat("hei_prop_bank_cctv_02"), joaat("ch_prop_ch_cctv_cam_02a"), joaat("xm_prop_x17_server_farm_cctv_01"),
}

cayoHeist:add_sameline()
cayoHeist:add_button("Delete Mission NPC's", function() -- Thanks to RazorGamerX for the help on this
    for index, ped in ipairs(entities.get_all_peds_as_handles()) do 
         model = ENTITY.GET_ENTITY_MODEL(ped)
        if model == 0x7ED5AD78 or model == 0x6C8C08E5 or model == 0x995B3F9F or model == 0xB881AEE then 
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, true)
                PED.DELETE_PED(ped)
                gui.show_message("Cayo Heist", "Deleted all mission NPC's.  This will cause the keycards to not drop, use Gold teleport to bypass when standing near a secondary loot room.")
        end
    end
end)
        
cayoHeist:add_separator()
cayoHeist:add_text("After Heist")
cayoHeist:add_button("Skip Cooldown", function()
    MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
    -- Solo Skip
    STATS.STAT_SET_INT(joaat(MPX .. "H4_TARGET_POSIX"), 1659643454, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H4_COOLDOWN"), 0, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H4_COOLDOWN_HARD"), 0, true)
    -- Multiplayer Skip
    STATS.STAT_SET_INT(joaat(MPX .. "H4_TARGET_POSIX"), 1659429119, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H4_COOLDOWN"), 0, true)
    STATS.STAT_SET_INT(joaat(MPX .. "H4_COOLDOWN_HARD"), 0, true)
    
    gui.show_message("Cayo Heist", "Skipped Cayo Perico Cooldown for all characters")
end)

 properties = {
    {name = "Drainage", id = 768}, {name = "Gold", id = 618}, {name = "Fingerprint Scanner", id = 619}, {name = "Main Gate", id = 770}, {name = "Kosatka", id = 760},
    -- Add more properties as needed
    -- Cayo Drainage = 768
}

-- Function to create buttons dynamically
 function createCayoButtons(cayoHeist)
     buttonsPerRow = 5
     buttonCount = 0
    for _, property in ipairs(properties) do
        cayoHeist:add_button(property.name, function()
             ped = PLAYER.PLAYER_PED_ID()
             blip_info = HUD.GET_FIRST_BLIP_INFO_ID(property.id)
             coords = HUD.GET_BLIP_COORDS(blip_info)
            
            if HUD.DOES_BLIP_EXIST(blip_info) then
                if property.id == 740 then
                    PED.SET_PED_COORDS_KEEP_VEHICLE(ped, coords.x + 5, coords.y - 5, coords.z)
                else 
                    PED.SET_PED_COORDS_KEEP_VEHICLE(ped, coords.x, coords.y, coords.z)
                end
            end
        end)
        buttonCount = buttonCount + 1
        if buttonCount < buttonsPerRow and _ < #properties then
            cayoHeist:add_sameline() -- Add next button on the same line if there are more buttons and haven't reached the limit per row
        else
            buttonCount = 0 -- Reset button count for the new row
        end
    end
end
cayoHeist:add_separator()
cayoHeist:add_text("Teleports")
createCayoButtons(cayoHeist)
cayoHeist:add_separator()
cayoHeist:add_text("How to Set Up or Bypass Cooldown:")
cayoHeist:add_text("Make sure you have completed the heist and you are standing in front of the planning screen")
cayoHeist:add_text("Click Skip Cooldown, then click on your Preset and click Reset Kosatka Board")

-- Cayo Bag Size & Value Editor
 cayoSizeEditor = cayoHeist:add_tab("Size/Value Editor")
cayoSizeEditor:add_text("Bag Size Editor")
bagSizeVal = 1800
cayoSizeEditor:add_imgui(function()
bagSizeVal, used = ImGui.SliderInt("Bag Size", bagSizeVal, 1800, 7200) -- 7200 = 4 players, this works if you want more money solo and it adjusts so you can always have full bags
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30009, bagSizeVal)
        gui.show_message('Bag Size Modified!', out)
    end
end)

cayoSizeEditor:add_separator()
cayoSizeEditor:add_text("Primary Target Editors")
pantherSizeVal = 1900000
cayoSizeEditor:add_imgui(function()
pantherSizeVal, used = ImGui.SliderInt("Panther Value", pantherSizeVal, 1900000, 3800000) -- Double the original price
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30264, pantherSizeVal)
        gui.show_message('Panther Value Modified!', out)
    end
end)

diamondSizeVal = 1300000
cayoSizeEditor:add_imgui(function()
diamondSizeVal, used = ImGui.SliderInt("Diamond Value", diamondSizeVal, 1300000, 2600000) -- Double the original price
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30262, diamondSizeVal)
        gui.show_message('Diamond Value Modified!', out)
    end
end)

bondSizeVal = 770000
cayoSizeEditor:add_imgui(function()
bondSizeVal, used = ImGui.SliderInt("Bonds Value", bondSizeVal, 770000, 1540000) -- Double the original price
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30261, bondSizeVal)
        gui.show_message('Bonds Value Modified!', out)
    end
end)

necklaceSizeVal = 700000
cayoSizeEditor:add_imgui(function()
necklaceSizeVal, used = ImGui.SliderInt("Necklace Value", necklaceSizeVal, 700000, 1400000) -- Double the original price
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30260, necklaceSizeVal)
        gui.show_message('Necklace Value Modified!', out)
    end
end)

tequilaSizeVal = 693000
cayoSizeEditor:add_imgui(function()
tequilaSizeVal, used = ImGui.SliderInt("Tequila Value", tequilaSizeVal, 693000, 1400000) -- Double the original price
    out = "Reset the board to see changes"
    
    if used then
        globals.set_int(262145 + 30259, tequilaSizeVal)
        gui.show_message('Tequila Value Modified!', out)
    end
end)

cayoSizeEditor:add_separator()
cayoSizeEditor:add_text("Secondary Target Editors")

goldSizeVal = 45375
cayoSizeEditor:add_imgui(function()
goldSizeVal, used = ImGui.SliderInt("Gold Value", goldSizeVal, 45375, 181500) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
        MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_GOLD_V"), goldSizeVal, true)
        gui.show_message('Gold Value Modified!', out)
    end
end)

cokeSizeVal = 25312
cayoSizeEditor:add_imgui(function()
cokeSizeVal, used = ImGui.SliderInt("Coke Value", cokeSizeVal, 25312, 101248) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
        MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_COKE_V"), cokeSizeVal, true)
        gui.show_message('Coke Value Modified!', out)
    end
end)

paintSizeVal = 22500
cayoSizeEditor:add_imgui(function()
paintSizeVal, used = ImGui.SliderInt("Paintings Value", paintSizeVal, 22500, 90000) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
        MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_PAINT_V"), paintSizeVal, true)
        gui.show_message('Paintings Value Modified!', out)
    end
end)

weedSizeVal = 16875
cayoSizeEditor:add_imgui(function()
weedSizeVal, used = ImGui.SliderInt("Weed Value", weedSizeVal, 16875, 67500) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
        MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), weedSizeVal, true)
        gui.show_message('Weed Value Modified!', out)
    end
end)

cashSizeVal = 10406
cayoSizeEditor:add_imgui(function()
cashSizeVal, used = ImGui.SliderInt("Cash Value", cashSizeVal, 10406, 41624) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
        MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end
        STATS.STAT_SET_INT(joaat(MPX .. "H4LOOT_WEED_V"), cashSizeVal, true)
        gui.show_message('Cash Value Modified!', out)
    end
end)
cayoSizeEditor:add_text("These values seem incorrect, but the game reads them properly.")
cayoSizeEditor:add_text("Minimum values are exact defaults for ALL targets.")
cayoSizeEditor:add_separator()
cayoSizeEditor:add_text("Press this after setting values.")
cayoSizeEditor:add_button("Reset Kosatka Board", function()
        locals.set_int(HIP, 1544, 2)
        gui.show_message("Cayo Heist", "Planning board has been reset!")
end)

-- Doomsday Heist Editor

 DP = heistEditor:add_tab("Doomsday Editor")
MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
    MPX = "MP0_"
else
    MPX = "MP1_"
end

a48 = 1

 contract_id = {0, 2, 3, 4} -- Assuming these are the IDs for "Select", "Data Breaches", "Bogdan Problem", "Doomsday Scenario"
 contract_names = {"Select", "Data Breaches", "Bogdan Problem", "Doomsday Scenario"}
 selectedContractIndex = 0
 selectedContractID = contract_id[selectedContractIndex + 1]

DP:add_text("Doomsday Act Selection")

 function DoomsdayActSetter(progress, status)
    STATS.STAT_SET_INT(joaat(MPX .. "GANGOPS_FLOW_MISSION_PROG"), progress, true)
    STATS.STAT_SET_INT(joaat(MPX .. "GANGOPS_HEIST_STATUS"), status, true)
   STATS.STAT_SET_INT(joaat(MPX .. "GANGOPS_FLOW_NOTIFICATIONS"), 1557, true)
end

DP:add_imgui(function()
    selectedContractIndex, used = ImGui.ListBox("##DoomsdayActList", selectedContractIndex, contract_names, #contract_names) -- Display the listbox
    if used then
        selectedContractID = contract_id[selectedContractIndex + 1]
    end

    if ImGui.Button("Select Act") then
        if selectedContractID == 2 then
            DoomsdayActSetter(503, 229383)
        elseif selectedContractID == 3 then
            DoomsdayActSetter(240, 229378)
        elseif selectedContractID == 4 then
            DoomsdayActSetter(16368, 229380)
        end
    end
end)

DP:add_sameline()
DP:add_button("Complete Preps", function() STATS.STAT_SET_INT(MPX() .. "GANGOPS_FM_MISSION_PROG", -1, true) end)
DP:add_sameline()
DP:add_button("Reset Preps", function() DoomsdayActSetter(240, 0) end)

DP:add_text("After all choices and pressing Complete Preps")
DP:add_text("leave your facility and go back inside")

 valEdit = DP:add_tab("Payout Editor")

 h2_d1_awd = valEdit:add_input_int("Data Breaches")
 h2_d2_awd = valEdit:add_input_int("Bogdan Problem")
 h2_d3_awd = valEdit:add_input_int("Doomsday Scenario")

valEdit:add_button("Retrieve Payouts", function()
    h2_d1_awd:set_value(tunables.get_int("GANGOPS_THE_IAA_JOB_CASH_REWARD"))
    h2_d2_awd:set_value(tunables.get_int("GANGOPS_THE_SUBMARINE_JOB_CASH_REWARD"))
    h2_d3_awd:set_value(tunables.get_int("GANGOPS_THE_MISSILE_SILO_JOB_CASH_REWARD"))
end)
valEdit:add_sameline()

h2_awd_lock = valEdit:add_checkbox("Apply Payouts")

 if  h2_awd_lock:is_enabled() then
        if h2_d1_awd:get_value() > 2500000 or h2_d1_awd:get_value() <= 0 or h2_d2_awd:get_value() > 2500000 or h2_d2_awd:get_value() <= 0 or h2_d3_awd:get_value() > 2500000 or h2_d3_awd:get_value() <= 0 then
            gui.show_message("Error", "Final chapter income may not exceed 2.500.000 and must be greater than 0")
            h2_awd_lock:set_enabled(false)
           return
       end
       tunablelocals.set_int("GANGOPS_THE_IAA_JOB_CASH_REWARD", h2_d1_awd:get_value())   
       tunablelocals.set_int("GANGOPS_THE_SUBMARINE_JOB_CASH_REWARD", h2_d2_awd:get_value())   
       tunablelocals.set_int("GANGOPS_THE_MISSILE_SILO_JOB_CASH_REWARD", h2_d3_awd:get_value())   
    end
    
-- Magnet/Forcefield
 xmen = Fun:add_tab("Magnet/Forcefield")
xmen:add_text("Magnetic field attracts all peds/vehicles")
 blackHoleLoopCheckbox = xmen:add_checkbox("Magnet")
 blackHoleRadius = 2.0
 blackHoleMarkerVisible = false
 magnitude = 1.0 -- Initialize the magnitude variable

xmen:add_imgui(function()
    blackHoleRadius, used = ImGui.SliderFloat("Magnet Radius", blackHoleRadius, 0.0, 100.0)
    out = "Radius set to " .. tostring(blackHoleRadius)
    if used then
        gui.show_message('Magnet Radius Modified!', out)
    end
    
    magnitude, used = ImGui.SliderFloat("Magnitude", magnitude, 0.0, 50.0) -- Add the magnitude slider
    out = "Magnitude set to " .. tostring(magnitude)
    if used then
        gui.show_message('Magnitude Modified!', out)
    end
    
    blackHoleMarkerVisible = blackHoleLoopCheckbox:is_enabled()
    
    -- Draw black hole marker
    if blackHoleMarkerVisible then
         playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
         playerCoords = ENTITY.GET_ENTITY_COORDS(playerPed, true)
        GRAPHICS.DRAW_MARKER_SPHERE(playerCoords.x, playerCoords.y, playerCoords.z, blackHoleRadius, 255, 0, 0, 0.3)
    end
end)

 function applyBlackHole(playerCoords, blackHoleRadius, magnitude) -- Include magnitude parameter
     vehicles = entities.get_all_vehicles_as_handles()
     peds = entities.get_all_peds_as_handles()
     blackHoleRadiusSquared = blackHoleRadius * blackHoleRadius
    for _, entity in ipairs(vehicles) do
        if PED.IS_PED_A_PLAYER(entity) == false then
            if entities.take_control_of(entity) then
                 entityCoord = ENTITY.GET_ENTITY_COORDS(entity, false)
                 distanceSquared = V3_DISTANCE_SQUARED(playerCoords, entityCoord)
                if distanceSquared <= blackHoleRadiusSquared then
                     forceX = (playerCoords.x - entityCoord.x) * magnitude -- Apply magnitude
                     forceY = (playerCoords.y - entityCoord.y) * magnitude
                     forceZ = (playerCoords.z - entityCoord.z) * magnitude
                    RequestControl(entity)
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 2, forceX, forceY, forceZ, 0.0, 0.0, 0.0, 0, false, true, true, false, false)
                end
            end
        end
    end
    
    for _, entity in ipairs(peds) do
        if PED.IS_PED_A_PLAYER(entity) == false then
            if entities.take_control_of(entity) then
                 entityCoord = ENTITY.GET_ENTITY_COORDS(entity, false)
                 distanceSquared = V3_DISTANCE_SQUARED(playerCoords, entityCoord)
                if distanceSquared <= blackHoleRadiusSquared then
                     forceX = (playerCoords.x - entityCoord.x) * magnitude -- Apply magnitude
                     forceY = (playerCoords.y - entityCoord.y) * magnitude
                     forceZ = (playerCoords.z - entityCoord.z) * magnitude
                    RequestControl(entity)
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 2, forceX, forceY, forceZ, 0.0, 0.0, 0.0, 0, false, true, true, false, false)
                end
            end
        end
    end
end

script.register_looped("blackHoleLoopScript", function(script)
    script:yield()
    if blackHoleLoopCheckbox:is_enabled() == true then
         player = PLAYER.PLAYER_ID()
         playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
         playerCoords = ENTITY.GET_ENTITY_COORDS(playerPed, true)
        applyBlackHole(playerCoords, blackHoleRadius, magnitude) -- Pass magnitude
    end
end)

function V3_DISTANCE_SQUARED(v1, v2)
     dx = v1.x - v2.x
     dy = v1.y - v2.y
     dz = v1.z - v2.z
    return dx * dx + dy * dy + dz * dz
end

xmen:add_text("Forcefield surrounds your player in a barrier")
xmen:add_text("Works with magnet to create a vehicle/ped barrier")
 forceFieldLoopCheckbox = xmen:add_checkbox("Forcefield")
 forceFieldRadius = 5.0
 forceFieldMagnitude = 10.0
 forceFieldMarkerVisible = false

xmen:add_imgui(function()
    forceFieldRadius, used = ImGui.SliderFloat("Force Field Radius", forceFieldRadius, 0.0, 100.0)
    out = "Radius set to " .. tostring(forceFieldRadius)
    if used then
        gui.show_message('Force Field Radius Modified!', out)
    end
    
    forceFieldMagnitude, used = ImGui.SliderFloat("Force Field Magnitude", forceFieldMagnitude, 0.0, 100.0)
    out = "Magnitude set to " .. tostring(forceFieldMagnitude)
    if used then
        gui.show_message('Force Field Magnitude Modified!', out)
    end
    
    forceFieldMarkerVisible = forceFieldLoopCheckbox:is_enabled()
    
    -- Draw force field marker
    if forceFieldMarkerVisible then
         playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
         playerCoords = ENTITY.GET_ENTITY_COORDS(playerPed, true)
        GRAPHICS.DRAW_MARKER_SPHERE(playerCoords.x, playerCoords.y, playerCoords.z, forceFieldRadius, 0, 255, 0, 0.3)
    end
end)

 function applyForceField(playerCoords, forceFieldRadius, forceMagnitude)
     vehicles = entities.get_all_vehicles_as_handles()
     peds = entities.get_all_peds_as_handles()
     forceFieldRadiusSquared = forceFieldRadius * forceFieldRadius

    -- Apply forces to vehicles
    for _, entity in ipairs(vehicles) do
        if PED.IS_PED_A_PLAYER(entity) == false then
            if entities.take_control_of(entity) then
                 entityCoord = ENTITY.GET_ENTITY_COORDS(entity, false)
                 distanceSquared = V3_DISTANCE_SQUARED(playerCoords, entityCoord)
                if distanceSquared <= forceFieldRadiusSquared then
                     forceX = (entityCoord.x - playerCoords.x) * forceMagnitude -- Invert the direction of force
                     forceY = (entityCoord.y - playerCoords.y) * forceMagnitude -- Invert the direction of force
                     forceZ = (entityCoord.z - playerCoords.z) * forceMagnitude -- Invert the direction of force
                    RequestControl(entity)
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 2, forceX, forceY, forceZ, 0.0, 0.0, 0.0, 0, false, true, true, false, false)
                end
            end
        end
    end

    -- Comment below to unapply to peds
    for _, entity in ipairs(peds) do
        if PED.IS_PED_A_PLAYER(entity) == false then
            if entities.take_control_of(entity) then
                 entityCoord = ENTITY.GET_ENTITY_COORDS(entity, false)
                 distanceSquared = V3_DISTANCE_SQUARED(playerCoords, entityCoord)
                if distanceSquared <= forceFieldRadiusSquared then
                     forceX = (entityCoord.x - playerCoords.x) * forceMagnitude -- Invert the direction of force
                     forceY = (entityCoord.y - playerCoords.y) * forceMagnitude -- Invert the direction of force
                     forceZ = (entityCoord.z - playerCoords.z) * forceMagnitude -- Invert the direction of force
                    RequestControl(entity)
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity, 2, forceX, forceY, forceZ, 0.0, 0.0, 0.0, 0, false, true, true, false, false)
                end
            end
        end
    end
end

script.register_looped("forceFieldLoopScript", function(script)
    script:yield()
    if forceFieldLoopCheckbox:is_enabled() == true then
         playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
         playerCoords = ENTITY.GET_ENTITY_COORDS(playerPed, true)
        applyForceField(playerCoords, forceFieldRadius, forceFieldMagnitude)
    end
end)

function V3_DISTANCE_SQUARED(v1, v2)
     dx = v1.x - v2.x
     dy = v1.y - v2.y
     dz = v1.z - v2.z
    return dx * dx + dy * dy + dz * dz
end

-- USBMenus (Contributor) Additions

raceTab = KAOS:add_tab("Race Editor")
raceTab:add_imgui(function()
    if (ImGui.TreeNode("Drift Races")) then
        ImGui.SetNextItemWidth(250)
        maxMultiplier, maxMp = ImGui.InputFloat("Max Multiplier", globals.get_float(262145 + 25983), 0.1, 1, "%.1f")
        toolTip("", "Max value that the drift multiplier will reach")
        ImGui.SetNextItemWidth(250)
        timeDrifting, timeDr = ImGui.InputInt("Time Drifting For Multiplier Increase (ms)", globals.get_int(262145 + 25982), 100, 1000)
        toolTip("", "Time in miliseconds while drifting that it takes for the multiplier to increase")
        ImGui.SetNextItemWidth(250)
        driftMultiplier, driftMp = ImGui.InputFloat("Multiplier Increase Rate", globals.get_float(262145 + 25981), 0.1, 1, "%.1f")
        toolTip("", "What the multiplier will increase by")
        ImGui.SetNextItemWidth(250)
        precisionDrift, precisionDr = ImGui.InputInt("Precision Drift Amount", globals.get_int(262145 + 25984), 100, 1000)
        toolTip("", "Amount of points rewarded for doing a precision drift")
        ImGui.SetNextItemWidth(250)
        respawnPenalty, respawnPn = ImGui.InputInt("Respawn Penalty", globals.get_int(262145 + 25995), 100, 1000)
        toolTip("", "Amount of points taken when you respawn")

        if maxMp then
            globals.set_float(262145 + 25983, maxMultiplier)
        end
        if timeDr then
            globals.set_int(262145 + 25982, timeDrifting)
        end
        if driftMp then
            globals.set_float(262145 + 25981, driftMultiplier)
        end
        if precisionDr then
            globals.set_int(262145 + 25984, precisionDrift)
        end
        if respawnPn then
            globals.set_int(262145 + 25995, respawnPenalty)
        end
    end
end)

--Chat Options
 chatOpt = KAOS:add_tab("Chat Options")

chatOpt:add_text("Send Unfiltered Messages")
 chatBox = ""
chatOpt:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    chatBox, used = ImGui.InputText("Message", chatBox, 256)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)
chatOpt:add_sameline()
 isTeam = chatOpt:add_checkbox("Team Only")
chatOpt:add_button("Send Message", function()
	if isCooldown then
        gui.show_message('Chat', "There is a delay before sending another chat message.")
        return
    end

    isCooldown = true
	
	script.run_in_fiber(function(chatMsg)
        if isTeam:is_enabled() == false then
            if chatBox ~= "" then
                network.send_chat_message("[Extras Addon]: "..chatBox, false)
            end
        else
            if chatBox ~= "" then
                network.send_chat_message("[Extras Addon]: "..chatBox, true)
            end
        end
        sleep(5)
        isCooldown = false  -- Reset the cooldown after the delay
    end)
end)

chatOpt:add_separator()
-- Discord Name Sender, easily send your discord name
chatOpt:add_text("Discord Advertiser")
 discordBox = ""
chatOpt:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    discordBox, used = ImGui.InputText("Discord Username", discordBox, 64)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)

chatOpt:add_button("Send", function()
    if discordBox ~= "" then
		if isCooldown then
            gui.show_message('Chat', "There is a delay before sending another discord message.")
            return
        end

        isCooldown = true

        script.run_in_fiber(function(discordMsg)
            network.send_chat_message("[Add My Discord]: "..discordBox, false)
            sleep(5)
            isCooldown = false  -- Reset the cooldown after the delay
        end)
    end
end)

chatOpt:add_separator()
chatOpt:add_button("Addon Info", function()
	if isCooldown then
        gui.show_message('Chat', "There is a delay before sending another addon info message.")
        return
    end

    isCooldown = true

    script.run_in_fiber(function(addonMsg)
         ainfo = "Extras Addon for YimMenu v"..addonVersion..", find it on Github for FREE @ https://github.com/Deadlineem/Extras-Addon-for-YimMenu!"
        network.send_chat_message("[Lua Script]: "..ainfo, false)
        sleep(5)
        isCooldown = false  -- Reset the cooldown after the delay
    end)
end)
chatOpt:add_sameline()
chatOpt:add_button("Menu Info", function()
	if isCooldown then
        gui.show_message('Chat', "There is a delay before sending another menu info message.")
        return
    end

    isCooldown = true

    script.run_in_fiber(function(spawnClone)
         binfo = "YimMenu version 1.68, find it on Github for FREE @ https://github.com/YimMenu/YimMenu!"
        network.send_chat_message("[Menu]: "..binfo, false)
        sleep(5)
        isCooldown = false  -- Reset the cooldown after the delay
    end)
end)

griefPlayerTab:add_text("Extras Addon v"..addonVersion.." - Player Options")
griefPlayerTab:add_separator()

griefPlayerTab:add_text("Toggle separate windows?")
extraGrief = griefPlayerTab:add_checkbox("Grief")
extraGrief:set_enabled(true)
griefPlayerTab:add_imgui(function()
    if extraGrief:is_enabled() then
     parentWindow = gui.get_tab("") -- Assuming this retrieves the parent window
         parentX, parentY = ImGui.GetWindowPos() -- Get the position of the parent window
         parentWidth, parentHeight = ImGui.GetWindowSize(parentWindow) -- Get the size of the parent window
         childWidth, childHeight = 200, 200 -- Size of your child window
         offset = 10 -- Offset between parent and child windows

         x = parentX + parentWidth + offset -- Position the child window to the right of the parent window
         y = parentY -- Align the child window vertically with the parent window

        ImGui.SetNextWindowPos(x, y)
            if ImGui.Begin("Extras Addon (Grief Options) - ".. PLAYER.GET_PLAYER_NAME(network.get_selected_player())) then
            -- Sets a new window for the options below, theres a wrapper for ImGui.End() at the bottom of the options.
            
        end
    end
end)

 balls = {
"p_ld_soc_ball_01",
"p_ld_am_ball_01",
"prop_bowling_ball",
"prop_beach_volball01",
"prop_beach_volball02",
"prop_beachball_02",
"v_ilev_exball_blue"
}

griefPlayerTab:add_text("Trolling")
npcDrive = griefPlayerTab:add_checkbox("NPCs Drive To This Player")
toolTip(griefPlayerTab, "Make all NPC's drive to this player")

griefPlayerTab:add_sameline()
dildos = griefPlayerTab:add_checkbox("Dildos")
toolTip(griefPlayerTab, "Spawns Vibrators on the player")

griefPlayerTab:add_sameline()
dropBalls = griefPlayerTab:add_checkbox("Balls")
toolTip(griefPlayerTab, "Spawns Volley Balls on the player")

vehicleSpin = griefPlayerTab:add_checkbox("Spin Vehicle")
toolTip(griefPlayerTab, "Spins the players vehicle uncontrollably.")

griefPlayerTab:add_sameline()
 trollLoop = false
trollLoop = griefPlayerTab:add_checkbox("Teleport Troll")

script.register_looped("trollLoop", function(script)
    script:yield()
    if trollLoop:is_enabled() == true then
         Player = PLAYER.PLAYER_ID()
         player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        gui.show_message("Teleport Troll", "Teleporting randomly around "..PLAYER.GET_PLAYER_NAME(network.get_selected_player()))
        PLAYER.START_PLAYER_TELEPORT(Player, coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z, 0, true, true, true)
        sleep(0.1)
    end
end)
toolTip(griefPlayerTab, "Teleports you randomly around the selected player, will destroy vehicles if you are in one when you activate this")

griefPlayerTab:add_button("Spawn Clone", function()
    script.run_in_fiber(function(spawnClone)
         player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
         coords = ENTITY.GET_ENTITY_COORDS(player, true)
        
        -- Create a pedestrian clone
         ped = PED.CREATE_PED(26, ENTITY.GET_ENTITY_MODEL(player), coords.x, coords.y + 1, coords.z, ENTITY.GET_ENTITY_HEADING(player), true, false, false)
        if ped ~= 0 then
            -- Clone the pedestrian's behavior to target the player
            PED.CLONE_PED_TO_TARGET(player, ped)
            
            -- Make the pedestrian aggressive
            TASK.TASK_COMBAT_PED(ped, player, 0, 16)
            
            -- Equip the pedestrian with a knife
            WEAPON.GIVE_WEAPON_TO_PED(ped, 1672152130, 1, false, true) -- -1716189206 is the hash for the knife weapon
            
            -- Set combat attributes
            PED.SET_PED_COMBAT_ABILITY(ped, 100)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) 
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true) -- Can do Driveby's     
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) -- Always Fight
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) -- Aggressive
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) -- always flee /false
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) -- Can chase on foot
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) -- Perfect Accuracy
            ENTITY.SET_ENTITY_MAX_HEALTH(ped, 1000);
            ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0);
            PED.SET_PED_CAN_RAGDOLL(ped, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) -- Disable Flee from combat
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 38, true) -- Disable Bullet Reactions
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 31, true) -- Maintain Min target distance
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) -- Can use vehicles
        else
            gui.show_error("Failed", "Failed to create ped")
        end
    end)
end)
toolTip(griefPlayerTab, "Spawns a clone of the player with a homing launcher to kill them.")

griefPlayerTab:add_sameline()
griefPlayerTab:add_button("Clown Attack", function()
    script.run_in_fiber(function (clownAttack)
         player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
         coords = ENTITY.GET_ENTITY_COORDS(player, true)
         heading = ENTITY.GET_ENTITY_HEADING(player)
         spawnDistance = 50.0 * math.sin(math.rad(heading))
         isRoad, roadCoords = PATHFIND.GET_NTH_CLOSEST_VEHICLE_NODE_WITH_HEADING(coords.x + spawnDistance, coords.y + spawnDistance, coords.z, 1, coords, heading, 0, 9, 3.0, 2.5)
         clown = joaat("s_m_y_clown_01")
         van = joaat("speedo2")
         weapon = -1121678507
        STREAMING.REQUEST_MODEL(clown)
        STREAMING.REQUEST_MODEL(van)
        STREAMING.REQUEST_MODEL(weapon)
        while not STREAMING.HAS_MODEL_LOADED(clown) or not STREAMING.HAS_MODEL_LOADED(van) do    
            STREAMING.REQUEST_MODEL(clown)
            STREAMING.REQUEST_MODEL(van)
            clownAttack:yield()
        end
        vehicle = VEHICLE.CREATE_VEHICLE(van, roadCoords.x, roadCoords.y, roadCoords.z, ENTITY.GET_ENTITY_HEADING(player), true, false, false)
        if vehicle ~= 0 then
            for seat = -1, 2 do
                --vehiclePed = PED.CREATE_PED_INSIDE_VEHICLE(vehicle, 0, clown, seat, true, false)
                 ped = PED.CREATE_PED(0, clown, roadCoords.x, roadCoords.y + 2, roadCoords.z, ENTITY.GET_ENTITY_HEADING(player), true, true)
                if ped ~= 0 then
                     group = joaat("HATES_PLAYER")
                    PED.ADD_RELATIONSHIP_GROUP("clowns", group)
                    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, group)
                    ENTITY.SET_ENTITY_CAN_BE_DAMAGED_BY_RELATIONSHIP_GROUP(ped, false, group)
                    PED.SET_PED_CAN_BE_TARGETTED_BY_TEAM(ped, group, false)
                    PED.SET_CAN_ATTACK_FRIENDLY(ped, false, false)
                    PED.SET_PED_CAN_BE_TARGETTED(ped, false)
                    WEAPON.GIVE_WEAPON_TO_PED(ped, weapon, 999999, false, true)
                    PED.SET_PED_INTO_VEHICLE(ped, vehicle, seat)
                    PED.SET_PED_COMBAT_ABILITY(ped, 100)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) 
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true) -- Can do Driveby's     
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) -- Always Fight
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) -- Aggressive
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) -- always flee /false
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) -- Can chase on foot
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) -- Perfect Accuracy
                    ENTITY.SET_ENTITY_MAX_HEALTH(ped, 1000);
                    ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0);
                    PED.SET_PED_CAN_RAGDOLL(ped, false)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) -- Disable Flee from combat
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 38, true) -- Disable Bullet Reactions
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 31, true) -- Maintain Min target distance
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) -- Can use vehicles
                    TASK.TASK_COMBAT_PED(ped, player, 0, 16)
                    TASK.TASK_DRIVE_BY(ped, player, vehicle, coords.x, coords.y, coords.z, 50, 100, false, joaat("FIRING_PATTERN_FULL_AUTO"))
                    
                    ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
                else
                    gui.show_error("Failed", "Failed to create ped")
                end
            end
        else
            gui.show_error("Failed", "Failed to create vehicle")
        end
        
        if ped == 0 then 
            gui.show_error("Failed", "Failed To Create Clowns")
        else
            gui.show_message("Success", "Successfully spawned the attack clowns")
        end
    end)
end)
toolTip(griefPlayerTab, "Spawns a Clown van full of clowns to chase/gun the player down.")

griefPlayerTab:add_sameline()
griefPlayerTab:add_button("Clown Jet Attack", function()
    script.run_in_fiber(function (clownJetsTwo)
         player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
         playerName = PLAYER.GET_PLAYER_NAME(network.get_selected_player())
         coords = ENTITY.GET_ENTITY_COORDS(player, true)
         heading = ENTITY.GET_ENTITY_HEADING(player)
         spawnDistance = 250.0 * math.sin(math.rad(heading))
         spawnHeight = 10.0 -- Adjust this value to set the height at which the jet spawns
         isRoad, roadCoords = PATHFIND.GET_NTH_CLOSEST_VEHICLE_NODE_WITH_HEADING(coords.x + spawnDistance, coords.y + spawnDistance, coords.z, 1, coords, heading, 0, 9, 3.0, 2.5)
         clown = joaat("s_m_y_clown_01")
         jet = joaat("Lazer")
         weapon = -1121678507

        STREAMING.REQUEST_MODEL(clown)
        STREAMING.REQUEST_MODEL(jet)
        STREAMING.REQUEST_MODEL(weapon)

        while not STREAMING.HAS_MODEL_LOADED(clown) or not STREAMING.HAS_MODEL_LOADED(jet) do    
            STREAMING.REQUEST_MODEL(clown)
            STREAMING.REQUEST_MODEL(jet)
            clownJetsTwo:yield()
        end

        -- Calculate the spawn position for the jet in the air
         jetSpawnX = coords.x + math.random(-1000, 1000)
         jetSpawnY = coords.y + math.random(-1000, 1000)
         jetSpawnZ = coords.z + math.random(100, 1200)
        
         colors = {27, 28, 29, 150, 30, 31, 32, 33, 34, 143, 35, 135, 137, 136, 36, 38, 138, 99, 90, 88, 89, 91, 49, 50, 51, 52, 53, 54, 92, 141, 61, 62, 63, 64, 65, 66, 67, 68, 69, 73, 70, 74, 96, 101, 95, 94, 97, 103, 104, 98, 100, 102, 99, 105, 106, 71, 72, 142, 145, 107, 111, 112,}
         jetVehicle = VEHICLE.CREATE_VEHICLE(jet, jetSpawnX, jetSpawnY, jetSpawnZ, heading, true, false, false)
        
        if jetVehicle ~= 0 then
             primaryColor = colors[math.random(#colors)]
             secondaryColor = colors[math.random(#colors)]

            -- Set vehicle colors
            VEHICLE.SET_VEHICLE_COLOURS(jetVehicle, primaryColor, secondaryColor)
            -- Spawn clowns inside the jet
            for seat = -1, -1 do
                 ped = PED.CREATE_PED(0, clown, jetSpawnX, jetSpawnY, jetSpawnZ, heading, true, true)
                
                if ped ~= 0 then
                     group = joaat("HATES_PLAYER")
                    PED.ADD_RELATIONSHIP_GROUP("clowns", group)
                    ENTITY.SET_ENTITY_CAN_BE_DAMAGED_BY_RELATIONSHIP_GROUP(ped, false, group)
                    PED.SET_PED_CAN_BE_TARGETTED(ped, false)
                    WEAPON.GIVE_WEAPON_TO_PED(ped, weapon, 999999, false, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 31, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
                    PED.SET_PED_INTO_VEHICLE(ped, jetVehicle, seat)
                    TASK.TASK_COMBAT_PED(ped, player, 0, 16)
                    ENTITY.SET_ENTITY_MAX_HEALTH(ped, 1000)
                    ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
                    ENTITY.SET_ENTITY_MAX_HEALTH(jetVehicle, 1000)
                    ENTITY.SET_ENTITY_HEALTH(jetVehicle, 1000, 0)
                    PED.SET_AI_WEAPON_DAMAGE_MODIFIER(10000)
                    WEAPON.SET_WEAPON_DAMAGE_MODIFIER(1060309761, 10000)
                else
                    gui.show_error("Failed", "Failed to create ped")
                end
            end
        else
            gui.show_error("Failed", "Failed to create jet")
        end
        
        if jetVehicle == 0 then 
            gui.show_error("Failed", "Failed to Create Jet")
        else
            gui.show_message("griefPlayerTabing", "Clown Lazers spawned!  Lock-on Acquired! Target: "..playerName)
        end

        -- Release the resources associated with the spawned entities
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(jetVehicle)
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)

    end)
end)
toolTip(griefPlayerTab, "Spawns Randomly colored jets with Clowns as pilots to attack the selected player.")

function request_model(model)
    script.run_in_fiber(function(script)
        while not STREAMING.HAS_MODEL_LOADED(model) do
            STREAMING.REQUEST_MODEL(model)
            script:yield()
        end
    end)
end

---@param entity Entity
---@param minDistance number
---@param maxDistance number
---@return v3
function get_random_offset_from_entity(entity, minDistance, maxDistance)
     pos = ENTITY.GET_ENTITY_COORDS(entity, false)
    return get_random_offset_in_range(pos, minDistance, maxDistance)
end


---@param coords v3
---@param minDistance number
---@param maxDistance number
---@return v3
function get_random_offset_in_range(coords, minDistance, maxDistance)
     radius = random_float(minDistance, maxDistance)
     angle = random_float(0, 2 * math.pi)
     delta = vec3.new(math.cos(angle), math.sin(angle), 0.0)
     offsetX = delta.x * radius
     offsetY = delta.y * radius
     offsetZ = delta.z * radius
     newX = coords.x + offsetX
     newY = coords.y + offsetY
     newZ = coords.z + offsetZ
    return vec3.new(newX, newY, newZ)
end

---@param min number
---@param max number
---@return number
function random_float(min, max)
    return min + math.random() * (max - min)
end

function request_fx_asset(asset)
    script.run_in_fiber(function(script)
        STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do script:yield() end
    end)
end

---@param entity Entity
---@return boolean
function request_control_once(entity)
    if not NETWORK.NETWORK_IS_IN_SESSION() then
        return true
    end
     netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
    return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end

function atan2(y, x)
    return math.atan(y / x)
end

function set_entity_face_entity(entity, target, usePitch)
     pos1 = ENTITY.GET_ENTITY_COORDS(entity, false)
     pos2 = ENTITY.GET_ENTITY_COORDS(target, false)
     relX = pos2.x - pos1.x
     relY = pos2.y - pos1.y
     relZ = pos2.z - pos1.z

     heading = atan2(relY, relX) * 180.0 / math.pi
    if heading < 0 then
        heading = heading + 360.0
    end

    ENTITY.SET_ENTITY_HEADING(entity, heading)

    if usePitch then
         distXY = math.sqrt(relX * relX + relY * relY)
         pitch = math.atan2(-relZ, distXY) * 180.0 / math.pi
        ENTITY.SET_ENTITY_ROTATION(entity, pitch, 0, heading, 2, false)
    end
end


griefPlayerTab:add_button("Clown Bombers", function()
    script.run_in_fiber(function(script)
         hash = joaat("s_m_y_clown_01")
         asset = "scr_rcbarry2"
         explosion = "scr_exp_clown"
         appears = "scr_clown_appears"
        request_model(hash)
         player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
         playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
         coord = get_random_offset_from_entity(player, 5.0, 8.0)
        coord.z = coord.z - 1.0
         ped = PED.CREATE_PED(0, hash, coord.x, coord.y, coord.z, 0.0, true, false)
        if ped == 0 then gui.show_error("Clown Bomber", "Failed to Create Ped\nMost Likely The Model Isnt Loaded\nTry Again.") else gui.show_message("Clown Bomber", "Spawned as ".. tostring(ped)) end

        request_fx_asset(asset)
        GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
            appears,
            ped,
            0.0, 0.0, -1.0,
            0.0, 0.0, 0.0,
            0.5, false, false, false
        )
        set_entity_face_entity(ped, player, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
        TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, playerpos.x, playerpos.y, playerpos.z, 5.0, 0, false, 0, 0.0)
         dest = playerpos
        PED.SET_PED_KEEP_TASK(ped, true)
        AUDIO.STOP_PED_SPEAKING(ped, true)
        while not PED.IS_PED_FATALLY_INJURED(ped) and ENTITY.DOES_ENTITY_EXIST(ped) do
             pos = ENTITY.GET_ENTITY_COORDS(ped, true)
             targetPos = ENTITY.GET_ENTITY_COORDS(player, true)
            if not ENTITY.DOES_ENTITY_EXIST(ped) or PED.IS_PED_FATALLY_INJURED(ped) then
                return false
            elseif calcDistanceFromTwoCoords(pos, targetPos) > 150 and request_control(ped) then
                ENTITY.DELETE_ENTITY(ped)
                return false
            elseif calcDistanceFromTwoCoords(pos, targetPos) < 3.0 and request_control(ped) then
                request_fx_asset(asset)
                GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                    explosion,
                    pos.x, pos.y, pos.z,
                    0.0, 0.0, 0.0,
                    1.0,
                    false, false, false, false
                )
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, true, true, 1.0, false)
                ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
                ENTITY.DELETE_ENTITY(ped)
                return false
            elseif calcDistanceFromTwoCoords(targetPos, dest) > 3.0 and request_control_once(ped) then
                dest = targetPos
                TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, targetPos.x, targetPos.y, targetPos.z, 5.0, 0, false, 0, 0.0)
            end
            script:yield()
        end
        ENTITY.DELETE_ENTITY(ped)
    end)
end)
toolTip(griefPlayerTab, "Spawns a kamikaze clown to kill the player")

griefPlayerTab:add_separator()
griefPlayerTab:add_text("Griefing")
hydrantCB = griefPlayerTab:add_checkbox("Hydrant")
toolTip(griefPlayerTab, "Spawns fire hydrant spray to ragdoll the player")

griefPlayerTab:add_sameline()
steamCB = griefPlayerTab:add_checkbox("Steam")
toolTip(griefPlayerTab, "Spawns steam to burn the player")

griefPlayerTab:add_sameline()
extinguisherCB = griefPlayerTab:add_checkbox("Extinguisher")
toolTip(griefPlayerTab, "Spawns fire extinguisher spray on the player")

explodeCB = griefPlayerTab:add_checkbox("Explode")
griefPlayerTab:add_sameline()
toolTip(griefPlayerTab, "Violently explodes the player and shakes their screen.")

noDamageExplode = griefPlayerTab:add_checkbox("Screen Shake")
toolTip(griefPlayerTab, "Causes a no damage explosion to shake the players screen.")

script.register_looped("extrasAddonLooped", function(script)
    if npcDrive:is_enabled() then
         vehtable = entities.get_all_vehicles_as_handles()
        for _, vehs in pairs(vehtable) do
             selfpos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), true)
             ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehs, -1, false)
             player = false
            for playerId = 0, 31 do
                if PLAYER.GET_PLAYER_PED(playerId) == ped then 
                    player = true
                end
            end
            if ped ~= 0 and player == false then
                request_control(vehs)
                request_control(ped)
                TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped, vehs, selfpos.x, selfpos.y, selfpos.z, 70.0, 1, vehs, 16777216, 0.0, 1)
                --gui.show_message("Success", "Peds Driving To Player")
            else
                --gui.show_message("Failed", "Ped Seat is: ".. ped)
            end
        end
    end
    if dildos:is_enabled() then
         selectedItem = "prop_cs_dildo_01"
         coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        while not STREAMING.HAS_MODEL_LOADED(joaat(selectedItem)) do
            STREAMING.REQUEST_MODEL(joaat(selectedItem))
            script:yield()
        end   
        OBJECT.CREATE_AMBIENT_PICKUP(738282662, coords.x, coords.y, coords.z + 1.5, 0, 1, joaat(selectedItem), false, true)
    end

    if dropBalls:is_enabled() then
         randomIndex = math.random(1, #balls)
         selectedItem = balls[randomIndex]
         coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        while not STREAMING.HAS_MODEL_LOADED(joaat(selectedItem)) do
            STREAMING.REQUEST_MODEL(joaat(selectedItem))
            script:yield()
        end
        OBJECT.CREATE_AMBIENT_PICKUP(738282662, coords.x, coords.y, coords.z + 2, 0, 1, joaat(selectedItem), false, true)
    end
    if vehicleSpin:is_enabled() then
        if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(network.get_selected_player()),true) then
            gui.show_error("Spin Vehicle","Player is not in a vehicle")
        else
            veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(network.get_selected_player()), true)
             time = os.time()
             request = false
            while not request do
                if os.time() - time >= 5 then
                    gui.show_error("Spin Vehicle","Couldnt Control Vehicle")
                    break
                end
                request = request_control(veh)
                script:yield()
            end
            gui.show_message("Spin Vehicle","Spinning Vehicle")
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 5, 0, 0, 150.0, 0, 0, 0, 0, true, false, true, false, true)
        end
    end
    if extinguisherCB:is_enabled() then
        player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        FIRE.ADD_OWNED_EXPLOSION(player, coords.x, coords.y, coords.z - 2.0, 24, 1, true, false, 0)
    end

    if steamCB:is_enabled() then
        player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        FIRE.ADD_OWNED_EXPLOSION(player, coords.x, coords.y, coords.z - 2.0, 11, 1, true, false, 0)
    end

    if hydrantCB:is_enabled() then
        player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        FIRE.ADD_OWNED_EXPLOSION(player, coords.x, coords.y, coords.z - 2.0, 13, 1, true, false, 0)
    end
    
    if explodeCB:is_enabled() then
        player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        FIRE.ADD_OWNED_EXPLOSION(player, coords.x, coords.y, coords.z - 2.0, 1, 100, true, false, 2147483647)
    end

    if noDamageExplode:is_enabled() then
        player = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        coords = ENTITY.GET_ENTITY_COORDS(player, true)
        FIRE.ADD_OWNED_EXPLOSION(player, coords.x, coords.y, coords.z - 2.0, 1, 0, true, false, 2147483647)
    end
end)

-- Grief Burn Player
griefPlayerTab:add_sameline()
 burnLoop = false
burnLoop = griefPlayerTab:add_checkbox("Burn")

script.register_looped("burnLoop", function()
    if burnLoop:is_enabled() == true then
         player_id = network.get_selected_player()
         coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
         fxType = 3
         ptfxAsset = "scr_bike_adversary"
         particle = "scr_adversary_foot_flames"
        
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, fxType, 100000.0, false, false, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxAsset)
        GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD(particle, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)
        
        gui.show_message("griefPlayerTab", "Burning "..PLAYER.GET_PLAYER_NAME(player_id).." repeatedly")

        -- Optionally, you can play a fire sound here using AUDIO.PLAY_SOUND_FROM_COORD

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before burning another player
    end
end)
toolTip(griefPlayerTab, "Repeatedly burns the selected player using molotovs")
-- Griefing Options

 ramLoopz = griefPlayerTab:add_checkbox("Vehicle Sandwich (On/Off)")

script.register_looped("ramLoopz", function()
    if ramLoopz:is_enabled() then
         player_id = network.get_selected_player()
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(player_id) then
                         coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

                        -- Get a random vehicle model from the list (make sure 'vehicleModels' is defined)
                         randomModel = vehicleModels[math.random(1, #vehicleModels)]

                        -- Convert the string vehicle model to its hash value
                         modelHash = MISC.GET_HASH_KEY(randomModel)

                        -- Create the vehicle without the last boolean argument (keepTrying)
                         vehicle = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z + 20, 0.0, true, true, false)
                        -- Set vehicle orientation
                        ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 0, 0, 2, true)
                         networkId = NETWORK.VEH_TO_NET(vehicle)
                        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle) then
                            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
                        end

                        if vehicle then
                            -- Set the falling velocity (adjust the value as needed)
                            ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -100000000)
                            -- Optionally, you can play a sound or customize the ramming effect here
                            VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(vehicle, true)
                        end
                        
                         vehicle2 = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z - 20, 0.0, true, true, false)
                        -- Set vehicle orientation
                        ENTITY.SET_ENTITY_ROTATION(vehicle2, 0, 0, 0, 2, true)
                         networkId = NETWORK.VEH_TO_NET(vehicle2)
                        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle2) then
                            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
                        end

                        if vehicle2 then
                            -- Set the falling velocity (adjust the value as needed)
                            ENTITY.SET_ENTITY_VELOCITY(vehicle2, 0, 0, 100000000)
                            -- Optionally, you can play a sound or customize the ramming effect here
                            VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(vehicle2, true)
                        end

                        gui.show_message("griefPlayerTab", "Ramming " .. PLAYER.GET_PLAYER_NAME(player_id) .. " with vehicles")

                        -- Use these lines to delete the vehicle after spawning. 
                        -- Needs some type of delay between spawning and deleting to function properly
                        
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(vehicle)
                        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(vehicle2)
        end

        -- Sets the timer in seconds for how long this should pause before ramming another player
        --sleep(0.2)
    end
end)
toolTip(griefPlayerTab, "Sandwiches the selected player between 2 vehicles at high velocity")

-- griefPlayerTabing Explode Player 2
griefPlayerTab:add_sameline()
 explodeLoop = false
explodeLoop = griefPlayerTab:add_checkbox("Explosion")

script.register_looped("explodeLoop", function()
    if explodeLoop:is_enabled() == true then
         explosionType = 1  -- Adjust this according to the explosion type you want (1 = GRENADE, 2 = MOLOTOV, etc.)
         explosionFx = "explosion_barrel"

                 player_id = network.get_selected_player()
                 coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000.0, true, false, 0, false)
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)
                
                gui.show_message("griefPlayerTab", "Exploding "..PLAYER.GET_PLAYER_NAME(player_id).." repeatedly")
                -- Optionally, you can play an explosion sound here using AUDIO.PLAY_SOUND_FROM_COORD

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before exploding another player
    end
end)
toolTip(griefPlayerTab, "Repeatedly explodes the selected player using a barrel explosion.")

-- Crash Options
griefPlayerTab:add_separator()
griefPlayerTab:add_text("Crash Options")
 prCrash = false
prCrash = griefPlayerTab:add_checkbox("PR Crash (On/Off)")

script.register_looped("prCrash", function()
    if prCrash:is_enabled() == true then

         model = joaat("vw_prop_vw_colle_prbubble")
         pickup = joaat("PICKUP_CUSTOM_SCRIPT")
         player_id = network.get_selected_player()
         money_value = 1000000

        STREAMING.REQUEST_MODEL(model)

        if STREAMING.HAS_MODEL_LOADED(model) then
        gui.show_message("PR Crash", "Crashing player")
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
             objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 0.5,
                3,
                money_value,
                model,
                true,
                false
            )

             net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
        sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
    end
end)
toolTip(griefPlayerTab, "Spawns Princes Robot figurines worth $1,000,000, causing the player to crash (not very effective on modders)")
-- SCH-Lua
griefPlayerTab:add_sameline()
griefPlayerTab:add_button("Fragment crash", function()
    script.run_in_fiber(function (fragcrash)
        if PLAYER.GET_PLAYER_PED(network.get_selected_player()) == PLAYER.PLAYER_PED_ID() then
            gui.show_message("The attack has stopped","The target has been detected to have left or the target is himself")
            return
        end
        fraghash = joaat("prop_fragtest_cnst_04")
        STREAMING.REQUEST_MODEL(fraghash)
         TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
         crashstaff1 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff1, 1, false)
         crashstaff2 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff2, 1, false)
         crashstaff3 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff3, 1, false)
         crashstaff4 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff4, 1, false)
        for i = 0, 100 do 
            if PLAYER.GET_PLAYER_PED(network.get_selected_player()) == PLAYER.PLAYER_PED_ID() then
                gui.show_message("The attack has stopped","The target has been detected to have left or the target is himself")
                return
            end    
             TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            fragcrash:sleep(10)
            delete_entity(crashstaff1)
            delete_entity(crashstaff2)
            delete_entity(crashstaff3)
            delete_entity(crashstaff4)
        end
    end)
    script.run_in_fiber(function (fragcrash2)
         TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        fraghash = joaat("prop_fragtest_cnst_04")
        STREAMING.REQUEST_MODEL(fraghash)
        for i=1,10 do
            if PLAYER.GET_PLAYER_PED(network.get_selected_player()) == PLAYER.PLAYER_PED_ID() then
                gui.show_message("The attack has stopped","The target has been detected to have left or the target is himself")
                return
            end    
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
             object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            fragcrash2:sleep(100)
            delete_entity(object)
        end
    end)
end)
toolTip(griefPlayerTab, "Spawns a bunch of objects on the selected player and breaks them into fragments, causing them to crash")

griefPlayerTab:add_sameline()
griefPlayerTab:add_button("Break HUD", function()
     pid = network.get_selected_player()
    network.trigger_script_event(1 << pid, {1450115979, pid, 1})
    gui.show_message("HUD Breaker", "You have broken "..PLAYER.GET_PLAYER_NAME(pid).."'s HUD and Interiors.")
    gui.show_message("HUD Breaker", "This causes them to have no HUD and also cannot see interior entry points, they can't pause or switch weapons either.")
end)
toolTip(griefPlayerTab, "Removes and breaks the HUD of the selected player, this causes them to not be able to pause, enter apartments and ruins their freemode missions")

-- Grief Sound Spam Targetable
griefPlayerTab:add_separator()
griefPlayerTab:add_text("Sound Spams")
 soundIndex = 0
 isPlaying = false

 searchQuery = ""
 filteredSoundNames = {}
 selectedFilteredSoundIndex = 0

 function updateFilteredSoundNames()
    filteredSoundNames = {}
    for _, sound in ipairs(sounds) do
        if string.find(string.lower(sound.SoundName), string.lower(searchQuery)) then
            table.insert(filteredSoundNames, sound.SoundName)
        end
    end
end

 function displaySoundNamesList()
    updateFilteredSoundNames()
    if selectedFilteredSoundIndex > #filteredSoundNames then
        selectedFilteredSoundIndex = 0
    end
    selectedFilteredSoundIndex, _ = ImGui.Combo("Select Sound", selectedFilteredSoundIndex, filteredSoundNames, #filteredSoundNames)
end

griefPlayerTab:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    searchQuery, _ = ImGui.InputText("Search Sounds", searchQuery, 128)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end

     soundNames = {}
    for _, sound in ipairs(sounds) do
        table.insert(soundNames, sound.SoundName)
    end

    displaySoundNamesList()

    if ImGui.Button("Play") then
         selectedSoundName = filteredSoundNames[selectedFilteredSoundIndex + 1]
         targetPlayer = network.get_selected_player()
            script.run_in_fiber(function()
                -- Play the selected sound
                local selectedSound
                for _, sound in ipairs(sounds) do
                    if sound.SoundName == selectedSoundName then
                        selectedSound = sound
                        break
                    end
                end
                soundId = AUDIO.PLAY_SOUND_FROM_ENTITY(-1, selectedSound.AudioName, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetPlayer), selectedSound.AudioRef, true, 999999999)
                soundId = AUDIO.GET_SOUND_ID()
                gui.show_message("Sound Spam", "Playing "..selectedSound.SoundName.." on "..PLAYER.GET_PLAYER_NAME(targetPlayer))
                gui.show_message("Sound ID", soundId)
            end)    
    end
end)
toolTip(griefPlayerTab, "Plays the selected sound from the dropdown.")

griefPlayerTab:add_sameline()
 stopSounds = false
stopSounds = griefPlayerTab:add_checkbox("Stop  Sounds")
    script.register_looped("stopSounds", function(script)
        if stopSounds:is_enabled() == true then     
            --soundId = AUDIO.GET_SOUND_ID()
            --gui.show_message("Sound ID", "Stopped "..soundId)
            --AUDIO.STOP_SOUND(soundId)
            --AUDIO.RELEASE_SOUND_ID(soundId)
            for i = -1, 25 do
                AUDIO.STOP_SOUND(i)
                AUDIO.RELEASE_SOUND_ID(i)
            end
        end
    end)

toolTip(griefPlayerTab, "Halts all sounds.") 

griefPlayerTab:add_imgui(function()
    -- Ends the ImGui wrapper, new additions should be added above this.
    ImGui.End()
end)



dropsPlayerTab:add_sameline()
Drops = dropsPlayerTab:add_checkbox("Drops")
Drops:set_enabled(true)
dropsPlayerTab:add_imgui(function()
    if Drops:is_enabled() then
     parentWindow = gui.get_tab("") -- Assuming this retrieves the parent window
         parentX, parentY = ImGui.GetWindowPos() -- Get the position of the parent window
         parentWidth, parentHeight = ImGui.GetWindowSize(parentWindow) -- Get the size of the parent window
         childWidth, childHeight = 200, 150 -- Size of your child window
         offset = 10 -- Offset between parent and child windows

         x = parentX + parentWidth + offset -- Position the child window to the right of the parent window
         y = parentY + 30-- Align the child window vertically with the parent window

        ImGui.SetNextWindowPos(x, y)
            if ImGui.Begin("Extras Addon (Drop Options) - ".. PLAYER.GET_PLAYER_NAME(network.get_selected_player())) then
        end
    end
end)

 princessBubblegumLoop = false
dropsPlayerTab:add_text("Action Figures")
dropsPlayerTab:add_button("Princess Robot Bubblegum (On/Off)", function()
    princessBubblegumLoop = not princessBubblegumLoop

    script.register_looped("princessbubblegumLoop", function(script)
         model = joaat("vw_prop_vw_colle_prbubble")
         pickup = joaat("PICKUP_CUSTOM_SCRIPT")
         player_id = network.get_selected_player()
         money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
        gui.show_message("RP/Cash Drop Started", "Dropping Princess Robot figurines on "..PLAYER.GET_PLAYER_NAME(player_id))
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
             objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                false,
                false
            )

             net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
            
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(objectIdSpawned)
        end
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(objectIdSpawned, player_id, false)
        sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not princessBubblegumLoop then
            script.unregister_script("princessbubblegumLoop")
        end
    end)
end)
toolTip(dropsPlayerTab, "Drops Princess Robot Figurines on a selected player.")
dropsPlayerTab:add_sameline()
dropsPlayerTab:add_button("Alien (On/Off)", function()
   alienfigurineLoop = not alienfigurineLoop

    script.register_looped("alienfigurineLoop", function(script)
         model = joaat("vw_prop_vw_colle_alien")
         pickup = joaat("PICKUP_CUSTOM_SCRIPT")
         player_id = network.get_selected_player()
         money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
        gui.show_message("RP/Cash Drop Started", "Dropping Alien figurines on "..PLAYER.GET_PLAYER_NAME(player_id))
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
             objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                false,
                false
            )

             net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
            
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(objectIdSpawned)
        end
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(objectIdSpawned, player_id, false)
        sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not alienfigurineLoop then
            script.unregister_script("alienfigurineLoop")
        end
    end)
end)
toolTip(dropsPlayerTab, "Drops Alien Figurines on a selected player.")
dropsPlayerTab:add_sameline()
dropsPlayerTab:add_button("Casino Cards (On/Off)", function()
   casinocardsLoop = not casinocardsLoop

    script.register_looped("casinocardsLoop", function(script)
         model = joaat("vw_prop_vw_lux_card_01a")
         pickup = joaat("PICKUP_CUSTOM_SCRIPT")
         player_id = network.get_selected_player()
         money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
        gui.show_message("RP/Cash Drop Started", "Dropping Casino Cards on "..PLAYER.GET_PLAYER_NAME(player_id))
             coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
             objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                false,
                false
            )
        
             net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
            
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(objectIdSpawned)
        end
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(objectIdSpawned, player_id, false)
        sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not casinocardsLoop then
            script.unregister_script("casinocardsLoop")
        end
    end)
end)
toolTip(dropsPlayerTab, "Drops Casino Cards on a selected player.")
dropsPlayerTab:add_separator()
dropsPlayerTab:add_button("Give 25k & Random RP", function()
    script.run_in_fiber(function(tse)
        pid = network.get_selected_player()
        for i = 0, 9 do
            for v = 0, 20 do
                network.trigger_script_event(1 << pid, {968269233, pid, 0, i, v, v, v})
                for n = 0, 16 do
                    network.trigger_script_event(1 << pid, {968269233, pid, n, i, v, v, v})
                end
            end
            network.trigger_script_event(1 << pid, {968269233, pid, 1, i, 1, 1, 1})
            network.trigger_script_event(1 << pid, {968269233, pid, 3, i, 1, 1, 1})
            network.trigger_script_event(1 << pid, {968269233, pid, 10, i, 1, 1, 1})
            network.trigger_script_event(1 << pid, {968269233, pid, 0, i, 1, 1, 1})
            tse:yield()
            
            gui.show_message("Bless RP", "Blessing "..PLAYER.GET_PLAYER_NAME(pid).." with 25k RP (1 time)")
        end
    end)
end)
toolTip(dropsPlayerTab, "Gives the selected player some Money and RP")
dropsPlayerTab:add_sameline()
 tseTest = dropsPlayerTab:add_checkbox("Super Fast RP")
script.register_looped("tseTest", function()
    if tseTest:is_enabled() == true then
        pid = network.get_selected_player()
        for i = 0, 24 do 
            network.trigger_script_event(1 << pid, {968269233 , pid, 1, 4, i, 1, 1, 1, 1})
        end
    end
end)
toolTip(dropsPlayerTab, "Remotely floods the selected player with RP (about 1 level/sec)")
dropsPlayerTab:add_sameline()
 ezMoney = dropsPlayerTab:add_checkbox("Money ($225k)")
    script.register_looped("ezMoney", function()
        if ezMoney:is_enabled() == true then
             pid = network.get_selected_player()
            for n = 0, 10 do
                for l = -10, 10 do
                    network.trigger_script_event(1 << pid, {968269233 , pid, 1, l, l, n, 1, 1, 1})
                end
            end
        end
    end)
toolTip(dropsPlayerTab, "Sometimes works, sometimes doesn't.  Up to 225k")

dropsPlayerTab:add_imgui(function()
    -- Ends the ImGui wrapper, new additions should be added above this.
    ImGui.End()
end)

giftPlayerTab:add_sameline()
Gifts = giftPlayerTab:add_checkbox("Vehicle")
Gifts:set_enabled(true)
giftPlayerTab:add_imgui(function()
    if Gifts:is_enabled() then
     parentWindow = gui.get_tab("") -- Assuming this retrieves the parent window
         parentX, parentY = ImGui.GetWindowPos() -- Get the position of the parent window
         parentWidth, parentHeight = ImGui.GetWindowSize(parentWindow) -- Get the size of the parent window
         childWidth, childHeight = 200, 450 -- Size of your child window
         offset = 10 -- Offset between parent and child windows

         x = parentX + parentWidth + offset -- Position the child window to the right of the parent window
         y = parentY + 60 -- Align the child window vertically with the parent window

        ImGui.SetNextWindowPos(x, y)
            if ImGui.Begin("Extras Addon (Vehicle Options) - ".. PLAYER.GET_PLAYER_NAME(network.get_selected_player())) then
        end
    end
end)

-- Orientation sliders and Spawn X Y Z sliders
 orientationPitch = 0
 orientationYaw = 0
 orientationRoll = 0
 spawnDistance = { x = 0, y = 0, z = -1 }
 defaultOrientationPitch = 0
 defaultOrientationYaw = 0
 defaultOrientationRoll = 0
 defaultSpawnDistance = { x = 0, y = 0, z = -1 }


-- Function to reset sliders to default values
 function resetVehicleSliders()
    orientationPitch = defaultOrientationPitch
    orientationYaw = defaultOrientationYaw
    orientationRoll = defaultOrientationRoll
    spawnDistance.x = defaultSpawnDistance.x
    spawnDistance.y = defaultSpawnDistance.y
    spawnDistance.z = defaultSpawnDistance.z
end

giftPlayerTab:add_imgui(function()
    orientationPitch, _ = ImGui.SliderInt("Pitch", orientationPitch, 0, 360)
    toolTip("", "Change the Pitch of the vehicle (Side to Side Axis)")
    orientationYaw, _ = ImGui.SliderInt("Yaw", orientationYaw, 0, 360)
    toolTip("", "Change the Yaw of the object (Vertical Axis)")
    orientationRoll, _ = ImGui.SliderInt("Roll", orientationRoll, 0, 360)
    toolTip("", "Change the Roll of the object (Front to Back Axis)")
end)

giftPlayerTab:add_imgui(function()
    spawnDistance.x, _ = ImGui.SliderFloat("Spawn Distance X", spawnDistance.x, -25, 25)
    toolTip("", "Change the X coordinates of where the object spawns (Left/Right depending on direction you are facing)")
    spawnDistance.y, _ = ImGui.SliderFloat("Spawn Distance Y", spawnDistance.y, -25, 25)
    toolTip("", "Change the Y coordinates of where the object spawns (Forward/Backwards depending on direction you are facing)")
    spawnDistance.z, _ = ImGui.SliderFloat("Spawn Distance Z", spawnDistance.z, -25, 25)
    toolTip("", "Change the Z coordinates of where the object spawns (Up/Down)")
end)

-- Save default values
defaultOrientationPitch = orientationPitch
defaultOrientationYaw = orientationYaw
defaultOrientationRoll = orientationRoll
defaultSpawnDistance.x = spawnDistance.x
defaultSpawnDistance.y = spawnDistance.y
defaultSpawnDistance.z = spawnDistance.z

-- Reset Sliders button
giftPlayerTab:add_button("Reset Sliders", function()
    resetVehicleSliders()
end)
toolTip(giftPlayerTab, "Reset the sliders to their default values")
giftPlayerTab:add_separator()

-- Function to spawn the vehicle with specified orientation and spawn position
function spawn_vehicle_with_orientation(vehicle_joaat, pos, pitch, yaw, roll)
    script.run_in_fiber(function (script)
         load_counter = 0
        while STREAMING.HAS_MODEL_LOADED(vehicle_joaat) == false do
            STREAMING.REQUEST_MODEL(vehicle_joaat)
            script:yield()
            if load_counter > 100 then
                return
            else
                load_counter = load_counter + 1
            end
        end
         veh = VEHICLE.CREATE_VEHICLE(vehicle_joaat, pos.x, pos.y, pos.z, yaw, true, true, false)
        -- Set vehicle orientation
        ENTITY.SET_ENTITY_ROTATION(veh, pitch, yaw, roll, 2, true)
         networkId = NETWORK.VEH_TO_NET(veh)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(veh) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
        end
        if endPollution:is_enabled() then
            ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(veh) -- only use to cut spawned object/vehicle/ped pollution out of sessions, plans for this eventually.
        end
    end)
end

-- Function to display the list of vehicle models with search functionality
 searchQuery = ""
 filteredVehicleModels = {}

 function updateFilteredVehicleModels()
    filteredVehicleModels = {}
    for _, model in ipairs(vehicleModels) do
        if string.find(string.lower(model), string.lower(searchQuery)) then
            table.insert(filteredVehicleModels, model)
        end
    end
end

 function displayVehicleModelsList()
    updateFilteredVehicleModels()
     vehicleModelNames = {}
    for _, item in ipairs(filteredVehicleModels) do
        table.insert(vehicleModelNames, vehicles.get_vehicle_display_name(item))
    end
    selectedObjectIndex, _ = ImGui.ListBox("Vehicle Models", selectedObjectIndex, vehicleModelNames, #vehicleModelNames)
end

-- Add search input field
giftPlayerTab:add_imgui(function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    searchQuery, _ = ImGui.InputText("Search Vehicles", searchQuery, 128)
    if ImGui.IsItemActive() then
        is_typing = true
    else
        is_typing = false
    end
end)
toolTip(giftPlayerTab, "Search for a vehicle (Example: Adder, Baller, Zentorno)")
giftPlayerTab:add_imgui(displayVehicleModelsList)

-- Add separator
giftPlayerTab:add_separator()

-- Spawn Selected vehicle button with orientation and spawn position
giftPlayerTab:add_button("Spawn Vehicle", function()
     selectedModelIndex = selectedObjectIndex + 1
    if selectedModelIndex > 0 then
         selectedVehicleModel = filteredVehicleModels[selectedModelIndex]
        if selectedVehicleModel then
             vehicleHash = MISC.GET_HASH_KEY(selectedVehicleModel)
             selPlayer = network.get_selected_player()
             targetPlayerPed = PLAYER.GET_PLAYER_PED(selPlayer)
             playerName = PLAYER.GET_PLAYER_NAME(selPlayer)
             -- Get the player's forward vector
			playerForward = ENTITY.GET_ENTITY_FORWARD_VECTOR(targetPlayerPed)

			playerPos = ENTITY.GET_ENTITY_COORDS(targetPlayerPed, false)
			playerPos.x = playerPos.x + playerForward.x * spawnDistance.x
			playerPos.y = playerPos.y + playerForward.y * spawnDistance.x
			playerPos.z = playerPos.z + playerForward.z * spawnDistance.x

            spawn_vehicle_with_orientation(vehicleHash, playerPos, orientationPitch, orientationYaw, orientationRoll)
            gui.show_message("Vehicle Spawner", "Spawned "..vehicles.get_vehicle_display_name(vehicleHash).." for "..playerName)
			
			script:yield()
        end
    else
        gui.show_message("Vehicle Spawner", "Please select a vehicle model.")
    end
--end
end)
toolTip(giftPlayerTab, "Spawns the vehicle on the selected player, if no player is selected, defaults to you")

giftPlayerTab:add_sameline()
 endPollution = giftPlayerTab:add_checkbox("No Pollution")
endPollution:set_enabled(true)
toolTip(giftPlayerTab, "Sets the entity as no longer needed to prevent session pollution of invisible vehicles, turn this off ONLY for gifting cars to others")
toolTip(giftPlayerTab, "If you disable this, make sure you use the delete gun 'Self > Weapons > Custom gun (enabled) > Delete Gun' and delete the gifted car after its been driven into the garage")

-- Vehicle Gift Options
giftedsucc = false
 
function giftVehToPlayer(vehicle, playerId, playerName)
    if request_control(vehicle) then
         netHash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(playerId)
 
        DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 8)
        DECORATOR.DECOR_SET_INT(vehicle, "Previous_Owner", netHash)
        DECORATOR.DECOR_SET_INT(vehicle, "Veh_Modded_By_Player", netHash)
        DECORATOR.DECOR_SET_INT(vehicle, "Not_Allow_As_Saved_Veh", 0)
        DECORATOR.DECOR_SET_INT(vehicle, "Player_Vehicle", netHash)
       
        gui.show_message("Gift Vehicle Success", "Gifted "..VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle)).." to "..playerName) 
        giftedsucc = true
    else
        gui.show_message("Gift Vehicle Failure", "Failed to gain control of the vehicle")
        giftedsucc = false
    end
end
 
-- Assuming gui provides a 'show_message' method

giftPlayerTab:add_button("Gift Vehicle", function()
 
    script.run_in_fiber(function(script)
 
         selectedPlayer = network.get_selected_player()
            
        -- Check if a player is selected
         targetPlayerPed = PLAYER.GET_PLAYER_PED(selectedPlayer)
         playerName = PLAYER.GET_PLAYER_NAME(selectedPlayer)
        
        if PED.IS_PED_IN_ANY_VEHICLE(targetPlayerPed, true) then
             targetVehicle = PED.GET_VEHICLE_PED_IS_IN(targetPlayerPed, true)
 
            repeat
                giftVehToPlayer(targetVehicle, selectedPlayer, playerName)
                script:sleep(200) 
            until(giftedsucc == true)
 
            giftedsucc = false -- set false to make sure next gifted car doesnt instantly stop repeating when it should still be repeating
        end 
    end)
end)
toolTip(giftPlayerTab, "Press the gift button after following the Gifting Process and when it reads Success, the gifting has been completed.")
giftPlayerTab:add_sameline()
giftPlayerTab:add_button("Get Vehicle Stats", function()
     selectedPlayer = network.get_selected_player()
     targetPlayerPed = PLAYER.GET_PLAYER_PED(selectedPlayer)
 
    if PED.IS_PED_IN_ANY_VEHICLE(targetPlayerPed, true) then
        last_veh = PED.GET_VEHICLE_PED_IS_IN(targetPlayerPed, true)
    end 
 
 
    if last_veh  then 
         playerName = PLAYER.GET_PLAYER_NAME(selectedPlayer)
        gui.show_message("Info", 
            "user :"..PLAYER.GET_PLAYER_NAME(selectedPlayer).."->"..NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(selectedPlayer).."->".. joaat(playerName).."\n".. --NETWORK.GET_HASH_KEY(playerName).."\n"..
            " Previous_Owner:"..DECORATOR.DECOR_GET_INT(last_veh , "Previous_Owner").."\n"..
            " Vehicle Model:"..VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(last_veh)).."\n"..
            " Player_Vehicle:"..DECORATOR.DECOR_GET_INT(last_veh , "Player_Vehicle").."\n"..
            " MPBitset:"..DECORATOR.DECOR_GET_INT(last_veh , "MPBitset").."\n"..
            " Veh_Modded_By_Player:"..DECORATOR.DECOR_GET_INT(last_veh , "Veh_Modded_By_Player").."\n"..
            " Not_Allow_As_Saved_Veh:"..DECORATOR.DECOR_GET_INT(last_veh , "Not_Allow_As_Saved_Veh"))
    end  
end)
toolTip(giftPlayerTab, "Checks to make sure the vehicle stats are what they need to be (Dev testing button)")
giftPlayerTab:add_separator()
giftPlayerTab:add_button("How To Gift Vehicles (Hover for tooltip!)", function()

end)
toolTip(giftPlayerTab, "To gift vehicles, Make sure all the players vehicles are repaired/returned and that they have a full garage")
toolTip(giftPlayerTab, "Have them go into their full garage, drive a vehicle out and back into their garage, then come out on foot")
toolTip(giftPlayerTab, "Spawn the vehicle using Extras Addon's Vehicle Spawner (UNCHECK THE NO POLLUTION BOX!), optionally you can get inside and customize it using Yim's LS customs tab (DONT PRESS 'Start LS customs!)")
toolTip(giftPlayerTab, "Once you are done, get out and have them get in, then Press the Gift Vehicle button, once it returns the success message they can drive it into their garage")
toolTip(giftPlayerTab, "NOTE: Gifted vehicles SHOULD come fully insured, MAKE SURE THEY CHECK IT IN LS CUSTOMS!")

giftPlayerTab:add_imgui(function()
    -- Ends the ImGui wrapper, new additions should be added above this.
    ImGui.End()
end)

----------Config--------------------
saveConfig = false

function presistEntry(tableEntry, value)
    configTable[tableEntry] = value
end

function setEntry(tableEntry, value)
    if value ~= configTable[tableEntry] then
        configTable[tableEntry] = value
        saveConfig = true
    end
end

 persisted_config = io.open("Extras-Addon.json", "r")
if persisted_config == nil then
    configTable = {}
    --Add entries here
    presistEntry("tireParticles", tirePTFX:is_enabled()) --param0 is the entry in the config table, param1 is the value to set the entry in the table(this will be the current value of the component)  
    --End Entires
     new_file = io.open("Extras-Addon.json", "w+")
    new_file:write(json.encode(configTable))
    new_file:flush()
    new_file:close()
else
    configTable = json.decode(persisted_config:read("*all"))
    --add entries, they need to be set to the values in the config
    tirePTFX:set_enabled(configTable["tireParticles"]) --sets the value of the component to the value from the config
    --end entries
    persisted_config:close()
end

script.register_looped("Extras Addon Config", function(script)
    if gui.is_open() then
        saveConfig = false
        --Each entry should look like this
        setEntry("tireParticles", tirePTFX:is_enabled()) --param0 is the entry in the config table, param1 is the value to set the entry in the table(this will be the current value of the component)
        --End Entries
        if saveConfig then
            gui.show_message("Config", "Saving")
             json_file = io.open("Extras-Addon.json", "w")
            json_file:write(json.encode(configTable))
            json_file:flush()
            json_file:close()
        end
    end
    script:yield()
end)
