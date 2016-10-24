--[[
config import lib
--]]
require "luasql.sqlite3"
require "jnrplualib/util_lib"
require "lfs"

configLib= {}
local checksum = ""
local resetFlag = "false"
local patchFlag = "false"

function configLib.readSaveTbl(filename)
    saveTables= {}
	local attr = lfs.attributes(filename)
	if (attr ~= nil) then
		dofile(filename)
		if saveTables ~= nil then
			for i,j in pairs(saveTables) do
				print(utilLib.tableToPrint(saveTables[i]))
			end
		end
	else
		print("readSaveTbl: open " .. filename .. " failed");
	end
end

function configLib.readAllTbl(filename)
 config = {}
 local attr = lfs.attributes(filename)
 local status = "OK"
 if (attr ~= nil) then
		--dofile (filename)
		res, message = pcall(dofile, filename)
		if config ~= nil then
			--Add_20130715
			if (res ~= true) then
			  print(message)
			  print("readAllTbl: Config content format error")
			  return "ERROR"
			end
			status = configLib.importAllTbl()
		else
			print("readAllTbl: Config is nil")
			status = "ERROR"
		end
	else
		print("readAllTbl: open " .. filename .. " failed");
		status = "ERROR"
	end

	return status
end

function configLib.import_db(index,tblname,table)
    local status = "OK"
    print("@@ import table name: " .. tblname)
    status = dbLib.dbinsert (tblname, table)
    return status
end

function configLib.importAllTbl()
	local status = "OK"
	if config ~= nil and type(config) == "table" then
		for key1,tbl in pairs(config) do
			--print ("loop key1 " .. key1)
			--print (utilLib.tableToPrint(tbl[2]))
			if key1 == "checksum" then
				checksum = tbl
				--print("checksum: " .. checksum)
			elseif key1 == "reset" then
				resetFlag = tbl
				--print("resetFlag: " .. resetFlag)
			elseif key1 == "patch" then
				patchFlag = tbl
				--print("patchFlag: " .. patchFlag)
			else
				if tbl ~= nil and type(tbl) == "table" then
					for i,rows in pairs(tbl) do
						status = configLib.import_db(i,key1,rows)
					end
				else
					print("importAllTbl: tbl == nil")
					status = "ERROR"
				end
			end

		end
	else
		print("importAllTbl: config is nil")
		status = "ERROR"
	end

	return status
end

function configLib.importDB(dbName, curPath)
	local status = ""
	dbLib.dbConnect(dbName)
	status = configLib.readAllTbl(curPath)
	dbLib.dbClose()
	return status
end
