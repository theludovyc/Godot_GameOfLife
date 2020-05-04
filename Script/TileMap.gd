extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const X = 100
const Y = 100

var _array:Array

var tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	tilemap = [$TileMap, $TileMap2]
	
	for x in range(X):
		for y in range(Y):
			var v = randi()%2 - 1
			
			tilemap[0].set_cell(x, y, v)
			tilemap[1].set_cell(x, y, v)
	pass # Replace with function body.


func isAlive(vx, vy):
	var i = 0;
	
	var cell = tilemap[0].get_cell(vx, vy)
	
	for x in range(vx-1, vx+2):
		for y in range(vy-1, vy+2):
			if x<0 or y<0 or x>X-1 or y>Y-1:
				continue;
			
			if tilemap[0].get_cell(x, y)==0:
				i+=1
	
	if cell==0 and (i==3 or i==4):
		tilemap[1].set_cell(vx, vy, 0)
		return
	elif cell==-1 and i==3:
		tilemap[1].set_cell(vx, vy, 0)
		return
	
	tilemap[1].set_cell(vx, vy, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(Engine.get_frames_per_second())
	
#	for x in range(X):
#		for y in range(Y):
#			_array[X*y+x] = get_cell(x, y)
#
#	for x in range(X):
#		for y in range(Y):
#			isAlive(x, y)
#	pass


func _on_Timer_timeout():
	for x in range(X):
		for y in range(Y):
			isAlive(x, y)
			
	tilemap[0].visible=false
	tilemap[1].visible=true
	
	tilemap.invert()
	pass # Replace with function body.
