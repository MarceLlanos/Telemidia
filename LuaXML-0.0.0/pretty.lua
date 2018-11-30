
-- Lua pretty printer from http://mini.net/cgi-bin/lua/44.html

-- This was extracted from utility code in "util.lua".
-- 23/02/2001 jcw@equi4.com
    
-- pretty displays a value, properly dealing with tables and cycles
local displayvalue=
  function (s)
    if not s or type(s)=='function' or type(s)=='userdata' then
      s=tostring(s)
    elseif type(s)~='number' then
      s=gsub(format('%q',s),'^"([^"\']*)"$',"'%1'")
    end
    return s
  end
local askeystr=
  function (u,s)
    if type(u)=='string' and strfind(u,'^[%w_]+$') then return s..u end
    return '['..%displayvalue(u)..']'
  end
local horizvec=
  function (x,n)
    local o,e='',''
    for i=1,getn(x) do
      if type(x[i])=='table' then return end
      o=o..e..%displayvalue(x[i])
      if strlen(o)>n then return end
      e=','
    end
    return '('..o..')'
  end
local horizmap=
  function (x,n)
    local o,e='',''
    for k,v in x do
      if type(v)=='table' then return end
      o=o..e..%askeystr(k,'')..'='..%displayvalue(v)
      if strlen(o)>n then return end
      e=','
    end
    return '{'..o..'}'
  end
function pretty(p,x,h,q)
  if not p then p,x='globals',globals() end
  if type(x)=='table' then
    if not h then h={} end
    if h[x] then
      x=h[x]
    else
      if not q then q=p end
      h[x]=q
      local s={}
      for k,v in x do tinsert(s,k) end
      if getn(s)>0 then
        local n=75-strlen(p)
        local f=getn(s)==getn(x) and %horizvec(x,n)
        if not f then f=%horizmap(x,n) end
        if not f then
          sort(s,function (a,b)
                   if tag(a)~=tag(b) then a,b=tag(b),tag(a) end
                   return a<b
                 end)
          for i=1,getn(s) do
            if s[i] then
              local u=%askeystr(s[i],'.')
              pretty(p..u,x[s[i]],h,q..u)
              p=strrep(' ',strlen(p))
            end
          end
          return
        end
        x=f
      else
        x='{}'
      end
    end
  else
    x=%displayvalue(x)
  end
  print(p..' = '..x)
end
