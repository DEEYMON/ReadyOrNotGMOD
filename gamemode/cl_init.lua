--                      Ready Or Not
--
-- Author:              deymon
-- Date:                03-18-2022
-- Last Modified by:    deymon
-- Last Modified date:  03-18-2022


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