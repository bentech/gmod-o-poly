local Map = game.GetMap()
local SpawnPositions = {}
local SpawnAngles = {}

--item 206 High
--Big items 217 wide
--Small 133 wide

local ITEM_HEIGHT = 206
local LARGE_WIDTH = 217
local SMALL_WIDTH = 129.5
local SMALL_WIDTH_2 = 124.5

function SpawnScoreboard()
print("RELOADING")

 for k,v in pairs(ents.FindByClass("base_property"))do v:Remove() end
	--local score_board = ents.Create("score_board")
	--score_board:SetPos(SpawnPositions[Map])
	--score_board:SetAngles(SpawnAngles[Map])
 	--score_board:Spawn() 

 	local pos = Boards["GB"].boardLocation
		  pos = Vector(pos.x, pos.y, pos.z+80)

	for i=0,39 do
 		local newEnt = nil
 		if true or Boards["GB"].properties[i].ent == nil or not Entity(Boards["GB"].properties[i].ent):IsValid() then
			newEnt = ents.Create("base_property")
			Boards["GB"].properties[i].ent = newEnt:EntIndex()
			newEnt:SetNWString("board", "GB")
			newEnt:SetNWString("position", i)
		else
			newEnt = Entity(property.ent)
			newEnt:SetNWString("board", "GB")
			newEnt:SetNWString("position", i)
		end

		if not newEnt or not newEnt:IsValid() then

			return

		end


		local addX, addY = 0,0

		if i <= 10 then
			newEnt:SetAngles(Angle(0, 0,90))
			if i == 0 then
				addY = addY + (ITEM_HEIGHT / 2)
				addX = addX -(LARGE_WIDTH / 2)
			elseif i == 1 || i == 10 then
				addX = addX -(LARGE_WIDTH / 2)
				addX = addX -(SMALL_WIDTH / 2)
			else
				addX = addX -SMALL_WIDTH
			end
		elseif i <= 20 then
			newEnt:SetAngles(Angle(0,270, 90))
			if i == 11 || i == 20 then
				addY = addY + (ITEM_HEIGHT / 2) + (SMALL_WIDTH_2 / 2)
			else
				addY = addY + SMALL_WIDTH_2
			end
		elseif i <= 30 then
			newEnt:SetAngles(Angle(0, 180, 90))
			if i == 21 || i == 30 then
				addX = addX +(LARGE_WIDTH / 2)
				addX = addX +(SMALL_WIDTH / 2)
			else
				addX = addX +SMALL_WIDTH
			end
		elseif i <= 40 then
			newEnt:SetAngles(Angle(0, 90, 90))
			if i == 31 || i == 40 then
				addY = addY - (ITEM_HEIGHT / 2) - (SMALL_WIDTH_2 / 2)
			else
				addY = addY - SMALL_WIDTH_2
			end
		end

		pos = Vector(pos.x+addX, pos.y+addY, pos.z)
		newEnt:SetPos(pos)

 		newEnt:Spawn() 
	end
end

hook.Add("InitPostEntity", "SpawnScoreboard", SpawnScoreboard)

SpawnScoreboard()