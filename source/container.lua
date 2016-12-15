--[[---
  this container class specifies a space of
  a certain width and height. Will be provided to
  classes' renderToContainer() method.
  @module container
--]]
--todo add default listeners?
container = {}
local container_mt = {__index = container}

function container.new(width, height)
  local c = setmetatable({}, container_mt)
  c.group = display.newGroup()
  c.width = width
  c.height = height
  return c
end

function container:translate(deltaX, deltaY)
  self.group:translate(deltaX, deltaY)
end

function container:insertIntoGroup(group)
  group:insert(self.group)
end