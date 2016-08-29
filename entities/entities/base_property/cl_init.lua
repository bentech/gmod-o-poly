include("shared.lua")

surface.CreateFont( "HostFont", 
                    {
                    font    = "coolvetica",
                    size    = 40,
                    weight  = 700,
                    antialias = true,
                    shadow = true
            })
			
surface.CreateFont( "PlayerFont", 
                    {
                    font    = "coolvetica",
                    size    = 40,
                    weight  = 700,
                    antialias = true,
                    shadow = false
            })

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


function ENT:Draw()
	
	if self.property == nil then

		cam.Start3D2D(self:GetPos() - self:GetAngles():Forward() * 190 + self:GetAngles():Right() * 190, self:GetAngles() + Angle(90, 90, 90), 0.3)
			draw.DrawText("No Property", "HostFont", 470, 295, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		return
	end

	for k, v in pairs(player.GetAll()) do

		if self:GetPos():Distance(v:GetPos()) > 300 then	
			continue
		end

		cam.Start3D2D(self:GetPos() - self:GetAngles():Forward() * 190 + self:GetAngles():Right() * 190, self:GetAngles() + Angle(90, 90, 90), 0.3)
				
		--Main layer
		draw.RoundedBox(0, 450, 270, 350, 400, Color(255,255,255,200))
			
		draw.RoundedBox(0, 460, 285, 330, 60, Color(0,0,0,255))
		draw.RoundedBox(0, 465, 290, 320, 50, Color(60, 179, 113, 255))
			
		--Line Border
		draw.RoundedBox(0, 452, 275, 5, 390, Color(0,0,0,255))
		draw.RoundedBox(0, 452, 275, 345, 5, Color(0,0,0,255))
		draw.RoundedBox(0, 792, 275, 5, 390, Color(0,0,0,255))
		draw.RoundedBox(0, 452, 660, 345, 5, Color(0,0,0,255))
				
		--Text
		draw.DrawText(self.property.PrintName, "HostFont", 470, 295, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		local yPos = 360
		draw.DrawText("Rent "..self.property.rent, "PlayerFont", 465, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		yPos = yPos + 30
		for h,amount in pairs(self.property.houses) do
			draw.DrawText("With "..h.." House\t"..amount, "PlayerFont", 465, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			yPos = yPos + 30
		end
		if not self.property.hotel == nil then
			draw.DrawText("With Hotel\t"..self.property.hotel, "PlayerFont", 465, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			yPos = yPos + 30
		end
		if not self.property.cost_to_build == nil then
			draw.DrawText("Cost to Build\t"..self.property.cost_to_build, "PlayerFont", 465, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			yPos = yPos + 30
		end
		draw.DrawText("Mortage Value\t"..self.property.mortgage, "PlayerFont", 465, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		yPos = yPos + 30

		cam.End3D2D()



	end

end