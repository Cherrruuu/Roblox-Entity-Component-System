--[[-----------------

AUTHOR



Written by: Cherrys_Life
Twitter: @Cherrys__Life
Date Created: January 7th, 2019
Date Modified: February 7th, 2019
For help contact her by DM on Twitter, or Roblox messages.



DOCUMENTATION



IMPORTANT: FOR BOTH CLIENTS AND THE SERVER TO USE THIS LIBRARY, PUT IT IN REPLICATEDSTORAGE.

This library comes with base Components, and Systems you can use. 

It is recommended to not remove the Replication System or the Replicate Component unless you want to create your own.
The reason being is these are used by default to replicate Entities with the Replicate Component to the clients.
How Replication works with this is the System checks all Entities to see if they have the Replicate Component
and if an Entity does, it checks the Replicate Component's "isReplicating" variable to see if it's alright to replicate.
If it's alright to replicate, then the System replicates the Entity to all players (or specific players if specified),
replicated Entities to clients reside in the "entities" table of the clients, but instead of using a regular numerical id
for the index, it uses a "sharedId" which is a string that uses that Entity's id on the server concated with "_Shared".

If any of your Systems use a wait or any other type of yield function, please wrap the run function
of the System in a coroutine or spawn. If you don't you may cause other Systems to not run properly.

If you wish for server-client and client-server communication, in your Systems use remotes you create.
You should use the isServer variable of the System's table for deciding which functions to use and/or which logic to follow. (This only applies
to Systems you put under the Shared folder.)

The "Components" folder is where you should create modules
for each Component you wish to make for your game.

The "Assemblages" folder is where you should create modules
for each Assemblage you wish to make for your game.

The "Systems" folder is where you should create modules
for each System you wish to make for your game.

DO NOTE WHEN CREATING, RECEIVING, OR SENDING ENTITIES/ASSEMBLAGES VIA BINDABLES OR REMOTES IT IS REQUIRED YOU
SET THEIR METATABLE TO THE ENTITY MODULE AGAIN, AS ROBLOX DOES NOT SUPPORT SENDING SELF-REFERENCES WITH BINDABLES AND REMOTES!
CREATING, RECEIVING, AND SENDING ENTITIES/ASSEMBLAGES VIA BINDABLES AND REMOTES IS NOT RECOMMENDED, UNLESS YOU WANT TO REPLICATE ENTITIES/ASSEMBLAGES
FROM THE SERVER TO THE CLIENT AND VICE VERSA. DO NOTE, HOWEVER, THE LIBRARY COMES WITH A BUILT-IN WAY OF REPLICATING ENTITIES FROM SERVER TO CLIENT.
YOU WILL HAVE TO SET UP A WAY TO REPLICATE ENTITIES/ASSEMBLAGES FROM CLIENT TO SERVER YOURSELF.
THE REASON IT IS NOT RECOMMENDED TO DO AS WAS SAID, IS DUE TO THE COMPLICATIONS IT RAISES WHEN DOING SO, AND THE EXCESS CODE RELATED TO IT.

Systems put in the Server folder will only be required by the Server ECS, Systems put in the Client folder will only be required by the Client ECSs,
Systems put in the Shared folder will be required by both.

FINAL NOTE: WHEN TESTING, DO NOT TEST IN PLAY TEST AS IT WILL NOT RUN AS EXPECTED DUE TO THERE NOT BEING PROPER CLIENTS AND SERVERS.
TO TEST PLEASE USE CLIENTS AND SERVERS TESTING UNDER THE TEST TAB.



TERMINOLOGY



ECS - Entity-Component-Systems.

Entity - The entity is a general purpose object.
Usually, it only consists of a unique id 
and a container (usually an array, but a table in this case) for Components. 
They "tag every coarse gameobject as a separate item". 
Implementations typically use a plain integer for this.

Components - A set of data, contains only data and no functionality/behavior.

System - Code that runs through every Entity and searches for Entities with
Components that the System needs to run logic on.

Assemblages - A collection of components to easily create the same type of Entity,
similar to a class. An example of an Assemblage would be a Orc Entity that consists of
an Position Component, Health Component, etc..



METHODS



ECS ECS.create()


Entity ECS.createEntity(number id)
Entity, bool ECS.removeEntity(number id)
void ECS.addEntities(Entity[] entities) --STRICTLY A FUNCTION FOR THE DEFAULT REPLICATION SYSTEM, NOTHING ELSE SHOULD USE THIS
Entity[] ECS.getEntities()
number ECS.getAmountOfEntities()
bool ECS.entityHasComponent(number id, string[] componentNames)
Entity[] ECS.getEntitiesWithComponents(string[] componentNames)
Components[] ECS.getComponentsFromEntity(number id, string[] componentNames)
Components[] ECS.getEntityComponents(number id)
number ECS.getAmountOfEntityComponents(number id)


void ECS.addComponent(Entity entity, string componentName)
bool ECS.removeComponent(Entity entity, string componentName)
unknown ECS.getComponentValue(Entity entity, string componentName, string index) --index, is the index of the component's data table that you want to check
void ECS.setComponentValue(Entity entity, string componentName, string index, anyDataType value)
void ECS.updateComponents(Entity entity, Component[] components)
Components[] ECS.getComponents()
number ECS.getAmountOfComponents()

Entity ECS.createAssemblage(string assemblageName, number id, varargs ...) --note: varargs (denoted by the ... syntax) are a random number of variables you can include as parameters
modules[] ECS.getAssemblages()
number ECS.getAmountOfAssemblages()


Systems[] ECS.getSystems()
number ECS.getAmountOfSystems()



HOW TO USE



Look to the "Example" script on how to setup a game loop with the ECS library.

-------------------]]

