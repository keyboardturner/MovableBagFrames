local defaultsTable = {
	CBBagsFrame = {x = -10, y = -85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	
	S1BagsFrame = {x = -10, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	S2BagsFrame = {x = -10, y = 10, point = "RIGHT", relativePoint = "RIGHT",},
	S3BagsFrame = {x = -10, y = -1, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	S4BagsFrame = {x = -200, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	S5BagsFrame = {x = -200, y = 75, point = "RIGHT", relativePoint = "RIGHT",},


	--BankFrame = {x = 0, y = 8, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},

	--BK7Frame = {x = -450, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	--BK8Frame = {x = -450, y = -177, point = "RIGHT", relativePoint = "RIGHT",},
	--BK9Frame = {x = -450, y = 50, point = "RIGHT", relativePoint = "RIGHT",},
	--BK10Frame = {x = -450, y = -210, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	--BK11Frame = {x = -450, y = 0, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	--BK12Frame = {x = 338, y = 85, point = "BOTTOM", relativePoint = "BOTTOM",},
	--BK13Frame = {x = 338, y = -177, point = "CENTER", relativePoint = "CENTER",},

	RBBagsFrame = {x = -224, y = -165, point = "RIGHT", relativePoint = "RIGHT",},

	BagsSetting = {show = true, checked = true, scale = 1, locked = false, click = true, sort = false, insert = false, perChar = true},
	
};

local BagFramesMap = {
	[ContainerFrameCombinedBags] = "CBBagsFrame",
	[ContainerFrame1] = "S1BagsFrame",
	[ContainerFrame2] = "S2BagsFrame",
	[ContainerFrame3] = "S3BagsFrame",
	[ContainerFrame4] = "S4BagsFrame",
	[ContainerFrame5] = "S5BagsFrame",
	[ContainerFrame6] = "RBBagsFrame",
	-- [BankFrame] = "BankFrame",
}


--[[
combined bags: BOTTOMRIGHT UIParent BOTTOMright -10 85

container1: BOTTOMRIGHT UIParent BOTTOMRIGHT -10 85
container2: RIGHT UIParent RIGHT -10 10 
container3: TOPRIGHT UIParent TOPRIGHT -10 -1 
container4: BOTTOMRIGHT UIParent BOTTOMRIGHT -200 85
container5: RIGHT UIParent RIGHT -200 75

container 7: BOTTOMRIGHT UIParent BOTTOMRIGHT -450 85
container 8: RIGHT UIParent RIGHT -450 -177
container 9: RIGHT UIParent RIGHT -450 50
container 10: TOPRIGHT UIParent TOPRIGHT -450 -210
container 11: TOPRIGHT UIParent TOPRIGHT -450 0
container 12: BOTTOM UIParent BOTTOM 338 85
container 13: CENTER UIParent CENTER 338 -177


]]

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
BagsFramePanel.Version:SetText("Version: " .. C_AddOns.GetAddOnMetadata("MovableBagFrames", "Version"));

BagsFramePanel.CBSlider = CreateFrame("Slider", "BagsFrameScaleCBSlider", BagsFramePanel, "OptionsSliderTemplate");
BagsFramePanel.CBSlider:SetWidth(300);
BagsFramePanel.CBSlider:SetHeight(15);
BagsFramePanel.CBSlider:SetMinMaxValues(50,150);
BagsFramePanel.CBSlider:SetValueStep(1);
BagsFramePanel.CBSlider:ClearAllPoints();
BagsFramePanel.CBSlider:SetPoint("TOPLEFT", BagsFramePanel, "TOPLEFT",12,-53);
getglobal(BagsFramePanel.CBSlider:GetName() .. 'Low'):SetText('50');
getglobal(BagsFramePanel.CBSlider:GetName() .. 'High'):SetText('150');
getglobal(BagsFramePanel.CBSlider:GetName() .. 'Text'):SetText('Bag Frames Size');
BagsFramePanel.CBSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(BagsFramePanel.CBSlider:GetName()):GetValue() / 100;
	MoveBagsF_DB.BagsSetting.scale = scaleValue;
end)

BagsFramePanel.CBCheckbox = CreateFrame("CheckButton", "CBCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.CBCheckbox:ClearAllPoints();
BagsFramePanel.CBCheckbox:SetPoint("TOPLEFT", 350, -53);
getglobal(BagsFramePanel.CBCheckbox:GetName().."Text"):SetText("Bag Frames Locked");

BagsFramePanel.CBCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.CBCheckbox:GetChecked() then
		MoveBagsF_DB.BagsSetting.locked = true;
	else
		MoveBagsF_DB.BagsSetting.locked = false;
	end
end);

BagsFramePanel.SortCheckbox = CreateFrame("CheckButton", "SortCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.SortCheckbox:ClearAllPoints();
BagsFramePanel.SortCheckbox:SetPoint("TOPLEFT", 350, -53*2);
getglobal(BagsFramePanel.SortCheckbox:GetName().."Text"):SetText("Sort Bags Right to Left");
getglobal(BagsFramePanel.SortCheckbox:GetName().."Text"):SetJustifyH("LEFT");

BagsFramePanel.SortCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.SortCheckbox:GetChecked() then
		MoveBagsF_DB.BagsSetting.sort = true;
		C_Container.SetSortBagsRightToLeft(true)
	else
		MoveBagsF_DB.BagsSetting.sort = false;
		C_Container.SetSortBagsRightToLeft(false)
	end
end);

BagsFramePanel.InsertCheckbox = CreateFrame("CheckButton", "InsertCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.InsertCheckbox:ClearAllPoints();
BagsFramePanel.InsertCheckbox:SetPoint("TOPLEFT", 350, -53*3);
getglobal(BagsFramePanel.InsertCheckbox:GetName().."Text"):SetText("Loot Items Right to Left");

BagsFramePanel.InsertCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.InsertCheckbox:GetChecked() then
		MoveBagsF_DB.BagsSetting.insert = true;
		C_Container.SetInsertItemsLeftToRight(true)
	else
		MoveBagsF_DB.BagsSetting.insert = false;
		C_Container.SetInsertItemsLeftToRight(false)
	end
end);


BagsFramePanel.ClickBagCheckbox = CreateFrame("CheckButton", "ClickBagCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.ClickBagCheckbox:ClearAllPoints();
BagsFramePanel.ClickBagCheckbox:SetPoint("TOPLEFT", 350, -53*4);
getglobal(BagsFramePanel.ClickBagCheckbox:GetName().."Text"):SetText("Correct Micromenu Bag Button Click\n(Experimental)");
getglobal(BagsFramePanel.ClickBagCheckbox:GetName().."Text"):SetJustifyH("LEFT");

BagsFramePanel.ClickBagCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.ClickBagCheckbox:GetChecked() then
		MoveBagsF_DB.BagsSetting.click = true;
	else
		MoveBagsF_DB.BagsSetting.click = false;
	end
end);


BagsFramePanel.CharSpecificCheckbox = CreateFrame("CheckButton", "CharSpecificCheckbox", BagsFramePanel, "UICheckButtonTemplate");
BagsFramePanel.CharSpecificCheckbox:ClearAllPoints();
BagsFramePanel.CharSpecificCheckbox:SetPoint("TOPLEFT", 350, -53*5);
getglobal(BagsFramePanel.CharSpecificCheckbox:GetName().."Text"):SetText("Character-Specific Bag Positions");
getglobal(BagsFramePanel.CharSpecificCheckbox:GetName().."Text"):SetJustifyH("LEFT");

BagsFramePanel.CharSpecificCheckbox:SetScript("OnClick", function(self)
	if BagsFramePanel.CharSpecificCheckbox:GetChecked() then
		MoveBagsF_DB.BagsSetting.perChar = true;
	else
		MoveBagsF_DB.BagsSetting.perChar = false;
	end
end);

local category, layout = Settings.RegisterCanvasLayoutCategory(BagsFramePanel, BagsFramePanel.name, BagsFramePanel.name);
category.ID = BagsFramePanel.name;
Settings.RegisterAddOnCategory(category)


local BagsFrameEventFrame = CreateFrame("Frame");
BagsFrameEventFrame:RegisterEvent("ADDON_LOADED");
BagsFrameEventFrame:RegisterEvent("PLAYER_LOGOUT");
BagsFrameEventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW");
BagsFrameEventFrame:RegisterEvent("BANKFRAME_CLOSED");
BagsFrameEventFrame:RegisterEvent("BANKFRAME_OPENED");
--BagsFrameEventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
BagsFrameEventFrame:RegisterEvent("MERCHANT_SHOW");
BagsFrameEventFrame:RegisterEvent("AUCTION_HOUSE_SHOW");



function BagsFrameEventFrame.Stuff(frame,button)
	frame:ClearAllPoints()
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:RegisterForDrag("LeftButton", "RightButton");
	frame:SetClampedToScreen(true)

	frame:SetScript("OnMouseDown", function(self, button)
		if MoveBagsF_DB.BagsSetting.locked == false then
			if button == "LeftButton" and not self.isMoving then
				Mixin(self, BackdropTemplateMixin);
				self:StartMoving();
				self.isMoving = true;
			end
		else
			return
		end
	end);
	frame:SetScript("OnMouseUp", function(self)
		Mixin(self, BackdropTemplateMixin)
		self:SetBackdropColor(0,0,0,0)
		self:StopMovingOrSizing()
		self.isMoving = false
		
		local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
		local dbKey = BagFramesMap[self]

		if dbKey then
			local db = MoveBagsF_DB.BagsSetting.perChar and MoveBagsPC_DB or MoveBagsF_DB
			
			db[dbKey].point = point
			db[dbKey].relativePoint = relativePoint
			db[dbKey].x = xOfs
			db[dbKey].y = yOfs
			
			BagsFrameEventFrame.ReMoveStuff()
		end
	end)
end


BagsFrameEventFrame.ReagentColors6 = CreateFrame("Frame")
BagsFrameEventFrame.ReagentColors6:SetPoint("CENTER", ContainerFrame6.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.ReagentColors6:SetParent(ContainerFrame6.Bg)
BagsFrameEventFrame.ReagentColors6:SetSize(100,100)
BagsFrameEventFrame.ReagentColors6.Tex = BagsFrameEventFrame.ReagentColors6:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.ReagentColors6.Tex:SetAllPoints(ContainerFrame6.Bg)
BagsFrameEventFrame.ReagentColors6.Tex:SetColorTexture(.49,1.0,.49,.2)

--BagsFrameEventFrame.BankColors7 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors7:SetPoint("CENTER", ContainerFrame7.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors7:SetParent(ContainerFrame7.Bg)
--BagsFrameEventFrame.BankColors7:SetSize(100,100)
--BagsFrameEventFrame.BankColors7.Tex = BagsFrameEventFrame.BankColors7:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors7.Tex:SetAllPoints(ContainerFrame7.Bg)
--BagsFrameEventFrame.BankColors7.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors8 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors8:SetPoint("CENTER", ContainerFrame8.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors8:SetParent(ContainerFrame8.Bg)
--BagsFrameEventFrame.BankColors8:SetSize(100,100)
--BagsFrameEventFrame.BankColors8.Tex = BagsFrameEventFrame.BankColors8:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors8.Tex:SetAllPoints(ContainerFrame8.Bg)
--BagsFrameEventFrame.BankColors8.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors9 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors9:SetPoint("CENTER", ContainerFrame9.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors9:SetParent(ContainerFrame9.Bg)
--BagsFrameEventFrame.BankColors9:SetSize(100,100)
--BagsFrameEventFrame.BankColors9.Tex = BagsFrameEventFrame.BankColors9:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors9.Tex:SetAllPoints(ContainerFrame9.Bg)
--BagsFrameEventFrame.BankColors9.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors10 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors10:SetPoint("CENTER", ContainerFrame10.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors10:SetParent(ContainerFrame10.Bg)
--BagsFrameEventFrame.BankColors10:SetSize(100,100)
--BagsFrameEventFrame.BankColors10.Tex = BagsFrameEventFrame.BankColors10:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors10.Tex:SetAllPoints(ContainerFrame10.Bg)
--BagsFrameEventFrame.BankColors10.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors11 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors11:SetPoint("CENTER", ContainerFrame11.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors11:SetParent(ContainerFrame11.Bg)
--BagsFrameEventFrame.BankColors11:SetSize(100,100)
--BagsFrameEventFrame.BankColors11.Tex = BagsFrameEventFrame.BankColors11:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors11.Tex:SetAllPoints(ContainerFrame11.Bg)
--BagsFrameEventFrame.BankColors11.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors12 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors12:SetPoint("CENTER", ContainerFrame12.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors12:SetParent(ContainerFrame12.Bg)
--BagsFrameEventFrame.BankColors12:SetSize(100,100)
--BagsFrameEventFrame.BankColors12.Tex = BagsFrameEventFrame.BankColors12:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors12.Tex:SetAllPoints(ContainerFrame12.Bg)
--BagsFrameEventFrame.BankColors12.Tex:SetColorTexture(1,.75,0,.2)
--
--BagsFrameEventFrame.BankColors13 = CreateFrame("Frame")
--BagsFrameEventFrame.BankColors13:SetPoint("CENTER", ContainerFrame13.Bg, "CENTER", 0, 0);
--BagsFrameEventFrame.BankColors13:SetParent(ContainerFrame13.Bg)
--BagsFrameEventFrame.BankColors13:SetSize(100,100)
--BagsFrameEventFrame.BankColors13.Tex = BagsFrameEventFrame.BankColors13:CreateTexture(nil, "ARTWORK", nil, 0)
--BagsFrameEventFrame.BankColors13.Tex:SetAllPoints(ContainerFrame13.Bg)
--BagsFrameEventFrame.BankColors13.Tex:SetColorTexture(1,.75,0,.2)


function BagsFrameEventFrame.StartUp()
	BagsFrameEventFrame.Stuff(ContainerFrameCombinedBags);
	BagsFrameEventFrame.Stuff(ContainerFrame1);
	BagsFrameEventFrame.Stuff(ContainerFrame2);
	BagsFrameEventFrame.Stuff(ContainerFrame3);
	BagsFrameEventFrame.Stuff(ContainerFrame4);
	BagsFrameEventFrame.Stuff(ContainerFrame5);
	
	BagsFrameEventFrame.Stuff(ContainerFrame6);

	--BagsFrameEventFrame.Stuff(ContainerFrame7);
	--BagsFrameEventFrame.Stuff(ContainerFrame8);
	--BagsFrameEventFrame.Stuff(ContainerFrame9);
	--BagsFrameEventFrame.Stuff(ContainerFrame10);
	--BagsFrameEventFrame.Stuff(ContainerFrame11);
	--BagsFrameEventFrame.Stuff(ContainerFrame12);
	--BagsFrameEventFrame.Stuff(ContainerFrame13);
	--[[
	BagsFrameEventFrame.Stuff(BankFrame);
]]

end

local function MergeDefaults(target, defaults)
	for k, v in pairs(defaults) do
		if type(v) == "table" then
			if type(target[k]) ~= "table" then
				target[k] = {}
			end
			MergeDefaults(target[k], v)
		elseif target[k] == nil then
			target[k] = v
		end
	end
end

function BagsFrameEventFrame.CheckSVs()
	MoveBagsF_DB = MoveBagsF_DB or {}
	MoveBagsPC_DB = MoveBagsPC_DB or {}

	MergeDefaults(MoveBagsF_DB, defaultsTable)
	MergeDefaults(MoveBagsPC_DB, defaultsTable)
	
	for _, dbKey in pairs(BagFramesMap) do
		if MoveBagsF_DB[dbKey] then MoveBagsF_DB[dbKey].height = nil end
		if MoveBagsPC_DB[dbKey] then MoveBagsPC_DB[dbKey].height = nil end
	end
end

function BagsFrameEventFrame.ReMoveStuff()
	--if InCombatLockdown() then return end
	
	BagsFrameEventFrame.CheckSVs()
	local db = MoveBagsF_DB.BagsSetting.perChar and MoveBagsPC_DB or MoveBagsF_DB

	for frame, dbKey in pairs(BagFramesMap) do
		local settings = db[dbKey]
		if settings then
			frame:ClearAllPoints()
			frame:SetPoint(settings.point, UIParent, settings.relativePoint, settings.x, settings.y)
			frame:SetScale(db.BagsSetting.scale)
		end
	end
end

function BagsFrameEventFrame.TokenChange()
	--if InCombatLockdown() then return end
	
	BagsFrameEventFrame.CheckSVs()
	local db = MoveBagsF_DB.BagsSetting.perChar and MoveBagsPC_DB or MoveBagsF_DB

	for frame, dbKey in pairs(BagFramesMap) do
		local settings = db[dbKey]
		if settings then
			frame:ClearAllPoints()
			frame:SetPoint(settings.point, UIParent, settings.relativePoint, settings.x, settings.y)
			frame:SetScale(db.BagsSetting.scale)
		end
	end
end


EventRegistry:RegisterCallback('ContainerFrame.OnShowTokenWatcher', BagsFrameEventFrame.StartUp)
EventRegistry:RegisterCallback('ContainerFrame.OpenBag', BagsFrameEventFrame.StartUp)
-- Let the UpdateContainerFrameAnchors hook handle the movements naturally
--EventRegistry:RegisterCallback('ItemButton.UpdateItemContextMatching', BagsFrameEventFrame.ReMoveStuff)

--BANKFRAME_OPENED
--ADDON_LOADED "Blizzard_AuctionHouseShared"
--PLAYER_INTERACTION_MANAGER_FRAME_SHOW
--BANKFARME_CLOSED



--ContainerFrame1 -- bottom right, -10, 85
--ContainerFrame2 -- top right, 0, 8
--ContainerFrame3 -- top right, 0, 8
--ContainerFrame4 -- bottom left, -11, 0
--ContainerFrame5 -- top right, 0, 8


function BagsFrameEventFrame:OnEvent(event,arg1)
	if event == "ADDON_LOADED" and arg1 == "MovableBagFrames" then
		BagsFrameEventFrame.CheckSVs()

		BagsFramePanel.CBSlider:SetValue(MoveBagsF_DB.BagsSetting.scale*100);
		BagsFramePanel.CBCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.locked);
		BagsFramePanel.SortCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.sort);
		BagsFramePanel.InsertCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.insert);
		C_Container.SetSortBagsRightToLeft(MoveBagsF_DB.BagsSetting.sort)
		C_Container.SetInsertItemsLeftToRight(MoveBagsF_DB.BagsSetting.insert)

		BagsFramePanel.ClickBagCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.click);
		BagsFramePanel.CharSpecificCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.perChar);
	end
	if event ~= "ADDON_LOADED" then
		BagsFrameEventFrame.ReMoveStuff()
	end
end
BagsFrameEventFrame:SetScript("OnEvent",BagsFrameEventFrame.OnEvent);


 -- "fix" button click, no longer taints
function BagsFrameEventFrame.Test()
	if MoveBagsF_DB.BagsSetting.perChar == true then
		if MoveBagsPC_DB.BagsSetting.click == true then
			BagsFrameEventFrame.ReMoveStuff()
		end
	else
		if MoveBagsF_DB.BagsSetting.click == true then
			BagsFrameEventFrame.ReMoveStuff()
		end
	end
end

hooksecurefunc("UpdateContainerFrameAnchors", function()
	--if not InCombatLockdown() then
		BagsFrameEventFrame.ReMoveStuff()
	--end
end)