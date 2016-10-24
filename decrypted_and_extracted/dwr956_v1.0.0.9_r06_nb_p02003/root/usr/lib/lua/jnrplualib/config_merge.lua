--[[
#### File: config_merge.lua
#### Description: System configuration merge functions
]]--


--************* Requires *************


--************* Functions *************

--[[ System configuration patch functions (for specific items) ]]--
local function itemsPatch(pchConfig_Path)

	print("DB items patching...")
	dofile(pchConfig_Path)
end

local function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

local function filterTable (t, f)
	assert (type (t) == "table")
	assert (type (f) == "function")
	local k, v
    local kk, vv
	local result = {}
	for k, v in pairs (t) do
        result[k]={}
	    for kk, vv in pairs (v) do
    	    if f (kk) then result [k][kk] = vv end
        end
  	end 
  	return result
end 

local function tableAppend (table1, table2)
    if (table1 == nil or table2 == nil) then return table1 end
    local k,v
    local kk, vv
    for k, v in pairs (table2) do
        for kk,vv in pairs (v) do
            -- create new row if required
            if (not table1[k]) then
                table1[k]= {}
            end
            table1[k][kk] = vv;
        end -- for
    end -- for

    return table1
end

local function tableSubtract (table1, table2)
	local result = {}
    result = filterTable (table1, 
    function (k)
        local key, value
        local kk, vv
		for key, value in pairs(table2) do
		    for kk, vv in pairs(value) do
                if kk == k then 
                    return true end
            end
        end
      	return false
    end
    )
    return result;
end


--************* Initial Code *************
config = {}
local oldTable = {}
local table = {}


-- verify version if upgrade?
function config.verifyVer(ConfigFile, defaultConfigFile)

	-- get firmware upgrade flag
	local upfwFlag = "false"
	upfwFlag = utilLib.getAsciiString("config.patch", ConfigFile)
	if upfwFlag == nil then
		upfwFlag = utilLib.getAsciiString("config.patch", defaultConfigFile)
	end
	print ("upfwFlag: " .. upfwFlag)

	-- get firmware version from dual image
	local fw_printenv = "fw_printenv "
	-- for XRAG
	local pFileBootPar = io.popen(fw_printenv .. "boot_partition | cut -d= -f2")
	local bootPar = pFileBootPar:read ("*all")
	pFileBootPar:close()
	bootPar = trim(bootPar)

	-- for OGxxxx
	if bootPar ~= "A" and bootPar ~= "B" then
		pFileBootPar = io.popen(fw_printenv .. "kernelname | cut -d= -f2")
		bootPar = pFileBootPar:read ("*all")
		pFileBootPar:close()
		bootPar = trim(bootPar)
		if bootPar == "kernel" then
			bootPar = "A"
		elseif bootPar =="kernelb" then
			bootPar = "B"
		end
	end


	local pFileVerCur
	local pFileVerOld

	if bootPar == "A" then
		pFileVerCur = io.popen(fw_printenv .. "part1_version | cut -d= -f2") or ""
		pFileVerOld = io.popen(fw_printenv .. "part2_version | cut -d= -f2") or ""
	elseif bootPar == "B" then
		pFileVerCur = io.popen(fw_printenv .. "part2_version | cut -d= -f2") or ""
		pFileVerOld = io.popen(fw_printenv .. "part1_version | cut -d= -f2") or ""
	end

	local curVer = pFileVerCur:read ("*all")
	local oldVer = pFileVerOld:read ("*all")
	pFileVerCur:close()
	pFileVerOld:close()
	print("bootPar:" .. bootPar)
	print("curVer:" .. curVer)
	print("oldVer:" .. oldVer)

	if upfwFlag == "true" and curVer ~= oldVer then
		return "true"
	else
		return "false"
	end
end


--************* Logic *************
function config.Merge(DB_Path, curConfig_Path, defConfig_Path, pchConfig_Path)

	dbLib.dbConnect (DB_Path)

	local res
	local SETTINGS_FILE = curConfig_Path
	local saveTables = dbLib.getTable("saveTables", false)

	-- step 1.1: load current configuration from ascii
	res, message = pcall(dofile, SETTINGS_FILE) -- read old configuration
	-- read old configuration failed, using default file
	if (res ~= true) then
		print("configMerge : failed to parse config file. using default...")
		dofile(defConfig_Path)
	end
	-- dofile (SETTINGS_FILE) -- read old configuration

	itemsPatch(pchConfig_Path)

	for k,v in pairs(saveTables) do
		local tableName = v ["tableName"]

		-- record the old table values
		oldTable[tableName] = deepcopy(config[tableName])

		-- clear glob. variables
		_G[tableName] = nil
	end

	-- step 1.2: load new default configuration from ascii
	dofile (defConfig_Path)

	-- step 1.3: merge current and new default configuration
	print("DB items merging...")
	for k,v in pairs(saveTables) do

		local tableName = v ["tableName"]
		local table1 = deepcopy(config[tableName])
		local table2 = oldTable[tableName]

		if (table1 == nil) then

			print ("configMerge : no LUA variable : " .. tableName)
		else

			-- TODO : Handle systemConfig table properly
			if (table2 and tableName ~= "systemConfig") then

				-- make new table compatible for old values
				local allKeys = dbLib.getColNames(tableName);
				for kk,vv in pairs(allKeys) do
					-- skip rowId column
					if (kk ~= "_ROWID_") then
						for kkk,vvv in pairs(table1) do
							-- if column required
							if (not table1[kkk][vv] and table2[kkk] and table2[kkk][vv]) then 
								table1[kkk][vv] = "";
							end
						end -- for
					end
				end -- for

				-- Make old table compatible for merge
				if (#table1 ~= 0) then
					table2 = tableSubtract (table2, table1) 
				end

				-- Update table with old values
				table1 = tableAppend (table1, table2)
			end

			-- Check table intergrity
			for kk,vv in pairs (table1) do
				-- add columns for NOT NULL kind of fields
				if (table1[1]) then
					for key,val in pairs (table1[1]) do
						-- if field is missing from a row
						if (not table1[kk][key]) then
							-- use value from first row
							table1[kk][key] = table1[1][key]
						end
					end
				end
				-- delete rows from table if not needed
				-- (if want to add new row from default file, mark this part)
				if (table2 and not table2[kk]) then
					table1[kk] = nil
				end
			end

			-- Save new table 
			if (#table1 >= 0) then
				table[tableName] = table1;
			end
		end
	end -- for


	-- setp 1.5: save configuration to file
	local file = io.open(SETTINGS_FILE .. "", "wb")

	file:write("config = {}\n")
	dbLib.saveTable(file, "config.reset", "false", false, 1, 1)
	dbLib.saveTable(file, "config.patch", "false", false, 1, 1)

	for k,v in pairs(saveTables) do

		local tableName = v ["tableName"]
		dbLib.saveTable(file, "config." .. tableName, table[tableName], false, 1, 1)
	end

	-- update Checksum
	utilLib.updateChecksum(SETTINGS_FILE)
	dbLib.dbClose() -- close db handle

end

