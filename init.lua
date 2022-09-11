local S = minetest.get_translator("moretubes")

do -- Low Priority Tube Segment
	local color = "#ff8888:128"
	local nodecolor = 0xffff8888
	pipeworks.register_tube("moretubes:low_priority_tube", {
		description = S("Low Priority Tube Segment"),
		inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
		plain = { { name = "pipeworks_tube_plain.png", color = nodecolor } },
		noctr = { { name = "pipeworks_tube_noctr.png", color = nodecolor } },
		ends  = { { name = "pipeworks_tube_end.png",   color = nodecolor } },
		short =   { name = "pipeworks_tube_short.png", color = nodecolor },
		node_def = {
			tube = { priority = 45 } -- Lower than tubes and receivers (50, 100 resp.)
		},
	})
end

do -- Decelerating Pneumatic Tube Segment
	local color = "#9bb75c:128"
	local nodecolor = 0xff9bb75c
	pipeworks.register_tube("moretubes:decelerator_tube", {
		description = S("Decelerating Pneumatic Tube Segment"),
		inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
		plain = { { name = "pipeworks_tube_plain.png", color = nodecolor } },
		noctr = { { name = "pipeworks_tube_noctr.png", color = nodecolor } },
		ends  = { { name = "pipeworks_tube_end.png",   color = nodecolor } },
		short =   { name = "pipeworks_tube_short.png", color = nodecolor },
		node_def = {
			tube = {can_go = function(pos, node, velocity, stack)
					if velocity.speed > 0.5 then
						velocity.speed = velocity.speed - 0.5
					end
					return pipeworks.notvel(pipeworks.meseadjlist, velocity)
				end}
			}
	})
	if minetest.get_modpath("default") then
		minetest.register_craft( {
			output = "moretubes:decelerator_tube_1 2",
			recipe = {
				{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
				{ "", "default:dirt", "" },
				{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
			},
		})
	end
end

do -- Eject Tube
	local color = "#76a5af:128"
	local nodecolor = 0xff76a5af
	pipeworks.register_tube("moretubes:eject_tube", {
		description = S("Eject Tube"),
		inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
		plain = { { name = "pipeworks_tube_plain.png", color = nodecolor } },
		noctr = { { name = "pipeworks_tube_noctr.png", color = nodecolor } },
		ends  = { { name = "pipeworks_tube_end.png",   color = nodecolor } },
		short =   { name = "pipeworks_tube_short.png", color = nodecolor },
		node_def = {
			groups = {tubedevice_receiver = 1},
			tube = {
				insert_object = function(pos, node, stack, direction)
					local drop = minetest.add_item(pos,stack)
					drop:add_velocity(vector.multiply(direction,1.3))
					return ItemStack("")
				end,
				can_insert = function(pos,node,stack,direction)
					return true
				end,
				priority = 50,
			},
		},
	})
end

do -- Reversing Tube Segment
	local color = "#00ff00:128"
	local nodecolor = 0xff00ff00
	pipeworks.register_tube("moretubes:reverse_tube", {
		description = S("Reversing Tube Segment"),
		inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
		plain = { { name = "pipeworks_tube_plain.png", color = nodecolor } },
		noctr = { { name = "pipeworks_tube_noctr.png", color = nodecolor } },
		ends  = { { name = "pipeworks_tube_end.png",   color = nodecolor } },
		short =   { name = "pipeworks_tube_short.png", color = nodecolor },
		node_def = {
			tube = {can_go = function(pos, node, velocity, stack)
					local nvelocity = table.copy(velocity)
					nvelocity.x = nvelocity.x * -1
					nvelocity.y = nvelocity.y * -1
					nvelocity.z = nvelocity.z * -1
					return nvelocity
				end}
			}
	})
end
