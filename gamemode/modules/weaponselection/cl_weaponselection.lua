
hook.Add("PlayerButtonDown", "ron:PlayerButtonDown", function( ply, key) 

    if key == KEY_1 then
        if not ply:HasWeapon(RON.PlayerCharacter.playerMainWeapon or "") then return end
        input.SelectWeapon(ply:GetWeapon(RON.PlayerCharacter.playerMainWeapon))
    end

    if key == KEY_2 then
        if not ply:HasWeapon(RON.PlayerCharacter.playerSecondaryWeapon or "") then return end
        input.SelectWeapon(ply:GetWeapon(RON.PlayerCharacter.playerSecondaryWeapon))
    end

end)