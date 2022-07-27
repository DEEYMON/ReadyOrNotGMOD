/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:52:47
 * @ Modified by: deymon
 * @ Modified time: 2022-06-27 23:55:09
 */

if SERVER then
    include("playercharacter/sv_playercharacter.lua")
    include("weaponselection/sv_weaponselection.lua")


    AddCSLuaFile("escapemenu/cl_escapemenu.lua")
    AddCSLuaFile("playercharacter/cl_playercharacter.lua")
    AddCSLuaFile("weaponselection/cl_weaponselection.lua")
end

if CLIENT then
    include("escapemenu/cl_escapemenu.lua")
    include("scoreboard/cl_scoreboard.lua")

    include("playercharacter/cl_playercharacter.lua")
    include("weaponselection/cl_weaponselection.lua")
end