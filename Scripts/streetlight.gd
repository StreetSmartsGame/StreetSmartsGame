extends Area3D

const GREEN_LIGHT_DELAY = 2.0  # Time before light turns green

var car_in_area = false
var car: BaseCar = null
var go = false  # Green light flag
var wait_timer = 0.0
var waiting_for_green = false

@onready var red_light = $red
@onready var green_light = $green

func _ready():
	# Ensure initial state is red visible, green hidden
	red_light.visible = true
	green_light.visible = false

func _process(delta):
	if car_in_area and car != null:
		var car_speed = car.linear_velocity.length()
		print("Car Speed:", car_speed, " | Wait Timer:", wait_timer, " | Go:", go)

		if not go:
			wait_timer += delta
			
			randomize()
			var VAL = randi_range(3,8)
			
			if wait_timer >= VAL:
				go = true
				_switch_to_green()

func _on_body_entered(body):
	if body is BaseCar:
		car = body
		car_in_area = true
		go = false
		wait_timer = 0.0
		waiting_for_green = true
		_switch_to_red()
		print("Car entered. Light is RED.")

func _on_body_exited(body):
	if body is BaseCar:
		if go:
			print("Car waited for green light.")
			car.successfully_stopped_at_stop_sign() 
		else:
			print("Car ran the red light!")
			car.apply_street_light_penalty()

		# Reset state
		car_in_area = false
		car = null
		go = false
		wait_timer = 0.0
		waiting_for_green = false
		#_switch_to_red()  # Reset light

func _switch_to_green():
	red_light.visible = false
	green_light.visible = true
	print("Switched to GREEN light!")

func _switch_to_red():
	red_light.visible = true
	green_light.visible = false
	print("Switched to RED light.")



func toggle_collision(enable: bool) -> void:
	$CollisionShape3D.disabled = !enable
	set_process(enable)
	set_physics_process(enable)
