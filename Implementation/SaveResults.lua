-- Save results. No processing, only file IO business.

--[[
  Version: 5
  Last mod.: 2024-02-19
]]

local CreateDirTree = request('!.file_system.tree.create')
local RemoveDirTree = request('!.file_system.tree.remove')

return
  function(self, DirTree_Create, DirTree_Remove, ResultsDir)
    assert_table(DirTree_Create)
    assert_table(DirTree_Remove)
    assert_string(ResultsDir)

    -- Apply <ResultsDir> to generated results:
    DirTree_Create = { [ResultsDir] = DirTree_Create }
    DirTree_Remove = { [ResultsDir] = DirTree_Remove }

    local Problems
    RemoveDirTree(DirTree_Remove)

    Problems = CreateDirTree(DirTree_Create)
    if (#Problems > 0) then
      print('Got problems:')
      for Index, Problem in ipairs(Problems) do
        print(Index, Problem)
      end
    end
  end
