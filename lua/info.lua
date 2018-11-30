require "tcp"

dofile("LuaXML/xml.lua")
dofile("LuaXML/handler.lua")

local colorTxt = 'black'
local fontTxt= 'vera'
local sizeTxt

function setSizeTxt(sizeTxtAtributo)
  sizeTxt = sizeTxtAtributo
end

function getSizeTxt()
  return sizeTxt
end

function setColorTxt(colorTxtAtributo)
  colorTxt = colorTxtAtributo
end

function getColorTxt()
  return colorTxt
end

function clearTxt()
   canvas:attrColor(0,0,0,0)
   canvas:clear()
   local screen_x, screen_y = canvas:attrSize()
   canvas:drawRect('fill', 0, 0, screen_x, screen_y)
   canvas:flush()
end  

function writeText(text)  
   canvas:attrColor(colorTxt)
   canvas:clear()
   
   canvas:attrFont(fontTxt, sizeTxt)
   --canvas:drawText(10, 20, text)
   local cw, ch = canvas:attrSize()
   local tw, th =   canvas:measureText("text")
   local charByLines = tonumber(string.format("%d",(cw/tw)*3))
   local desct = breakString(text,charByLines)
   local y =0
   for k,ln in pairs(desct) do
    canvas:drawText(5, y,ln)
    y=y+th+5
   end
   canvas:flush()
end

function breakString(str, maxLineSize)
  local t={}
  local ini, fin, countLines =1, 0, 0
  while ini < #str do
    countLines=countLines+1
    if ini > #str then
      t[countLines] =str
      ini =#str
    else
      fin =ini +maxLineSize -1
        if fin > #str then
          fin =#str
        end
        t[countLines]=string.sub(str, ini, fin)
        ini =fin+1
    end
  end
  return t
end

function handler (evt)
    if evt.class == 'ncl' and 
       evt.type == 'presentation' and 
       evt.action == 'start' then 
        archivo =assert(io.open("n1.txt","r"))
        titulo = archivo:read("*a")
        io.close(archivo)
        writeText(titulo)
    end
    
    if evt.class == 'ncl' and
       evt.type == 'attribution' and
       evt.property == 'sizeTxt' and
       evt.action == 'start' and
       evt.value == sizeTxt then
                    setSizeTxt(sizeTxt)
                    canvas:clear()
                    archivo =assert(io.open("n1.txt","r"))
                    titulo = archivo:read("*a")
                    io.close(archivo)
                    writeText(titulo)
    end
       
    --tcp.execute(
      --function ()
          --local host = "localhost"
          --tcp.connect(host, 80)
          
          --local path = "/noticia.php"
          --local url = host..path
          --local request = "GET "..url.." HTTP/1.0\n"
          --request = request .. "Host: "..host.."\n\n"
          --tcp.send(request)
          --local result = tcp.receive("*a")
          --tcp.disconnect()
      --end)  
end
event.register(handler)