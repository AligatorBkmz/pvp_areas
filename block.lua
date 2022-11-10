minetest.register_node("pvp_areas:protector", {
	description = "PVP protector block",
	tiles = {"pvp.png"},
	wield_image = "pvp.png",

	groups = {cracky = 1, cracky = 3,  stone = 1},
	

	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "pvp_areas:protector", param2 = 1})
                        pvp_areas:addProtectorBlock(placer:get_player_name(),pos)
		end
       end,

       after_dig_node = function(pos, oldnode, oldmetadata, player)
            pvp_areas:removeProtectorBlock(pos)
       end,
})

minetest.register_craft({
	output = "pvp_areas:protector",
	recipe = {
          {"group:stone", "group:stone", "group:stone"},
          {"group:stone", "farming:hemp_leaf", "group:stone"},
          {"group:stone", "group:stone", "group:stone"}	}
})
