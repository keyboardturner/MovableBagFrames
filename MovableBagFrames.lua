local defaultsTable = {
	CBBagsFrame = {show = true, checked = true, scale = 1, x = -224, y = -165, height = 475, point = "RIGHT", relativePoint = "RIGHT", locked = false},
	S1BagsFrame = {show = true, checked = true, scale = 1, x = -10, y = 85, height = 475, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT", locked = false},
	S2BagsFrame = {show = true, checked = true, scale = 1, x = 0, y = 8, height = 475, point = "TOPRIGHT", relativePoint = "TOPRIGHT", locked = false},
	S3BagsFrame = {show = true, checked = true, scale = 1, x = 0, y = 8, height = 475, point = "TOPRIGHT", relativePoint = "TOPRIGHT", locked = false},
	S4BagsFrame = {show = true, checked = true, scale = 1, x = -11, y = 0, height = 475, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT", locked = false},
	S5BagsFrame = {show = true, checked = true, scale = 1, x = 0, y = 8, height = 475, point = "TOPRIGHT", relativePoint = "TOPRIGHT", locked = false},
	RBBagsFrame = {show = true, checked = true, scale = 1, x = -224, y = -165, height = 475, point = "RIGHT", relativePoint = "RIGHT", locked = false},
}

local BagsFramePanel = CreateFrame("FRAME", "BagStuff");
BagsFramePanel.name = "Movable Bag Frames";

BagsFramePanel.Headline = BagsFramePanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
BagsFramePanel.Headline:SetFont(BagsFramePanel.Headline:GetFont(), 23);
BagsFramePanel.Headline:SetTextColor(0,1,0,1);
BagsFramePanel.Headline:ClearAllPoints();
BagsFramePanel.Headline:SetPoint("TOPLEFT", BagsFramePanel, "TOPLEFT",12,-12);
BagsFramePanel.Headline:SetText("Movable & Resizable Bag Frames");

BagsFramePanel.Version = BagsFramePanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
BagsFramePanel.Version:SetFont(BagsFramePanel.Version:GetFont(), 12);
BagsFramePanel.Version:SetTextColor(1,1,1,1);
BagsFramePanel.Version:ClearAllPoints();
BagsFramePanel.Version:SetPoint("TOPLEFT", BagsFramePanel, "TOPLEFT",400,-21);
BagsFramePanel.Version:SetText("Version: " .. GetAddOnMetadata("MovableBagFrames", "Version"));

BagsFramePanel.CBSlider = CreateFrame("Slider", "BagsFrameScaleCBSlider", BagsFramePanel, "OptionsSliderTemplate");
BagsFramePanel.CBSlider:SetWidth(300);
BagsFramePanel.CBSlider:SetHeight(15);
BagsFramePanel.CBSlider:SetMinMaxValues(50,150);
BagsFramePanel.CBSlider:SetValueStep(1);
BagsFramePanel.CBSlider:ClearAllPoints();
BagsFramePanel.CBSlider:SetPoint("TOPLEFT", BagsFramePanel, "TOPLEFT",12,-53);
getglobal(BagsFramePanel.CBSlider:GetName() .. 'Low'):SetText('50');
getglobal(BagsFramePanel.CBSlider:GetName() .. 'High'):SetText('150');
getglobal(BagsFramePanel.CBSlider:GetName() .. 'Text'):SetText('Combined Bag Frame Size');
BagsFramePanel.CBSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(BagsFramePanel.CBSlider:GetName()):GetValue() / 100;
	MoveBagsF_DB.CBBagsFrame.scale = scaleValue;
end)

BagsFramePanel.SB1Slider = CreateFrame("Slider", "BagsFrameScaleSB1Slider", BagsFramePanel, "OptionsSliderTemplate");
BagsFramePanel.SB1Slider:SetWidth(300);
BagsFramePanel.SB1Slider:SetHeight(15);
BagsFramePanel.SB1Slider:SetMinMaxValues(50,150);
BagsFramePanel.SB1Slider:SetValueStep(1);
BagsFramePanel.SB1Slider:ClearAllPoints();
BagsFramePanel.SB1Slider:SetPoint("TOPLEFT", BagsFramePanel, "TOPLEFT",12,-53*2);
getglobal(BagsFramePanel.SB1Slider:GetName() .. 'Low'):SetText('50');
getglobal(BagsFramePanel.SB1Slider:GetName() .. 'High'):SetText('150');
getglobal(BagsFramePanel.SB1Slider:GetName() .. 'Text'):SetText('Separate Bag 1 Frame Size');
BagsFramePanel.SB1Slider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(BagsFramePanel.SB1Slider:GetName()):GetValue() / 100;
	MoveBagsF_DB.S1BagsFrame.scale = scaleValue;
end)

BagsFramePanel.CBCheckbox = CreateFrame("CheckButton", "CBCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.CBCheckbox:ClearAllPoints();
BagsFramePanel.CBCheckbox:SetPoint("TOPLEFT", 350, -53);
getglobal(BagsFramePanel.CBCheckbox:GetName().."Text"):SetText("Combined Bag Frame Locked");

BagsFramePanel.CBCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.CBCheckbox:GetChecked() then
		MoveBagsF_DB.CBBagsFrame.locked = true;
	else
		MoveBagsF_DB.CBBagsFrame.locked = false;
	end
end);

InterfaceOptions_AddCategory(BagsFramePanel);


