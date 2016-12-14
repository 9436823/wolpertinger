--[[--- the restrictValueProxy monitors access to
  table variables and restricts values to specified
  bounds.
  @module restrictValueProxy
--]]
restrictValueProxy = {}
---
-- @param object the table object containing restricted variables
-- @param bounds {variable = {max = maxValue, min = minValue}}
function restrictValueProxy.new(object, bounds)
    assert(type(object) == "table", "restrictValueProxy needs a table object")
      
    local rvp = {}
    local restrictValueProxy_mt = {
      __index = function(t, k)
        return object[k]
      end,
      
      __newindex = function(t, k, v)
        if bounds[k] ~= nil then 
          object[k] = math.min(math.max(v, bounds[k].min), bounds[k].max)
        else
          object[k] = v
        end
      end
      }
    return setmetatable(rvp, restrictValueProxy_mt)
end