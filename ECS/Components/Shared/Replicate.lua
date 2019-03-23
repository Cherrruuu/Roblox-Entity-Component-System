local component  = {}
component.name    = "Replicate"
component.__index = component

function component.create()
	
	local name = component.name
	
	local data = {

		["isReplicating"]            = true, --Set this to false if you don't want the entity to replicate just yet.
		["Players"]                  = {}, --if you want to replicate to specific players, put their Player objects in this table, this can be done during runtime.
		["ComponentsToNotReplicate"] = {} --add the name of components here that you don't want to be replicated
		
	}
	
	local self = setmetatable({
		
		name = name,
		data = data
		
	}, component)
	
	return self
	
end

return component.create