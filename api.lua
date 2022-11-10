--pvp_areas_table=pvp_areas:pvp_areas_table
function saveBlockPos(pos)
    --print("High score: "..tostring(score))
    local file = io.open("block_pos.txt",'w')
    file:write(minetest.pos_to_string(pos)..'/n')
    file:close()
end

function pvp_areas:areaExists(pos)
        for k, v in pairs(pvp_areas_store:get_areas_for_pos(pos)) do
                if k then
                        --minetest.chat_send_player(playername, "in loop - safemode"..savemodeToString.." isPlayer "..IsPlayerToString)
                        return true --KILL_NO
                 end
        end
        return false
end
--pvp_areas_table={}
function pvp_areas:addProtectorBlock(name,pos)
local pos1={}
local pos2={}

 pos1.y=pos.y-6
 pos1.x=pos.x-6
 pos1.z=pos.z-6

 pos2.y=pos.y+6
 pos2.x=pos.x+6
 pos2.z=pos.z+6

 minetest.chat_send_player(name, "Position 1: " .. minetest.pos_to_string(pos1))
 minetest.chat_send_player(name, "Position 2: " .. minetest.pos_to_string(pos2))
 --mod_storage(pos)
 pvp_areas_store:insert_area(pos1,pos2, "pvp_areas", #pvp_areas_table)
 table.insert(pvp_areas_table, pvp_areas_store:get_area(#pvp_areas_table))
 pvp_areas:update_pvp_areas()
 pvp_areas:save_pvp_areas()
 
 id=0
 while pvp_areas_store:get_area(id) do
  id=id+1
 end 
 id=id-1
 mod_storage:set_string(minetest.pos_to_string(pos), tostring(id) )
 minetest.chat_send_player(name, "Non PVP Area set. 11x11 blocks ")

end
 
function pvp_areas:removeProtectorBlock(pos)
 --pvp_areas:update_pvp_areas()

  key=minetest.pos_to_string(pos)
  minetest.chat_send_all( "pos " .. key)
  
  n=tonumber(mod_storage:get_string(key) )
  minetest.chat_send_all( "n " .. tostring(n))

  
  for k, v in pairs(pvp_areas_store:get_areas_for_pos(pos)) do
   if k then
    n=k
    break
   end
  end

   if n and pvp_areas_store:get_area(n) then
     pvp_areas_store:remove_area(n)
     if pvp_areas_store:get_area(n + 1) then
        -- Insert last entry in new empty (removed) slot.
        local a = pvp_areas_store:get_area(#pvp_areas_table - 1)
        pvp_areas_store:remove_area(#pvp_areas_table - 1)
        pvp_areas_store:insert_area(a.min, a.max, "pvp_areas", n)
     end
  pvp_areas:update_pvp_areas()
  pvp_areas:save_pvp_areas()
  minetest.chat_send_all( "Removed " .. tostring(n))
else
  minetest.chat_send_all( "Invalid argument.  You must enter a valid area identifier.")
end
  --area=pvp_areas_store:get_area(counter)
  --minetest.chat_send_player(name, "areas " .. minetest.pos_to_string(area[1]))
end
