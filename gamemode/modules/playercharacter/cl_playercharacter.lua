RON.PlayerCharacter = RON.PlayerCharacter or {}

net.Receive("RON:PlayerCharacter", function( _len )

    local playerCharacter = net.ReadTable()
    print(playerCharacter)
    RON.PlayerCharacter = playerCharacter

end)