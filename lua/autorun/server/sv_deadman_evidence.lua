hook.Add("PlayerDeath", "DeadmanEvidenceCheckDeath", function(victim, inflictor, attacker)
	if victim:IsPlayer() and attacker:IsPlayer() then
		local douille = ents.Create( "deadman_evidence_douille" )
		if ( !IsValid( douille ) ) then return end
		douille:SetModel( "models/weapons/w_bullet.mdl" )
		douille:SetPos( attacker:GetPos() )
		douille:Spawn()
		douille:SetNWString("victim", victim:Nick())
		douille:SetNWString("attacker", attacker:Nick())
	end
end)