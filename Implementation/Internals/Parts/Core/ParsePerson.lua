-- Parse string with person record (name and email)

--[[
  Input

    string

  Output

    table

      {
        Name: string
        Email: string
      }

  Examples

    'Chr Sch <sch@bamberg.ccc.de>' ->
      { Name = 'Chr Sch', Email = 'sch@bamberg.ccc.de' }

    'M V' -> { Name = 'M V', Email = '' }

    '<jilee@pleaseenjoy.com>' ->
      { Name = '', Email = 'jilee@pleaseenjoy.com' }

    'Some Guy not@email.com' ->
      { Name = 'Some Guy not@email.com', Email = '' }
]]

-- Last mod.: 2024-03-03

--[[
  Well, there are tons of bad inputs so we need to devise and
  describe sane strategy of parsing before actual implementation.

  // "a <<b> c": reduce it to "a <<b>" and parse it

  1. We are looking for first ">"
      Trim string at that position
    If we can't find ">"
      All part is <name>

  Okay, we have "a <<b>". Or "a b>". What now?

  2. We are looking for first "<"
      Split string to two parts there: <name> and <email>
    If we can't find "<"
      All part is <name>

  Okay, we have (name: "a ", email: "<<b>"). What now?

  3. We use Lua's 5.3 balanced brackets match: "%b<>"
    // That stuff is good. It resolves both "<<b>" and "<b>>" to "<b>".
    If we got match
      <email> is the contents inside brackets: string.sub(2, -2)
    If there is no match
      Well, no match - no <email>. Consider it empty.

  4. Trim possible tail spaces from <name>
]]

local TrimStringTail = request('!.string.trim_tail')

return
  function(DataStr)
    assert_string(DataStr)

    local Person
    do
      local Name = ''
      local Email = ''

      -- 1. Trim string after first ">"
      do
        local NameEmail = string.match(DataStr, '(.->)')
        if is_nil(NameEmail) then
          Name = DataStr
          goto Continue
        end
        DataStr = NameEmail
      end

      -- 2. Split before first "<"
      do
        local BracketPos = string.find(DataStr, '<')
        if is_nil(BracketPos) then
          Name = DataStr
          goto Continue
        end
        Name = string.sub(DataStr, 1, BracketPos - 1)
        Email = string.sub(DataStr, BracketPos)
      end

      -- 3. Get "<>"-balanced substring
      --[[
        I believe we have correct brackets at ends so "%b<>" wont fail.
        So we will get substring and substring will start with "<" and
        end with ">". So we can strip them right here.
      ]]
      Email = string.match(Email, '%b<>'):sub(2, -2)

      ::Continue::

      -- 4. Trim <name>
      Name = TrimStringTail(Name)

      Person = { Name = Name, Email = Email }
    end
    assert_table(Person)

    return Person
  end

--[[
  2024-03-03
]]
