--                      Ready Or Not
--
-- Author:              deymon
-- Date:                03-18-2022
-- Last Modified by:    deymon
-- Last Modified date:  03-18-2022

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function GM:CanPlayerSuicide()
	return false
end

function GM:PlayerDeathThink()
	return false
end

function GM:PlayerNoClip()
	return false
end