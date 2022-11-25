local defaultsTable = {
	CBBagsFrame = {x = -10, y = -85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	
	S1BagsFrame = {x = -10, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	S2BagsFrame = {x = -10, y = 10, point = "RIGHT", relativePoint = "RIGHT",},
	S3BagsFrame = {x = -10, y = -1, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	S4BagsFrame = {x = -200, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	S5BagsFrame = {x = -200, y = 75, point = "RIGHT", relativePoint = "RIGHT",},


	BankFrame = {x = 0, y = 8, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},

	BK7Frame = {x = -450, y = 85, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
	BK8Frame = {x = -450, y = -177, point = "RIGHT", relativePoint = "RIGHT",},
	BK9Frame = {x = -450, y = 50, point = "RIGHT", relativePoint = "RIGHT",},
	BK10Frame = {x = -450, y = -210, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	BK11Frame = {x = -450, y = 0, point = "TOPRIGHT", relativePoint = "TOPRIGHT",},
	BK12Frame = {x = 338, y = 85, point = "BOTTOM", relativePoint = "BOTTOM",},
	BK13Frame = {x = 338, y = -177, point = "CENTER", relativePoint = "CENTER",},

	RBBagsFrame = {x = -224, y = -165, point = "RIGHT", relativePoint = "RIGHT",},

	BagsSetting = {show = true, checked = true, scale = 1, locked = false, click = true, sort = false, insert = false},
	
};


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
getglobal(BagsFramePanel.SortCheckbox:GetName().."Text"):SetText("Sort Bags Right to Left\n(Reagents may not be sorted into reagent bag)");
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


InterfaceOptions_AddCategory(BagsFramePanel);


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
	frame:SetUserPlaced(true);
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
		Mixin(self, BackdropTemplateMixin);
		frame:SetBackdropColor(0,0,0,0);
		self:StopMovingOrSizing();
		self.isMoving = false;
		local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint();
		--[[ --debug
		frame:SetPoint(point, nil, relativePoint, xOfs, yOfs);
		print("point: " .. point) -- nil
		--print("relativeTo: " .. relativeTo) -- nil
		print("relativePoint: " .. relativePoint) -- nil
		print("xOfs: " .. xOfs)
		print("yOfs: " .. yOfs)
		]]
		if frame == ContainerFrameCombinedBags then
			MoveBagsF_DB.CBBagsFrame.point = point
			MoveBagsF_DB.CBBagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.CBBagsFrame.x = xOfs
			MoveBagsF_DB.CBBagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame1 then
			MoveBagsF_DB.S1BagsFrame.point = point
			MoveBagsF_DB.S1BagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.S1BagsFrame.x = xOfs
			MoveBagsF_DB.S1BagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame2 then
			MoveBagsF_DB.S2BagsFrame.point = point
			MoveBagsF_DB.S2BagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.S2BagsFrame.x = xOfs
			MoveBagsF_DB.S2BagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame3 then
			MoveBagsF_DB.S3BagsFrame.point = point
			MoveBagsF_DB.S3BagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.S3BagsFrame.x = xOfs
			MoveBagsF_DB.S3BagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame4 then
			MoveBagsF_DB.S4BagsFrame.point = point
			MoveBagsF_DB.S4BagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.S4BagsFrame.x = xOfs
			MoveBagsF_DB.S4BagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame5 then
			MoveBagsF_DB.S5BagsFrame.point = point
			MoveBagsF_DB.S5BagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.S5BagsFrame.x = xOfs
			MoveBagsF_DB.S5BagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame6 then
			MoveBagsF_DB.RBBagsFrame.point = point
			MoveBagsF_DB.RBBagsFrame.relativePoint = relativePoint
			MoveBagsF_DB.RBBagsFrame.x = xOfs
			MoveBagsF_DB.RBBagsFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame7 then
			MoveBagsF_DB.BK7Frame.point = point
			MoveBagsF_DB.BK7Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK7Frame.x = xOfs
			MoveBagsF_DB.BK7Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame8 then
			MoveBagsF_DB.BK8Frame.point = point
			MoveBagsF_DB.BK8Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK8Frame.x = xOfs
			MoveBagsF_DB.BK8Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame9 then
			MoveBagsF_DB.BK9Frame.point = point
			MoveBagsF_DB.BK9Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK9Frame.x = xOfs
			MoveBagsF_DB.BK9Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame10 then
			MoveBagsF_DB.BK10Frame.point = point
			MoveBagsF_DB.BK10Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK10Frame.x = xOfs
			MoveBagsF_DB.BK10Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame11 then
			MoveBagsF_DB.BK11Frame.point = point
			MoveBagsF_DB.BK11Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK11Frame.x = xOfs
			MoveBagsF_DB.BK11Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame12 then
			MoveBagsF_DB.BK12Frame.point = point
			MoveBagsF_DB.BK12Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK12Frame.x = xOfs
			MoveBagsF_DB.BK12Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == ContainerFrame13 then
			MoveBagsF_DB.BK13Frame.point = point
			MoveBagsF_DB.BK13Frame.relativePoint = relativePoint
			MoveBagsF_DB.BK13Frame.x = xOfs
			MoveBagsF_DB.BK13Frame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end

		if frame == BankFrame then
			MoveBagsF_DB.BankFrame.point = point
			MoveBagsF_DB.BankFrame.relativePoint = relativePoint
			MoveBagsF_DB.BankFrame.x = xOfs
			MoveBagsF_DB.BankFrame.y = yOfs
			BagsFrameEventFrame.ReMoveStuff()
		end
	end);
end


BagsFrameEventFrame.ReagentColors6 = CreateFrame("Frame")
BagsFrameEventFrame.ReagentColors6:SetPoint("CENTER", ContainerFrame6.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.ReagentColors6:SetParent(ContainerFrame6.Bg)
BagsFrameEventFrame.ReagentColors6:SetSize(100,100)
BagsFrameEventFrame.ReagentColors6.Tex = BagsFrameEventFrame.ReagentColors6:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.ReagentColors6.Tex:SetAllPoints(ContainerFrame6.Bg)
BagsFrameEventFrame.ReagentColors6.Tex:SetColorTexture(.49,1.0,.49,.2)

BagsFrameEventFrame.BankColors7 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors7:SetPoint("CENTER", ContainerFrame7.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors7:SetParent(ContainerFrame7.Bg)
BagsFrameEventFrame.BankColors7:SetSize(100,100)
BagsFrameEventFrame.BankColors7.Tex = BagsFrameEventFrame.BankColors7:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors7.Tex:SetAllPoints(ContainerFrame7.Bg)
BagsFrameEventFrame.BankColors7.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors8 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors8:SetPoint("CENTER", ContainerFrame8.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors8:SetParent(ContainerFrame8.Bg)
BagsFrameEventFrame.BankColors8:SetSize(100,100)
BagsFrameEventFrame.BankColors8.Tex = BagsFrameEventFrame.BankColors8:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors8.Tex:SetAllPoints(ContainerFrame8.Bg)
BagsFrameEventFrame.BankColors8.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors9 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors9:SetPoint("CENTER", ContainerFrame9.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors9:SetParent(ContainerFrame9.Bg)
BagsFrameEventFrame.BankColors9:SetSize(100,100)
BagsFrameEventFrame.BankColors9.Tex = BagsFrameEventFrame.BankColors9:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors9.Tex:SetAllPoints(ContainerFrame9.Bg)
BagsFrameEventFrame.BankColors9.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors10 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors10:SetPoint("CENTER", ContainerFrame10.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors10:SetParent(ContainerFrame10.Bg)
BagsFrameEventFrame.BankColors10:SetSize(100,100)
BagsFrameEventFrame.BankColors10.Tex = BagsFrameEventFrame.BankColors10:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors10.Tex:SetAllPoints(ContainerFrame10.Bg)
BagsFrameEventFrame.BankColors10.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors11 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors11:SetPoint("CENTER", ContainerFrame11.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors11:SetParent(ContainerFrame11.Bg)
BagsFrameEventFrame.BankColors11:SetSize(100,100)
BagsFrameEventFrame.BankColors11.Tex = BagsFrameEventFrame.BankColors11:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors11.Tex:SetAllPoints(ContainerFrame11.Bg)
BagsFrameEventFrame.BankColors11.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors12 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors12:SetPoint("CENTER", ContainerFrame12.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors12:SetParent(ContainerFrame12.Bg)
BagsFrameEventFrame.BankColors12:SetSize(100,100)
BagsFrameEventFrame.BankColors12.Tex = BagsFrameEventFrame.BankColors12:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors12.Tex:SetAllPoints(ContainerFrame12.Bg)
BagsFrameEventFrame.BankColors12.Tex:SetColorTexture(1,.75,0,.2)

BagsFrameEventFrame.BankColors13 = CreateFrame("Frame")
BagsFrameEventFrame.BankColors13:SetPoint("CENTER", ContainerFrame13.Bg, "CENTER", 0, 0);
BagsFrameEventFrame.BankColors13:SetParent(ContainerFrame13.Bg)
BagsFrameEventFrame.BankColors13:SetSize(100,100)
BagsFrameEventFrame.BankColors13.Tex = BagsFrameEventFrame.BankColors13:CreateTexture(nil, "ARTWORK", nil, 0)
BagsFrameEventFrame.BankColors13.Tex:SetAllPoints(ContainerFrame13.Bg)
BagsFrameEventFrame.BankColors13.Tex:SetColorTexture(1,.75,0,.2)


function BagsFrameEventFrame.StartUp()
	BagsFrameEventFrame.Stuff(ContainerFrameCombinedBags);
	BagsFrameEventFrame.Stuff(ContainerFrame1);
	BagsFrameEventFrame.Stuff(ContainerFrame2);
	BagsFrameEventFrame.Stuff(ContainerFrame3);
	BagsFrameEventFrame.Stuff(ContainerFrame4);
	BagsFrameEventFrame.Stuff(ContainerFrame5);
	
	BagsFrameEventFrame.Stuff(ContainerFrame6);

	BagsFrameEventFrame.Stuff(ContainerFrame7);
	BagsFrameEventFrame.Stuff(ContainerFrame8);
	BagsFrameEventFrame.Stuff(ContainerFrame9);
	BagsFrameEventFrame.Stuff(ContainerFrame10);
	BagsFrameEventFrame.Stuff(ContainerFrame11);
	BagsFrameEventFrame.Stuff(ContainerFrame12);
	BagsFrameEventFrame.Stuff(ContainerFrame13);
	--[[
	BagsFrameEventFrame.Stuff(BankFrame);
]]

end

function BagsFrameEventFrame.CheckSVs()
	--need to fix to prevent future bugs, this should not have been saved
	if MoveBagsF_DB.CBBagsFrame.height then
		MoveBagsF_DB.CBBagsFrame.height = nil
	end
	if MoveBagsF_DB.S1BagsFrame.height then
		MoveBagsF_DB.S1BagsFrame.height = nil
	end
	if MoveBagsF_DB.S2BagsFrame.height then
		MoveBagsF_DB.S2BagsFrame.height = nil
	end
	if MoveBagsF_DB.S3BagsFrame.height then
		MoveBagsF_DB.S3BagsFrame.height = nil
	end
	if MoveBagsF_DB.S4BagsFrame.height then
		MoveBagsF_DB.S4BagsFrame.height = nil
	end
	if MoveBagsF_DB.S5BagsFrame.height then
		MoveBagsF_DB.S5BagsFrame.height = nil
	end
	if MoveBagsF_DB.RBBagsFrame.height then
		MoveBagsF_DB.RBBagsFrame.height = nil
	end
	if MoveBagsF_DB.BK7Frame.height then
		MoveBagsF_DB.BK7Frame.height = nil
	end
	if MoveBagsF_DB.BK8Frame.height then
		MoveBagsF_DB.BK8Frame.height = nil
	end
	if MoveBagsF_DB.BK9Frame.height then
		MoveBagsF_DB.BK9Frame.height = nil
	end
	if MoveBagsF_DB.BK10Frame.height then
		MoveBagsF_DB.BK10Frame.height = nil
	end
	if MoveBagsF_DB.BK11Frame.height then
		MoveBagsF_DB.BK11Frame.height = nil
	end
	if MoveBagsF_DB.BK12Frame.height then
		MoveBagsF_DB.BK12Frame.height = nil
	end
	if MoveBagsF_DB.BK13Frame.height then
		MoveBagsF_DB.BK13Frame.height = nil
	end

	if MoveBagsF_DB == nil then
		MoveBagsF_DB = defaultsTable
	end

	if MoveBagsF_DB.CBBagsFrame.x == nil then
		MoveBagsF_DB.CBBagsFrame = defaultsTable.CBBagsFrame
	end

	if MoveBagsF_DB.S1BagsFrame.x == nil then
		MoveBagsF_DB.S1BagsFrame = defaultsTable.S1BagsFrame
	end

	if MoveBagsF_DB.S2BagsFrame.x == nil then
		MoveBagsF_DB.S2BagsFrame = defaultsTable.S2BagsFrame
	end

	if MoveBagsF_DB.S3BagsFrame.x == nil then
		MoveBagsF_DB.S3BagsFrame = defaultsTable.S3BagsFrame
	end

	if MoveBagsF_DB.S4BagsFrame.x == nil then
		MoveBagsF_DB.S4BagsFrame = defaultsTable.S4BagsFrame
	end

	if MoveBagsF_DB.S5BagsFrame.x == nil then
		MoveBagsF_DB.S5BagsFrame = defaultsTable.S5BagsFrame
	end

	if MoveBagsF_DB.RBBagsFrame.x == nil then
		MoveBagsF_DB.RBBagsFrame = defaultsTable.RBBagsFrame
	end

	if MoveBagsF_DB.BK7Frame.x == nil then
		MoveBagsF_DB.BK7Frame = defaultsTable.BK7Frame
	end

	if MoveBagsF_DB.BK8Frame.x == nil then
		MoveBagsF_DB.BK8Frame = defaultsTable.BK8Frame
	end

	if MoveBagsF_DB.BK9Frame.x == nil then
		MoveBagsF_DB.BK9Frame = defaultsTable.BK9Frame
	end

	if MoveBagsF_DB.BK10Frame.x == nil then
		MoveBagsF_DB.BK10Frame = defaultsTable.BK10Frame
	end

	if MoveBagsF_DB.BK11Frame.x == nil then
		MoveBagsF_DB.BK11Frame = defaultsTable.BK11Frame
	end

	if MoveBagsF_DB.BK12Frame.x == nil then
		MoveBagsF_DB.BK12Frame = defaultsTable.BK12Frame
	end

	if MoveBagsF_DB.BK13Frame.x == nil then
		MoveBagsF_DB.BK13Frame = defaultsTable.BK13Frame
	end
--[[
	if MoveBagsF_DB.BankFrame == nil then
		MoveBagsF_DB.BankFrame = defaultsTable.BankFrame
	end
	]]

end

function BagsFrameEventFrame.ReMoveStuff()
	BagsFrameEventFrame.CheckSVs()
	ContainerFrameCombinedBags:ClearAllPoints()
	ContainerFrameCombinedBags:SetPoint(MoveBagsF_DB.CBBagsFrame.point, UIParent, MoveBagsF_DB.CBBagsFrame.relativePoint, MoveBagsF_DB.CBBagsFrame.x, MoveBagsF_DB.CBBagsFrame.y);
	ContainerFrameCombinedBags:SetScale(MoveBagsF_DB.BagsSetting.scale);


	ContainerFrame1:ClearAllPoints()
	ContainerFrame1:SetPoint(MoveBagsF_DB.S1BagsFrame.point, UIParent, MoveBagsF_DB.S1BagsFrame.relativePoint, MoveBagsF_DB.S1BagsFrame.x, MoveBagsF_DB.S1BagsFrame.y);
	ContainerFrame1:SetScale(MoveBagsF_DB.BagsSetting.scale);


	ContainerFrame2:ClearAllPoints()
	ContainerFrame2:SetPoint(MoveBagsF_DB.S2BagsFrame.point, UIParent, MoveBagsF_DB.S2BagsFrame.relativePoint, MoveBagsF_DB.S2BagsFrame.x, MoveBagsF_DB.S2BagsFrame.y);
	ContainerFrame2:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame3:ClearAllPoints()
	ContainerFrame3:SetPoint(MoveBagsF_DB.S3BagsFrame.point, UIParent, MoveBagsF_DB.S3BagsFrame.relativePoint, MoveBagsF_DB.S3BagsFrame.x, MoveBagsF_DB.S3BagsFrame.y);
	ContainerFrame3:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame4:ClearAllPoints()
	ContainerFrame4:SetPoint(MoveBagsF_DB.S4BagsFrame.point, UIParent, MoveBagsF_DB.S4BagsFrame.relativePoint, MoveBagsF_DB.S4BagsFrame.x, MoveBagsF_DB.S4BagsFrame.y);
	ContainerFrame4:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame5:ClearAllPoints()
	ContainerFrame5:SetPoint(MoveBagsF_DB.S5BagsFrame.point, UIParent, MoveBagsF_DB.S5BagsFrame.relativePoint, MoveBagsF_DB.S5BagsFrame.x, MoveBagsF_DB.S5BagsFrame.y);
	ContainerFrame5:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame6:ClearAllPoints()
	ContainerFrame6:SetPoint(MoveBagsF_DB.RBBagsFrame.point, UIParent, MoveBagsF_DB.RBBagsFrame.relativePoint, MoveBagsF_DB.RBBagsFrame.x, MoveBagsF_DB.RBBagsFrame.y);
	ContainerFrame6:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame7:ClearAllPoints()
	ContainerFrame7:SetPoint(MoveBagsF_DB.BK7Frame.point, UIParent, MoveBagsF_DB.BK7Frame.relativePoint, MoveBagsF_DB.BK7Frame.x, MoveBagsF_DB.BK7Frame.y);
	ContainerFrame7:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame8:ClearAllPoints()
	ContainerFrame8:SetPoint(MoveBagsF_DB.BK8Frame.point, UIParent, MoveBagsF_DB.BK8Frame.relativePoint, MoveBagsF_DB.BK8Frame.x, MoveBagsF_DB.BK8Frame.y);
	ContainerFrame8:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame9:ClearAllPoints()
	ContainerFrame9:SetPoint(MoveBagsF_DB.BK9Frame.point, UIParent, MoveBagsF_DB.BK9Frame.relativePoint, MoveBagsF_DB.BK9Frame.x, MoveBagsF_DB.BK9Frame.y);
	ContainerFrame9:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame10:ClearAllPoints()
	ContainerFrame10:SetPoint(MoveBagsF_DB.BK10Frame.point, UIParent, MoveBagsF_DB.BK10Frame.relativePoint, MoveBagsF_DB.BK10Frame.x, MoveBagsF_DB.BK10Frame.y);
	ContainerFrame10:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame11:ClearAllPoints()
	ContainerFrame11:SetPoint(MoveBagsF_DB.BK11Frame.point, UIParent, MoveBagsF_DB.BK11Frame.relativePoint, MoveBagsF_DB.BK11Frame.x, MoveBagsF_DB.BK11Frame.y);
	ContainerFrame11:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame12:ClearAllPoints()
	ContainerFrame12:SetPoint(MoveBagsF_DB.BK12Frame.point, UIParent, MoveBagsF_DB.BK12Frame.relativePoint, MoveBagsF_DB.BK12Frame.x, MoveBagsF_DB.BK12Frame.y);
	ContainerFrame12:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame13:ClearAllPoints()
	ContainerFrame13:SetPoint(MoveBagsF_DB.BK13Frame.point, UIParent, MoveBagsF_DB.BK13Frame.relativePoint, MoveBagsF_DB.BK13Frame.x, MoveBagsF_DB.BK13Frame.y);
	ContainerFrame13:SetScale(MoveBagsF_DB.BagsSetting.scale);

	--[[
	BankFrame:ClearAllPoints()
	BankFrame:SetPoint(MoveBagsF_DB.BankFrame.point, UIParent, MoveBagsF_DB.BankFrame.relativePoint, MoveBagsF_DB.BankFrame.x, MoveBagsF_DB.BankFrame.y);
	BankFrame:SetScale(MoveBagsF_DB.BagsSetting.scale);
	]]
end

function BagsFrameEventFrame.TokenChange()
	ContainerFrameCombinedBags:ClearAllPoints()
	ContainerFrameCombinedBags:Hide()
	ContainerFrameCombinedBags:SetScale(MoveBagsF_DB.BagsSetting.scale);


	ContainerFrame1:ClearAllPoints()
	ContainerFrame1:Hide()
	ContainerFrame1:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame2:ClearAllPoints()
	ContainerFrame2:Hide()
	ContainerFrame2:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame3:ClearAllPoints()
	ContainerFrame3:Hide()
	ContainerFrame3:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame4:ClearAllPoints()
	ContainerFrame4:Hide()
	ContainerFrame4:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame5:ClearAllPoints()
	ContainerFrame5:Hide()
	ContainerFrame5:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame6:ClearAllPoints()
	ContainerFrame6:Hide()
	ContainerFrame6:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame7:ClearAllPoints()
	ContainerFrame7:Hide()
	ContainerFrame7:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame8:ClearAllPoints()
	ContainerFrame8:Hide()
	ContainerFrame8:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame9:ClearAllPoints()
	ContainerFrame9:Hide()
	ContainerFrame9:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame10:ClearAllPoints()
	ContainerFrame10:Hide()
	ContainerFrame10:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame11:ClearAllPoints()
	ContainerFrame11:Hide()
	ContainerFrame11:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame12:ClearAllPoints()
	ContainerFrame12:Hide()
	ContainerFrame12:SetScale(MoveBagsF_DB.BagsSetting.scale);

	
	ContainerFrame13:ClearAllPoints()
	ContainerFrame13:Hide()
	ContainerFrame13:SetScale(MoveBagsF_DB.BagsSetting.scale);

	--[[
	BankFrame:ClearAllPoints()
	BankFrame:Hide()
	BankFrame:SetScale(MoveBagsF_DB.BagsSetting.scale);
	]]
end


EventRegistry:RegisterCallback('ContainerFrame.OnShowTokenWatcher', BagsFrameEventFrame.StartUp)
EventRegistry:RegisterCallback('ContainerFrame.OpenBag', BagsFrameEventFrame.StartUp)
EventRegistry:RegisterCallback('ContainerFrame.OpenAllBags', BagsFrameEventFrame.ReMoveStuff)
EventRegistry:RegisterCallback('TokenFrame.OnTokenWatchChanged', BagsFrameEventFrame.TokenChange)
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
		if not MoveBagsF_DB then
			MoveBagsF_DB = defaultsTable;
		end
		if not MoveBagsF_DB.BagsSetting.scale then
			MoveBagsF_DB.BagsSetting.scale = defaultsTable.BagsSetting.scale;
		end
		if MoveBagsF_DB.BagsSetting.click == nil then
			print("setting the click function thing")
			MoveBagsF_DB.BagsSetting.click = defaultsTable.BagsSetting.click;
		end
		if MoveBagsF_DB.BagsSetting.sort == nil then
			MoveBagsF_DB.BagsSetting.sort = defaultsTable.BagsSetting.sort;
		end
		if MoveBagsF_DB.BagsSetting.insert == nil then
			MoveBagsF_DB.BagsSetting.insert = defaultsTable.BagsSetting.insert;
		end
		BagsFramePanel.CBSlider:SetValue(MoveBagsF_DB.BagsSetting.scale*100);
		BagsFramePanel.CBCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.locked);
		BagsFramePanel.SortCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.sort);
		BagsFramePanel.InsertCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.insert);
		C_Container.SetSortBagsRightToLeft(MoveBagsF_DB.BagsSetting.sort)
		C_Container.SetInsertItemsLeftToRight(MoveBagsF_DB.BagsSetting.insert)

		BagsFramePanel.ClickBagCheckbox:SetChecked(MoveBagsF_DB.BagsSetting.click);
		
	end
	if event ~= "ADDON_LOADED" then
		BagsFrameEventFrame.TokenChange()
	end
	if event == "PLAYER_LOGOUT" then
		ContainerFrameCombinedBags:SetUserPlaced(false);
		ContainerFrameCombinedBags:ClearAllPoints();

		ContainerFrame1:SetUserPlaced(false);
		ContainerFrame1:ClearAllPoints();
		
		ContainerFrame2:SetUserPlaced(false);
		ContainerFrame2:ClearAllPoints();
		
		ContainerFrame3:SetUserPlaced(false);
		ContainerFrame3:ClearAllPoints();
		
		ContainerFrame4:SetUserPlaced(false);
		ContainerFrame4:ClearAllPoints();
		
		ContainerFrame5:SetUserPlaced(false);
		ContainerFrame5:ClearAllPoints();
		
		ContainerFrame6:SetUserPlaced(false);
		ContainerFrame6:ClearAllPoints();
		
		ContainerFrame7:SetUserPlaced(false);
		ContainerFrame7:ClearAllPoints();
		
		ContainerFrame8:SetUserPlaced(false);
		ContainerFrame8:ClearAllPoints();
		
		ContainerFrame9:SetUserPlaced(false);
		ContainerFrame9:ClearAllPoints();
		
		ContainerFrame10:SetUserPlaced(false);
		ContainerFrame10:ClearAllPoints();
		
		ContainerFrame11:SetUserPlaced(false);
		ContainerFrame11:ClearAllPoints();
		
		ContainerFrame12:SetUserPlaced(false);
		ContainerFrame12:ClearAllPoints();
		
		ContainerFrame13:SetUserPlaced(false);
		ContainerFrame13:ClearAllPoints();
		
		ContainerFrame13:SetUserPlaced(false);
		ContainerFrame13:ClearAllPoints();
		
		BankFrame:SetUserPlaced(false);
		BankFrame:ClearAllPoints();
	end
end
BagsFrameEventFrame:SetScript("OnEvent",BagsFrameEventFrame.OnEvent);


 -- "fix" button click, no longer taints
function BagsFrameEventFrame.Test()
	if MoveBagsF_DB.BagsSetting.click == true then
		BagsFrameEventFrame.ReMoveStuff()
	end
end
hooksecurefunc('ToggleBag', BagsFrameEventFrame.Test)

function BagsFrameEventFrame.delay()
	RunNextFrame(BagsFrameEventFrame.ReMoveStuff)
end
EventRegistry:RegisterCallback('ContainerFrame.CloseBag', BagsFrameEventFrame.delay)