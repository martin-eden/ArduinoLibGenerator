-- Check Lua table for our custom library format

--[[
  Input

    table

  Output

    boolean

      true if okay, false if not okay

    table

      List of messages


  See also [CheckLibrary_AnnotatedLines]
]]

-- Last mod.: 2024-03-05

return
  function(Data)
    assert_table(Data)

    local IsOkay = true
    local Messages = {}

    do
      local AddMessage =
        function(Message)
          assert_string(Message)
          table.insert(Messages, Message)
        end

      local Add_NoField =
        function(FieldName)
          assert_string(FieldName)
          local MessageFmt = 'No string field "%s".'
          local Message = string.format(MessageFmt, FieldName)
          AddMessage(Message)
          IsOkay = false
        end

      local Add_NoStructure =
        function(StrucName)
          assert_string(StrucName)
          local MessageFmt = 'No structure at "%s".'
          local Message = string.format(MessageFmt, StrucName)
          AddMessage(Message)
          IsOkay = false
        end

      local CheckStructure =
        function(Node, NodeName)
          if not is_table(Node) then
            Add_NoStructure(NodeName)
            return false
          end
          return true
        end

      local CheckField =
        function(Node, NodeName)
          if not is_string(Node) then
            Add_NoField(NodeName)
            return false
          end
          return true
        end

      if CheckStructure(Data.What, '.What') then
        CheckField(Data.What.Name, '.What.Name')
        CheckField(Data.What.Version, '.What.Version')
        CheckField(Data.What.Category, '.What.Category')
        CheckField(Data.What.Description, '.What.Description')
        CheckField(Data.What.Description_Continued, '.What.Description_Continued')
        CheckField(Data.What.MoreInfo_Url, '.What.MoreInfo_Url')
      end

      if CheckStructure(Data.How, '.How') then
        CheckStructure(Data.How.Architectures, '.How.Architectures')
        CheckStructure(Data.How.Dependencies, '.How.Dependencies')
      end

      if CheckStructure(Data.Who, '.Who') then
        CheckStructure(Data.Who.Authors, '.Who.Authors')
        CheckStructure(Data.Who.Maintainers, '.Who.Maintainers')
      end

      --[[
        We can do deeper checks for ".Dependencies", ".Authors" and
        ".Maintainers". But this will require writing "for".

        This function is for early detection, not for deep analysis.

        Best approach for deep analysis is let the tool crash in
        your hands.
      ]]
    end

    return IsOkay, Messages
  end

--[[
  2024-03-05
]]
