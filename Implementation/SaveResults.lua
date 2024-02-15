-- Save results. No processing, only file IO business.

--[[
  Receives string with "library.properties" file content,
  <ReadOnly> flag and results directory path.

  Logic

    Go to results directory
    Save "library.properties"
    If not <ReadOnly>
      Create ".development" flag file
]]

--[[
  Status: fine
  Version: 3
  Last mod.: 2024-02-15
]]

local LibPropsFileName = 'library.properties'
local DevFlagFileName = '.development'

local DirectoryExists = request('!.directory.exists')
local CreateDirectory = request('!.directory.create')
local GetCurrentDirectory = request('!.directory.get_current')
local CreateFile = request('!.file.create')
local SaveToFile = request('!.string.save_to_file')
local RemoveFile = request('!.file.remove')

local CreateDirectoryError =
  function(ResultsDir)
    local MessageFmt =
      'Cannot create directory for result files.\n' ..
      '  Requested directory: "%s"\n' ..
      '  Current directory: "%s"\n'
    local CurrentDir = GetCurrentDirectory()
    local ErrorMsg = string.format(MessageFmt, ResultsDir, CurrentDir)
    error(ErrorMsg)
  end

local PrintFileCreated =
  function(FileName, FilePath)
    local MessageFmt = 'Created "%s" in "%s".'
    print(string.format(MessageFmt, FileName, FilePath))
  end

return
  function(self, LibPropsStr, ReadOnly, ResultsDir)
    assert_string(LibPropsStr)
    assert_boolean(ReadOnly)
    assert_string(ResultsDir)

    if not DirectoryExists(ResultsDir) then
      if not CreateDirectory(ResultsDir) then
        CreateDirectoryError(ResultsDir)
      end
    end

    local LibPropsPathName = ResultsDir .. LibPropsFileName
    SaveToFile(LibPropsPathName, LibPropsStr)
    PrintFileCreated(LibPropsFileName, ResultsDir)

    local DevFlagPathName = ResultsDir .. DevFlagFileName
    RemoveFile(DevFlagPathName)
    if not ReadOnly then
      CreateFile(DevFlagPathName)
      PrintFileCreated(DevFlagFileName, ResultsDir)
    end
  end
