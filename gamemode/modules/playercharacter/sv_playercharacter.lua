/** Ready Or Not
 * @ Author: deymon
 * @ Create Time: 2022-03-18 13:38:03
 * @ Modified by: deymon
 * @ Modified time: 2022-03-18 14:49:02
 */

if not SERVER then return end

sql.Query("CREATE TABLE IF NOT EXISTS ron_PlayerCharacters( steam_id64 TEXT NOT NULL, playerModel TEXT NOT NULL, playerMainWeapon TEXT NOT NULL, playerSecondaryWeapon TEXT NOT NULL, playerTacticalWeapon TEXT NOT NULL, playerGearArmor TEXT NOT NULL, playerGearHead TEXT NOT NULL, playerGrenade TEXT NOT NULL, playerTactical TEXT NOT NULL )")


local function playerExists( steamid )

    local query = sql.Query("SELECT * FROM ron_PlayerCharacters WHERE steam_id64="..sql.SQLStr(steamid))
    if not query then return false end
    return true

end

local function createPlayer( steamid, model )

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

    ply:SetModel( playerCharacter.playerModel )

end)