-- ButtonForge Classic - minimap button + central configuration menu
local BF = BFClassic

function BF:GetMinimapButtonAngle()
    self:EnsureDB()
    if not ButtonForgeClassicDB.settings.minimapAngle then
        ButtonForgeClassicDB.settings.minimapAngle = 225
    end
    return ButtonForgeClassicDB.settings.minimapAngle
end

function BF:SetMinimapButtonPosition(angle)
    if not self.MinimapButton or not Minimap then return end
    self:EnsureDB()
    angle = angle or self:GetMinimapButtonAngle()
    ButtonForgeClassicDB.settings.minimapAngle = angle

    local rad = angle * 3.141592653589793 / 180
    local radius = 78
    local x = math.cos(rad) * radius
    local y = math.sin(rad) * radius

    self.MinimapButton:ClearAllPoints()
    self.MinimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function BF:ShowMinimapTooltip(button)
    GameTooltip:SetOwner(button, "ANCHOR_LEFT")
    GameTooltip:SetText("ButtonForge Classic")
    GameTooltip:AddLine("Left-click: Open ButtonForge menu", 1, 1, 1)
    GameTooltip:AddLine("Right-click: Toggle Configure Mode", 1, 1, 1)
    GameTooltip:AddLine("Shift + Left-click: Toggle Keybind Mode", 1, 1, 1)
    GameTooltip:AddLine("Alt + drag: Move minimap button", 0.8, 0.8, 0.8)
    GameTooltip:Show()
end

local function BFC_CreateMenuButton(parent, name, width, height, text)
    local b = CreateFrame("Button", name, parent, "UIPanelButtonTemplate")
    b:SetWidth(width)
    b:SetHeight(height)
    b:SetText(text or "")
    return b
end

local function BFC_CreateLabel(parent, name, text, template)
    local fs = parent:CreateFontString(name, "OVERLAY", template or "GameFontNormalSmall")
    fs:SetText(text or "")
    return fs
end

local function BFC_FindBarById(id)
    if not BF.Bars then return nil end
    local i
    for i = 1, table.getn(BF.Bars) do
        local bar = BF.Bars[i]
        if bar and bar.save and bar.save.id == id then
            return bar
        end
    end
    return nil
end

local function BFC_SetButtonEnabled(button, enabled)
    if not button then return end
    if enabled then
        if button.Enable then button:Enable() end
        button:SetAlpha(1)
    else
        if button.Disable then button:Disable() end
        button:SetAlpha(0.45)
    end
end

