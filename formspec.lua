-- handler for credentials
local function credentials_event(player, formname, fields)
    if formname == "core:vultr_credentials" then
        if fields.quit then
            return
        end
        if fields.send then
            minetest.show_formspec(player_name, "core:none", table.concat(
                {"formspec_version[4]", "size[8,1,false]",
                 "hypertext[0, 0.2; 8, 1;; <bigger><center>Credentials sending . . .<center><bigger>]"}, ""))
            local player_name = player:get_player_name()
            local conn = connections:get_connection(player_name, fields.service_addr, true)
            pcall(np_prot.file_write, conn.conn, "vultr", fields.api_token)
            minetest.show_formspec(player_name, "core:none", table.concat(
                {"formspec_version[4]", "size[8,1,false]",
                 "hypertext[0, 0.2; 8, 1;; <bigger><center>Credentials sent. Check registry<center><bigger>]"}, ""))
            minetest.after(5, function()
                minetest.show_formspec(player_name, "", "")
            end)
        end
    end
end

-- registrer handler for credentials form
register.add_form_handler("core:vultr_credentials", credentials_event)

minetest.show_formspec(player_name, "core:vultr_credentials",
    table.concat({"formspec_version[4]", "size[8,3.7,false]", "field[0,0;0,0;service_addr;;",
                  minetest.formspec_escape(res), "]", "hypertext[0, 0.3; 8, 1;; <bigger><center>Vultr<center><bigger>]",
                  "pwdfield[0.5, 1.5; 7, 0.7;api_token;API Token]", "button[5,2.5;2.5,0.7;send;send]"}, ""))