local runService = game:GetService("RunService")


local entityModule = require(script.Entity)


local ECS = {}


ECS.entities    = {}
ECS.components  = {}
ECS.assemblages = {}
ECS.systems     = {}


local isServer = runService:IsServer()


ECS.ready = false


function ECS.create()
	
	for componentIndex, component in next, script.Components:GetDescendants() do
		
		if (component.ClassName == "ModuleScript" and component.Name ~= "Template") then
			
			ECS.components[component.Name] = component
			
		end
		
	end
	
	for assemblageIndex, assemblage in next, script.Assemblages:GetDescendants() do
		
		if (assemblage.ClassName == "ModuleScript" and assemblage.Name ~= "Template") then
			
			ECS.assemblages[assemblage.Name] = assemblage
			
		end
		
	end
	
	if (isServer) then
	
		local systems = script.Systems.Server:GetDescendants()
		
		for systemIndex, system in next, systems do
			
			if (system.ClassName == "ModuleScript" and system.Name ~= "Template") then
				
				ECS.systems[system.Name] = require(system)
				
			end
			
		end
		
	else
		
		local systems = script.Systems.Client:GetDescendants()
		
		for systemIndex, system in next, systems do
			
			if (system.ClassName == "ModuleScript" and system.Name ~= "Template") then
				
				ECS.systems[system.Name] = require(system)
				
			end
			
		end
		
	end
	
	local systems = script.Systems.Shared:GetDescendants()
	
	for systemIndex, system in next, systems do
			
		if (system.ClassName == "ModuleScript" and system.Name ~= "Template") then
			
			ECS.systems[system.Name] = require(system)
			
		end
		
	end
	
	table.sort(ECS.systems, function(a, b)
			
		return a.order < b.order
		
	end)
	
	ECS.ready = true
	
end


--Entity


function ECS.createEntity(id)
	
	if (id == nil) then
		
		id = ECS.getAmountOfEntities() + 1
		
	end
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local entity = entityModule.create(id)
	
	ECS.entities[id] = entity
	
	return entity
	
