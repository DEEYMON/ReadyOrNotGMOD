local escMenu = escMenu or {}
local newEsc

local iLastScreenH = false

local grey = Color(100,100,100,50)
local lgrey = Color(150,150,150,50)
local red = Color(255,50,50,255)
local invis = Color(0,0,0,0)
local white = Color(255,255,255)

local function scaleVGUI()
    local iH = ScrH()
    -- if iLastScreenH and ( iLastScreenH == iH ) then
    --     return iMargin, iRoundness
    -- end

    local ceil = math.ceil
    local iFontSize1 = ceil( iH * .02 )

    surface.CreateFont( "ron.ButtonFontt", { font = "Smooch Sans ExtraLight", size = iFontSize1 } )
    iLastScreenH, iMargin, iRoundness = iH, ceil( iH * .008 ), ceil( iH * .006 )

    return iMargin, iRoundness
end

hook.Add("PreRender", "ron:EscapeMenu:PR", function()

    if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
        
        if IsValid(newEsc) then
            gui.HideGameUI()
            newEsc:Remove()
            return
        end

        gui.HideGameUI()
        scaleVGUI()
        escMenu.Open()


    end
end)

local matBlur = Material("pp/blurscreen")

local buttons = {
    [1] = {
        name = "resume",
        display = "RESUME GAME",
        func = function()
            newEsc:Remove()
        end,
    },
    [2] = {
        name = "invite",
        display = "INVITE FRIENDS",
        func = function()
            print("Invite")
        end
    },
    [3] = {
        name = "options",
        display = "OPTIONS",
        func = function()
            print("options")
        end
    },
    [4] = {
        name = "report",
        display = "REPORT BUG",
        func = function()
            print("bug")
        end
    },
}



scaleVGUI()

escMenu.Open = function()
    scaleVGUI()

    gui.EnableScreenClicker(true)

    newEsc = vgui.Create("DFrame")
    newEsc:ShowCloseButton(false)
    newEsc:SetTitle("")
    newEsc:MakePopup()
    newEsc:SetSize(ScrW(), ScrH())

    function newEsc:Paint(w,h)
        surface.SetMaterial( matBlur )
        surface.SetDrawColor( 255, 255, 255, 255 )

        for i=0.33, 1, 0.33 do
            matBlur:SetFloat( "$blur", 1 * 10 * i )
            matBlur:Recompute()
            if ( render ) then render.UpdateScreenEffectTexture() end 
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH() )
        end

        draw.SimpleText( GAMEMODE.Name .. " " .. GAMEMODE.Version, "ron.ButtonFontt", ( w * .15 ) / 2, h * .94, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    function newEsc:OnRemove()
        gui.EnableScreenClicker(false)
    end


    local leaveColor = invis
    local leaveTextColor = red
    local leaveButton = vgui.Create("DButton", newEsc)
    leaveButton:SetSize(ScrW() * .1, ScrH() * .03)
    leaveButton:SetPos( ScrW() * .05, ScrH() * .9)
    leaveButton:SetText("")
    function leaveButton:Paint(w,h)

        surface.SetDrawColor(red)
        surface.DrawOutlinedRect(0,0,w,h,2)

        surface.SetDrawColor(leaveColor)
        surface.DrawRect(0,0,w,h)

        draw.SimpleText("QUIT TO MAIN MENU", "ron.ButtonFontt", w/2,h/2 - 1, leaveTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    leaveButton.OnCursorEntered = function()
        leaveColor = red
        leaveTextColor = white

        chat.PlaySound()
    end
    leaveButton.OnCursorExited = function()
        leaveColor = invis
        leaveTextColor = red
    end

    for k,v in pairs(buttons) do

        local selectedColor = grey
        
        local button = vgui.Create("DButton", newEsc)
        button:SetSize(ScrW() * .1, ScrH() * .03)
        button:SetPos( ScrW() * .05, ScrH() * .7 + ( ScrH() * .035 * k ) )
        button:SetText("")
        function button:Paint(w,h)

            surface.SetDrawColor(selectedColor)
            surface.DrawRect(0,0,w,h)

            draw.SimpleText(v.display, "ron.ButtonFontt", w/2,h/2 - 1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

        function button:DoClick()
            v.func()
        end

        button.OnCursorEntered = function()
            selectedColor = lgrey

            chat.PlaySound()
        end
        button.OnCursorExited = function()
            selectedColor = grey
        end

    end
end