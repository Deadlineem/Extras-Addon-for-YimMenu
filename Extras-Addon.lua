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
		Addon Version: 0.8.8
		
		Credits:  Yimura, L7Neg, 
	Loled69, Alestarov, gir489returns, 
	  TheKuter, RazorGamerX & More!

]]--

-- Function to create a text element
local function createText(tab, text)
    tab:add_text(text)
end

function sleep(seconds)
    local start = os.clock()
    while os.clock() - start < seconds do
        -- Yield the CPU to avoid high CPU usage during the delay
        coroutine.yield()
    end
end
-- Vehicle List

local vehicleModels = {
    "adder",
	"zentorno",
	"comet2",
	"ardent",
	"autarch",
	"cheetah",
	"champion",
	"cyclone",
	"cyclone2",
    -- Add more vehicle models here
}
-- Weapons List
local weaponNamesString = {
    "weapon_dagger", "weapon_bat", "weapon_bottle", "weapon_crowbar",
    "weapon_unarmed", "weapon_flashlight", "weapon_golfclub", "weapon_hammer",
    "weapon_hatchet", "weapon_knuckle", "weapon_knife", "weapon_machete",
    "weapon_switchblade", "weapon_nightstick", "weapon_wrench", "weapon_battleaxe",
    "weapon_poolcue", "weapon_stone_hatchet", "weapon_pistol", "weapon_pistol_mk2",
    "weapon_combatpistol", "weapon_appistol", "weapon_stungun", "weapon_pistol50",
    "weapon_snspistol", "weapon_snspistol_mk2", "weapon_heavypistol", "weapon_vintagepistol",
    "weapon_flaregun", "weapon_marksmanpistol", "weapon_revolver", "weapon_revolver_mk2",
    "weapon_doubleaction", "weapon_raypistol", "weapon_ceramicpistol", "weapon_navyrevolver",
    "weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_assaultsmg",
    "weapon_combatpdw", "weapon_machinepistol", "weapon_minismg", "weapon_raycarbine",
    "weapon_pumpshotgun", "weapon_pumpshotgun_mk2", "weapon_sawnoffshotgun", "weapon_assaultshotgun",
    "weapon_bullpupshotgun", "weapon_musket", "weapon_heavyshotgun", "weapon_dbshotgun",
    "weapon_autoshotgun", "weapon_assaultrifle", "weapon_assaultrifle_mk2", "weapon_carbinerifle",
    "weapon_carbinerifle_mk2", "weapon_advancedrifle", "weapon_specialcarbine", "weapon_specialcarbine_mk2",
    "weapon_bullpuprifle", "weapon_bullpuprifle_mk2", "weapon_compactrifle", "weapon_mg",
    "weapon_combatmg", "weapon_combatmg_mk2", "weapon_gusenberg", "weapon_sniperrifle",
    "weapon_heavysniper", "weapon_heavysniper_mk2", "weapon_marksmanrifle", "weapon_marksmanrifle_mk2",
    "weapon_rpg", "weapon_grenadelauncher", "weapon_grenadelauncher_smoke", "weapon_minigun",
    "weapon_firework", "weapon_railgun", "weapon_hominglauncher", "weapon_compactlauncher",
    "weapon_rayminigun", "weapon_grenade", "weapon_bzgas", "weapon_smokegrenade",
    "weapon_flare", "weapon_molotov", "weapon_stickybomb", "weapon_proxmine",
    "weapon_snowball", "weapon_pipebomb", "weapon_ball", "weapon_petrolcan",
    "weapon_fireextinguisher", "weapon_hazardcan", "weapon_militaryrifle",
    "weapon_combatshotgun", "weapon_gadgetpistol", "WEAPON_SNOWLAUNCHER", "WEAPON_BATTLERIFLE", 
	"WEAPON_TECPISTOL", "WEAPON_CANDYCANE", "WEAPON_PISTOLXM3", "WEAPON_RAILGUNXM3", "WEAPON_PRECISIONRIFLE", 
	"WEAPON_TACTICALRIFLE", "WEAPON_EMPLAUNCHER", "WEAPON_HEAVYRIFLE"
}

local weaponModels = {
    "prop_w_me_dagger", "prop_baseball_bat", "prop_ld_flow_bottle", "prop_tool_crowbar", "prop_ld_ammo_pack_01", "prop_ld_shovel", "prop_golf_iron_01", "prop_tool_hammer", "prop_ld_fireaxe", "prop_ld_handbag", "prop_knife", "prop_ld_w_me_machette", "prop_ld_w_me_switchblade",
    "prop_ld_bat_01", "prop_tool_wrench", "prop_tool_fireaxe", "prop_pool_cue", "prop_melee_rock", "w_pi_pistol", "w_pi_pistol_mk2", "w_pi_combatpistol", "w_pi_appistol", "w_pi_stungun", "w_pi_pistol50", "w_pi_sns_pistol", "w_pi_sns_pistol_mk2", "w_pi_heavy_pistol",
    "w_pi_vintage_pistol", "w_pi_flaregun", "w_pi_marksmanpistol", "w_pi_revolver", "w_pi_revolver_mk2", "w_pi_doubleaction", "w_pi_ray_pistol", "w_pi_ceramic_pistol", "w_pi_navy_revolver", "w_sb_microsmg", "w_sb_smg", "w_sb_smg_mk2", "w_sb_assaultsmg", "w_sb_pdw",
    "w_sb_machinepistol", "w_sb_minismg", "w_sb_ray_carbine", "w_sg_pumpshotgun", "w_sg_pumpshotgun_mk2", "w_sg_sawnoff", "w_sg_assaultshotgun", "w_sg_bullpupshotgun", "w_ar_musket", "w_sg_heavyshotgun", "w_sg_doublebarrel", "w_sg_autoshotgun", "w_ar_assaultrifle",
    "w_ar_assaultrifle_mk2", "w_ar_carbinerifle", "w_ar_carbinerifle_mk2", "w_ar_advancedrifle", "w_ar_specialcarbine", "w_ar_specialcarbine_mk2", "w_ar_bullpuprifle", "w_ar_bullpuprifle_mk2", "w_ar_compactrifle", "w_mg_mg", "w_mg_combatmg", "w_mg_combatmg_mk2", "w_sb_gusenberg",
    "w_sr_sniperrifle", "w_sr_heavysniper", "w_sr_heavysniper_mk2", "w_sr_marksmanrifle", "w_sr_marksmanrifle_mk2", "w_lr_rpg", "w_lr_grenadelauncher", "w_lr_grenadelauncher_smoke", "w_mg_minigun", "w_lr_firework", "w_lr_railgun", "w_lr_homing", "w_lr_grenadelauncher", "w_mg_rayminigun",
    "w_ex_grenadethrow", "w_ex_bzgas", "w_ex_grenadesmoke", "w_ex_flare", "w_ex_molotov", "w_ex_stickybomb", "w_ex_proxmine", "w_ex_snowball", "w_ex_pipebomb", "prop_snow_flower_01", "w_me_petrolcan", "prop_fire_exting_1a", "w_lr_hazard", "w_ar_militaryrifle",
    "w_sg_combatshotgun", "w_pi_gadget_pistol", "w_ar_snowball", "w_ar_battlerifle", "w_pi_tecpistol", "w_me_candy_cane", "w_pi_pistolxm3", "w_ar_railgunxm3", "w_ar_precisionrifle", "w_ar_tacticalrifle", "w_lr_emplauncher", "w_ar_heavyrifle"
}



-- Extras Menu Addon for YimMenu 1.68 by DeadlineEm
local KAOS = gui.get_tab("Extras Addon")
createText(KAOS, "Welcome to Extras Addon v0.8.8 please read the information below before proceeding to use the menu options.")
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
createText(KAOS, "Alestarov, RazorGamerX & the UC community")
KAOS:add_separator()
createText(KAOS, "Thanks to all my testers, your time is appreciated.  Thanks to all of the above for your scripts and")
createText(KAOS, "for your inputs on my comments, I have done alot of reading, scrolling, testing and learning from it all")
createText(KAOS, "- DeadlineEm")

-- Player Options Tab
local Pla = KAOS:add_tab("Player Options")

