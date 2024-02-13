# Annotated lines format

Works with simple `key=some one-line string` format.

"Annotated lines" name is too generic as there are many ways to
express binding of one-line string to identifier. But for now that's
the only type of family I'm implementing, so I won't qualify name
any further.

## Details and background

It's part of ArduinoLibGenerator. I want to save results in
`library.properties` which looks like

  ```
    name=ArduinoJson
    version=7.0.3
    author=Benoit Blanchon <blog.benoitblanchon.fr>
  ```

So the general format is

  ```
    format:

      (<line> <newline>)*
       ~~~~~~~~~~~~~~~~
        annotated_line

    line:

      <any_char_except_=> "=" <any_char>
      ~~~~~~~~~~~~~~~~~~~     ~~~~~~~~~~
              key                value
  ```

### Internal data structures

Of course `Load(DataStr: string): table` will return Lua table,
I want natural access to keys.

But for Save() I want to option to specify keys ordering. And there is
possible to have duplicate keys. So Save() method will accept optional
parameter with key names to serialize in table sequence:
`Save(Data: table [, Keys: table]): string`.

-- Martin, 2024-02-13
