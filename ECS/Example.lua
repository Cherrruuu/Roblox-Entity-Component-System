--[[-----------------

This script is an example of how
you would create a game loop with the ECS library

you can initialize entities and assemblages from any script if you want for ease of doing so
that's why bindables are provided. this means you could also create them from your systems scripts
as well, although this is NOT recommended.
This is just an option for those who want to adopt an OOP ECS approach or do what they want, rather than do a pure ECS approach.

Do note, the order of your Systems matter depending on what you're doing.
For example, you'd want the Input System to go before the Movement System. That way there isn't a delay
when a player presses a key to walk.
To order the Systems, just change the order variable of the systems. Make sure there isn't any conflicts, however. If two Systems
have the same order one of them won't be added to the systems variable of the ECS table.
If you don't care about the order, just set the order variable to nil.

The Clients' versions of the game loop should look exactly like this, or very close.

-------------------]]

local repStorage = game:GetService("ReplicatedStorage")


local ECS = require(repStorage.ECS)
ECS.create()


repeat wait() until ECS.ready --we do this so all needed Modules can be required by ECS


for systemIndex, system in next, ECS:getSystems() do
		
	if (system.init) then --we do this in case we want to leave out the init function
	
		system.init() --we do this in case we have any code we want to run before the "run" method of our systems
		
	end
	
end


while (true) do
	
	local entities = ECS:getEntities()
	
	for systemIndex, system in next, ECS:getSystems() do
		
		if (system.run) then --we do this in case we want to leave out the run function for whatever reason (like using a system as a regular module, or as a regular script)
		
			system.run(entities)
			
		end
		
	end
	
	wait()
	
end