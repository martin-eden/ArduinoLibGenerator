-- Check library name

--[[
  Input

    string

      Library name.

  Output

    boolean

      Result of formal checks.

    string

      Details of formal checks. One-line string.

      In generated message we are not mentioning library name.
      Because caller have this information.
]]

--[[
  Reformulated rules for library name limitations.

  Based on

    https://arduino.github.io/arduino-cli/0.35/library-specification/#libraryproperties-file-format

  1. Must contain only

    basic letters (A-Z, a-z)
    numbers (0-9)
    spaces ( )
    underscores (_)
    dots (.)
    dashes (-)

  2. Must start with letter or number.

  3. Must contain at least one letter.

  4. Must not start with "Arduino".
]]

-- Last mod.: 2024-03-03

return
  function(LibName)
    assert_string(LibName)

    local Message, MessageFmt

    do
      -- (1) and (2) are covered by <NamePattern>
      local NamePattern = '^[%a%d][%a%d _.%-]*$'
      local MatchesPattern = string.match(LibName, NamePattern)
      if not MatchesPattern then
        MessageFmt =
          [[Name doesn't match pattern "%s".]]
        Message = string.format(MessageFmt, NamePattern)
        return false, Message
      end
    end

    do
      -- (3) has letter
      local HasLetter = (string.find(LibName, '%a') ~= nil)
      if not HasLetter then
        local Message = 'Name must contain letter.'
        return false, Message
      end
    end

    do
      -- (4) not starts with "Arduino"
      --[[
        Requirement (4) is quite badly formulated as "ARDUINO" and
        "arduino" will pass it.
      ]]
      local StartsWithArduino = (string.find(LibName, '^Arduino') ~= nil)
      if StartsWithArduino then
        local Message = 'Name should not start with "Arduino".'
        return false, Message
      end
    end

    Message = 'Name is formally okay.'

    return true, Message
  end

--[[
  2024-02-13
  2024-02-25
  2024-03-03
]]
