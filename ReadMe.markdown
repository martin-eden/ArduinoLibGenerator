# ArduinoLibGenerator -- Generate library description files for ArduinoIDE

WIP

Tinkering with Arduino Uno yielded to programming in C++ and
growing set of personal libraries.

Now I'm coming to point when I want to release some of my projects.

And so I need to release libraries these projects are using.

ArduinoIDE since v1.5 wants to see "library.properties" file,
code in "src/", examples in "examples/" and any shit in "extras/".

I'm okay with this structure but editing key=value strings is not what
I'm wanting to do.

So instead I'm creating personal tool to generate "library.properties"
from structured description in Lua table.

See also [my other repositories](https://github.com/martin-eden/contents).

-- Martin, 2024-02-11