-- Movement Tab with Slider for Movement Speed
local Mvmt = Pla:add_tab("Movement")

runSpeed = 0
Mvmt:add_imgui(function()
    runSpeed, used = ImGui.SliderInt("Run Speed", runSpeed, 0, 10)
	out = "Speed set to "..tostring(runSpeed).."x"
    if used then
        PLAYER.SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), runSpeed/7)
		gui.show_message('Run Speed Modified!', out)
    end
end)

swimSpeed = 0
Mvmt:add_imgui(function()
    swimSpeed, used = ImGui.SliderInt("Swim Speed", swimSpeed, 0, 10)
    out = "Speed set to "..tostring(swimSpeed).."x"
    if used then
        PLAYER.SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), swimSpeed/7)
		gui.show_message('Swim Speed Modified!', out)
    end
end)

-- Fun Random Things
local Fun = Pla:add_tab("Fun Self Options")
Fun:add_text("PTFX")
local fireworkLoop3 = Fun:add_checkbox("Firework (On/Off)")

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
            local localPlayerId = PLAYER.PLAYER_ID()
				local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(localPlayerId), true)

				-- Get random color values
				local colorR, colorG, colorB = random_color()
				test = player_coords.z - 1
				GRAPHICS.USE_PARTICLE_FX_ASSET("proj_indep_firework")
				GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_indep_firework_grd_burst", player_coords.x, player_coords.y, test, 0, 0, 0, 1, false, false, false, false)
			sleep(0.2)
		end
    end
end)

Fun:add_sameline()
local smokeLoop = Fun:add_checkbox("Smoke (On/Off)")
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
            local localPlayerId = PLAYER.PLAYER_ID()
				local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(localPlayerId), true)

				-- Get random color values
				local colorR, colorG, colorB = random_color()
				test = player_coords.z - 2.5
				GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
				GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_sum2_hal_rider_death_blue", player_coords.x, player_coords.y, test, 0, 0, 0, 1, false, false, false, false)
			sleep(0.2)
		end
    end
end)

Fun:add_sameline()
local flameLoop = Fun:add_checkbox("Flames (On/Off)")
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
            local localPlayerId = PLAYER.PLAYER_ID()
				local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(localPlayerId), true)

				-- Get random color values
				local colorR, colorG, colorB = random_color()
				test = player_coords.z - 1
				GRAPHICS.USE_PARTICLE_FX_ASSET("scr_bike_adversary")
				GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colorR, colorG, colorB)
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_adversary_foot_flames", player_coords.x, player_coords.y, test, 0, 0, 0, 5, false, false, false, false)
			sleep(0.2)
		end
    end
end)
Fun:add_separator()

-- Stat Editor - Alestarov_Menu
local Stats = Pla:add_tab("Stats")

Stats:add_button("Reset Stats", function()
    gui.show_message("Multiplayer Stats Reset", "Stats reset for both Player 1 and Player 2, Change session to apply changes")
    script.run_in_fiber(function (script)
        STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_EVC"), 0, true)
        STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_SVC"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_JOBS"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_JOBSHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_SELLING_VEH"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_WEAPON_ARMOR"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_VEH_MAINTENANCE"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_STYLE_ENT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_PROPERTY_UTIL"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_JOB_ACTIVITY"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_SPENT_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_MONEY_EARN_CLUB_DANCING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_CHIPS_WON_GD"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_CHIPS_WONTIM"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_GMBLNG_GD"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_BAN_TIME"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_CHIPS_PURTIM"), 0, true)
        STATS.STAT_SET_INT(joaat("MP0_CASINO_CHIPS_PUR_GD"), 0, true)
		-- Player 2 Stats Reset
		STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_EVC"), 0, true)
        STATS.STAT_SET_INT(joaat("MPPLY_TOTAL_SVC"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_JOBS"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_SHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_JOBSHARED"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_SELLING_VEH"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_WEAPON_ARMOR"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_VEH_MAINTENANCE"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_STYLE_ENT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_PROPERTY_UTIL"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_JOB_ACTIVITY"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_BETTING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_SPENT_VEHICLE_EXPORT"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_MONEY_EARN_CLUB_DANCING"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_CHIPS_WON_GD"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_CHIPS_WONTIM"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_GMBLNG_GD"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_BAN_TIME"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_CHIPS_PURTIM"), 0, true)
        STATS.STAT_SET_INT(joaat("MP1_CASINO_CHIPS_PUR_GD"), 0, true)
    end)
end)
Stats:add_separator()
Stats:add_text("Resets your player stats (Ban time, earned income, sales, etc.)")
Stats:add_text("*This may glitch some owned properties and reset mission progress in freemode*")


-- Autorun Drops
local Money = Pla:add_tab("Money")
local Drops = Money:add_tab("Drops")

local princessBubblegumLoop = false

