/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:24:58
 * @ Modified by: deymon
 * @ Modified time: 2022-06-28 00:03:52
 */

include("shared.lua")
include("modules/loadmodules.lua")

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudWeaponSelection = true,
}

hook.Add( "HUDShouldDraw", "ron:RemoveHUDs", function( name )
	if ( hide[ name ] ) then return false end
end )

function GM:HUDDrawTargetID()
end

function GM:HUDWeaponPickedUp()
end

function GM:HUDAmmoPickedUp()
end

function GM:DrawDeathNotice()
end