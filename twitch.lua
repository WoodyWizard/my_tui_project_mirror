local socket = require("socket")
local toConnect = "ws://irc-ws.chat.twitch.tv:80"

local server = assert(socket.bind("127.0.0.1", 0))
local ip, port = server:getsockname()

print(string.format("telnet %s %s", ip, port))

server:connect("ws://irc-ws.chat.twitch.tv", 80)


while true do
    local line, err = server:receive()


    print(line , " " , err)
end