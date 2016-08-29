include("shared.lua")

--name="old_kent_road",
--colour=Color(139,69,19,255),
--entity=NULL,
--cost=60,
--rent=2,
--houses={ [1]=10, [2]=30, [3]=90, [4]=160},
--hotel=250
--cost_to_build=50
--mortgage=30,
--PrintName="Old Kent Road",
--Owner=nil


--name="kings_cross_station",
--colour=Color(0,0,0,255),
--entity=NULL,
--cost=200,
--rent=25,
--multi_property={ [1]=25, [2]=50, [3]=100, [4]=200},
--mortgage=100,
--PrintName="Kings Cross Station",
--Owner=nil 


function ENT:DrawTranslucent()

	local board = self:GetNWString("board", nil)
	local position = self:GetNWString("position", nil)

	local property

	if board == nil or position == nil then
		property = nil
	else
		property = Boards[board].properties[position]
	end

	local pos = self:GetPos()

	pos:Add(self:GetForward()*-40)
	pos:Add(self:GetRight()*-40)
	pos:Add(self:GetUp()*-50)

	local myAng = self:GetAngles()

	myAng = Angle(myAng.pitch, myAng.yaw, myAng.roll)

	if property == nil then
    	self:DrawModel() -- Draws Model Client Side

		cam.Start3D2D(pos, myAng, 0.5)

			local size = surface.GetTextSize( "No Property" .. board)
			draw.DrawText("No Property", "HostFont", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		return
	end

	for k, v in pairs(player.GetAll()) do
		if self:GetPos():Distance(v:GetPos()) > 250 then	
			continue
		end
		cam.Start3D2D(pos, myAng, 0.3)
			renderProperty(property)
		cam.End3D2D()
		break
	end

end