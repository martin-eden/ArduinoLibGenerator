-- Check library name

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

  2. Must start with a letter or number.

  3. Must contain at least one letter.

  4. Must not start with "Arduino".
]]

return
  function(LibName)
    assert_string(LibName)

    -- (1) and (2) are covered by <NamePattern>
    local NamePattern = '^[%a%d][%a%d _.%-]*$'
    local MatchesPattern = string.match(LibName, NamePattern)
    if not MatchesPattern then
      local ErrorMsgFmt =
        "Library name doesn't match library name pattern.\n" ..
        '  Library name: %s\n' ..
        '  Pattern: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName, NamePattern)
      error(ErrorMsg)
    end

    -- (3) has letter
    local HasLetter = (string.find(LibName, '%a') ~= nil)
    if not HasLetter then
      local ErrorMsgFmt =
        'Library name must contain letter.\n' ..
        '  Library name: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName)
      error(ErrorMsg)
    end

    -- (4) not starts with "Arduino"
    --[[
      Requirement (4) quite badly formulated as "ARDUINO" and "arduino"
      will pass it.
    ]]
    local StartsWithArduino = (string.find(LibName, '^Arduino') ~= nil)
    if StartsWithArduino then
      local ErrorMsgFmt =
        'Library name should not start with "Arduino".\n' ..
        '  Library name: %s\n'
      local ErrorMsg = string.format(ErrorMsgFmt, LibName)
      error(ErrorMsg)
    end

    return LibName
  end

--[[
  2024-02-13
  2024-02-25
]]
