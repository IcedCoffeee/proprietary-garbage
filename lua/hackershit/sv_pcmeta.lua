local meta = FindMetaTable("Entity")

function meta:IsPC()
	if self.PC == true then
		return true
	end
	return false
end

function meta:GetIP()
	if self:IsPC() then
		return self.IP
	end
	return nil
end

function meta:GetPC()
	if self:IsPC() then
		if file.Exists("hack/servers/" .. self:GetIP() .. ".txt", "DATA") then
			return util.JSONToTable(file.Read("hack/servers/" .. self:GetIP() .. ".txt"))
		end
	end
	return nil
end

function meta:GetFileSystem()
	if self:IsPC() then
		return self:GetPC().files
	end
	return nil
end