Drops:add_button("Princess Robot Bubblegum (On/Off)", function()
    princessBubblegumLoop = not princessBubblegumLoop

    script.register_looped("princessbubblegumLoop", function(script)
        local model = joaat("vw_prop_vw_colle_prbubble")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = network.get_selected_player()
        local money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("RP/Cash Drop Started", "Princess Robot Bubblegum Drops inbound!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )

            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
		sleep(0.4) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not princessBubblegumLoop then
            script.unregister_script("princessbubblegumLoop")
        end
    end)
end)
Drops:add_sameline()
Drops:add_button("Alien (On/Off)", function()
   alienfigurineLoop = not alienfigurineLoop

    script.register_looped("alienfigurineLoop", function(script)
        local model = joaat("vw_prop_vw_colle_alien")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = network.get_selected_player()
        local money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("RP/Cash Drop Started", "Alien Drops inbound!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )

            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
		sleep(0.4) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not alienfigurineLoop then
            script.unregister_script("alienfigurineLoop")
        end
    end)
end)
Drops:add_sameline()
Drops:add_button("Casino Cards (On/Off)", function()
   casinocardsLoop = not casinocardsLoop

    script.register_looped("casinocardsLoop", function(script)
        local model = joaat("vw_prop_vw_lux_card_01a")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = network.get_selected_player()
        local money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("RP/Cash Drop Started", "Casino Card Drops inbound!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
		
            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
		sleep(0.4) -- Sets the timer in seconds for how long this should pause before sending another figure
        if not casinocardsLoop then
            script.unregister_script("casinocardsLoop")
        end
    end)
end)
Drops:add_sameline()
Drops:add_button("Cash Loop (On/Off)", function()
kcashLoop = not kcashLoop
    script.register_looped("kcashLoop", function(script)
        local model = joaat("ch_prop_ch_cashtrolley_01a")
        local pickup = joaat("PICKUP_MONEY_VARIABLE")
        local player_id = network.get_selected_player()

        local money_value = 2000

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("Cash Drop Started", "LOCAL CASH WORKS ON PICKUP but other players cannot see it!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x,
                coords.y,
                coords.z + 1,
                3,
                money_value,
                model,
                true,
                false
            )

            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
		sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
		if not kcashLoop then
            script.unregister_script("kcashLoop")
        end
    end)
end)

Drops:add_separator()
Drops:add_text("Cash loop is REAL but only for you, other players cannot see it at all");
Drops:add_text("You CAN run multiple at once (like Robot bubblegum/Alien)")
Drops:add_text("Select a Player from the list and toggle");

-- CasinoPacino - gir489returns

casino_gui = Money:add_tab("Casino")

blackjack_cards         = 112
blackjack_table_players = 1772
blackjack_decks         = 846
 
three_card_poker_cards           = blackjack_cards
three_card_poker_table           = 745
three_card_poker_current_deck    = 168
three_card_poker_anti_cheat      = 1034
three_card_poker_anti_cheat_deck = 799
three_card_poker_deck_size       = 55
 
roulette_master_table   = 120
roulette_outcomes_table = 1357
roulette_ball_table     = 153
 
slots_random_results_table = 1344
 
prize_wheel_win_state   = 276
prize_wheel_prize       = 14
prize_wheel_prize_state = 45
 
globals_tuneable        = 262145
 
casino_heist_cut        = 1971696
casino_heist_cut_offset = 1497 + 736 + 92
casino_heist_lester_cut = 28998
casino_heist_gunman_cut = 29024
casino_heist_driver_cut = 29029
casino_heist_hacker_cut = 29035
 
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
 
fm_mission_controller_cart_grab       = 10247
fm_mission_controller_cart_grab_speed = 14
fm_mission_controller_cart_autograb   = true

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
 
    local card_number = math.fmod(card_index, 13)
    local cardName = ""
    local cardSuit = ""
 
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
        local player_id = PLAYER.PLAYER_ID()
        while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("blackjack", 3, 0) ~= player_id do 
            network.force_script_host("blackjack")
            gui.show_message("CasinoPacino", "Taking control of the blackjack script.") --If you see this spammed, someone if fighting you for control.
            script:yield()
        end
        local blackjack_table = locals.get_int("blackjack", blackjack_table_players + 1 + (player_id * 8) + 4) --The Player's current table he is sitting at.
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

local player_id = PLAYER.PLAYER_ID()

		casVal = -1
		casino_gui:add_imgui(function()
			casVal, used2 = ImGui.SliderInt("Betting Number", casVal, -1, 36)
			if used2 then
				valz = casVal
			end
		end)
		
casino_gui:add_separator()
casino_gui:add_text("Using these options are risky, especially if you use the cooldown bypass")
 
script.register_looped("Casino Pacino Thread", function (script)
    if force_poker_cards:is_enabled() then
        local player_id = PLAYER.PLAYER_ID()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("three_card_poker")) ~= 0 then
            while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("three_card_poker", 3, 0) ~= player_id do 
                network.force_script_host("three_card_poker")
                gui.show_message("CasinoPacino", "Taking control of the three_card_poker script.") --If you see this spammed, someone if fighting you for control.
                script:sleep(500)
            end
            local players_current_table = locals.get_int("three_card_poker", three_card_poker_table + 1 + (player_id * 9) + 2) --The Player's current table he is sitting at.
            if (players_current_table ~= -1) then -- If the player is sitting at a poker table
                local player_0_card_1 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (1) + (0 * 3))
                local player_0_card_2 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (2) + (0 * 3))
                local player_0_card_3 = locals.get_int("three_card_poker", (three_card_poker_cards) + (three_card_poker_current_deck) + (1 + (players_current_table * three_card_poker_deck_size)) + (2) + (3) + (0 * 3))
                if player_0_card_1 ~= 50 or player_0_card_2 ~= 51 or player_0_card_3 ~= 52 then --Check if we need to overwrite the deck.
                    local total_players = 0
                    for player_iter = 0, 31, 1 do
                        local player_table = locals.get_int("three_card_poker", three_card_poker_table + 1 + (player_iter * 9) + 2)
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
        local dealers_card = 0
        local blackjack_table = locals.get_int("blackjack", blackjack_table_players + 1 + (PLAYER.PLAYER_ID() * 8) + 4) --The Player's current table he is sitting at.
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
		 local player_id = PLAYER.PLAYER_ID()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casinoroulette")) ~= 0 then
            while NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", -1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 0, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 1, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 2, 0) ~= player_id and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("casinoroulette", 3, 0) ~= player_id do 
                network.force_script_host("casinoroulette")
                gui.show_message("CasinoPacino", "Taking control of the casinoroulette script.") --If you see this spammed, someone if fighting you for control.
                script:sleep(500)
            end
            for tabler_iter = 0, 6, 1 do
                locals.set_int("casinoroulette", (roulette_master_table) + (roulette_outcomes_table) + (roulette_ball_table) + (tabler_iter), valz)
				gui.show_message("CasinoPacino Activated!", "Winning Number: "..valz)
            end
        end
    end
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("casino_slots")) ~= 0 then
        local needs_run = false
        if rig_slot_machine:is_enabled() then
            for slots_iter = 3, 195, 1 do
                if slots_iter ~= 67 and slots_iter ~= 132 then
                    if locals.get_int("casino_slots", (slots_random_results_table) + (slots_iter)) ~= 6 then
                        needs_run = true
                    end
                end
            end
        else
            local sum = 0
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
                    local slot_result = 6
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
            locals.set_int("fm_mission_controller", fm_mission_controller_cart_grab, 4)
        elseif locals.get_int("fm_mission_controller", fm_mission_controller_cart_grab) == 4 then
            locals.set_float("fm_mission_controller", fm_mission_controller_cart_grab + fm_mission_controller_cart_grab_speed, 2)
        end
    end
end)


-- Instant Money Loops - Pessi v2
local TransactionManager <const> = {};
TransactionManager.__index = TransactionManager

function TransactionManager:New()
    local self = setmetatable({}, TransactionManager);
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

local millLoop = Money:add_tab("Loops")
millLoop:add_text("Money Loop Options (SEVERELY RISKY!)")
local oneMillLoop = millLoop:add_checkbox("1M Loop")
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
millLoop:add_sameline()
local twofiveMillLoop = millLoop:add_checkbox("2.5M Loop")
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
millLoop:add_sameline()
local threeSixMillLoop = millLoop:add_checkbox("3.6M Loop")
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
millLoop:add_sameline()
local sevenMillLoop = millLoop:add_checkbox("7M Loop")
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
millLoop:add_sameline()
local fifteenMillLoop = millLoop:add_checkbox("15M Loop")
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
millLoop:add_separator()
millLoop:add_text("Money loops are SEVERELY risky, If you overdo them, you WILL GET BANNED!")

-- Griefing Drop Vehicles on Players
local grief = KAOS:add_tab("Grief Options")
grief:add_text("Kill Options")
local ramLoopz = grief:add_checkbox("Vehicle Ram (On/Off)")

script.register_looped("ramLoopz", function()
    if ramLoopz:is_enabled() then
        local player_id = network.get_selected_player()
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(player_id) then
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

            -- Get a random vehicle model from the list (make sure 'vehicleModels' is defined)
            local randomModel = vehicleModels[math.random(2, #vehicleModels)]

            -- Convert the string vehicle model to its hash value
            local modelHash = MISC.GET_HASH_KEY(randomModel)

            -- Create the vehicle without the last boolean argument (keepTrying)
            local vehicle = VEHICLE.CREATE_VEHICLE(modelHash, coords.x, coords.y, coords.z - 10, 0.0, true, false, true)

            if vehicle then
                -- Set the falling velocity (adjust the value as needed)
                ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 100000)
                -- Optionally, you can play a sound or customize the ramming effect here
            end

            gui.show_message("Grief", "Ramming " .. PLAYER.GET_PLAYER_NAME(player_id) .. " with vehicles")

            -- Use these lines to delete the vehicle after spawning. 
            -- Needs some type of delay between spawning and deleting to function properly
			sleep(0.1)
             ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
             VEHICLE.DELETE_VEHICLE(vehicle)
        end

        -- Sets the timer in seconds for how long this should pause before ramming another player
        --sleep(0.2)
    end
end)

-- Griefing Explode Player
grief:add_sameline()
local explodeLoop = false
explodeLoop = grief:add_checkbox("Explosion (On/Off)")

script.register_looped("explodeLoop", function()
    if explodeLoop:is_enabled() == true then
        local explosionType = 1  -- Adjust this according to the explosion type you want (1 = GRENADE, 2 = MOLOTOV, etc.)
        local explosionFx = "explosion_barrel"

                local player_id = network.get_selected_player()
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000.0, true, false, 0, false)
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)
				
				gui.show_message("Grief", "Exploding "..PLAYER.GET_PLAYER_NAME(player_id).." repeatedly")
                -- Optionally, you can play an explosion sound here using AUDIO.PLAY_SOUND_FROM_COORD

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before exploding another player
    end
end)

-- Griefing Burn Player
grief:add_sameline()
local burnLoop = false
burnLoop = grief:add_checkbox("Burn (On/Off)")

