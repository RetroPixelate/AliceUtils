print("AliceUtils loaded.")

if not AliceUtilsDB then
    AliceUtilsDB = {}
end

local mainFrame = CreateFrame("Frame", "AliceSettingsFrame", UIParent, "BasicFrameTemplateWithInset")
mainFrame:SetSize(400, 300)
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
mainFrame.TitleBg:SetHeight(30)
mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
mainFrame.title:SetPoint("TOP", mainFrame.TitleBg, "TOP", 0, -5)
mainFrame.title:SetText("AliceUtils Settings")

mainFrame:EnableMouse(true)
mainFrame:SetMovable(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", function(self)
	self:StartMoving()
end)
mainFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
end)

mainFrame:SetScript("OnShow", function()
        PlaySound(808)
end)

mainFrame:SetScript("OnHide", function()
        PlaySound(808)
end)

table.insert(UISpecialFrames, "MyAddonMainFrame")

mainFrame:Hide()

SLASH_ALICEUTILS1 = "/aliceutils"
SLASH_ALICEUTILS2 = "/alice"
SLASH_ALICEUTILS3 = "/au"
SlashCmdList["ALICEUTILS"] = function()
    if mainFrame:IsShown() then
        mainFrame:Hide()
    else
        mainFrame:Show()
    end
end

local SOUL_SHARD_ID = 6265
SLASH_DELSHARDS1 = "/deleteshards"
SLASH_DELSHARDS2 = "/delshards"
SLASH_DELSHARDS3 = "/dss"
SlashCmdList["DELSHARDS"] = function(msg, editbox)
    local soulShards = 0
    local kept = tonumber(msg)

    if kept == nil then
        print("Usage: /delshards <kept>")
    else
        for bag = 0, 4 do
            local slots = C_Container.GetContainerNumSlots(bag)
            for slot = 1, slots do
                if C_Container.GetContainerItemID(bag, slot) == SOUL_SHARD_ID then
                    soulShards = soulShards + 1
                end
            end
        end

        for bag = 0, 4 do
            local slots = C_Container.GetContainerNumSlots(bag)
            for slot = 1, slots do
                if (C_Container.GetContainerItemID(bag, slot) == SOUL_SHARD_ID)
                and (soulShards > kept) then
                    C_Container.PickupContainerItem(bag, slot)
                    DeleteCursorItem()
                    return
                end
            end
        end
    end
end