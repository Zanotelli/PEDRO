extends TileMap

enum layers{
	layer0 = 0,
	layer1 = 1
}

const grass_block1_atlas_coord = Vector2i(0,2)
const grass_block2_atlas_coord = Vector2i(1,2)
const invisible_wall_atlas_coord = Vector2i(10,7)

const water0_atlas_coord = Vector2i(0, 10)
const water1_atlas_coord = Vector2i(1, 10)
const water2_atlas_coord = Vector2i(2, 10)
const water3_atlas_coord = Vector2i(3, 10)
const water4_atlas_coord = Vector2i(4, 10)
const water5_atlas_coord = Vector2i(5, 10)
const water6_atlas_coord = Vector2i(6, 10)
const water7_atlas_coord = Vector2i(7, 10)
const water8_atlas_coord = Vector2i(8, 10)
const water9_atlas_coord = Vector2i(9, 10)

const atlas_source = 0

func _ready():
	place_boudries()

func place_boudries():
	var offsets = [
		Vector2i(0,-1),
		Vector2i(0,1),
		Vector2i(-1,0),
		Vector2i(1,0)
	]
	var used = get_used_cells(layers.layer0)
	
	for spot in used:
		for offset in offsets:
			# spot boundries
			var curent = spot + offset
			# if spot = empty
			if get_cell_source_id(layers.layer0, curent) == -1:
				set_cell(layers.layer1, curent, atlas_source, water0_atlas_coord)
				
			
		
	
