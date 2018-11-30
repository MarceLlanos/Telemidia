-- this function is registered to treat all events from gingancl
function handler(evt)

  if evt.class == "ncl" then

    for k, v in pairs(evt) do
      print(k,v)
    end
    if evt.type == "presentation" then

    -- presentation events
      if evt.action == "start" then
        if setting.start ~= nil then setting.start() end
      end
      if evt.action == "stop" then
        setting.stop()
      end
      if evt.action == "pause" then
        setting.pause()
      end
    -- end of presentation events

    end

    if evt.type == "attribution" then
      
    -- attribution events
      if setting.property ~= nil then
        for k, v in pairs(setting.property) do
          if k == evt.name then
            v(evt.value)
          end
        end
      end
      evt.action = "stop"
      event.post(evt)
    -- end of attribution events
    end
  end
  
  if evt.class == "user" then
      setting.updateContent(event.uptime())
      event.post('in', evt)
  end
end
 
event.register(handler)