function BF:RefreshMinimapMenu()
    local f = self.MinimapMenu
    if not f then return end

    self:EnsureDB()

    if f.configButton then
        if self:IsConfigMode() then
            f.configButton:SetText("Configure Mode: ON")
        else
            f.configButton:SetText("Configure Mode: OFF")
        end
    end

    if f.keybindButton then
        if self:IsKeybindMode() then
            f.keybindButton:SetText("Keybind Mode: ON")
        else
            f.keybindButton:SetText("Keybind Mode: OFF")
        end
    end

    if f.macroNamesButton then
        if ButtonForgeClassicDB.settings.showMacroNames ~= false then
            f.macroNamesButton:SetText("Macro Names: ON")
        else
            f.macroNamesButton:SetText("Macro Names: OFF")
        end
    end

    local i
    if f.barButtons then
        for i = 1, table.getn(f.barButtons) do
            local selector = f.barButtons[i]
            local bar = BFC_FindBarById(i)
            if bar then
                selector:SetText("Bar " .. tostring(i))
                selector:SetAlpha(1)
                if selector.Enable then selector:Enable() end
                if self:GetActiveBar() == bar then
                    selector:SetText("Bar " .. tostring(i) .. " *")
                end
            else
                selector:SetText("Bar " .. tostring(i))
                selector:SetAlpha(0.35)
                if selector.Disable then selector:Disable() end
            end
        end
    end

    local bar = self:GetActiveBar()
    local hasBar = bar and bar.save

    if f.activeName then
        if hasBar then
            f.activeName:SetText("Active Bar: " .. tostring(bar.save.name or ("Bar " .. tostring(bar.save.id or "?"))))
        else
            f.activeName:SetText("Active Bar: none")
        end
    end

    if f.activeControls then
        for i = 1, table.getn(f.activeControls) do
            BFC_SetButtonEnabled(f.activeControls[i], hasBar)
        end
    end

    if not hasBar then
        if f.colsValue then f.colsValue:SetText("-") end
        if f.rowsValue then f.rowsValue:SetText("-") end
        if f.scaleValue then f.scaleValue:SetText("-") end
        if f.lockButton then f.lockButton:SetText("Position Lock: -") end
        if f.actionLockButton then f.actionLockButton:SetText("Action Lock: -") end
        if f.backgroundButton then f.backgroundButton:SetText("Background: -") end
        if f.gridButton then f.gridButton:SetText("Empty Slots: -") end
        if f.mouseoverButton then f.mouseoverButton:SetText("Mouseover: -") end
        if f.mouseoverDelayValue then f.mouseoverDelayValue:SetText("-") end
        if f.deleteButton then f.deleteButton:SetText("Delete Bar") end
        f.deleteConfirmId = nil
        return
    end

    if f.colsValue then f.colsValue:SetText(tostring(bar.save.cols or 1)) end
    if f.rowsValue then f.rowsValue:SetText(tostring(bar.save.rows or 1)) end
    if f.scaleValue then f.scaleValue:SetText(tostring(math.floor(((bar.save.scale or 1) * 100) + 0.5)) .. "%") end

    if f.lockButton then
        if bar.save.locked then
            f.lockButton:SetText("Position Lock: ON")
        else
            f.lockButton:SetText("Position Lock: OFF")
        end
    end

    if f.actionLockButton then
        if bar.save.actionsLocked then
            f.actionLockButton:SetText("Action Lock: ON")
        else
            f.actionLockButton:SetText("Action Lock: OFF")
        end
    end

    if f.backgroundButton then
        if bar.save.hideBackground then
            f.backgroundButton:SetText("Background: HIDDEN")
        else
            f.backgroundButton:SetText("Background: SHOWN")
        end
    end

    if f.gridButton then
        if bar.save.showGrid then
            f.gridButton:SetText("Empty Slots: SHOWN")
        else
            f.gridButton:SetText("Empty Slots: HIDDEN")
        end
    end

    if f.mouseoverButton then
        if bar.save.mouseover then
            f.mouseoverButton:SetText("Mouseover: ON")
        else
            f.mouseoverButton:SetText("Mouseover: OFF")
        end
    end

    if f.mouseoverDelayValue then
        f.mouseoverDelayValue:SetText(tostring(bar.save.mouseoverDelay or 1) .. "s")
    end

    if f.deleteConfirmId ~= (bar.save.id or 0) then
        f.deleteConfirmId = nil
        if f.deleteButton then f.deleteButton:SetText("Delete Bar") end
    end
end

