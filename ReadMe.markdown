# ArduinoLibGenerator -- Generate library description files for ArduinoIDE

WIP, project is not released

## Requirements

* Lua 5.4
* [Workshop](https://github.com/martin-eden/workshop)

## First launch

1. Clone repo
2. Install requirements
3. `lua Run.lua Configurations/Sample.lua`

  Result will be in "Results/" directory. (Directory will be created,
  don't worry.)

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

-- Martin, 2024-02-11/2024-02-28
