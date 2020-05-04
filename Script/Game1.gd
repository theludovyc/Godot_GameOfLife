extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const X = 160
const Y = 160

var _array0:Array

var _array1:Array

var b = false

var arrays = [_array0, _array1]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	_array0.resize(X*Y)
	_array1.resize(X*Y)
	
	for x in range(X):
		for y in range(Y):
			var v = randi()%2 - 1
			
			_array0[y*X+x] = v
			_array1[y*X+x] = v
	
	pass # Replace with function body.

func isAlive(vx, vy):
	var i = 0;
	
	var cell = arrays[0][vy*X+vx]
	
	for x in range(vx-1, vx+2):
		for y in range(vy-1, vy+2):
			if x<0 or y<0 or x>X-1 or y>Y-1:
				continue;
			
			if arrays[0][y*X+x]==0:
				i+=1
	
	if cell==0 and (i==3 or i==4):
		arrays[1][vy*X+vx] = 0
		return
	elif cell==-1 and i==3:
		arrays[1][vy*X+vx] = 0
		return
	
	arrays[1][vy*X+vx] = -1

func _draw():
	#draw_rect(Rect2(0, 0, 4*X, 4*Y), Color.black)
	for x in range(X):
		for y in range(Y):
			if arrays[0][y*X+x] == 0:
				draw_rect(Rect2(x*4, y*4, 4, 4), Color.blue)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(Engine.get_frames_per_second())
#	pass


func _on_Timer_timeout():
	for x in range(X):
		for y in range(Y):
			isAlive(x, y)
	
	update()
	
	arrays.invert()
	
	pass # Replace with function body.