function BF:CreateMinimapMenu()
    if self.MinimapMenu then return self.MinimapMenu end

    local f = CreateFrame("Frame", "ButtonForgeClassicMinimapMenu", UIParent)
    f:SetWidth(330)
    f:SetHeight(506)
    f:SetFrameStrata("DIALOG")
    f:SetFrameLevel(20)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    f:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 18, -8)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function() this:StartMoving() end)
    f:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
    f:Hide()

    if UISpecialFrames then
        table.insert(UISpecialFrames, "ButtonForgeClassicMinimapMenu")
    end

    local title = BFC_CreateLabel(f, "ButtonForgeClassicMinimapMenuTitle", "ButtonForge Classic", "GameFontNormalLarge")
    title:SetPoint("TOP", f, "TOP", 0, -18)

    local sub = BFC_CreateLabel(f, "ButtonForgeClassicMinimapMenuSub", "Central configuration", "GameFontHighlightSmall")
    sub:SetPoint("TOP", title, "BOTTOM", 0, -2)

    local close = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapMenuClose", 24, 22, "X")
    close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -15, -13)
    close:SetScript("OnClick", function() f:Hide() end)

    local general = BFC_CreateLabel(f, "ButtonForgeClassicMinimapMenuGeneral", "GENERAL", "GameFontNormalSmall")
    general:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -62)

    f.configButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapConfig", 138, 24, "Configure Mode")
    f.configButton:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -80)
    f.configButton:SetScript("OnClick", function()
        BF:ToggleConfigMode()
        BF:RefreshMinimapMenu()
    end)

    f.keybindButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapKeybind", 138, 24, "Keybind Mode")
    f.keybindButton:SetPoint("LEFT", f.configButton, "RIGHT", 8, 0)
    f.keybindButton:SetScript("OnClick", function()
        BF:ToggleKeybindMode()
        BF:RefreshMinimapMenu()
    end)

    f.newBarButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapNewBar", 284, 24, "Create New Bar")
    f.newBarButton:SetPoint("TOPLEFT", f.configButton, "BOTTOMLEFT", 0, -6)
    f.newBarButton:SetScript("OnClick", function()
        BF:CreateBar()
        BF:ApplyConfigModeToAllBars()
        BF:RefreshMinimapMenu()
    end)

    local barsLabel = BFC_CreateLabel(f, "ButtonForgeClassicMinimapBarsLabel", "SELECT BAR", "GameFontNormalSmall")
    barsLabel:SetPoint("TOPLEFT", f.newBarButton, "BOTTOMLEFT", 0, -12)

    f.barButtons = {}
    local i
    for i = 1, 8 do
        local b = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapBar" .. tostring(i), 66, 22, "Bar " .. tostring(i))
        local row = math.floor((i - 1) / 4)
        local col = (i - 1) - (row * 4)
        b:SetPoint("TOPLEFT", f, "TOPLEFT", 22 + (col * 72), -157 - (row * 27))
        b.barId = i
        b:SetScript("OnClick", function()
            local bar = BFC_FindBarById(this.barId)
            if bar then
                BF:SetActiveBar(bar)
                BF:RefreshMinimapMenu()
            end
        end)
        table.insert(f.barButtons, b)
    end

    f.activeName = BFC_CreateLabel(f, "ButtonForgeClassicMinimapActiveName", "Active Bar: none", "GameFontHighlight")
    f.activeName:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -218)

    local function AddMinusValuePlus(prefix, y, labelText, onMinus, onPlus)
        local label = BFC_CreateLabel(f, prefix .. "Label", labelText, "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", f, "TOPLEFT", 22, y)

        local minus = BFC_CreateMenuButton(f, prefix .. "Minus", 32, 22, "-")
        minus:SetPoint("TOPLEFT", f, "TOPLEFT", 157, y + 5)
        minus:SetScript("OnClick", onMinus)

        local value = BFC_CreateLabel(f, prefix .. "Value", "-", "GameFontHighlight")
        value:SetWidth(58)
        value:SetJustifyH("CENTER")
        value:SetPoint("LEFT", minus, "RIGHT", 2, 0)

        local plus = BFC_CreateMenuButton(f, prefix .. "Plus", 32, 22, "+")
        plus:SetPoint("LEFT", value, "RIGHT", 2, 0)
        plus:SetScript("OnClick", onPlus)

        table.insert(f.activeControls, minus)
        table.insert(f.activeControls, plus)
        return value
    end

    f.activeControls = {}

    f.colsValue = AddMinusValuePlus("ButtonForgeClassicMinimapCols", -242, "Columns", function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarCols((bar.save.cols or 1) - 1) end
        BF:RefreshMinimapMenu()
    end, function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarCols((bar.save.cols or 1) + 1) end
        BF:RefreshMinimapMenu()
    end)

    f.rowsValue = AddMinusValuePlus("ButtonForgeClassicMinimapRows", -273, "Rows", function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarRows((bar.save.rows or 1) - 1) end
        BF:RefreshMinimapMenu()
    end, function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarRows((bar.save.rows or 1) + 1) end
        BF:RefreshMinimapMenu()
    end)

    f.scaleValue = AddMinusValuePlus("ButtonForgeClassicMinimapScale", -304, "Scale", function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarScale((bar.save.scale or 1) - 0.1) end
        BF:RefreshMinimapMenu()
    end, function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarScale((bar.save.scale or 1) + 0.1) end
        BF:RefreshMinimapMenu()
    end)

    f.lockButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapLock", 138, 24, "Position Lock")
    f.lockButton:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -337)
    f.lockButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarLocked(not bar.save.locked) end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.lockButton)

    f.actionLockButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapActionLock", 138, 24, "Action Lock")
    f.actionLockButton:SetPoint("LEFT", f.lockButton, "RIGHT", 8, 0)
    f.actionLockButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then BF:SetActiveBarActionsLocked(not bar.save.actionsLocked) end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.actionLockButton)

    f.backgroundButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapBackground", 138, 24, "Background")
    f.backgroundButton:SetPoint("TOPLEFT", f.lockButton, "BOTTOMLEFT", 0, -6)
    f.backgroundButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then BF:ToggleBarBackground(bar) end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.backgroundButton)

    f.gridButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapGrid", 138, 24, "Empty Slots")
    f.gridButton:SetPoint("LEFT", f.backgroundButton, "RIGHT", 8, 0)
    f.gridButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then BF:ToggleBarGrid(bar) end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.gridButton)

    f.mouseoverButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapMouseover", 138, 24, "Mouseover")
    f.mouseoverButton:SetPoint("TOPLEFT", f.backgroundButton, "BOTTOMLEFT", 0, -6)
    f.mouseoverButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then BF:ToggleBarMouseover(bar) end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.mouseoverButton)

    f.macroNamesButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapMacroNames", 138, 24, "Macro Names: ON")
    f.macroNamesButton:SetPoint("LEFT", f.mouseoverButton, "RIGHT", 8, 0)
    f.macroNamesButton:SetScript("OnClick", function()
        BF:ToggleMacroNames()
        BF:RefreshMinimapMenu()
    end)

    local delayLabel = BFC_CreateLabel(f, "ButtonForgeClassicMinimapDelayLabel", "Mouseover Delay", "GameFontNormalSmall")
    delayLabel:SetPoint("TOPLEFT", f.mouseoverButton, "BOTTOMLEFT", 0, -14)

    f.delayMinus = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapDelayMinus", 32, 22, "-")
    f.delayMinus:SetPoint("TOPLEFT", f, "TOPLEFT", 157, -435)
    f.delayMinus:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then
            local value = (bar.save.mouseoverDelay or 1) - 0.5
            if value < 0 then value = 0 end
            BF:SetBarMouseoverDelay(bar, value)
        end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.delayMinus)

    f.mouseoverDelayValue = BFC_CreateLabel(f, "ButtonForgeClassicMinimapDelayValue", "-", "GameFontHighlight")
    f.mouseoverDelayValue:SetWidth(58)
    f.mouseoverDelayValue:SetJustifyH("CENTER")
    f.mouseoverDelayValue:SetPoint("LEFT", f.delayMinus, "RIGHT", 2, 0)

    f.delayPlus = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapDelayPlus", 32, 22, "+")
    f.delayPlus:SetPoint("LEFT", f.mouseoverDelayValue, "RIGHT", 2, 0)
    f.delayPlus:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if bar then
            local value = (bar.save.mouseoverDelay or 1) + 0.5
            if value > 5 then value = 5 end
            BF:SetBarMouseoverDelay(bar, value)
        end
        BF:RefreshMinimapMenu()
    end)
    table.insert(f.activeControls, f.delayPlus)

    f.deleteButton = BFC_CreateMenuButton(f, "ButtonForgeClassicMinimapDelete", 284, 24, "Delete Bar")
    f.deleteButton:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -469)
    f.deleteButton:SetScript("OnClick", function()
        local bar = BF:GetActiveBar()
        if not bar or not bar.save then return end
        local id = bar.save.id or 0
        if f.deleteConfirmId == id then
            f.deleteConfirmId = nil
            BF:DeleteActiveBar()
            BF:RefreshMinimapMenu()
        else
            f.deleteConfirmId = id
            f.deleteButton:SetText("Click again to delete " .. tostring(bar.save.name or "bar"))
        end
    end)
    table.insert(f.activeControls, f.deleteButton)

    f:SetScript("OnShow", function()
        BF:RefreshMinimapMenu()
    end)

    self.MinimapMenu = f
    self:RefreshMinimapMenu()
    return f
