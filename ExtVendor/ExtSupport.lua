function ExtVendor_ElvUICheck()
    if (EXTVENDOR.ElvUI_Installed) then return; end
    if (ElvUI) then
        local E = ElvUI[1];
        local S = E:GetModule("Skins");
        
        if ((not E.private.skins.blizzard.enable) or (not E.private.skins.blizzard.merchant)) then return; end
    
        MerchantFrame:SetWidth(690);
        S:HandleButton(MerchantFrameFilterButton);
        local i;
        for i = 13, 20 do
            local button = _G["MerchantItem"..i.."ItemButton"];
            local icon = button.icon;
            local iconBorder = button.IconBorder;
            local item = _G["MerchantItem"..i];
            item:StripTextures(true);
            item:CreateBackdrop("Default");

            button:StripTextures();
            button:StyleButton(false);
            button:SetTemplate("Default", true);
            button:Point("TOPLEFT", item, "TOPLEFT", 4, -4);
            icon:SetTexCoord(unpack(E.TexCoords));
            icon:SetInside();
            iconBorder:SetAlpha(0);
            hooksecurefunc(iconBorder, 'SetVertexColor', function(self, r, g, b)
                self:GetParent():SetBackdropBorderColor(r, g, b);
                self:SetTexture("");
            end);
            hooksecurefunc(iconBorder, 'Hide', function(self)
                self:GetParent():SetBackdropBorderColor(unpack(E.media.bordercolor));
            end);

            _G["MerchantItem"..i.."MoneyFrame"]:ClearAllPoints();
            _G["MerchantItem"..i.."MoneyFrame"]:Point("BOTTOMLEFT", button, "BOTTOMRIGHT", 3, 0);
        end
        
        S:HandleEditBox(MerchantFrameSearchBox);
        
        EXTVENDOR.ElvUI_Installed = true;
    end
end
