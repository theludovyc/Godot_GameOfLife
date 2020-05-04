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
			if x == 0 or y == 0 or x == X-1 or y == Y-1:
				_array0[y*X+x] = 0
				_array1[y*X+x] = 0
				continue
			
			var v = randi()%2
			
			_array0[y*X+x] = v
			_array1[y*X+x] = v
	
	pass # Replace with function body.

func isAlive(x, y):	
	var cell = arrays[0][y*X+x]
	
	var i = 0
	
	for vx in range(x-1, x+2):
		for vy in range(y-1, y+2):
			if vx<0 or vy<0 or vx>X-1 or vy>Y-1:
				continue;
				
			i += arrays[0][vy*X+vx]
	
	if (cell==1 and (i==3 or i==4)) or (cell==0 and i==3):
		arrays[1][y*X+x] = 1
		return
	
	arrays[1][y*X+x] = 0

func _draw():
	#draw_rect(Rect2(0, 0, 4*X, 4*Y), Color.black)
	for x in range(1, X-1):
		for y in range(1, Y-1):
			if arrays[0][y*X+x] == 1:
				draw_rect(Rect2(x*4, y*4, 4, 4), Color.blue)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(Engine.get_frames_per_second())
#	pass

func _on_Timer_timeout():
	for x in range(1, X-1):
		for y in range(1, Y-1):
			var cell = arrays[0][y*X+x]
	
			var i = 0
			
			for vx in range(x-1, x+2):
				for vy in range(y-1, y+2):
					i += arrays[0][vy*X+vx]
			
			if (cell==1 and (i==3 or i==4)) or (cell==0 and i==3):
				arrays[1][y*X+x] = 1
			else:
				arrays[1][y*X+x] = 0
	
	arrays.invert()
	
	update()
