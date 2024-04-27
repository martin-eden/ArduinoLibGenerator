-- Serialize person (name and email)

--[[
  Input

    table

      {
        Name: string
        Email: string
      }

  Output

    string

  Special cases

    When <Email> is empty string or one character
      We skip <Email> processing

  Examples

    { Name = 'Paul Stoffregen', Email = 'paul@pjrc.com' } ->
    'Paul Stoffregen <paul@pjrc.com>'

    { Name = 'Martin Eden', Email = '.' } -> 'Martin Eden'

    { Name = '', Email = '<a@b.c>' } -> '<a@b.c>'
]]

-- Last mod.: 2024-03-04

local AssertNoNewlines = request('!.string.assert_no_newlines')

return
  function(Person)
    local Name = Person.Name
    local Email = Person.Email

    AssertNoNewlines(Name)
    AssertNoNewlines(Email)

    local Result
    do
      Result = Name

      if (Email == '') then
        goto Continue
      end

      if (string.len(Email) < 2) then
        goto Continue
      end

      if (Result ~= '') then
        Result = Result .. ' '
      end

      Result = Result .. '<' .. Email .. '>'

      ::Continue::
    end
    assert_string(Result)

    return Result
  end

--[[
  2024-02-25
  2024-03-04
]]
