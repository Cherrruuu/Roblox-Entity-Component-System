# Roblox Entity-Component-System
A Entity-Component-System library for Roblox

[Roblox Place File](https://github.com/Cherrruuu/Roblox-Entity-Component-System/blob/master/Other/ECS.rbxl)

[Example Game Place File](https://github.com/Cherrruuu/Roblox-Entity-Component-System/blob/master/Other/Coin-Collect-Example-Game.rbxl)

[Example Game on Roblox](https://www.roblox.com/games/2784186475/Coin-Collect-Example-Game). The example game is also uncopylocked.

Twitter post about the library [here](https://twitter.com/Cherrys__Life/status/1094385102480646145)

## Documentation from ECS.lua

### AUTHOR



Written by: Cherrys_Life
Twitter: @Cherrys__Life
Date Created: January 7th, 2019
Date Modified: February 7th, 2019
For help contact her by DM on Twitter, or Roblox messages.



### DOCUMENTATION



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



### TERMINOLOGY



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



### METHODS



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



### HOW TO USE



Look to the "Example" script on how to setup a game loop with the ECS library.
