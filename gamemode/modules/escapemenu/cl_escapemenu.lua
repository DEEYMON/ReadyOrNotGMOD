/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 14:45:22
 * @ Modified by: deymon
 * @ Modified time: 2022-06-27 22:59:11
 */

local escMenu = escMenu or {}
local newEsc
local toLegacy = false

local iLastScreenH = false

local grey = Color(100,100,100,50)
local lgrey = Color(150,150,150,50)
local red = Color(255,50,50,255)
local invis = Color(0,0,0,0)
local white = Color(255,255,255)

local function scaleVGUI()
    local iH = ScrH()
    if iLastScreenH and ( iLastScreenH == iH ) then
        return iMargin, iRoundness
    end

    local ceil = math.ceil
    local iFontSize1 = ceil( iH * .02 )

    surface.CreateFont( "ron.ButtonFont", { font = "Smooch Sans ExtraLight", size = iFontSize1 } )
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
        name = "options",
        display = "OPTIONS",
        func = function()
            gui.ActivateGameUI()
            RunConsoleCommand( "gamemenucommand", "OpenOptionsDialog" )
        end
    },
    [3] = {
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

        draw.SimpleText( GAMEMODE.Name .. " " .. GAMEMODE.Version, "ron.ButtonFont", ( w * .15 ) / 2, h * .94, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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

        draw.SimpleText("QUIT TO MAIN MENU", "ron.ButtonFont", w/2,h/2 - 1, leaveTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    leaveButton.OnCursorEntered = function()
        leaveColor = red
        leaveTextColor = white

        surface.PlaySound("readyornot/gui/next.ogg")
    end
    leaveButton.OnCursorExited = function()
        leaveColor = invis
        leaveTextColor = red
    end

    leaveButton.DoClick = function()

        RunConsoleCommand("disconnect")
        surface.PlaySound("readyornot/gui/click.ogg")

    end

    for k,v in pairs(buttons) do

        k = #buttons - k

        local selectedColor = grey
        
        local button = vgui.Create("DButton", newEsc)
        button:SetSize(ScrW() * .1, ScrH() * .03)
        button:SetPos( ScrW() * .05, ScrH() * .84 - ( ScrH() * .035 * k ) )
        button:SetText("")
        function button:Paint(w,h)

            surface.SetDrawColor(selectedColor)
            surface.DrawRect(0,0,w,h)

            draw.SimpleText(v.display, "ron.ButtonFont", w/2,h/2 - 1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

        function button:DoClick()
            v.func()
            surface.PlaySound("readyornot/gui/click.ogg")
        end

        button.OnCursorEntered = function()
            selectedColor = lgrey

            surface.PlaySound("readyornot/gui/next.ogg")
        end
        button.OnCursorExited = function()
            selectedColor = grey
        end

    end
end