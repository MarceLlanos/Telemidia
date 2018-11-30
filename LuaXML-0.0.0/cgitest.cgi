#!/usr/local/bin/lua

dofile("../Lua/cgi.lua")
dofile("../Lua/xml.lua")
dofile("../Lua/handler.lua")
dofile("../Lua/pretty.lua")

c = CGI()
c.options.xml_parser = xmlParser
c.options.xml_handler = simpleTreeHandler
c:parse()

print [[Content-Type: text/plain

LUA CGI
=======

Env:
---
]]

for k,v in c.env do
    write(format("%-20s : %s\n",k,v))
end

print [[
Headers:
--------
]]

for k,v in c.headers do
    write(format("%-20s : %s\n",k,v))
end

print [[
Fields:
-------
]]

for k,v in c.fields do
    write(format("%-20s : %s\n",k,v))
end

print [[
Files:
-------
]]

for k,v in c.files do
    write(format("%-20s : %s\n","Name",k))
    for k,v2 in v do
        if k ~= 'data' then
            write(format("%-20s : %s\n",k,v2))
        end
    end
end

print [[
XML:
----
]]

pretty("XML",c.xml)
