local component = {}
component.name   = "Replicate"
component.data   = {

	["isReplicating"] = true, --Set this to false if you don't want the entity to replicate just yet.
	["Players"]       = {} --if you want to replicate to specific players, put their Player objects in this table, this can be done during runtime.
	
}

function component.returnCopy()
	
	local new = {}
	new.name  = component.name
	new.data  = {}
	
	for dataIndex, data in next, component.data do
		
		new.data[dataIndex] = data
		
	end
	
	return new
	
end

return component.returnCopy