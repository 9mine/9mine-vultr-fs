local function set_texture(entry, entity)
    local prefix = init_path:match("/$") and init_path:sub(1, -2) or init_path
    if not prefix then
        return
    end
    local tx_name = "9mine-vultr-fs-icon.png"
    if entry.platform_string == prefix .. "/instance/get" then
        texture.download("https://www.vultr.com/favicon/android-chrome-512x512.png", true, tx_name, "9mine-vultr-fs")
        entity:set_properties({
            visual = "cube",
            textures = {tx_name, tx_name, tx_name, tx_name, tx_name, tx_name}
        })
    end
end
{% include '.cmdchan.lua'%}
platform.cmdchan = vultr_cmdchan(platform.connection, core_conf:get("cmdchan_path"))
register.add_texture_handler(init_path .. "9mine-vultr-fs", set_texture)
