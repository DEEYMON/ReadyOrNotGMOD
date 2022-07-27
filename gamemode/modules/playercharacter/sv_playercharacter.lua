/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:38:03
 * @ Modified by: deymon
 * @ Modified time: 2022-06-27 23:56:09
 */

util.AddNetworkString("RON:PlayerCharacter")

sql.Query("CREATE TABLE IF NOT EXISTS ron_PlayerCharacters( steam_id64 TEXT NOT NULL, playerModel TEXT NOT NULL, playerMainWeapon TEXT NOT NULL, playerSecondaryWeapon TEXT NOT NULL, playerTacticalWeapon TEXT NOT NULL, playerGearArmor TEXT NOT NULL, playerGearHead TEXT NOT NULL, playerGrenade TEXT NOT NULL, playerTactical TEXT NOT NULL )")

local characterValidParams = {
    ["playerModel"] = true,
    ["playerMainWeapon"] = true,
    ["playerSecondaryWeapon"] = true,
    ["playerTacticalWeapon"] = true,
    ["playerGearArmor"] = true,
    ["playerGearHead"] = true,
    ["playerGrenade"] = true,
    ["playerTactical"] = true,
}

local function playerExists( steamid )

    local query = sql.Query("SELECT * FROM ron_PlayerCharacters WHERE steam_id64="..sql.SQLStr(steamid))
    if not query then return false end
    return true

end

local function createPlayer( steamid, model )

    model = model or ""

    sql.Query('INSERT INTO ron_PlayerCharacters( steam_id64, playerModel, playerMainWeapon, playerSecondaryWeapon, playerTacticalWeapon, playerGearArmor, playerGearHead, playerGrenade, playerTactical ) VALUES ( ' .. sql.SQLStr(steamid) .. ',' .. sql.SQLStr(model) .. ', "" , "" , "" , "" , "" , "" , "" )')

    print("create")

end

local function updatePlayer( steamid, param, arg )

    sql.Query("UPDATE ron_PlayerCharacters SET " .. sql.SQLStr(param) .. "=" .. sql.SQLStr(arg) .. "WHERE steam_id64=" .. sql.SQLStr(steamid))

end

local function loadPlayer( steamid )

    local playerCharacter = sql.Query("SELECT * FROM ron_PlayerCharacters WHERE steam_id64=" .. sql.SQLStr(steamid))
    if not playerCharacter then playerCharacter = {} end

    return playerCharacter

end

hook.Add("PlayerSpawn", "ron:PlayerCharacter:PIS", function( ply )

    local sid = ply:SteamID64()

    if not playerExists(sid) then createPlayer(sid, "Default Model") end

    local playerCharacter = loadPlayer(sid)[1]
    ply.playerCharacter = playerCharacter

    ply:SetModel( playerCharacter.playerModel )

    ply:Give( weapons.Get(playerCharacter.playerMainWeapon) and playerCharacter.playerMainWeapon or "" )
    ply:Give( weapons.Get(playerCharacter.playerSecondaryWeapon) and playerCharacter.playerSecondaryWeapon or "" )

    net.Start("RON:PlayerCharacter")
    net.WriteTable(playerCharacter)
    net.Send(ply)

end)

concommand.Add("RON_ModifyPlayer", function( ply, cmd, args )

    if not args or #args < 3 then RON:Log("Invalid usage. [steamid64] [parameter] [value]", false) return end
    if not args[1]:StartWith("7656") or args[1]:len() < 16 then RON:Log("Invalid usage. [steamid64] [parameter] [value]", false) return end
    if not characterValidParams[args[2]] then RON:Log("Invalid usage. [steamid64] [parameter] [value]", false) return end
    updatePlayer(args[1],args[2],args[3])
    RON:Log("You modified " .. args[2] .. " of " .. args[1] .. " to " .. args[3], true)

end)