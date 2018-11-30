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
                  info.writeText(text)
                  function texto (evt)
                    if evt.class == 'ncl' and 
                       evt.type == 'presentation' and 
                       evt.action == 'start' then 
                        archivo =assert(io.open("n1.txt","r"))
                        titulo = archivo:read("*a")
                        io.close(archivo)
                        writeText(titulo)
                    end
                  end
                 event.register(texto)
                end
               end,
    sizeTxt = function(value)
                info.setSizeTxt(value)
                if text ~= 0 then
                  clearTxt()
                  info.writeText(text)
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