end


function ECS.removeEntity(id)
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local exists = ECS.entities[id]
	
	if (exists) then
		
		exists:remove()
		ECS.entities[id] = nil
		
	end
	
	return exists ~= nil and true or false
	
end


function ECS.addEntities(entities) --STRICTLY A FUNCTION FOR THE DEFAULT REPLICATION SYSTEM, NOTHING ELSE SHOULD USE THIS
	
	for entityIndex, entity in next, entities do
		
		setmetatable(entity, entityModule)
		
		local exists = ECS.entities[entity.sharedId]
		
		if (exists) then
			
			ECS.updateComponents(exists, entity.components)
			
		else
			
			ECS.entities[entity.sharedId] = entity
			
		end
		
	end
	
end

if (not isServer) then script.Remotes.Events.ECS.Entity.addEntities.OnClientEvent:Connect(function(...) return ECS.addEntities(...) end) end


function ECS.getEntities()
	
	return ECS.entities
	
end


function ECS.getAmountOfEntities()
	
	return #ECS.entities
	
end


function ECS.entityHasComponents(id, componentNames)
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local exists = ECS.entities[id]
	
	if (exists) then
		
		return exists:hasComponents(componentNames)
		
	end
	
end


function ECS.getEntitiesWithComponents(componentNames)
	
	local entities = ECS.getEntities()
	local got      = {}
	
	for entityIndex, entity in next, entities do
		
		local has = true
		
		for componentIndex, component in next, componentNames do
			
			if (ECS.entityHasComponents(entity.id, {component}) == false) then
				
				has = false
				break
				
			end
			
		end
		
		if (has) then
			
			got[#got + 1] = entity
			
		end
		
	end
	
	return got
	
end


function ECS.getComponentsFromEntity(id, componentName)
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local exists = ECS.entities[id]
	
	if (exists) then
		
		return exists:getComponents(componentName)
		
	end
	
end


function ECS.getEntityComponents(id)
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local exists = ECS.entities[id]
	
	if (exists) then
		
		return exists:getAllComponents()
		
	end
	
end


function ECS.getAmountOfEntityComponents(id)
	
	if (type(id) ~= "number" and type(id) ~= "string") then return end
	
	local exists = ECS.entities[id]
	
	if (exists) then
		
		return exists:getAmountOfComponents()
		
	end
	
end


--Components


function ECS.addComponent(entity, component)
	
	entity:addComponent(ECS.components[component])
	
end


function ECS.removeComponent(entity, componentName)
	
	local success = entity:removeComponent(componentName)
	
	return success
	
end


function ECS.getComponentValue(entity, componentName, index)
	
	local value = entity:getComponentValue(componentName, index)
	
	return value
	
end


function ECS.setComponentValue(entity, componentName, index, value)
	
	entity:setComponentValue(componentName, index, value)
	
end


function ECS.updateComponents(entity, components)
	
	entity:updateComponents(components)
	
end


function ECS.getComponents()
	
	return ECS.components
	
end


function ECS.getAmountOfComponents()
	
	return #ECS.components
	
end


--Assemblages


function ECS.createAssemblage(assemblageName, id, ...)
	
	local exists = ECS.assemblages[assemblageName]
	local assemblage
	
	if (exists) then
		
		assemblage = require(exists)
		
	else return end
	
	local entity = ECS.createEntity(id)
	
	for componentIndex, component in pairs(assemblage.components) do
		
		ECS.addComponent(entity, component.name, component.values)
		
	end
	
	assemblage.func(entity, ...)
	
	return entity
	
end


function ECS.getAssemblages()
	
	return ECS.assemblages
	
end


function ECS.getAmountOfAssemblages()
	
	return #ECS.assemblages
	
end


--Systems


function ECS.getSystems()
	
	return ECS.systems
	
end


function ECS.getAmountOfSystems()
	
	return #ECS.systems
	
end


return ECS