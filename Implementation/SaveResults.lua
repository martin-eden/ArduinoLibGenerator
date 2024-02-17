-- Save results. No processing, only file IO business.

--[[
  Version: 4
  Last mod.: 2024-02-17
]]

local CreateDirTree = request('!.file_system.tree.create')
local RemoveDirTree = request('!.file_system.tree.remove')

local AddNamePrefix =
  function(DirTree, Prefix)
    assert_table(DirTree)
    assert_string(Prefix)

    --[[
      We gonna add some directory prefix to string keys in table.
      Problem that there may already be keys with prefixed name.
      So we will create prefixed table separately, make original
      table empty and copy write contents from prefixed table.
    ]]

    local PrefixedDirTree = {}
    for Name, Value in pairs(DirTree) do
      assert_string(Name)
      local NewName = Prefix .. Name
      PrefixedDirTree[NewName] = Value
    end

    -- Make table empty
    for Key in pairs(DirTree) do
      DirTree[Key] = nil
    end

    for Key, Value in pairs(PrefixedDirTree) do
      DirTree[Key] = Value
    end
  end

return
  function(self, DirTree_Create, DirTree_Remove, ResultsDir)
    assert_table(DirTree_Create)
    assert_table(DirTree_Remove)
    assert_string(ResultsDir)

    AddNamePrefix(DirTree_Create, ResultsDir)
    AddNamePrefix(DirTree_Remove, ResultsDir)

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
