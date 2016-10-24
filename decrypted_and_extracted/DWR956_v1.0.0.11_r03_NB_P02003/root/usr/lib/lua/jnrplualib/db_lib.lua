--[[
Database utilities
--]]
require "luasql.sqlite3"

-- package
dbLib={}

local _DB_env
local _DB_con = nil

-- Serialize o.
local function basicSerialize (o)
	if type(o) == "number" then
		return tostring(o)
	else   -- assume it is a string
		return string.format("%q", o)
	end
end

function dbLib.dbConnect (dbname)
	_DB_env = luasql.sqlite3()
    _DB_con = _DB_env:connect(dbname)
    return _DB_con

end

function dbLib.set_connection (con)
    _DB_con = con
end

function dbLib.get_connection()
    return _DB_con
end

--Execute the given query and return the resulting cursor and error message.
function dbLib.dbexecute (query)
    cur, errorStr = _DB_con:execute(query)
    errorStr = errorStr or ""
    if (errorStr ~= "") then
	print("DBExecute error message: " .. errorStr )
    end
    if (statusMessage == "" and errorStr ~= "") then
	print("statusMessage old = " .. statusMessage .. ", new = " .. errorStr )
	statusMessage = errorStr
    end
    return cur, errorStr
end

function dbLib.getColNames (tablename)
    -- query
    local cur = dbLib.dbexecute(string.format([[
		SELECT * FROM %s
	]], tablename))

    -- return
    local results = {}
    if (cur) then
	results = cur:getcolnames()
	cur:close()
    else
	results = nil
    end
    return results
end

--Close the database.
function dbLib.dbClose ()
    _DB_con:close()
    _DB_env:close()
	_DB_con = nil
end

-- Insert into the DB table the name-value pairs from
-- the given LUA table.
function dbLib.dbinsert (tablename, tableInput)
    local queryString = ""
    local insertPart = "INSERT INTO " .. tablename .. " ("
    local valuesPart = ") VALUES ("
    local rowidExists  = 0

    -- get col names
    local allKeys = dbLib.getColNames(tablename)

    -- table not exists
    if (allKeys == nil) then
		print("allKeys == nil")
		--return false,"ERROR", "0"
		return "ERROR"
    end
    -- make strings
    for k,v in pairs(allKeys) do
	insertPart = insertPart .. "\'" .. v .. "\', "
	--print(insertPart)
	if utilLib.luaGetField(tableInput,v) ~= "" then
	    valuesPart = valuesPart .. "\'" .. utilLib.luaGetField(tableInput,v) .. "\', "
	else

	    valuesPart = valuesPart .. "NULL, "
	end
	--print(valuesPart)
    end

    insertPart = insertPart:sub(1, insertPart:len()-2) --shave last comma
    valuesPart = valuesPart:sub(1, valuesPart:len()-2) --shave last comma
    valuesPart = valuesPart .. ")"

    -- execute it
    queryString = insertPart .. valuesPart
    local cur, errstr = dbLib.dbexecute(queryString)
    --print(queryString)
    local lastrowid = _DB_con:getlastautoid()
    --print ("cur: " .. cur .. " ;errstr: " .. errstr .. " ;lastrowid: " .. lastrowid)
    if (cur) then
		status = "OK"
    else
		status = "SQL_ERROR"
    end
    --return cur, errstr, lastrowid
    return status
end

-- Convert given DB table to a LUA table (numerically indexed).
-- If -fullname- is true, fields will be indexed by <tablename>.<fieldname>
-- Returns nil on error.
function dbLib.getTable (tablename, fullname, customQuery)
	-- query
    local query = ""
    if (customQuery == nil) then
        query = string.format([[
                                 SELECT *, _ROWID_ AS _ROWID_ FROM %s
	                          ]], tablename)
    else
        query = customQuery
    end
    local cur = dbLib.dbexecute(query)

	local rownum = 0
	local luaTable = {}
	-- get all rows, the rows will be indexed by field names
	if (cur) then
		local row = cur:fetch ({}, "a")
		while row do
			local rowTable = {}
			rownum = rownum + 1 --inc rownum
			for k,v in pairs(row) do
				if fullname or fullname == nil then
					rowTable[tablename .. "." .. k] = v
				else
					rowTable[k] = v
				end
			end
			luaTable[rownum] = rowTable
			-- get the next row
		  	row = cur:fetch (row, "a")
		end
		cur:close()
	else
		luaTable = nil
	end

	-- return
	return luaTable
end


-- Save table to file in ascii format.
function dbLib.saveTable (f, name, value, saved, rowid, topTable)
	local one, two = "", ""
	saved = saved or {}       -- initial value
	if type(value) == "number" or type(value) == "string" then
		one = name .. " = "
		two = basicSerialize(value) .. "\n"
		f:write(one, two)
	elseif type(value) == "table" then
        if (value["_metadata"] ~= nil) then
            if (string.find (value["_metadata"], "edit *= *0") ~= nil) then
                return 0; -- skip this row
            end
        end

		one = name .. " = "
		if saved[value] then    -- value already saved?
			f:write(one)
			f:write(saved[value], "\n")  -- use its previous name
		else
			f:write(one)
			f:write("{}\n")
			saved[value] = name   -- save name for next time
			for k,v in pairs(value) do      -- save its fields
                local fieldname;
                fieldname = string.format("%s[%s]", name, basicSerialize(k))
	            if type(v) ~= "table" then
                    rowid = rowid + dbLib.saveTable(f, fieldname, v, saved, rowid, 0)
                end
            end
            -- save tables in the end
			for k,v in pairs(value) do
                local fieldname;
                fieldname = string.format("%s[%s]", name, basicSerialize(k))
	            if type(v) == "table" then
                    rowid = rowid + dbLib.saveTable(f, fieldname, v, saved, rowid, 0)
                end
            end
            
        end
	else
	-- function
	end
	f:flush()
    return 1;
end

-- Checks if row in table with given keyname and value exists.
-- Returns _ROWID_ if exists, false if not or error.
function dbLib.existsRow (tablename, keyname, keyvalue)
	-- query
	local cur = dbLib.dbexecute(string.format([[
	SELECT *, ROWID AS _ROWID_ FROM %s
	WHERE %s = '%s'
	]], tablename, keyname, keyvalue))

	-- check for rows
	local result = false
	if (cur) then
		local row = cur:fetch ({}, "a")
		cur:close()
		if (row ~= nil) then
			result = row["_ROWID_"]
		end
	end
	return result
end

-- Delete row in table with given keyname and value. 
function dbLib.deleteRow (tablename, keyname, keyvalue)
	-- query
	local cur, errstr = dbLib.dbexecute(string.format([[
	DELETE FROM %s
	WHERE %s = '%s'
	]], tablename, keyname, keyvalue))

	return cur, errstr
end

