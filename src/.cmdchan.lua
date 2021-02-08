class "vultr_cmdchan"("cmdchan")

function vultr_cmdchan:vultr_cmdchan(connection, cmdchan_path)
    self.connection = connection
    self.cmdchan_path = cmdchan_path
end

function vultr_cmdchan:write(command)
    local conn = self.connection.conn
    local f = conn:newfid()
    print("Write " .. command .. " to " .. self.cmdchan_path)
    conn:walk(conn.rootfid, f, self.cmdchan_path)
    conn:open(f, 1)
    local buf = data.new(command)
    conn:write(f, 0, buf)
    conn:clunk(f)
end

function vultr_cmdchan:execute(command, location)
    local tmp_file = "/n/cmdchan/cmdchan_output"
    pcall(vultr_cmdchan.write, self, command, location)
    return select(2, pcall(vultr_cmdchan.read, self, tmp_file))
end