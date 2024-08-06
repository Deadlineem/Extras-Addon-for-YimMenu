function mainInfo(tab)
	tab:add_imgui(function()
	ImGui.Text("Welcome to Extras Addon v"..version)
	textSeparator("", "About")
	ImGui.TextWrapped("This addon features extra tools for YimMenu that aren't already a part of the standalone base version.  It is created with community input in mind. Whether the features are Recovery, Toxic, or for Entertainment purposes, it's intended to have something for everyone.")
	ImGui.Text(""..caesar_decrypt(encodedTwo.." "..encoded, 3).."")
	
    ImGui.PushStyleColor(ImGuiCol.HeaderHovered, 1.0, 0.0, 0.0, 0.5)
    ImGui.PushStyleColor(ImGuiCol.HeaderActive, 1.0, 0.0, 0.0, 1.0)
	
		if (ImGui.TreeNode("Developer Credits")) then
		   ImGui.Text("DeadlineEm - Creator")
		   ImGui.Separator()
		   ImGui.Text("USBMenus & Samurai - Co-Creators")
		   ImGui.Separator()
		   ImGui.Text("Juniorkrz, V1RU513N - Contributors")
		   ImGui.TreePop()
		end
		toolTip("", "Credits to the creators/developers")
		
		if not hasUserAcceptedTerms and not declined then
		ImGui.OpenPopup("Terms & Conditions")
		end
		ImGui.PushStyleColor(ImGuiCol.ModalWindowDimBg, 1, 1, 1, 1)
		centerx, centery = GRAPHICS.GET_ACTUAL_SCREEN_RESOLUTION()
		--gui.show_message(center)
		ImGui.SetNextWindowPos(centerx/2, centery/2, ImGuiCond.Appearing, 0.5, 0.5)

		if (ImGui.BeginPopupModal("Terms & Conditions", ImGuiWindowFlags.AlwaysAutoResize)) then
			ImGui.Text("This script is provided free of charge and as open source software. \nIt is intended solely for educational purposes. \nThe creators and contributors of this script are not responsible for any bans or penalties that may result from its use. \nFurthermore, we are not affiliated with Rockstar Games in any way. \nUse this script at your own risk\n\n-The Dev Team")
			ImGui.Separator()
			ImGui.Text("By agreeing to the terms, you are agreeing to the following:\n\nYou will not sell this script for profit\nYou will not advertise this script as your own\nYou will not publish duplicates of this script without permission to do so.\n")
			ImGui.Separator()
			if (ImGui.Button("Accept", 120, 0)) then
				hasUserAcceptedTerms = true
				ImGui.CloseCurrentPopup()
			end
			ImGui.SetItemDefaultFocus()
			ImGui.SameLine()
			if (ImGui.Button("Decline", 120, 0)) then
				gui.show_message("ToS", "You must agree to the terms of use to use Extras Addon.")
			end
			ImGui.EndPopup()
		end
		ImGui.PopStyleColor()
	end)
end

function createTab(name)
-- Usage: myTab = createTab("tabLabel", "Tab Name")
	return gui.add_tab(name)
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

function textSeparator(tab, text)
	tp1 = math.random(0, 2147483647)
    tp2 = math.random(0, 2147483647)
	crx, cry = ImGui.GetContentRegionAvail()
    if type(tab) ~= "string" then
        tab:add_imgui(function()
			if ImGui.BeginChild("##textSeparator".. tp1, ImGui.GetFontSize(), ImGui.GetFontSize(), false, ImGuiWindowFlags.NoBackground) then
				ImGui.SetWindowFontScale(0.2)
				ImGui.Text("\n")
				ImGui.SetWindowFontScale(1)
				ImGui.Separator()
			end
			ImGui.EndChild()
			ImGui.SameLine()
			ImGui.Text(text)
			ImGui.SameLine()
			if ImGui.BeginChild("##textSeparator".. tp2, ImGui.GetContentRegionAvail(), ImGui.GetFontSize(), false, ImGuiWindowFlags.NoBackground) then
				ImGui.SetWindowFontScale(0.2)
				ImGui.Text("\n")
				ImGui.SetWindowFontScale(1)
				ImGui.Separator()
			end
			ImGui.EndChild()
		end)
    else
		if ImGui.BeginChild("##textSeparator".. tp1, ImGui.GetFontSize(), ImGui.GetFontSize(), false, ImGuiWindowFlags.NoBackground) then
			ImGui.SetWindowFontScale(0.2)
			ImGui.Text("\n")
			ImGui.SetWindowFontScale(1)
			ImGui.Separator()
		end
		ImGui.EndChild()
		ImGui.SameLine()
		ImGui.Text(text)
		ImGui.SameLine()
		if ImGui.BeginChild("##textSeparator".. tp2, ImGui.GetContentRegionAvail(), ImGui.GetFontSize(), false, ImGuiWindowFlags.NoBackground) then
			ImGui.SetWindowFontScale(0.2)
			ImGui.Text("\n")
			ImGui.SetWindowFontScale(1)
			ImGui.Separator()
		end
		ImGui.EndChild()
    end
end

function createButton(gui, name, command, buttonToolTip)
	gui:add_button(name, function()
		script.run_in_fiber(function(script)
			command()
			script:yield()
		end)
	end)
	toolTip(gui, buttonToolTip)
end

function createCheckbox(tag, gui, name, checkboxToolTip, command, timeout, addSlider, sliderName, sliderMin, sliderMax, sliderToolTip)
    local sliderVar = sliderMin
    local tag = gui:add_checkbox(name)
	
    script.register_looped(name, function(script)
        if tag:is_enabled() then
            command()
            if timeout ~= -1 then
                script:sleep(timeout)
            else
				script:yield()
			end
        end
    end)
	toolTip(gui, checkboxToolTip)
	
	if addSlider == true then
		resetCheckboxStyle(gui) -- reset the styling so the slider is normal.
			gui:add_imgui(function()
				if tag:is_enabled() then
					ImGui.SameLine()
					ImGui.SetNextItemWidth(ImGui.GetFontSize() * 10)
					sliderVar, _ = ImGui.SliderInt(sliderName, sliderVar, sliderMin, sliderMax)
					if sliderVar then
						returnVal = sliderVar
					end
				end
			end)
			toolTip(gui, sliderToolTip)
		return returnVal
	end
end

function applyCheckboxStyle(r, g, b, a, rounding, gui)
	gui:add_imgui(function()
		ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, rounding)
		ImGui.PushStyleColor(ImGuiCol.CheckMark, r, g, b, a)
	end)
end

function resetCheckboxStyle(gui)
	gui:add_imgui(function()
		ImGui.PopStyleColor(1)
		ImGui.PopStyleVar(1)
	end)
end

function applyButtonStyle(r, g, b, a, hr, hg, hb, ha, ar, ag, ab, aa, rounding, gui)
	gui:add_imgui(function()
		ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, rounding)
		ImGui.PushStyleColor(ImGuiCol.Button, r, g, b, a)
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, hr, hg, hb, ha)
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, ar, ag, ab, aa)
	end)
end

function resetButtonStyle(gui)
	gui:add_imgui(function()
		ImGui.PopStyleColor(3)
		ImGui.PopStyleVar(1)
	end)
end
