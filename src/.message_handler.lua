local function vultr_message_handler(player_name, message)
    if message:match("^vultr%-cli ") then
        local player = minetest.get_player_by_name(player_name)
        local player_graph = graphs:get_player_graph(player_name)
        local platform = player_graph:get_platform(common.get_platform_string(player))
        if not platform then
            return false
        end
        local cmdchan = platform:get_cmdchan()
        if not cmdchan then
            return
        end
        message = message:gsub("^vultr%-cli ", "")

        cmdchan:write(message)
        minetest.chat_send_player(player_name, "Please, wait for response . . . ")
        minetest.after(2, function()
            local function read_response()
                local result, response = pcall(cmdchan.read, cmdchan, "/n/cmdchan/cmdchan_output")
                if not result then
                    minetest.after(2, read_response)
                    return
                end
                minetest.chat_send_player(player_name, message .. "\n" .. response .. "\n")
                cmdchan.show_response(response, player_name)
            end
            read_response()
        end)
        return true
    end
end

register.add_message_handler(init_path .. "vultr_message_handler", vultr_message_handler)