script.register_looped("burnLoop", function()
    if burnLoop:is_enabled() == true then
        local player_id = network.get_selected_player()
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
		local fxType = 3
		local ptfxAsset = "scr_bike_adversary"
		local particle = "scr_adversary_foot_flames"
		
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, fxType, 100000.0, false, false, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxAsset)
        GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD(particle, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)
        
        gui.show_message("Grief", "Burning "..PLAYER.GET_PLAYER_NAME(player_id).." repeatedly")

        -- Optionally, you can play a fire sound here using AUDIO.PLAY_SOUND_FROM_COORD

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before burning another player
    end
end)

-- Griefing Water Spray
grief:add_sameline()
local waterLoop = false
waterLoop = grief:add_checkbox("Water (On/Off)")

script.register_looped("waterLoop", function()
    if waterLoop:is_enabled() == true then
        local player_id = network.get_selected_player()
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
		local fxType = 13
		local ptfxAsset = "scr_sum_gy"
		local particle = "scr_sum_gy_exp_water_bomb"
		
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z - 1, fxType, 100000.0, false, false, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxAsset)
        GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD(particle, coords.x, coords.y, coords.z - 1, 0.0, 0.0, 0.0, 1.0, false, true, false)
        
        gui.show_message("Grief", "Drowning? "..PLAYER.GET_PLAYER_NAME(player_id))

        -- Optionally, you can play a fire sound here using AUDIO.PLAY_SOUND_FROM_COORD

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before burning another player
    end
end)

-- Figurine Crash
grief:add_separator()
grief:add_text("Crash Options")
local prCrash = false
prCrash = grief:add_checkbox("PR Crash (On/Off)")

script.register_looped("prCrash", function()
    if prCrash:is_enabled() == true then

        local model = joaat("vw_prop_vw_colle_prbubble")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = network.get_selected_player()
        local money_value = 1000000

        STREAMING.REQUEST_MODEL(model)

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("PR Crash", "Crashing player")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
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

            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
		sleep(0.1) -- Sets the timer in seconds for how long this should pause before sending another figure
    end
end)

grief:add_separator()
-- Griefing Sound Spam Targetable
grief:add_text("Sound Spams")
local sSpamAlarm = grief:add_checkbox("Alarm Spam") -- THIS DOES NOT TURN OFF EVEN WHEN UNTOGGLED, SEVERELY ANNOYING
script.register_looped("sSpamAlarm", function()
local targetPlayer = network.get_selected_player()
	if sSpamAlarm:is_enabled() then
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Warning_Alarm_Loop", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetPlayer), "DLC_H4_Submarine_Crush_Depth_Sounds", true, 0)
				gui.show_message("Sound Spam", "Alarm spamming "..targetPlayer)
	end
end)
grief:add_sameline()
local pSpamAlarm = grief:add_checkbox("Phone Spam") -- THIS DOES NOT TURN OFF EVEN WHEN UNTOGGLED, SEVERELY ANNOYING
script.register_looped("pSpamAlarm", function()
local targetPlayer = network.get_selected_player()
	if pSpamAlarm:is_enabled() then
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Remote_Ring", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetPlayer), "Phone_SoundSet_Michael", true, 0)
				gui.show_message("Sound Spam", "Phone spamming "..targetPlayer)
	end
end)

grief:add_text("Select a player from the list and activate.")

-- Object Spawner (Can be used negatively!) (Originally from Kuter Menu)

local Obje = KAOS:add_tab("Object Options")
local Objets = Obje:add_tab("Spawner")

local orientation = 0
local spawnDistance = { x = 0, y = 0, z = -1 }
local defaultOrientation = 0
local defaultSpawnDistance = { x = 0, y = 0, z = -1 }

-- Function to reset sliders to default values
local function resetSliders()
    orientation = defaultOrientation
    spawnDistance.x = defaultSpawnDistance.x
    spawnDistance.y = defaultSpawnDistance.y
    spawnDistance.z = defaultSpawnDistance.z
end

Objets:add_imgui(function()
    orientation, used = ImGui.SliderInt("Orientation", orientation, 0, 360)
end)

Objets:add_imgui(function()
    spawnDistance.x, used = ImGui.SliderFloat("Spawn Distance X", spawnDistance.x, -25, 25)
    spawnDistance.y, used = ImGui.SliderFloat("Spawn Distance Y", spawnDistance.y, -25, 25)
    spawnDistance.z, used = ImGui.SliderFloat("Spawn Distance Z", spawnDistance.z, -25, 25)
end)

-- Save default values
defaultOrientation = orientation
defaultSpawnDistance.x = spawnDistance.x
defaultSpawnDistance.y = spawnDistance.y
defaultSpawnDistance.z = spawnDistance.z

-- Reset Sliders button
Objets:add_button("Reset Sliders", function()
    resetSliders()
end)

Objets:add_separator()
-- Objects hashes/names, add to this list to have more objects in your listbox on YimMenu
local adultesItems = {

	{ hash = 0xD51B7D9C, nom = "Select an object" },
	{ hash = 0x4F7B518F, nom = "Dildo 1" },
    { hash = 0xE6CB661E, nom = "Dildo 2" },
    { hash = 0xE6CB661E, nom = "Dildo 3" },
    { hash = 0x4B09A48A, nom = "Porn Magazine 1" },
    { hash = 0x902961BC, nom = "Porn Magazine 2" },
    { hash = 0xC512CB8E, nom = "Porn Magazine 3" },
    { hash = 0x1D5B492E, nom = "Porn Magazine 4" },
    { hash = 0xA0680239, nom = "Porn Magazine 5" },
    { hash = 0x2F84ED81, nom = "Porn Magazine 6" },
    { hash = 0xB6D12F0B, nom = "Porn Magazine 7" },
    { hash = 0x4601A2B7, nom = "Condom" },
	{ hash = 0x62766E18, nom = "Pharm Unit" },
	{ hash = 0x16A2C165, nom = "Pills Bottle" },
	{ hash = 0xD2E94182, nom = "Pills Bottle 2" },
	{ hash = 0xE1A9E2D1, nom = "Médical Crate" },
	{ hash = 0xBCB3AAA5, nom = "Médical Crate 2" },
	{ hash = 0x788321D3, nom = "Weed Bottle" },
	{ hash = 0x53B2A941, nom = "LSD Bottle" },
	{ hash = 0x13DA7EAA, nom = "Médical Bottles" },
	{ hash = 0x746ACBAF, nom = "Desk Lamp" },
	{ hash = 0x4F605192, nom = "Médical Trolley/Chariot Médical" },
	{ hash = 0x7650E782, nom = "Scalpel" },
	{ hash = 0xBEF2C429, nom = "Médical Bed/Lit Médical" },
	{ hash = 0x80710E61, nom = "First Aid Kit" },
	{ hash = 0xF43C5A15, nom = "Exam Light" },
	{ hash = 0x4AECE1A5, nom = "Oscillator/Oscillateur" },
	{ hash = 0xAEB6C823, nom = "Prop Beach Bag" },
	{ hash = 0x5213D35, nom = "Stunt Tube X" }, -- Semi-Toxic / Can be used to cage players, set to Z:-3 to spawn safely.
	{ hash = 0x64E33712, nom = "Dog Cage (Closed)" },
	{ hash = 0x26F2E2E6, nom = "Gas Tank Cage (destroyed)" }, -- Toxic / Can be used to cage players
	{ hash = 0xAF9E03CD, nom = "Gas Tank Cage" }, 
	{ hash = 0x8EB05D67, nom = "Casino Wheel" },
	{ hash = 0x33E46105, nom = "Potted Weed Plant" },
	{ hash = 0x29CB0F3C, nom = "Body Armor Prop" },
	{ hash = 0xC0877175, nom = "Casino Chips Pile" },
	{ hash = 0x23DDE6DB, nom = "RP Space Ranger" },
	{ hash = 0xCE64EF0B, nom = "Crate" },
	{ hash = 0x1282769, nom = "Electrical Box" },
	{ hash = 0x34312619, nom = "Container" }, -- Toxic / Can be used to cage players
	{ hash = 0x392D62AA, nom = "Gold Cage" }, -- Toxic / Can be used to cage players / Cannot be deleted with Yim's Delete Gun
	{ hash = 0x6F2FD125, nom = "Casino HR Roulette Table" },
	{ hash = 0x8E7B47A7, nom = "Mini Drone" },
	{ hash = 0x19AE1F4D, nom = "Mini Drone 2" },
	{ hash = 0x2DDA37E0, nom = "Money Laundering" }, -- Its an animated clothing dryer filled with money.. lol
	{ hash = 0xD6BF48A1, nom = "Tunnel Fan" }, -- Toxic / Can be used to cage players
	{ hash = 0x6B676D83, nom = "Oil Pump" },
	{ hash = 0x745F3383, nom = "Windmill" }, -- Z: -2 to place on ground.
	{ hash = 0x4D02ED6A, nom = "Stunt Ramp Spiral" }, -- Z: -1.25 for best placement
	{ hash = 0x69702115, nom = "Stunt Loop" }, -- Z: -1.5 for best placement
	{ hash = 0xB8F0B770, nom = "Breakable Glass" },
	{ hash = 0xDDA3E6D8, nom = "Crane Ladders" },
	{ hash = 0x6373EEF4, nom = "Stunt Jump XL" },
	
}

