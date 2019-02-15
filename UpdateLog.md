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
