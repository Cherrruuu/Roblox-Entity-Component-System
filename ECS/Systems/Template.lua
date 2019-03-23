--[[-----------------

This template system will not run. 
If you want it to run, name it something besides "Template"

-------------------]]

--local runService = game:GetService("RunService") --use for Shared Systems


local ECSDir     = script.Parent.Parent.Parent --we add the extra .Parent because the Systems will be in one of the folders: Server, Client, or Shared.
local ECS        = require(ECSDir)
local system     = {}
system.components = {

	"Template"
	
}
system.order      = nil
--system.isServer   = runService:IsServer() --use for Shared Systems


--whatever functions you want to use and modules you want to require can go in between here. same for variables.


system.init = function()
	
	print("initiated")
	
end


return system