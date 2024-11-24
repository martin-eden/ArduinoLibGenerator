-- Simplify configuration table

-- Last mod.: 2024-11-24

--[[
  I want following transformations:

    { Email = '', Name = <A> } => <A>
    { Name = <A>, VersionExpr = '' } => <A>

    .Authors = { <A> } => .Author = <A>
    .Maintainers = { <A> } => .Maintainer = <A>
    .Architectures = { <A> } => .Architecture = <A>
    .Dependencies = { <A> } => .Dependency = <A>
]]

local GetNumEntries = request('!.table.get_num_entries')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

-- Return true if node contains only one value
local IsOnlyValue =
  function(Node)
    if is_nil(Node) then
      return false
    end
    if not is_table(Node) then
      return true
    end
    if (GetNumEntries(Node) == 1) and Node[1] then
      return true
    end
    return false
  end

--[[
  Get the only value of node

  Node can be any value.

  If node is table, it must be { [1] = <Value> }.
]]
local GetOnlyValue =
  function(Node)
    if not is_table(Node) then
      return Node
    end

    if not IsOnlyValue(Node) then
      error('Node is not list with one value.')
    end

    return Node[1]
  end

--[[
  { Email = '', Name = 'Martin Eden' } => 'Martin Eden'
]]
local SimplifyPersonRec =
  function(Person)
    if not is_table(Person) then
      return Person
    end
    if (Person.Email == '') then
      return Person.Name
    end
    return Person
  end

--[[
  { Name = 'me_BaseTypes', VersionExpr = '' } => 'me_BaseTypes'
]]
local SimplifyDependencyRec =
  function(Dependency)
    if not is_table(Dependency) then
      return Dependency
    end
    if (Dependency.VersionExpr == '') then
      return Dependency.Name
    end
    return Dependency
  end

local SimplifyConfig =
  function(Config)
    if IsOnlyValue(Config.How.Architectures) then
      Config.How.Architecture = GetOnlyValue(Config.How.Architectures)
      Config.How.Architectures = nil
    end

    ApplyFunc(SimplifyDependencyRec, Config.How.Dependencies)
    ApplyFunc(SimplifyPersonRec, Config.Who.Authors)
    ApplyFunc(SimplifyPersonRec, Config.Who.Maintainers)

    if IsOnlyValue(Config.How.Dependencies) then
      Config.How.Dependency = GetOnlyValue(Config.How.Dependencies)
      Config.How.Dependencies = nil
    end
    if IsOnlyValue(Config.Who.Authors) then
      Config.Who.Author = GetOnlyValue(Config.Who.Authors)
      Config.Who.Authors = nil
    end
    if IsOnlyValue(Config.Who.Maintainers) then
      Config.Who.Maintainer = GetOnlyValue(Config.Who.Maintainers)
      Config.Who.Maintainers = nil
    end
  end

-- Exports:
return SimplifyConfig

--[[
  2024-10-24
]]
