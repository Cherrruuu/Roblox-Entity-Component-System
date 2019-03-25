## March 25th, 2019
Added a new function, ECS.copyEntity
Takes a single parameter of "id" which is the id of the entity you wish to copy.
This function copys all components and the data in the components of the copied entity.


## March 23rd, 2019
Fixed an unknown issue with Components not working properly. Despite being different tables,
they had the same values. This could cause many issues with Players having the same data, or entities
having same data.


## February 21st, 2019
Fixed issue with Assemblages not being able to update components from creation of the Assemblage.
ECS.addComponent and Entity.addComponent both now take a new parameter of "values" which is a dictionary
that can be used to give new default values to a component on addition of a component to an entity.


## February 14th, 2019
Added new function: ECS.getEntityByID()

Entity ECS.getEntityByID(number id)

Use this function to find entities by IDs, is helpful for when you use bindables, since bindables can't send entities
without breaking the metatables of entities.


## February 13th, 2019
The Server folders for Systems, Components, and Assemblages were put into their own folder, so they can reside
in ServerScriptService. This way exploiters can't just read your Server code from it being in ReplicatedStorage with the rest of the stuff.
The separate folder for the Server also has its own Bindables folder, but the Remotes folder is still under the ECS ModuleScript.


## February 12th, 2019
Added Server, Client, and Shared folders for Components and Assemblages just like the Systems folder. This way only certain ones will be required depending if Client or Server. Server will now only get Systems, Components, and Assemblages in Server and Shared folders. Clients will now only get Systems, Components, and Assemblages in Client and Shared folders.
