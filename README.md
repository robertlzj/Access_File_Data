## Summary

Access (read/write) table data from/to lua file.

## Usage

- `Data=Access_File_Data([Data_File_Name])`: read data from `Data_File_Name` (or default data file name).
- `Access_File_Data([Data_File_Name,]Data)`: write data to `Data_File_Name` (or default data file name).

If `Data_File_Name` not specified, will use default data file name - "script_name_passed_to_interpreter*.data*.lua".  
If full path not specified, will use working directory.

## Install

- Copy 'Access_File_Data.lua' to lua libs.
- `luarock install Access_File_Data `.

### Dependence

- Data2String: core module. 
  See [robertlzj/Data2String: Serialize data Fast in any struct to string. Clear view through complex reference](https://github.com/robertlzj/Data2String) 
  Auto contain when install from luarock.
- gbk: Option. Code page converter.  
  See [starwing/luagbk: GBK encoding string support for Lua programming language. (github.com)](https://github.com/starwing/luagbk) and its description in 'rockspec'.