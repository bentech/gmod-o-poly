surface.CreateFont( "HostFont", 
                    {
                    font    = "coolvetica",
                    size    = 40,
                    weight  = 700,
                    antialias = true,
                    shadow = true
            })

surface.CreateFont( "SmallFont", 
                    {
                    font    = "coolvetica",
                    size    = 29,
                    weight  = 700,
                    antialias = true,
                    shadow = true
            })
surface.CreateFont( "SmallestFont", 
                    {
                    font    = "coolvetica",
                    size    = 23,
                    weight  = 700,
                    antialias = true,
                    shadow = true
            })
			
surface.CreateFont( "PlayerFont", 
                    {
                    font    = "coolvetica",
                    size    = 20,
                    weight  = 500,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "PlayerFontStrong", 
                    {
                    font    = "coolvetica",
                    size    = 20,
                    weight  = 800,
                    antialias = true,
                    shadow = false
            })

function renderProperty(property)


			local cardW = 250
			local cardH = 330

			--Main layer
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawRect(0, 0, cardW, cardH)

			--outline	
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawOutlinedRect(2, 2, cardW-4, cardH-4)

			if property == nil then
				return
			end
			--title backgroud border
			surface.DrawRect(10, 10, cardW - 20, 60)
			--title background color
			if property.colour then
				surface.SetDrawColor(property.colour)
				surface.DrawRect(15,15, cardW - 30, 50)
			end
				
			--Text		
			local yPos = 15

			draw.DrawText("Title Deeds", "PlayerFont", cardW / 2, yPos, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			yPos = yPos + 10

			local size = surface.GetTextSize( property.PrintName)
			if size > 140 then
			draw.DrawText(property.PrintName, "SmallestFont", cardW / 2, yPos+10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			elseif size > 100 then
			draw.DrawText(property.PrintName, "SmallFont", cardW / 2, yPos+7, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
			draw.DrawText(property.PrintName, "HostFont", cardW / 2, yPos, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			yPos = yPos + 50

			if property.rent then
				draw.DrawText("Rent M"..property.rent, "PlayerFont", cardW / 2, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				yPos = yPos + 20
			end

			--Space for below rent
			yPos = yPos + 10

			local xPos = 15
			local costPos = 220


			surface.SetFont( "PlayerFont" )
			surface.SetTextColor( 0, 0, 0, 255 )

			if property.houses then
				for h,amount in pairs(property.houses) do

					surface.SetTextPos( xPos, yPos )
					surface.DrawText("With "..h.." House" )

					surface.SetTextPos( costPos- surface.GetTextSize( amount ), yPos )
					surface.DrawText("M " .. amount)
					yPos = yPos + 20
				end
			end
			if property.hotel then
				surface.SetTextPos( xPos, yPos )
				surface.DrawText("With Hotel")
				surface.SetTextPos( costPos- surface.GetTextSize( property.hotel ), yPos )
				surface.DrawText("M " .. property.hotel)
				yPos = yPos + 20
			end
			--Section space
			yPos = yPos + 10

			if property.mortgage then
				draw.DrawText("Mortage Value  M"..property.mortgage, "PlayerFontStrong", cardW / 2, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				yPos = yPos + 25
			end
			surface.SetFont( "PlayerFont" )
			surface.SetTextColor( 0, 0, 0, 255 )


			if property.cost_to_build then			
				draw.DrawText("Houses Cost  M"..property.cost_to_build, "PlayerFont", cardW / 2, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				yPos = yPos + 20	
				draw.DrawText("Hotels M"..property.cost_to_build.. " each", "PlayerFont", cardW / 2, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				yPos = yPos + 20
				draw.DrawText("plus 4 houses", "PlayerFont", cardW / 2, yPos, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				yPos = yPos + 20
			end


end
