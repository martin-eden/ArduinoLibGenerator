# ArduinoLibGenerator

## Generate library description files for ArduinoIDE

Status: ready to release

Last mod.: 2023-03-04

Example input: [Configurations/Sample.lua](Configurations/Sample.lua)

Example output: [Results/library.properties](Results/library.properties)

Official format specification:
  [arduino.github.io/arduino-cli/0.36/library-specification/][libprops.spec].

## Requirements

* Linux
* [Lua 5.4][install.lua] (should work with 5.3 too)

## First launch

1. Clone
2. `lua Run.lua`

    Will print usage help.

3. `lua Run.lua Configurations/Sample.lua`

    Will generate "library.properties" and place it in "Results/"
    directory:

    ```
    ArduinoLibGenerator --(
    Created file "Results/library.properties".
    )--
    ```

## Background

Tinkering with Arduino Uno yielded to programming in C++ and
growing set of personal libraries.

Now I'm coming to point when I want to release some of my projects.

And so I need to release libraries these projects are using.

ArduinoIDE since v1.5 wants to see "library.properties" file.

Editing "key=value" strings is not what I'm wanting to do.

So I've created tool to generate "library.properties" from structured
description in Lua table.

## See also

* [My other repositories](https://github.com/martin-eden/contents).

-- Martin, 2024-02-11/2024-03-02

[install.lua]: https://gist.github.com/martin-eden/4d3d1677244234e6501654cb32316305
[libprops.spec]: https://arduino.github.io/arduino-cli/0.36/library-specification/
