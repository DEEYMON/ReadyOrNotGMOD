/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:24:58
 * @ Modified by: deymon
 * @ Modified time: 2022-06-27 23:14:53
 */

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

include("modules/loadmodules.lua")


-- function GM:CanPlayerSuicide()
-- 	return true
-- end

-- function GM:PlayerDeathThink()
-- 	return true
-- end

function GM:PlayerNoClip()
	return false
end

hook.Add("PlayerInitialSpawn", "ron:Init:PlayerInitialSpawn", function(ply)

	ply:SetCanZoom(false)

end)