end

function BF:ToggleMinimapMenu()
    local f = self:CreateMinimapMenu()
    if not f then return end
    if f:IsVisible() then
        f:Hide()
    else
        f:Show()
        self:RefreshMinimapMenu()
    end
end

function BF:CreateMinimapButton()
    if self.MinimapButton then return end
    if not Minimap then return end

    -- Classic minimap button layout. The texture anchors intentionally match
    -- Blizzard's own tracking button pattern; many minimap-button-bags expect this.
    local b = CreateFrame("Button", "ButtonForgeClassicMinimapButton", Minimap)
    b:SetWidth(32)
    b:SetHeight(32)
    b:SetFrameStrata("MEDIUM")
    b:SetFrameLevel(8)
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b:RegisterForDrag("LeftButton")
    b:EnableMouse(true)

    local icon = b:CreateTexture("ButtonForgeClassicMinimapButtonIcon", "BACKGROUND")
    icon:SetWidth(20)
    icon:SetHeight(20)
    icon:SetPoint("TOPLEFT", b, "TOPLEFT", 7, -6)
    icon:SetTexture("Interface\\Icons\\Trade_BlackSmithing")
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    b.icon = icon

    local overlay = b:CreateTexture("ButtonForgeClassicMinimapButtonBorder", "OVERLAY")
    overlay:SetWidth(53)
    overlay:SetHeight(53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
    b.overlay = overlay

    local highlight = b:CreateTexture("ButtonForgeClassicMinimapButtonHighlight", "HIGHLIGHT")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")
    highlight:SetAllPoints(b)
    b.highlight = highlight

    b:SetScript("OnEnter", function()
        BF:ShowMinimapTooltip(this)
    end)

    b:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    b:SetScript("OnClick", function()
        if arg1 == "LeftButton" then
            if IsShiftKeyDown and IsShiftKeyDown() then
                BF:ToggleKeybindMode()
            else
                BF:ToggleMinimapMenu()
            end
        elseif arg1 == "RightButton" then
            BF:ToggleConfigMode()
            BF:RefreshMinimapMenu()
        end
        BF:ShowMinimapTooltip(this)
    end)

    b:SetScript("OnDragStart", function()
        if IsAltKeyDown and IsAltKeyDown() then
            this:SetScript("OnUpdate", function()
                local mx, my = Minimap:GetCenter()
                local px, py = GetCursorPosition()
                local scale = UIParent:GetScale() or 1
                px = px / scale
                py = py / scale
                local angle = math.deg(math.atan2(py - my, px - mx))
                BF:SetMinimapButtonPosition(angle)
            end)
        end
    end)

    b:SetScript("OnDragStop", function()
        this:SetScript("OnUpdate", nil)
    end)

    self.MinimapButton = b
    self:SetMinimapButtonPosition(self:GetMinimapButtonAngle())
end
