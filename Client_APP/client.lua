require "gui"

local temp_port
local message

local temp


local window = gui.create_window()   --creates window
window.title = "Client Demo"

local status_text = window:add_label()   --status
status_text.x = 150
status_text.y = 300
status_text.text = "Status"
status_text.word_wrap = true


local port_label = window:add_label()    -- label for port
port_label.x = 120
port_label.y = 100
port_label.text = "Enter Port"
port_label.word_wrap = true


local msg_label = window:add_label()    --label for message
msg_label.x = 120
msg_label.y = 160
msg_label.text = "Enter data"
msg_label.word_wrap = true

local port_text_box = window:add_text_box()     --textbox that takes port as input
port_text_box.x = 200
port_text_box.y = 100
port_text_box.width = 150

local msg_text_box = window:add_text_box()        --textbox that takes message as input
msg_text_box.x = 200
msg_text_box.y = 160
msg_text_box.width = 150

local send_button = window:add_button()        --button to send data
send_button.x = 260
send_button.y = 200
send_button.text = "Send to server"

function port_text_box:on_text_changed()     --function to use port_textbox data
   temp_port = port_text_box.text
end

function msg_text_box:on_text_changed()      --function to use message_textbox data
   message = msg_text_box.text
end

function send_button:on_click()    --function to use send button
  
  local host = "127.0.0.1"
  local port = temp_port
  
  local socket = require("socket")
local tcp = assert(socket.tcp())

tcp:connect(host, port);
--note the newline below
tcp:send(message.."\n")


while true do
    local s, status, partial = tcp:receive()
    print(s or partial)
    
    temp = s or partial
    
   
    if status == "closed" then break end
    status_text.text = temp
    
end

tcp:close()


end


gui.run()