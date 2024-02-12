-- Save results

--[[
  Status: in writing
  Version: 0
  Last mod.: 2024-02-11
]]

local ResultsDir = 'Results/'
local LibPropsFileName = 'library.properties'
local DevFlagFileName = '.development'

local DirectoryExists = request('!.directory.exists')
local CreateDirectory = request('!.directory.create')
local SaveToFile = request('!.string.save_to_file')

return
  function(self, Result)
    if not DirectoryExists(ResultsDir) then
      if not CreateDirectory(ResultsDir) then
        local ErrorMsg =
          ([[Cannot create directory "%s" for result files. (Current directory is "%s".)]]):
          format(ResultsDir, CurrentDir)
        error(ErrorMsg)
      end
    end

    assert_table(Result)
    local ResultString = Result.Data

    assert_string(LibPropsFileName)
    SaveToFile(ResultsDir .. LibPropsFileName, ResultString)
    SaveToFile(ResultsDir .. DevFlagFileName, '')
  end
