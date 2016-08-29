local Map = game.GetMap()
local SpawnPositions = {}
local SpawnAngles = {}

function SpawnScoreboard()

	--local score_board = ents.Create("score_board")
	--score_board:SetPos(SpawnPositions[Map])
	--score_board:SetAngles(SpawnAngles[Map])
 	--score_board:Spawn() 

 	local properties = Boards["GB"].properties

 	local pos = Boards["GB"].boardLocation

 	for i, property in pairs(Boards["GB"].properties) do

 		local newEnt = nil
 		if property.entity == nil or not property.entity:IsValid() then
 			print(property.entity)
 			PrintTable(property)
			newEnt = ents.Create("base_property")
			property.entity = newEnt
		end
		property.entity.property = property


		property.entity:SetPos(Vector(pos.x + i * 50, pos.y + 220, pos.z))

		if i < 10 then
			property.entity:SetAngles(Angle(0, 90, 180))
		elseif i < 20 then
			property.entity:SetAngles(Angle(0, 0, 180))
		elseif i < 30 then
			property.entity:SetAngles(Angle(0, -90, 180))
		elseif i < 40 then
			property.entity:SetAngles(Angle(0, 180, 180))
		end

		if not newEnt == nil then
	 		property.entity:Spawn() 
	 	end
	end
end

hook.Add("InitPostEntity", "SpawnScoreboard", SpawnScoreboard)