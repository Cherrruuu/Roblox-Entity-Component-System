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


system.init = function()
	
	print("initiated")
	
end


return system