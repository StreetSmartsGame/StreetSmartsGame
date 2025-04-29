extends Node3D  # or "Node" if Player is a plain node

func _ready():
	print("Player node is ready, listing children:")
	for child in get_children():
		print(" -", child.name)

	randomize()

	for i in range(1, 7):
		var group_name = "Group " + str(i)
		print("Looking for:", group_name)

		if has_node(group_name):
			var group = get_node(group_name)
			var children = group.get_children()
			if children.size() > 0:
				var visible_index = randi() % children.size()
				for j in range(children.size()):
					children[j].visible = (j == visible_index)
					var collision = children[j].get_node_or_null("CollisionShape3D")
					if collision:
						collision.disabled = (j != visible_index)

					
				print("✅ Group", i, "-> Visible:", children[visible_index].name)
			else:
				print("⚠️ Group", i, "has no children.")
		else:
			print("❌ Group", i, "not found.")
 
