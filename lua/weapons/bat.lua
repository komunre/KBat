AddCSLuaFile()

SWEP.PrintName = "KBat"
SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Author = "komunre"
SWEP.Contact = "koliziy5@gmail.com"
SWEP.Instruction = "BEAT THE PEOPLE"
SWEP.Category = "Melee"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/bate.mdl"
SWEP.WorldModel = "models/weapons/bate.mdl"
SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.DefaultOffset = Vector(2, -2, 0.5)

SWEP.HitDistance = 80

if SERVER then
	util.AddNetworkString("play_smash")
end

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	if (!SERVER) then return end
	local data = self.Owner:GetEyeTrace()
	local ent = data.Entity
	if (ent or data.Hit or data.HitWorld) and (data.HitPos - data.StartPos):Length() < self.HitDistance then
		net.Start("play_smash")
		net.WriteEntity(self)
		net.Send(self.Owner)
	end
	if (ent) and (data.HitPos - data.StartPos):Length() < self.HitDistance then
		ent:TakeDamage(67, self:GetOwner(), self)
	end
	self:SetNextPrimaryFire(CurTime() + 2)
end

net.Receive("play_smash", function()
	local ent = net.ReadEntity()
	ent:EmitSound("Weapon_Crowbar.Melee_Hit", 55)
end)

function SWEP:Think()
end

function SWEP:SecondaryAttack()

end

function SWEP:GetViewModelPosition(eyePos, eyeAng)
	local resVec = eyeAng:Forward()
	resVec = resVec * 5
	resVec = eyePos + resVec
	resVec = resVec + self.DefaultOffset.x * eyeAng:Right()
	resVec = resVec + self.DefaultOffset.y * eyeAng:Up()
	resVec = resVec + self.DefaultOffset.z * eyeAng:Forward()
	return resVec, eyeAng
end