local selectedObjectIndex = 1 

Objets:add_text("Object Spawner")

local selectedObject = adultesItems[selectedObjectIndex].nom
Objets:add_imgui(function()
    local itemNames = {}
    for _, item in ipairs(adultesItems) do
        table.insert(itemNames, item.nom)
    end
    ImGui.PushItemWidth(500)
    selectedObjectIndex, used = ImGui.ListBox("", selectedObjectIndex, itemNames, #adultesItems)
    selectedObject = adultesItems[selectedObjectIndex].nom
    ImGui.PopItemWidth(-1)
end)

Objets:add_separator()

Objets:add_button("Spawn Selected", function()
    script.run_in_fiber(function()
		local selPlayer = network.get_selected_player()
        local targetPlayerPed = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        local playerName = PLAYER.GET_PLAYER_NAME(selPlayer)
        local playerPos = ENTITY.GET_ENTITY_COORDS(targetPlayerPed, false)

        playerPos.x = playerPos.x + spawnDistance.x
        playerPos.y = playerPos.y + spawnDistance.y
        playerPos.z = playerPos.z + spawnDistance.z

        selectedObjectIndex = selectedObjectIndex + 1
        if selectedObjectIndex > #adultesItems then
            selectedObjectIndex = 1 
        end

        local selectedObjectInfo = adultesItems[selectedObjectIndex]
        local heading = math.rad(orientation) 

        while not STREAMING.HAS_MODEL_LOADED(selectedObjectInfo.hash) do
            STREAMING.REQUEST_MODEL(selectedObjectInfo.hash)
            coroutine.yield()
        end

        local spawnedObject = OBJECT.CREATE_OBJECT(selectedObjectInfo.hash, playerPos.x, playerPos.y, playerPos.z, true, true, false)
        ENTITY.SET_ENTITY_HEADING(spawnedObject, heading)
        gui.show_message("Object Spawner", "Spawned object "..selectedObjectInfo.nom.." on "..playerName)
    end)
end)

-- Teleports tab
local Tel = Pla:add_tab("Teleports")

Tel:add_button("Teleport to Location", function()
    gui.show_message('Teleport to Location', 'Failed! Feature unavailable.')
end)

-- Vehicle Options Tab
local Veh = KAOS:add_tab("Vehicle Options")

-- Sub-tab for Vehicle Options

local Spa = Veh:add_tab("Spawn/Delete")

Spa:add_button("Spawn Vehicle", function()
    gui.show_message('Spawn Vehicle', 'Failed! Feature unavailable.')
end)
Spa:add_sameline()
Spa:add_button("Delete Vehicle", function()
    gui.show_message('Delete Vehicle', 'Failed! Feature unavailable.')
end)
Spa:add_button("Clone Vehicle", function()
    gui.show_message('Clone Vehicle', 'Failed! Feature unavailable.')
end)
Spa:add_sameline()
Spa:add_button("Save Vehicle", function()
    gui.show_message('Save Vehicle', 'Failed! Feature unavailable.')
end)

-- Vehicle Gifting
function RequestControl(entity)
    local tick = 0
 
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
 
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, true)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 50 do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        tick = tick + 1
    end
 
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end
 
function giftVehToPlayer(vehicle, playerId, playerName)
    if RequestControl(vehicle) then
        local netHash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(playerId)
 
        DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 3)
        DECORATOR.DECOR_SET_INT(vehicle, "Previous_Owner", 3)
        DECORATOR.DECOR_SET_INT(vehicle, "Veh_Modded_By_Player", netHash)
        DECORATOR.DECOR_SET_INT(vehicle, "Not_Allow_As_Saved_Veh", 0)
        DECORATOR.DECOR_SET_INT(vehicle, "Player_Vehicle", netHash)
 
        gui.show_message("Gift Vehicle Success", "Gifted "..vehicle.." to "..playerName..":"..netHash..":"..playerId)
    else
        gui.show_message("Gift Vehicle Failure", "Failed to gain control of the vehicle")
    end
end
 
-- Assuming gui provides a 'show_message' method
local Gif = Veh:add_tab("Gifting")
 
-- Assuming gui provides a 'add_button' method
Gif:add_button("Gift Vehicle", function()
    local selectedPlayer = network.get_selected_player()
 
    -- Check if a player is selected
    local targetPlayerPed = PLAYER.GET_PLAYER_PED(selectedPlayer)
    local playerName = PLAYER.GET_PLAYER_NAME(selectedPlayer)
 
    if PED.IS_PED_IN_ANY_VEHICLE(targetPlayerPed, true) then
        local targetVehicle = PED.GET_VEHICLE_PED_IS_IN(targetPlayerPed, true)
        giftVehToPlayer(targetVehicle, selectedPlayer, playerName)
    end 
end)
 
