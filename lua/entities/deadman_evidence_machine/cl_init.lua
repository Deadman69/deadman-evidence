AddCSLuaFile( "shared.lua" )
include('shared.lua')

surface.CreateFont( "Font", {
	font = "Coolvetica",
	size = 30,
	weight = 1000,
	antialias = true,
} )

local shouldDraw = false
local attacker 
local victim

net.Receive("DE:SendInformations", function()
	victim = net.ReadString()
	attacker = net.ReadString()
	shouldDraw = true
end)

function ENT:Draw()
	self:DrawModel()

	local eye = LocalPlayer():EyeAngles()
	local Pos = self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 40 )
	local Ang = Angle( 0, eye.y - 90, 90 )
	local clr = HSVToColor(((CurTime()*10)%360), 0.5, 0.5)
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) > 1500 then return end
	cam.Start3D2D(Pos, Ang, 0.2)
		if shouldDraw then 
			draw.SimpleTextOutlined("Murderer: "..attacker,"Font",0,-20,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )
			draw.SimpleTextOutlined("Victim: "..victim,"Font",0,0,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,0,1.5,Color(0, 0, 0, 255) )
			timer.Simple(5, function()
				shouldDraw = false
			end)
		end
		
		surface.SetDrawColor(255, 255, 255)
	cam.End3D2D()
end
