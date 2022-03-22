if SERVER then
    include("playercharacter/sv_playercharacter.lua")
    AddCSLuaFile("escapemenu/cl_escapemenu.lua")
end

if CLIENT then
    include("escapemenu/cl_escapemenu.lua")
end