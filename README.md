# luaweb

Lua 5.4.7 for the web. Uses xterm, xterm-pty, and emscripten.

## Running a Lua CLI application

You can run Lua CLI applications in luaweb, so long as they don't require any binary modules (i.e; pure Lua). Make a TOML file accessible somewhere CORS-accessible, with the following format:

```
[info]
title = "This replaces the document title"
arguments = ['main.lua'] # or whatever arguments need to be passed to the lua interpreter in order to work

[[files]]
name = "the_filename.lua"
url = "https://theurl.to/the_file.lua" # must also be CORS-accessible

[[files]]
name = "another_filename.lua"
url = "https://theurl.to/another_file.lua"
```

Then link to `https://minerobber9000.github.io/luaweb/?config=https://theurl.to/the.toml`. An example of my [Tsuki REPL](https://github.com/MineRobber9000/tsuki) is included [here](https://github.com/MineRobber9000/luaweb/blob/trunk/tsuki.toml), with a little cheat in that I also include [a modified runner](https://github.com/MineRobber9000/luaweb/blob/trunk/runtsuki.lua) to stub out LFS.
