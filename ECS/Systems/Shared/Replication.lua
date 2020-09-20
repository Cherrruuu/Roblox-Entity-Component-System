local runService = game:GetService("RunService")


local ECSDir     = script.Parent.Parent.Parent
local ECS        = require(ECSDir)
local system     = {}
system.components = {

	"Replicate"
	
}
system.order       = nil
system.isServer    = runService:IsServer()
system.oldEntities = {}


function areValuesEqual(table1, table2, ignoreMT)

   local tableType1 = type(table1)
   local tableType2 = type(table2)

   if (tableType1 ~= tableType2) then return false end

   if (tableType1 ~= "table" and tableType1 ~= "table") then return tableType1 == tableType2 end

   local metatable = getmetatable(table1)
   if (not ignoreMT and metatable and metatable.__eq) then return table1 == table2 end

   for index, value in next, table1 do

      local value2 = table2[index]
      if (value2 == nil or not areValuesEqual(value,value2)) then return false end

   end

   for index, value in next, table2 do

      local value1 = table1[index]
      if (value1 == nil or not areValuesEqual(value1,value)) then return false end

   end

   return true

end


function checkIfAllComponentsReplicable(entity)
	
	local exists = system.oldEntities[entity.id]
			
	if (exists) then
		
		for componentIndex, component in next, entity:getAllComponents() do
		
			if (componentIndex ~= "Replicate") then
		
				local replicate = true
			
				for key, value in next, component.data do
					
					local typeOfKey = type(value)
					
					if (typeOfKey ~= "table") then
					
						if (system.oldEntities[entity.id][key] == value) then
							
							replicate = false
							
						else
							
							system.oldEntities[entity.id][key] = value
							
						end
						
					else
						
						replicate = areValuesEqual(system.oldEntities[entity.id][key], value)
						
					end
					
				end
				
				if (replicate == false) then
					
					entity.components[componentIndex] = nil
					
				end
				
			end
			
		end
		
	else
		
		system.oldEntities[entity.id] = {}
		
		for componentIndex, component in next, entity:getAllComponents() do
		
			for key, value in pairs(component.data) do
				
				system.oldEntities[entity.id][key] = value
				
			end
			
		end
		
	end
	
end


function replicateEntities(entities)
	
	if (system.isServer) then
		
		local allPlayers      = {}
		local specificPlayers = {}
		
		for entityIndex, entity in next, entities do
			
			checkIfAllComponentsReplicable(entity)
			
			local players = entity:getComponentValue("Replicate", "Players")
			
			if (#players > 0) then
				
				for playerIndex, player in next, players do
					
					local exists = specificPlayers[player]
					
					if (not exists) then specificPlayers[player] = {} end
					
					specificPlayers[player][#player + 1] = entity
					
				end
				
			else
				
				allPlayers[#allPlayers + 1] = entity
				
			end
			
		end
		
		if (#allPlayers > 0) then ECSDir.Remotes.Events.ECSDir.Entity.addEntities:FireAllClients(allPlayers) end
		
		if (#specificPlayers > 0) then
			
			for player, playerEntities in next, specificPlayers do
				
				ECSDir.Remotes.Events.ECSDir.Entity.addEntities:FireClient(player, playerEntities)
				
			end
			
		end
		
	end
	
end


system.run = function(entities)

	local entities = ECS.getEntities()
	
	if (system.isServer) then
	
		local toReplicate = {}
		
		for entityIndex, entity in next, entities do
			
			if (entity) then
				
				local hasComponents = entity:hasComponents(system.components)
				
				if (hasComponents and entity:getComponentValue("Replicate", "isReplicating")) then
					
					if (entity.sharedId == "") then entity.sharedId = tostring(entity.id) .. "_Shared" end
					toReplicate[#toReplicate + 1] = entity
					
				end
			
			end
			
		end
		
		replicateEntities(toReplicate)
		
	end
	
	wait()

end


system.init = nil


return system
