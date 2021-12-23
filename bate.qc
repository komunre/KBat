$modelname "models/weapons/bate.mdl"
$scale 1
$surfaceprop "Wood"

$body 1 "bate.smd"

// Bone animations
$sequence "idle" "anims/idle.smd"  {
	fps 24.0
	"ACT_VM_IDLE" 1
}
$sequence "attack" "anims/attack.smd" {
	fps 24.0
	"ACT_VM_PRIMARYATTACK" 1
}

$cdmaterials "bate"

$include "DefineBones.qci"
