--[[-----------------

This template assemblage will not be added to the ECS assemblages table. 
If you want it added, name it something besides "Template"

-------------------]]

local assemblage     = {}
assemblage.components = {

	{
		
		name   = "Template",
		values = { --set this variable to nil if you want to keep the default values of the component
		
			["Template"] = false	
			
		}
		
	}
	
}


assemblage.func = function(entity, ...) --function that will be ran after the assemblage is created
	
	local data = {...}
	
end


return assemblage