local BagsFrameEventFrame = CreateFrame("Frame");
BagsFrameEventFrame:RegisterEvent("ADDON_LOADED");
BagsFrameEventFrame:RegisterEvent("PLAYER_LOGOUT");
BagsFrameEventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW");
BagsFrameEventFrame:RegisterEvent("BANKFRAME_CLOSED");
BagsFrameEventFrame:RegisterEvent("BANKFRAME_OPENED");
BagsFrameEventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
BagsFrameEventFrame:RegisterEvent("MERCHANT_SHOW");


function BagsFrameEventFrame:OnEvent(event,arg1)
	if event == "ADDON_LOADED" and arg1 == "MovableBagFrames" then
		if not MoveBagsF_DB then
			MoveBagsF_DB = defaultsTable;
		end
		if not MoveBagsF_DB.CBBagsFrame.scale then
			MoveBagsF_DB.CBBagsFrame.scale = defaultsTable.CBBagsFrame.scale;
		end
		BagsFramePanel.CBSlider:SetValue(MoveBagsF_DB.CBBagsFrame.scale*100);
		BagsFramePanel.SB1Slider:SetValue(MoveBagsF_DB.CBBagsFrame.scale*100);
	end
	if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" or "BANKFRAME_CLOSED" or "PLAYERBANKSLOTS_CHANGED" or "MERCHANT_SHOW" or "BANKFRAME_OPENED" then
		BagsFrameEventFrame.TokenChange()
	end
	if event == "PLAYER_LOGOUT" then
		ContainerFrameCombinedBags:SetUserPlaced(false);
		ContainerFrameCombinedBags:ClearAllPoints()
	end
end
BagsFrameEventFrame:SetScript("OnEvent",BagsFrameEventFrame.OnEvent);

function BagsFrameEventFrame.Stuff()
	ContainerFrameCombinedBags:ClearAllPoints()
	ContainerFrameCombinedBags:SetMovable(true);
	ContainerFrameCombinedBags:SetUserPlaced(true);
	ContainerFrameCombinedBags:EnableMouse(true);
	ContainerFrameCombinedBags:RegisterForDrag("LeftButton", "RightButton");
	ContainerFrameCombinedBags:SetClampedToScreen(true)

	ContainerFrameCombinedBags:SetScript("OnMouseDown", function(self, button)
		if MoveBagsF_DB.CBBagsFrame.locked == false then
			if button == "LeftButton" and not self.isMoving then
				Mixin(self, BackdropTemplateMixin);
				self:StartMoving();
				self.isMoving = true;
			end
		else
			return
		end
	end);
	ContainerFrameCombinedBags:SetScript("OnMouseUp", function(self)
		Mixin(self, BackdropTemplateMixin);
		ContainerFrameCombinedBags:SetBackdropColor(0,0,0,0);
		self:StopMovingOrSizing();
		self.isMoving = false;
		local point, relativeTo, relativePoint, xOfs, yOfs = ContainerFrameCombinedBags:GetPoint();
		--[[ --debug
		ContainerFrameCombinedBags:SetPoint(point, nil, relativePoint, xOfs, yOfs);
		print("point: " .. point) -- nil
		--print("relativeTo: " .. relativeTo) -- nil
		print("relativePoint: " .. relativePoint) -- nil
		print("xOfs: " .. xOfs)
		print("yOfs: " .. yOfs)
		]]
		MoveBagsF_DB.CBBagsFrame.point = point
		MoveBagsF_DB.CBBagsFrame.relativePoint = relativePoint
		MoveBagsF_DB.CBBagsFrame.x = xOfs
		MoveBagsF_DB.CBBagsFrame.y = yOfs
		MoveBagsF_DB.CBBagsFrame.height = ContainerFrameCombinedBags:GetHeight()
	end);
end

function BagsFrameEventFrame.ReMoveStuff(event,arg1)
	ContainerFrameCombinedBags:ClearAllPoints()
	ContainerFrameCombinedBags:SetPoint(MoveBagsF_DB.CBBagsFrame.point, nil, MoveBagsF_DB.CBBagsFrame.relativePoint, MoveBagsF_DB.CBBagsFrame.x, MoveBagsF_DB.CBBagsFrame.y);
	ContainerFrameCombinedBags:SetScale(MoveBagsF_DB.CBBagsFrame.scale);
end

function BagsFrameEventFrame.TokenChange()
	ContainerFrameCombinedBags:ClearAllPoints()
	ContainerFrameCombinedBags:Hide()
	ContainerFrameCombinedBags:SetScale(MoveBagsF_DB.CBBagsFrame.scale);
end

EventRegistry:RegisterCallback('ContainerFrame.OpenBag', BagsFrameEventFrame.Stuff)
EventRegistry:RegisterCallback('ContainerFrame.OpenAllBags', BagsFrameEventFrame.ReMoveStuff)
EventRegistry:RegisterCallback('TokenFrame.OnTokenWatchChanged', BagsFrameEventFrame.TokenChange)

--BANKFRAME_OPENED
--ADDON_LOADED "Blizzard_AuctionHouseShared"
--PLAYER_INTERACTION_MANAGER_FRAME_SHOW
--BANKFARME_CLOSED



--ContainerFrame1 -- bottom right, -10, 85
--ContainerFrame2 -- top right, 0, 8
--ContainerFrame3 -- top right, 0, 8
--ContainerFrame4 -- bottom left, -11, 0
--ContainerFrame5 -- top right, 0, 8