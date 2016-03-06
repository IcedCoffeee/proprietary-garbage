AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Personal Computer"
ENT.Author = "Iced Coffee"
ENT.Purpose = "test shit iunno"

ENT.Spawnable = true
ENT.Category = "Iced Coffee"

if SERVER then

function ENT:Initialize()
	self:SetModel("models/props/cs_office/computer.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DrawShadow(false)
		
	local physicsObject = self:GetPhysicsObject()
	if ( IsValid(physicsObject) ) then
		physicsObject:Wake()
		physicsObject:EnableMotion(true)
	end


end

function ENT:Use(activator)	
	if activator:GetPos():Distance(self:GetPos()) < 100 then
		net.Start("MainGUI")
		net.Send(activator)
	end
end

function ENT:SpawnFunction(ply, tr, ClassName)

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent:SetNWString("ip", GetIP(ply))

	return ent

end

end