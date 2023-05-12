local function executeMulticlientCheck()
    local ipList = {}
    local players = Game.getPlayers()
    for i = 1, #players do
        local tmpPlayer = players[i]
        local ip = tmpPlayer:getIp()
        if ip ~= 0 then
            local list = ipList[ip]
            if not list then
                ipList[ip] = {}
                list = ipList[ip]
            end
            list[#list + 1] = tmpPlayer
        end
    end

    for ip, list in pairs(ipList) do
        local listLength = #list
        if listLength > 1 then
            local tmpPlayer = list[1]
            local message = ("%s: %s [%d]"):format(Game.convertIpToString(ip), tmpPlayer:getName(), tmpPlayer:getLevel())
            for i = 2, listLength do
                tmpPlayer = list[i]
                message = ("%s, %s [%d]"):format(message, tmpPlayer:getName(), tmpPlayer:getLevel())
            end

            local playerName = db.escapeString(tmpPlayer:getName())
            local timestamp = os.time()
            local formattedTimestamp = os.date('%Y-%m-%d %H:%M:%S', timestamp)

            db.query("INSERT INTO `mc_check` (`mc_message`, `mc_time`) VALUES (" ..
            db.escapeString(message) .. ", " .. db.escapeString(formattedTimestamp) .. ")")
        end
    end
end

function onThink(interval)
    if interval % 10000 == 0 then
        executeMulticlientCheck()
    end
    return true
end
