--[[-----------------

This template system will not run. 
If you want it to run, name it something besides "Template"

-------------------]]

local repStorage = game:GetService("ReplicatedStorage")


local ServerECSDir = script.Parent.Parent
local ECSDir       = repStorage.ECS
local ECS          = require(ECSDir)
local system       = {}
system.components   = {

	"Template"
	
}
system.order      = nil


--whatever functions you want to use and modules you want to require can go in between here. same for variables.


system.run = function(entities)
	
	local currentEntity
	
	for entityIndex, entity in next, entities do
		
		if (entity) then --check just in case rbx.lua's garbage collection doesn't remove an entity in time
		
			currentEntity = entity
			
			local hasComponents = entity:hasComponents(system.components)
			
			if (hasComponents) then
				
				--do whatever logic checks you need here to affect whichever component
				
			end
		
		end
		
	end
	
end


system.init = function()
	
	print("initiated")
	
end


return system