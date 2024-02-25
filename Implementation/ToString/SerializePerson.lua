-- Serialize person

local AssertNoNewlines = request('^.AnnotatedLines.string.assert_no_newlines')

return
  function(Person)
    local Name = Person.Name
    local Email = Person.Email

    AssertNoNewlines(Name)
    assert_string(Email)

    local Result = ''

    Result = Result .. Name

    if (Email ~= '') then
      if (string.len(Email) < 2) then
        goto Continue
      end

      Result = Result .. ' '

      local FirstChar = string.sub(Email, 1, 1)
      local LastChar = string.sub(Email, -1, -1)
      if (FirstChar == '<') and (LastChar == '>') then
        Result = Result .. Email
      else
        Result = Result .. '<' .. Email .. '>'
      end
    end

    ::Continue::

    return Result
  end

