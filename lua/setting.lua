local info = require 'info'
local eventHandler = require 'handlerSet'
text = 0

function clearTxt()
   canvas:attrColor(0,0,0,0)
   local screen_x, screen_y = canvas:attrSize()
   canvas:drawRect('fill', 0, 0, screen_x, screen_y)
   canvas:flush()
end

setting = {
  property = {
    colorTxt = function(value)
                info.setColorTxt(value)
                if text ~= 0 then
                  clearTxt()
                  archivo =assert(io.open("n1.txt","r"))
                  titulo = archivo:read("*a")
                  io.close(archivo)
                  info.writeText(titulo)
                end
               end,
    sizeTxt = function(value)
                info.setSizeTxt(value)
                if text ~= 0 then
                  clearTxt()
                   archivo =assert(io.open("n1.txt","r"))
                                  titulo = archivo:read("*a")
                                  io.close(archivo)
                                  info.writeText(titulo)
                end
               end
   },

  start = function()
    running = true
    end,

   stop = function()
    running = false
    end,

   pause = function()
    end
}