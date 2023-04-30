--Access_File_Data\Test.lua
local Access_Data=require'Access_File_Data'

local File_Hanlde=io.open(arg[0])
local File_Content=File_Hanlde:read'a'
File_Hanlde:close()

Access_Data{File_Content=File_Content}
local File_Content_Read=Access_Data().File_Content

assert(File_Content_Read==File_Content)
print"test done."
