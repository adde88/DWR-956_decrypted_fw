--[[
-- general utilities
--]]
utilLib={}

function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function utilLib.luaGetField (table,field)
	local ret = ""
	if table ~= nil and field ~= nil then
		for key1,val in pairs(table) do
			if key1 == field then
				return val
			end
		end
	end
	return ret
end

function utilLib.tableToPrint(table)
	if (table == nil) then return "Nil table!" end
	local toReturn = "----- Table: -----\n"
	for k,v in pairs(table) do
		toReturn = toReturn .. "Key = " .. k .. ", Value = " .. v .. "\n"
	end
	return toReturn .. "----------------------\n"
end

-- utilLib.stripLRSpaces - strips the leading and trailing spaces
-- This function strips the leading and trailing spaces on the given string.
-- RETURNS - new string
function utilLib.stripLRSpaces (str)
	if (str == nil) then
		return str
	end
	return string.gsub (str, "^%s*(.-)%s*$", "%1")
end

function utilLib.getAsciiString(varStr,filename)
	require "lfs"
	local strTbl = {}
	--print ("util.getAsciiString: " .. varStr)
	strTbl["name"] = ""
	local attr = lfs.attributes(filename)
	if (attr ~= nil) then
		local file = io.open(filename,"r")
		if (file) then
			for line in file:lines() do
				for var,value in string.gfind (line,"(.-)=(.*)") do
					var = utilLib.stripLRSpaces(var)
					value = utilLib.stripLRSpaces(value)
					if (var == varStr) then
						strTbl[1],strTbl[2],strTbl[3], strTbl["name"] = string.find(value,"([\"'])(.-)%1")
						--print(strTbl[1],strTbl[2],strTbl[3], strTbl["name"])
						return strTbl["name"]
					end
				end
			end
		else
			return ""
		end
		io.close(file)
	end
end

-- Return lua variable with given name in the global environment
-- (does not use lexical scoping).
function utilLib.getLuaVariable(varname)
	print(varname)
	local f = loadstring("return " .. varname)
	print(f)
	return f()
end


-- generate md5 sum for file                                                               
function utilLib.getChecksum(fileName)

	local pfile = io.popen ("cat " .. fileName .. " | grep -v 'checksum' | md5sum  | cut -d' ' -f1")
	local checksum = pfile:read ("*a")
	pfile:close()

	-- remove new line character
	return string.gsub (checksum, "\n", "")
end

-- verify checksum on file
function utilLib.verifyChecksum(fileName)

	-- populate table entires from file
	if (pcall (loadfile (fileName))) then
		dofile (fileName)
	else
		return nil
	end

	-- get checksum from systemConfig tbl
	local checksum_file = config["checksum"]

	-- generate md5sum for file
	local checksum_md5sum = utilLib.getChecksum (fileName)

	-- verify checksum is correct or 0
	if (checksum_file == checksum_md5sum or checksum_file == "0") then
		return "ok"
	else
		return nil
	end
end

-- update checksum in file
function utilLib.updateChecksum(fileName)

	local checksum = utilLib.getChecksum (fileName)

	local file = io.open(fileName .. "", "ab")
	dbLib.saveTable(file, "config.checksum", checksum or 0, false, 1, 1)
	file:close()
end
