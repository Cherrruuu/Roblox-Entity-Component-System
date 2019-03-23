--[[-----------------

This template component will not be added to the ECS components table. 
If you want it added, name it something besides "Template"

Please do not use nil values if you plan on using the default Replication System,
it ignores nil values and won't update that client's version of the entity's component

-------------------]]

local component  = {}
component.name    = "Template"
component.__index = component


function component.create()
	
	local name = component.name
	
	local data = {

		["test"] = true
		
	}
	
	local self = setmetatable({
		
		name = name,
		data = data
		
	}, component)
	
	return self
	
end

return component.create