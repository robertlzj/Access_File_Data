--Access_File_Data.lua
local Data2String=require'Data2String'

local IO_Open do
	local Handle=io.popen('CHCP')
	local Code_Page=Handle:read'a'
	Handle:close()
	local IO_Open_Core=io.open
	if string.match(Code_Page,': (%d+)')=='936' and pcall(require,'gbk') then
		local Convert_Code_Page_From_UTF8_To_936=require'gbk'.fromutf8
		function IO_Open(Path,Mode)
			return IO_Open_Core(Convert_Code_Page_From_UTF8_To_936(Path),Mode)
		end
	else
		IO_Open=IO_Open_Core
	end
end

local function Access_File_Data(Param_1,Param_2)
	--[[usage:
		- Data=([Data_File_Name]): read data from Data_File_Name (or default data file name) on work directory.
		- ([Data_File_Name,]Data): write data to Data_File_Name (or default data file name) on work directory.
	]]
	local Data_File_Name,Data do
		local Param_1_Type,Param_2_Type=type(Param_1),type(Param_2)
		if Param_1_Type=='string' then
			Data_File_Name=Param_1~='' and Param_1
			Data=Param_2
		elseif Param_1==nil or Param_1_Type=='table' then
			Data=Param_1
		end
		if not Data_File_Name then--use default
			local Script_File_Path=arg[0]
			Data_File_Name=string.gsub(Script_File_Path,'.-([^\\/]+)(%..-)$','%1.data%2')
		end
		assert(type(Data_File_Name)=='string' and (Data==nil or type(Data)=='table'))
	end
	if Data then
		local File_Handle=assert(IO_Open(Data_File_Name,'w'))
		assert(File_Handle:write(Data2String(Data)))
		File_Handle:close()
	else
		local File_Handle=IO_Open(Data_File_Name,'r')
		if File_Handle then
			local Content=File_Handle:read'a'
			File_Handle:close()
			local Loader=assert(load(Content),Data_File_Name..": \n"..Data2String(Content))
			Data=Loader()
		end
	end
	return Data
end

return Access_File_Data