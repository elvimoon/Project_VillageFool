extends Area2D

var push_vec = Vector2.ZERO

func colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0
	
func push():
	var areas = get_overlapping_areas()
	if colliding():
		var area = areas[0]
		push_vec = (area.global_position.direction_to(global_position)).normalized()
	return push_vec
		