Gif:add_button("Get Vehicle Stats", function()
	local selectedPlayer = network.get_selected_player()
	local targetPlayerPed = PLAYER.GET_PLAYER_PED(selectedPlayer)
 
	if PED.IS_PED_IN_ANY_VEHICLE(targetPlayerPed, true) then
		last_veh = PED.GET_VEHICLE_PED_IS_IN(targetPlayerPed, true)
	end 
 
 
	if last_veh  then 
		local playerName = PLAYER.GET_PLAYER_NAME(selectedPlayer)
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

Gif:add_button("Spawn Vehicle", function()
    -- Assuming vehicleModels is a valid array of vehicle model names
    local randomModel = vehicleModels[math.random(1, #vehicleModels)]
    
    -- Get the player's ID
    local player_id = network.get_selected_player()
    
    -- Get the player's coordinates
    local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
    
    -- Convert the string vehicle model to its hash value
    local modelHash = MISC.GET_HASH_KEY(randomModel)

    -- Create the vehicle
    local vehicle = VEHICLE.CREATE_VEHICLE(modelHash, coords.x + 5, coords.y, coords.z, 0.0, true, true, true)

    -- Check if the vehicle creation was successful
    if vehicle ~= 0 then
        gui.show_message("Vehicle Spawner", "Vehicle spawned successfully!")
    else
        gui.show_message("Vehicle Spawner", "Failed to spawn vehicle.")
    end
end)

-- Upgrade Options
local Upg = Veh:add_tab("Upgrades")

Upg:add_button("Apply Benny's Wheels", function()
    gui.show_message('1 Click Bennys', 'Failed! Feature unavailable.')
end)
Upg:add_sameline()
Upg:add_button("Apply Formula 1 Wheels", function()
    gui.show_message('1 Click F1s', 'Failed! Feature unavailable.')
end)
Upg:add_button("Downgrade Vehicle", function()
    gui.show_message('Downgrade Vehicle', 'Failed! Feature unavailable.')
end)
Upg:add_button("Max Vehicle Performance", function()
    gui.show_message('Max Performance', 'Failed! Feature unavailable.')
end)
Upg:add_sameline()
Upg:add_button("Max Vehicle Modifications", function()
    gui.show_message('Max Upgrades', 'Failed! Feature unavailable.')
end)

-- Global Player Options

local Global = KAOS:add_tab("Global")

-- Global RP Loop Options
local PRGBGLoop = false
Global:add_text("Global RP Options")
rpLoop = Global:add_checkbox("Drop Global RP (On/Off)")

        script.register_looped("PRGBGLoop", function()
		if rpLoop:is_enabled() == true then
            local model = joaat("vw_prop_vw_colle_prbubble")
            local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
            local money_value = 0
			gui.show_message("WARNING", "15 or more players may cause lag or RP to not drop.")
            STREAMING.REQUEST_MODEL(model)
            while STREAMING.HAS_MODEL_LOADED(model) == false do
                sleep(1)
            end
		
            if STREAMING.HAS_MODEL_LOADED(model) then
                local localPlayerId = PLAYER.PLAYER_ID()
                local player_count = PLAYER.GET_NUMBER_OF_PLAYERS() - 1 -- Minus 1 player (yourself) from the drop count.
                gui.show_message("Global", "Dropping figurines to ".. player_count.." Players in the session.")

                for i = 0, 32 do
                    if i ~= localPlayerId then
                        local player_id = i
						
                        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                        local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                            pickup,
                            coords.x - 0,
                            coords.y + 0,
                            coords.z + 1,
                            3,
                            money_value,
                            model,
                            true,
                            false
                        )

						local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
						NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
                    end
                end
            end
			sleep(0.4) -- Sets the timer in seconds for how long this should pause before sending another figure
		end
        end)
Global:add_sameline()		
local moneyLoop = Global:add_checkbox("Give Global Money (On/Off)")

script.register_looped("moneyLoop", function()
    if moneyLoop:is_enabled() then
        local localPlayerId = network.get_selected_player() -- Assuming you have a function like this to get the player ID
        local model = joaat("prop_cash_pile_01")
            local pickup = joaat("PICKUP_MONEY_VARIABLE")
            local money_value = 100
			gui.show_message("WARNING", "15 or more players may cause lag or RP to not drop.")
            STREAMING.REQUEST_MODEL(model)
            while STREAMING.HAS_MODEL_LOADED(model) == false do
                sleep(1)
            end
		
            if STREAMING.HAS_MODEL_LOADED(model) then
                local localPlayerId = PLAYER.PLAYER_ID()
                local player_count = PLAYER.GET_NUMBER_OF_PLAYERS() - 1 -- Minus 1 player (yourself) from the drop count.
                gui.show_message("Global", "Dropping money to ".. player_count.." Players in the session.")

                for i = 0, 32 do
                    if i ~= localPlayerId then
                        local player_id = i
						
                        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                        local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                            pickup,
                            coords.x - 0,
                            coords.y + 0,
                            coords.z + 1,
                            3,
                            money_value,
                            model,
                            true,
                            false
                        )

						local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
						NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
                    end
                end
            end
			sleep(0.4) -- Sets the timer in seconds for how long this should pause before sending another figure
    end
    sleep(0.4) -- Sets the timer in seconds for how long this should pause
end)


-- Global Sound Spam Options
Global:add_separator()
Global:add_text("Global Sound Options")
local sSpam = Global:add_checkbox("Jet Spam")
script.register_looped("soundSpamLoop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Jet_Explosions", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "exile_1", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam2 = Global:add_checkbox("Pickup Spam")
script.register_looped("soundSpam2Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam2:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "PICKUP_DEFAULT", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "HUD_FRONTEND_STANDARD_PICKUPS_SOUNDSET", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam3 = Global:add_checkbox("Phone Spam") -- THIS DOES NOT TURN OFF EVEN WHEN UNTOGGLED, SEVERELY ANNOYING
script.register_looped("soundSpam3Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam3:is_enabled() then
	gui.show_message("Phonecall Spam", "This sound cannot be toggled off once its on.  The only way to stop it is to exit the game")
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Remote_Ring", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "Phone_SoundSet_Michael", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam4 = Global:add_checkbox("Wasted Spam")
script.register_looped("soundSpam4Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam4:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "ScreenFlash", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "WastedSounds", true, 0)
			end
		end
	end
end)
local sSpam5 = Global:add_checkbox("Bodies Spam")
script.register_looped("soundSpam5Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam5:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Architect_Fall", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "FBI_HEIST_SOUNDSET", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam6 = Global:add_checkbox("Yacht Spam")
script.register_looped("soundSpam6Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam6:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "HORN", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "DLC_Apt_Yacht_Ambient_Soundset", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam7 = Global:add_checkbox("Whistle Spam")
script.register_looped("soundSpam7Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam7:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Franklin_Whistle_For_Chop", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "SPEECH_RELATED_SOUNDS", true, 0)
			end
		end
	end
end)
Global:add_sameline()
local sSpam8 = Global:add_checkbox("Alarm Spam") -- THIS DOES NOT TURN OFF EVEN WHEN UNTOGGLED, SEVERELY ANNOYING
script.register_looped("soundSpam8Loop", function()
local localPlayerId = PLAYER.PLAYER_ID()
	if sSpam8:is_enabled() then
		for i = 0, 32 do
			if i ~= localPlayerId then
                local player_id = i
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Warning_Alarm_Loop", PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), "DLC_H4_Submarine_Crush_Depth_Sounds", true, 0)
			end
		end
	end
end)

-- Global Particle Effects

Global:add_separator()
Global:add_text("PTFX")
local fireworkLoop = Global:add_checkbox("Fireworks (On/Off)")

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
            local localPlayerId = PLAYER.PLAYER_ID()
			for i = 0, 32 do
				if i ~= localPlayerId then
					local player_id = i
					local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

					-- Get random color values
					local colorR, colorG, colorB = random_color()
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
					GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_firework_indep_burst_rwb", player_coords.x, player_coords.y, setExp2, 0, 0, 0, math.random(1, 5), false, false, false, false)
				end
			end
		end
    end
end)
Global:add_sameline()
local flameLoopGlobal = Global:add_checkbox("Flames (On/Off)")
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
            local localPlayerId = PLAYER.PLAYER_ID()
			for i = 0, 32 do
				if i ~= localPlayerId then
					local player_id = i
					local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

					-- Get random color values
					local colorR, colorG, colorB = random_color()
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

Global:add_sameline()
local lightningLoopGlobal = Global:add_checkbox("Lightning (On/Off)")
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
            local localPlayerId = PLAYER.PLAYER_ID()
			for i = 0, 32 do
				if i ~= localPlayerId then
					local player_id = i
					local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

					-- Get random color values
					local colorR, colorG, colorB = random_color()
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

Global:add_sameline()
local snowLoopGlobal = Global:add_checkbox("Snow (On/Off)")
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
            local localPlayerId = PLAYER.PLAYER_ID()
			for i = 0, 32 do
				if i ~= localPlayerId then
					local player_id = i
					local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)

					-- Get random color values
					local colorR, colorG, colorB = random_color()
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

-- Global Explode
Global:add_separator()
local explosionLoop = false
Global:add_text("Toxic Options")
explosionLoop = Global:add_checkbox("Explosion (On/Off)")

script.register_looped("explosionLoop", function()
    if explosionLoop:is_enabled() == true then
        local explosionType = 1  -- Adjust this according to the explosion type you want (1 = GRENADE, 2 = MOLOTOV, etc.)
        local explosionFx = "explosion_barrel"
        local localPlayerId = PLAYER.PLAYER_ID()

        gui.show_message("Global", "Exploding all other players in the session.")

        for i = 0, 32 do
            if i ~= localPlayerId then
                local player_id = i
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
                
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000.0, true, false, 0, false)
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx)
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, true, false)

                -- Optionally, you can play an explosion sound here using AUDIO.PLAY_SOUND_FROM_COORD
            end
        end

        sleep(0.4)  -- Sets the timer in seconds for how long this should pause before exploding another player
    end
end)

