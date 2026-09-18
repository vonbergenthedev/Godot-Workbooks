class_name MobPathToFollow extends PathFollow2D

var mob: DefaultMob = null: set = set_mob

func _ready() -> void:
	if mob == null and get_child_count() > 0:
		set_mob(get_child(0))


func _physics_process(delta: float) -> void:
	progress += mob.speed * delta


func set_mob(new_mob: DefaultMob) -> void:
	mob = new_mob
	if mob != null:
		mob.tree_exited.connect(queue_free)
