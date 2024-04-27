-- Check structure in "annotated lines" format

--[[
  Well, I need function to do pre-flight checks before we will
  try to convert "library.properties" to custom Lua format.

  We can run without it but then in case of failure we will
  just get stack trace and need to look in code to figure out
  core reason.

  Input

    table

      Loaded data in "annotated lines" format.
      String key, string value.

      We will not check for illegal symbols in them, it's
      loader's job.

      We will check for presence of required fields.

  Output

    boolean

      true if okay, false if not okay

    table

      List of strings with messages. May be empty if no problems found.
]]

-- Last mod.: 2024-03-05

return
  function(Data)
    assert_table(Data)

    local IsOkay = true
    local Messages = {}

    do
      local Add_NoField =
        function(FieldName)
          local MessageFmt = 'No required field "%s".'
          local Message = string.format(MessageFmt, FieldName)
          table.insert(Messages, Message)
        end

      local RequireField =
        function(FieldName)
          if not is_string(Data[FieldName]) then
            Add_NoField(FieldName)
            IsOkay = false
          end
        end

      local RequireFields =
        function(RequiredFields)
          assert_table(RequiredFields)
          for _, FieldName in ipairs(RequiredFields) do
            RequireField(FieldName)
          end
        end

      RequireFields(
        {
          'name',
          'version',
          'category',
          'architectures',
          'sentence',
          'paragraph',
          'url',
          'author',
          'maintainer',
        }
      )
    end

    return IsOkay, Messages
  end

--[[
  2024-03-05
]]
