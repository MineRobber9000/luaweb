-- cheating a little
-- I'd need some way of stubbing lfs even if tsuki upstream had linenoise support
-- so whatever, might as well make linenoise work here
local L = require"linenoise"

-- stub lfs to prevent tsuki.utils.searchfor from crashing
package.loaded["lfs"] = {attributes=function() end}

-- install linenoise as input function
require"tsuki.repl".input = function(prompt)
        local line = L.linenoise(prompt)
        if line~=nil then L.historyadd(line) end
        return line
end

-- run the damn thing
require'tsuki.init'()