-- Global Weapons
Global:add_separator()
Global:add_text("Global Weapons Options")
Global:add_button("Give All Weapons to Players", function()
    local player_count = PLAYER.GET_NUMBER_OF_PLAYERS()

    for i = 0, player_count - 1 do
        local playerID = i
        local ent = PLAYER.GET_PLAYER_PED(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                local weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, 9999, false, true)
            end
        end
    end

    gui.show_message("Global", "Successfully given all weapons to all players")
end)
Global:add_sameline()
Global:add_button("Remove All Weapons from Players", function()
    local player_count = PLAYER.GET_NUMBER_OF_PLAYERS()

    for i = 0, player_count - 1 do
        local playerID = i
        local ent = PLAYER.GET_PLAYER_PED(playerID)
        if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
            for _, name in ipairs(weaponNamesString) do
                local weaponHash = MISC.GET_HASH_KEY(name)
                WEAPON.REMOVE_WEAPON_FROM_PED(ent, weaponHash)
            end
        end
    end

    gui.show_message("Global", "Successfully removed all weapons from all players")
end)

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

local Weapons = KAOS:add_tab("Weapons")

Weapons:add_button("Remove All Weapons", function()
		local playerID = PLAYER.PLAYER_ID()
		local ent = PLAYER.GET_PLAYER_PED(playerID)
		out = "Successfully removed all weapons"
		if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
			for _, name in ipairs(weaponNamesString) do
				local weaponHash = MISC.GET_HASH_KEY(name)
				WEAPON.REMOVE_WEAPON_FROM_PED(ent, weaponHash)
				gui.show_message('Weapons', out)
				
			end
		end
end)
Weapons:add_sameline()
Weapons:add_button("Give All Weapons", function()
		local playerID = PLAYER.PLAYER_ID()
		local ent = PLAYER.GET_PLAYER_PED(playerID)
		out = "Successfully given all weapons"
		if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
			for _, name in ipairs(weaponNamesString) do
				local weaponHash = MISC.GET_HASH_KEY(name)
				WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, 9999, false, true)
				gui.show_message('Weapons', out)
				
			end
		end
end)

Weapons:add_tab("Drops")
Weapons:add_separator()
Weapons:add_text("Weapon Drops")
Weapons:add_button("Drop Random Weapon", function()
    mk2Loop = not mk2Loop

    script.register_looped("mk2Loop", function(script)
        local weaponName = weaponNamesString[math.random(1, #weaponNamesString)]
        local money_value = 0
        local player_id = network.get_selected_player()
		local model = weaponModels[math.random(1, #weaponModels)]

        local modelHash = joaat(model)
        STREAMING.REQUEST_MODEL(modelHash)
        while STREAMING.HAS_MODEL_LOADED(modelHash) == false do
            script:yield()
        end
        if STREAMING.HAS_MODEL_LOADED(modelHash) then
            gui.show_message("Weapon Drop Started", "Dropping " .. weaponName)
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
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

            local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
        end
    end)
end)
Weapons:add_separator()
Weapons:add_text("To use the Random Weapon Dropper, Select a player from the player list")
Weapons:add_text("then press Drop Random Weapon, you can press it as many times as you want")
Weapons:add_text("it will drop weapon pickups on the player you selected")


-- Business Management
local Business = KAOS:add_tab("Business Manager")
local Hangar = Business:add_tab("Hangar")


hStock = Hangar:add_checkbox("Resupply Hangar Cargo (Looped)")
script.register_looped("autoGetHangarCargo", function(script)
	script:yield()
	if hStock:is_enabled() == true then
		autoGetHangarCargo = not autoGetHangarCargo
		if autoGetHangarCargo then
			globals.set_int(1882413+7, 6) -- remove this to get crates, its set to narcotics.
			stats.set_packed_stat_bool(36828, true) 
			gui.show_message("Business Manager", "Restocking cargo, please wait...")
		end
	end
end)

-- Nightclub Loop - L7Neg
local Club = Business:add_tab("Nightclub")

MPX = PI
PI = stats.get_int("MPPLY_LAST_MP_CHAR")
if PI == 0 then
	MPX = "MP0_"
else
	MPX = "MP1_"
end

nClub = Club:add_checkbox("Enable Nightclub $250k/15s (Safe AFK)")
script.register_looped("nightclubloop", function(script)
	script:yield()
	if nClub:is_enabled() == true then
		gui.show_message("Business Manager", "Supplying 50k/s to Nightclub Safe")
		STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true)
		STATS.STAT_SET_INT(joaat(MPX .. "CLUB_PAY_TIME_LEFT"), -1, true)
		sleep(2.5)
	end
end)
Club:add_separator()
Club:add_button("Max Club Popularity", function()
	STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true)
end)

-- YimCEO -- Alestarov_Menu
local yimCEO = Business:add_tab("YimCEO")

cratevalue = 10000
yimCEO:add_imgui(function()
    cratevalue, used = ImGui.SliderInt("Crate Value", cratevalue, 10000, 5000000)
    if used then
        globals.set_int(262145 + 15991, cratevalue)
    end
end)

yCEO = yimCEO:add_checkbox("Enable YimCeo")

yimCEO:add_button("Show computer", function()
    SCRIPT.REQUEST_SCRIPT("apparcadebusinesshub")
    SYSTEM.START_NEW_SCRIPT("apparcadebusinesshub", 8344)
end)

script.register_looped("yimceoloop", function(script)
    cratevalue = globals.get_int(262145 + 15991)
    globals.set_int(262145 + 15756, 0)
    globals.set_int(262145 + 15757, 0)
    script:yield()

    while true do
        script:sleep(1000)  -- Adjust the sleep duration as needed

        if yCEO:is_enabled() == true then
		gui.show_message("YimCEO Enabled!", "Enjoy the bank roll!")
            if locals.get_int("gb_contraband_sell", 2) == 1 then
                locals.set_int("gb_contraband_sell", 543 + 595, 1)
                locals.set_int("gb_contraband_sell", 543 + 55, 0)
                locals.set_int("gb_contraband_sell", 543 + 584, 0)
                locals.set_int("gb_contraband_sell", 543 + 7, 7)
                script:sleep(500)
                locals.set_int("gb_contraband_sell", 543 + 1, 99999)
            end

            if locals.get_int("appsecuroserv", 2) == 1 then
                script:sleep(500)
                locals.set_int("appsecuroserv", 740, 1)
                script:sleep(200)
                locals.set_int("appsecuroserv", 739, 1)
                script:sleep(200)
                locals.set_int("appsecuroserv", 558, 3012)
                script:sleep(1000)
            end

            if locals.get_int("gb_contraband_buy", 2) == 1 then
                locals.set_int("gb_contraband_buy", 601 + 5, 1)
                locals.set_int("gb_contraband_buy", 601 + 1, 111)
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

-- Casino Heist Editor - converted from L7Negs Ultimate Menu for Kiddions and some features like remove CCTV from Alestarov.

--Required Stats--

FMC2020 = "fm_mission_controller_2020"
HIP = "heist_island_planning"

-- Editor Stuff
local heisteEditor = KAOS:add_tab("Heist Editor")
local cayoHeist = heisteEditor:add_tab("Cayo Perico Editor")

cayoHeist:add_text("Non-Legit Presets")

cayoHeist:add_button("Panther/Gold (Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 1191817, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Panther Hard Mode has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)
cayoHeist:add_sameline()
cayoHeist:add_button("Diamond/Gold (Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 3, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 1191817, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Diamond Hard Mode has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Bonds/Gold (Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 2, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 1191817, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Bonds Hard Mode has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Necklace/Gold (Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 1191817, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Necklace Hard Mode has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Tequila/Gold (Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 1191817, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Tequila Hard Mode has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)
cayoHeist:add_separator()
cayoHeist:add_text("Legit Presets")

cayoHeist:add_button("Panther/Gold (L. Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 5, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
		-- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		
		-- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
		
		-- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
		
		-- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 45375, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_V"), 10406, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), 16875, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), 25312, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), 22500, true)
		globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
		--globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
		--globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
		--globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
		--globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
		
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Panther Hard Mode (Legit) has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Diamond/Gold (L. Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 3, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
		-- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		
		-- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
		
		-- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
		
		-- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 45375, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_V"), 10406, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), 16875, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), 25312, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), 22500, true)
		--globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
		globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
		--globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
		--globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
		--globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
		
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Diamond Hard Mode (Legit) has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Bonds/Gold (L. Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 2, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
		-- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		
		-- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
		
		-- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
		
		-- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 45375, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_V"), 10406, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), 16875, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), 25312, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), 22500, true)
		--globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
		--globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
		globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
		--globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
		--globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
		
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Bonds Hard Mode (Legit) has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Necklace/Gold (L. Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 1, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
		-- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		
		-- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
		
		-- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
		
		-- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 45375, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_V"), 10406, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), 16875, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), 25312, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), 22500, true)
		--globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
		--globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
		--globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
		globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
		--globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
		
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
	gui.show_message("Cayo Heist", "Necklace Hard Mode (Legit) has been set up!")
	gui.show_message("Cayo Heist", "Reset the board to see the changes")
end)

cayoHeist:add_sameline()

cayoHeist:add_button("Tequila/Gold (L. Hard)", function()
	PlayerIndex = globals.get_int(1574918)
	if PlayerIndex == 0 then
		mpx = "MP0_"
	else
		mpx = "MP1_"
	end
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_GEN"), 131071, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ENTR"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_BS_ABIL"), 63, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEAPONS"), 5, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_WEP_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_ARM_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_HEL_DISRP"), 3, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TARGET"), 0, true) --Primary Target Values: 0. Tequila, 1. Necklace, 2. Bonds, 3. Diamond, 4. Medrazo Files, 5. Panther
		STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_TROJAN"), 2, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4CNF_APPROACH"), -1, true)
		-- Island Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I"), 0, true)
		
		-- Compound Loot // -1 shows all, 0 shows none
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C"), -1, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PROGRESS"), 131055, true) -- 131055 // Hard Mode  -  130667 // Solo Normal??
		
		-- These are what is set when you find loot throughout the island/compound
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_C_SCOPED"), 0, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_C_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_I_SCOPED"), 0, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_C_SCOPED"), -1, true)
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_SCOPED"), 0, true)
		
		-- Payout Values // Set to "Normal" values.  Each value is multiplied by 8, bc there are 8 locations for them.
		STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), 45375, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_CASH_V"), 10406, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), 16875, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), 25312, true)
		--STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), 22500, true)
		--globals.set_int(262145 + 30264, 1900000) -- Panther Value -- 1900000 shows as 2,090,000 in-game on the board. 190,000 difference.
		--globals.set_int(262145 + 30262, 1300000) -- Diamond Value  -- 1300000 shows as 1,430,000 in-game. 130,000 difference.
		--globals.set_int(262145 + 30261, 770000) -- Bonds Value -- 770000 shows as 847,000 in-game.  77,000 difference.
		--globals.set_int(262145 + 30260, 700000) -- Necklace Value -- 700000 shows as 770,000 in-game. 70,000 difference.
		globals.set_int(262145 + 30259, 693000) -- Tequila Value -- 630000 shows as 693,000. 63,000 difference.
		
        STATS.STAT_SET_INT(joaat(mpx .. "H4_MISSIONS"), 65535, true)
        STATS.STAT_SET_INT(joaat(mpx .. "H4_PLAYTHROUGH_STATUS"), 32, true)
	
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
    locals.set_float(FMC2020, 30357 + 3, 100.0)
	gui.show_message("Cayo Heist", "Bypassed Plasma Cutter")
