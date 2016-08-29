AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate2x3.mdl" )
	self.Entity:PhysicsInit( SOLID_NONE );
	self.Entity:SetSolid( SOLID_NONE );
	self:DrawShadow( false )
    self:SetUseType(SIMPLE_USE)
end

function ENT:OnTakeDamage(dmg)
	return
end

function ENT:Use(pl,caller)
	pl:PrintMessage(3,"ummm mine")
	return
end

/*---------------------------------------------------------
   Name: PhysicsUpdate
   Desc: Called to update the physics .. or something.
---------------------------------------------------------*/
function ENT:PhysicsUpdate( physobj )
end
/*---------------------------------------------------------
   Name: PhysicsCollide
   Desc: Called when physics collides. The table contains 
			data on the collision
---------------------------------------------------------*/
function ENT:PhysicsCollide(Data, PhysObj)
end