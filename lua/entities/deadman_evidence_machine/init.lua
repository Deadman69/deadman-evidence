AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include('shared.lua')

util.AddNetworkString("DE:SendInformations")

function ENT:Initialize()

    self:SetModel("models/props/cs_office/computer.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	if phys:IsValid() then
		phys:Wake()
	end

end

local victim
local attacker

function ENT:Touch( entity )
	if entity:GetClass() == "deadman_evidence_douille" then
		victim = entity:GetNWString("victim")
		attacker = entity:GetNWString("attacker")
		print(victim)
		print(attacker)

		net.Start("DE:SendInformations")
		net.WriteString(victim)
		net.WriteString(attacker)
		net.Send(player.GetAll())

		entity:Remove()
	end
end