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
    "weapon_fireextinguisher", "weapon_parachute", "weapon_hazardcan", "weapon_militaryrifle",
    "weapon_combatshotgun", "weapon_gadgetpistol", "WEAPON_SNOWLAUNCHER", "WEAPON_BATTLERIFLE", 
	"WEAPON_TECPISTOL", "WEAPON_CANDYCANE", "WEAPON_PISTOLXM3", "WEAPON_RAILGUNXM3", "WEAPON_PRECISIONRIFLE", 
	"WEAPON_TACTICALRIFLE", "WEAPON_EMPLAUNCHER", "WEAPON_HEAVYRIFLE"
}

-- Extras Menu Addon for YimMenu 1.68 by DeadlineEm
local KAOS = gui.get_tab("Extras")
createText(KAOS, "Welcome to the Extras menu, please read the information below before proceeding to use the menu options.")
createText(KAOS, "These options are considered Recovery based options, use them at your own risk!")
createText(KAOS, "YimMenu or Extras Addon does not take responsibility for bans from using these features.")

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


-- Health Tab
local Hel = Pla:add_tab("Health")

Hel:add_button("Heal Player", function()
    gui.show_message('Health Modifier', 'Failed! Feature unavailable.')
end)


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
        local player_id = PLAYER.PLAYER_ID()
        local money_value = 5

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("RP/Cash Drop Started", "Princess Robot Bubblegum Drops inbound!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
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

Drops:add_button("Alien (On/Off)", function()
   alienfigurineLoop = not alienfigurineLoop

    script.register_looped("alienfigurineLoop", function(script)
        local model = joaat("vw_prop_vw_colle_alien")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = PLAYER.PLAYER_ID()
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
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
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

Drops:add_button("Casino Cards (On/Off)", function()
   casinocardsLoop = not casinocardsLoop

    script.register_looped("casinocardsLoop", function(script)
        local model = joaat("vw_prop_vw_lux_card_01a")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = PLAYER.PLAYER_ID()
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
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
                3,
                money_value,
                model,
                true,
                false
            )
			local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
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

Drops:add_button("Cash Loop (On/Off)", function()
   kcashLoop = not kcashLoop

    script.register_looped("kcashLoop", function(script)
        local model = joaat("m23_2_prop_m32_cashwrapped_01a")
        local pickup = joaat("PICKUP_CUSTOM_SCRIPT")
        local player_id = PLAYER.PLAYER_ID()
        local money_value = 0

        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end

        if STREAMING.HAS_MODEL_LOADED(model) then
		gui.show_message("RP/Cash Drop Started", "Fake Cash Drops inbound!")
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
            local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(
                pickup,
                coords.x + 5,
                coords.y - 5,
                coords.z,
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
        if not kcashLoop then
            script.unregister_script("kcashLoop")
        end
    end)
end)

Drops:add_separator()
Drops:add_text("Cash loop is Fake, it gives nothing on pickup, future plans to get it working.");
Drops:add_text("You CAN run multiple at once (like Robot bubblegum/Alien)")
Drops:add_text("just make sure someone is collecting it or you can lag severely or freeze.");

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

-- Object Spawner (Can be used negatively!) (Originally from Kuter Menu)

local Obje = KAOS:add_tab("Object Options")
local Objets = Obje:add_tab("Spawner")


local orientation = 0
Objets:add_imgui(function()
orientation, used = ImGui.SliderInt("Orientation", orientation, 0, 360) -- Orientation does not seem to work to rotate items...
end)

local spawnDistance = { x = 0, y = 0, z = -1 } -- Z Axis set to -1, usually spawns items on the ground
Objets:add_imgui(function()
    spawnDistance.x, used = ImGui.SliderFloat("Spawn Distance X", spawnDistance.x, -10, 10)
    spawnDistance.y, used = ImGui.SliderFloat("Spawn Distance Y", spawnDistance.y, -10, 10) -- Sliders for X, Y, Z positions aka How far you want an item to spawn from someone
    spawnDistance.z, used = ImGui.SliderFloat("Spawn Distance Z", spawnDistance.z, -10, 10)
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
        local targetPlayerPed = PLAYER.GET_PLAYER_PED(network.get_selected_player())
		local playerName = PLAYER.GET_PLAYER_NAME(PLAYER.PLAYER_ID())
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

-- Gift Options
local Gif = Veh:add_tab("Gifting")

Gif:add_button("Gift Vehicle", function()
    gui.show_message('Gift Vehicle', 'Failed! Feature unavailable.')
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
local justRP = Global:add_checkbox("Give Global RP (On/Off)")

script.register_looped("justRPLoop", function()
    if justRP:is_enabled() then
        local localPlayerId = PLAYER.PLAYER_ID() -- Assuming you have a function like this to get the player ID
        local eventHash = 968269233

        for i = 0, 32 do
            if i ~= localPlayerId then
                for j = 0, 24 do
                    local targetPlayerId = 1 << i
                    local eventArgs = { eventHash, localPlayerId, targetPlayerId, 1, 1, 4, j, 1, 1, 1 }

                    -- Ensure localPlayerId is a number, not a table
                    if type(localPlayerId) == "number" then
						
						gui.show_message("Global", "Triggering Script Event")
						gui.show_message("WARNING", "Script in BETA and may not work yet!")
                        SCRIPT.TRIGGER_SCRIPT_EVENT(targetPlayerId, table.unpack(eventArgs))
                        eventArgs[6] = 8
                        eventArgs[7] = -5
                        SCRIPT.TRIGGER_SCRIPT_EVENT(targetPlayerId, table.unpack(eventArgs))
						gui.show_message("Global", "Script event triggered, restarting.")
                        sleep(0)
                    else
                        -- Handle the case where localPlayerId is not a number
                        gui.show_message("Global", "Invalid localPlayerId type")
                    end
                end
            end
        end
    end
    sleep(0.4) -- Sets the timer in seconds for how long this should pause
end)

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

-- Business Management
local Business = KAOS:add_tab("Business Manager")
local Hangar = Business:add_tab("Hangar")


hStock = Hangar:add_checkbox("Resupply Hangar Cargo (Looped)")
script.register_looped("autoGetHangarCargo", function(script)
	script:yield()
	if hStock:is_enabled() == true then
		autoGetHangarCargo = not autoGetHangarCargo
		if autoGetHangarCargo then
			globals.set_int(1882413+7, 6)
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