end)

cayoHeist:add_sameline()
cayoHeist:add_button("Remove All CCTV's", function()
	for _, ent in pairs(entities.get_all_objects_as_handles()) do
		for __, cam in pairs(CamList) do
			if ENTITY.GET_ENTITY_MODEL(ent) == cam then
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)
				ENTITY.DELETE_ENTITY(ent)
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
		local model = ENTITY.GET_ENTITY_MODEL(ped)
		if model == 0x7ED5AD78 or model == 0x6C8C08E5 or model == 0x995B3F9F or model == 0xB881AEE then 
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, true)
				PED.DELETE_PED(ped)
		end
	end
end)

cayoHeist:add_separator()
cayoHeist:add_text("After Heist")
cayoHeist:add_button("Skip Cooldown", function()
	-- Solo Skip
	STATS.STAT_SET_INT(joaat("MP0_H4_TARGET_POSIX"), 1659643454, true)
	STATS.STAT_SET_INT(joaat("MP0_H4_COOLDOWN"), 0, true)
	STATS.STAT_SET_INT(joaat("MP0_H4_COOLDOWN_HARD"), 0, true)
	-- Multiplayer Skip
	STATS.STAT_SET_INT(joaat("MP0_H4_TARGET_POSIX"), 1659429119, true)
	STATS.STAT_SET_INT(joaat("MP0_H4_COOLDOWN"), 0, true)
	STATS.STAT_SET_INT(joaat("MP0_H4_COOLDOWN_HARD"), 0, true)
	-- Solo Skip (Second Character)
	STATS.STAT_SET_INT(joaat("MP1_H4_TARGET_POSIX"), 1659643454, true)
	STATS.STAT_SET_INT(joaat("MP1_H4_COOLDOWN"), 0, true)
	STATS.STAT_SET_INT(joaat("MP1_H4_COOLDOWN_HARD"), 0, true)
	-- Multiplayer Skip (Second Character)
	STATS.STAT_SET_INT(joaat("MP1_H4_TARGET_POSIX"), 1659429119, true)
	STATS.STAT_SET_INT(joaat("MP1_H4_COOLDOWN"), 0, true)
	STATS.STAT_SET_INT(joaat("MP1_H4_COOLDOWN_HARD"), 0, true)
	
	gui.show_message("Cayo Heist", "Skipped Cayo Perico Cooldown for all characters")
	gui.show_message("Cayo Heist", "Go to story mode and come back to apply the reset")
end)
cayoHeist:add_separator()
cayoHeist:add_text("How to Set Up or Bypass Cooldown:")
cayoHeist:add_text("Make sure you have completed the heist and you are standing in front of the planning screen")
cayoHeist:add_text("Click Skip Cooldown, then click on your Preset and click Reset Kosatka Board")

-- Cayo Bag Size & Value Editor
local cayoSizeEditor = cayoHeist:add_tab("Size/Value Editor")
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
		PlayerIndex = globals.get_int(1574918)
		if PlayerIndex == 0 then
			mpx = "MP0_"
		else
			mpx = "MP1_"
		end
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_GOLD_V"), goldSizeVal, true)
		gui.show_message('Gold Value Modified!', out)
    end
end)

cokeSizeVal = 25312
cayoSizeEditor:add_imgui(function()
cokeSizeVal, used = ImGui.SliderInt("Coke Value", cokeSizeVal, 25312, 101248) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
		PlayerIndex = globals.get_int(1574918)
		if PlayerIndex == 0 then
			mpx = "MP0_"
		else
			mpx = "MP1_"
		end
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_COKE_V"), cokeSizeVal, true)
		gui.show_message('Coke Value Modified!', out)
    end
end)

paintSizeVal = 22500
cayoSizeEditor:add_imgui(function()
paintSizeVal, used = ImGui.SliderInt("Paintings Value", paintSizeVal, 22500, 90000) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
		PlayerIndex = globals.get_int(1574918)
		if PlayerIndex == 0 then
			mpx = "MP0_"
		else
			mpx = "MP1_"
		end
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_PAINT_V"), paintSizeVal, true)
		gui.show_message('Paintings Value Modified!', out)
    end
end)

weedSizeVal = 16875
cayoSizeEditor:add_imgui(function()
weedSizeVal, used = ImGui.SliderInt("Weed Value", weedSizeVal, 16875, 67500) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
		PlayerIndex = globals.get_int(1574918)
		if PlayerIndex == 0 then
			mpx = "MP0_"
		else
			mpx = "MP1_"
		end
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), weedSizeVal, true)
		gui.show_message('Weed Value Modified!', out)
    end
end)

cashSizeVal = 10406
cayoSizeEditor:add_imgui(function()
cashSizeVal, used = ImGui.SliderInt("Cash Value", cashSizeVal, 10406, 41624) -- Quadruple the original price
    out = "Reset the board to see changes"
    
    if used then
		PlayerIndex = globals.get_int(1574918)
		if PlayerIndex == 0 then
			mpx = "MP0_"
		else
			mpx = "MP1_"
		end
        STATS.STAT_SET_INT(joaat(mpx .. "H4LOOT_WEED_V"), cashSizeVal, true)
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
