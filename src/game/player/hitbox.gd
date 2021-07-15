extends Area2D
class_name Hitbox

enum AttackType {DEFAULT, FIRE, ICE, BUBBLE, BALL}
export(int) var attack : int = 4
export(AttackType) var type = AttackType.DEFAULT
