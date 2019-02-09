--[[-----------------

This template component will not be added to the ECS components table. 
If you want it added, name it something besides "Template"

Please do not use nil values if you plan on using the default Replication System,
it ignores nil values and won't update that client's version of the entity's component

-------------------]]

local component = {}
component.name   = "test"
component.data   = {

	["test"] = true
	
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