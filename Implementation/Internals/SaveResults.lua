-- Save results. No processing, only file IO business.

--[[
  Version: 6
  Last mod.: 2024-02-29
]]

local CreateDirTree = request('!.file_system.tree.create')
local StringFromLines = request('!.string.from_lines')

return
  function(DirTree_Create, ResultsDir)
    assert_table(DirTree_Create)
    assert_string(ResultsDir)

    -- Store results in <ResultsDir>:
    local Adjusted_DirTree_Create = { [ResultsDir] = DirTree_Create }

    local Report = {}

    Report = CreateDirTree(Adjusted_DirTree_Create)

    print('ArduinoLibGenerator --(')
    io.write(StringFromLines(Report))
    print(')--')
  end

--[[
  2024-02-19
  2024-02-29
]]
