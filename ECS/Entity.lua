--[[-----------------

METHODS



Entity entity.create(number id) --this is only ever used in the ECS module/object

void entity:addComponent(module componentModule) --can use this to quickly add components in runtime, REQUIRES YOU TO GIVE MODULE FOR THIS FUNCTION, NOT THE NAME
bool entity:removeComponent(string componentName) --use this to quickly remove components in runtime
bool entity:hasComponents(string[] componentNames)
Components[] entity:getComponents(string[] componentNames)
Unknown entity:getComponentValue(string componentName, string index) --index, is the index of the component's data table that you want to check
void entity:setComponentValue(string componentName, string index, anyDataType value)
Components[] entity:getAllComponents()
number entity:getAmountOfComponents()
void entity:remove() --use this to get rid of the entity during runtime

-------------------]]

local entity  = {}
entity.__index = entity


function entity.create(id)
	
	local self = setmetatable({
		
		id         = id,
		sharedId   = "",
		components = {}
		
	}, entity)
	
	return self
	
end


function entity:addComponent(componentModule)
	
	local component = require(componentModule)()
	
	self.components[component.name] = component
	
end


function entity:removeComponent(componentName)
	
	local exists = self.components[componentName]
	
	if (exists) then
		
		self.components[componentName] = nil
		
	end
	
	return exists ~= nil and true or false
	
end


function entity:updateComponents(components)
	
	for componentIndex, component in next, components do
		
		if (component ~= nil) then
		
			local exists = self.components[component.name]
			
			if (exists) then
			
				self.data = component.data
				
			end
			
		end
		
	end
	
end


function entity:hasComponents(componentNames)
	
	local has = true
	
	if (#componentNames == 0) then return has end
	
	for componentIndex, component in next, componentNames do
		
		if (self.components[component] == nil) then
			
			has = false
			break
			
		end
		
	end
	
	return has
	
end


function entity:getComponents(componentNames)
	
	local components = {}
	
	for componentIndex, component in next, componentNames do
		
		local has = true
		
		if (self.components[component] == false) then
			
			has = false
			
		end
		
		if (has) then
			
			components[#components + 1] = component
			
		end
		
	end
	
	return components
	
end

function entity:getComponentValue(componentName, index)
	
	local exists = self.components[componentName]
	
	if (exists) then
		
		return exists.data[index]
		
	end
	
end


function entity:setComponentValue(componentName, index, value)
	
	local exists = self.components[componentName]
	
	if (exists) then
		
		exists.data[index] = value
		
	end
	
end


function entity:getAllComponents()
	
	return self.components
	
end


function entity:getAmountOfComponents()
	
	return #self.components
	
end


function entity:remove()
	
	self = nil
	
end


return entity