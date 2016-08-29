
local openMenu = nil

concommand.Add("buy_property_menu", function(pl,cmd,args)

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

	local board = args[1]
	local item = tonumber(args[2])

	local property_item = Boards[board].properties[item]

	local CardFrame = vgui.Create( "DFrame" )
	openMenu = CardFrame
	CardFrame:SetPos( ScrW() / 2 - 250, ScrH() / 2 - 200)
	CardFrame:SetSize(500,450)
	CardFrame:SetTitle( "FOR SALE!" )
	CardFrame:SetVisible( true )
	CardFrame:SetDraggable( false )
	CardFrame:ShowCloseButton( false )
	CardFrame:MakePopup()
	function CardFrame:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function CardFrame:OnClose()
		openMenu = nil
	end

	local BackPanel = vgui.Create( "DPanel", CardFrame )
	BackPanel:SetPos( 130, 10 )
	BackPanel:SetSize( 250, 330 )
	BackPanel.Paint = function()
		renderProperty(property_item)
	end

	local DButton = vgui.Create( "DButton", CardFrame)
 	DButton:SetPos( 10, 380 )
 	DButton:SetText( "Pass" )
 	DButton:SetSize( 120, 60 )
 	DButton.DoClick = function()
    	LocalPlayer():ConCommand("pass")
    	CardFrame:Close()
 	end

 	local DButton2 = vgui.Create( "DButton", CardFrame )
 	DButton2:SetPos( 130, 380 )
 	DButton2:SetText( "Manage" )
 	DButton2:SetSize( 120, 60 )
 	DButton2.DoClick = function()
    	print( "Manage was clicked" )
    	CardFrame:Close()
 	end

 	local DButton3 = vgui.Create( "DButton", CardFrame )
 	DButton3:SetPos( 250, 380 )
 	DButton3:SetText( "Trade" )
 	DButton3:SetSize( 120, 60 )
 	DButton3.DoClick = function()
    	print( "Trade was clicked" )
    	CardFrame:Close()
 	end

 	local DButton4 = vgui.Create( "DButton", CardFrame )
 	DButton4:SetPos( 370, 380 )
 	DButton4:SetText( "Buy" )
 	DButton4:SetSize( 120, 60 )
 	DButton4.DoClick = function()
	RunConsoleCommand( "buy" )
    	CardFrame:Close()
 	end
end)

concommand.Add("`", function(pl,cmd,args)

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

	local board = args[1]
	local item = tonumber(args[2])

	local property_item = Boards[board].properties[item]

	local CardFrame = vgui.Create( "DFrame" )
	CardFrame:SetPos( ScrW() / 2 - 250, ScrH() / 2 - 200)
	CardFrame:SetSize(500,450)
	CardFrame:SetTitle( "Manage " .. property_item.PrintName )
	CardFrame:SetVisible( true )
	CardFrame:SetDraggable( false )
	CardFrame:ShowCloseButton( true )

	openMenu = CardFrame
	CardFrame:MakePopup()
	function CardFrame:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function CardFrame:OnClose()
		openMenu = nil
	end


	local DButton = vgui.Create( "DButton", CardFrame)
     	DButton:SetPos( 10, 100 )
     	DButton:SetText( "Buy House(+1)" )
     	DButton:SetSize( 120, 60 )
     	DButton.DoClick = function()
        	LocalPlayer():ConCommand("buy_house")
     	end

     	local DButton2 = vgui.Create( "DButton", CardFrame )
     	DButton2:SetPos( 10, 180 )
     	DButton2:SetText( "Sell House(-1)" )
     	DButton2:SetSize( 120, 60 )
     	DButton2.DoClick = function()
        	LocalPlayer():ConCommand("sell_house")
     	end

     	local DButton2 = vgui.Create( "DButton", CardFrame )
     	DButton2:SetPos( 10, 260 )
     	DButton2:SetText( "Mortgage" )
     	DButton2:SetSize( 120, 60 )
     	DButton2.DoClick = function()
        	LocalPlayer():ConCommand("mortgage")
     	end

     	local DButton2 = vgui.Create( "DButton", CardFrame )
     	DButton2:SetPos( 10, 340 )
     	DButton2:SetText( "Un-Mortgage" )
     	DButton2:SetSize( 120, 60 )
     	DButton2.DoClick = function()
        	LocalPlayer():ConCommand("unmortgage")
     	end

		local BackPanel = vgui.Create( "DPanel", CardFrame )
		BackPanel:SetPos( 150, 70 )
		BackPanel:SetSize( 250, 330 )
		BackPanel.Paint = function()
			renderProperty(property_item)
		end

end)

concommand.Add("CardList", function()

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

	--[[for i = -1,39 do 	
		if LocalPlayer():Nick() == property[i].Owner then
			local test = property[i].name
		end
	end
	]]--
	
	local CardFrame = vgui.Create( "DFrame" )
	CardFrame:SetPos( ScrW() / 2 - 250, ScrH() / 2 - 200)
	CardFrame:SetSize(500,450)
	CardFrame:SetTitle( LocalPlayer():Nick() .. "'s Cards" )
	CardFrame:SetVisible( true )
	CardFrame:SetDraggable( false )
	CardFrame:ShowCloseButton( true )
	openMenu = CardFrame
	CardFrame:MakePopup()
	function CardFrame:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function CardFrame:OnClose()
		openMenu = nil
	end

	local CardPanel = vgui.Create( "DPanel", CardFrame)
	CardPanel:SetPos( 25, 50 )
	CardPanel:SetSize( 250, 250 )

	local myLabel = vgui.Create("DLabel", CardPanel)
	myLabel:SetPos(1,1)
	myLabel:SetColor(Color(0,0,0,255))
	myLabel:SetFont("default")
	myLabel:SetText("I Love Gmod")
	myLabel:SizeToContents()
	
end)



--Team selection Menu
concommand.Add("team_menu", function()
 
	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

	local TeamMenu = vgui.Create( "DFrame" )
	TeamMenu:SetPos( ScrW() +125, ScrH() / 2 -125 )
	TeamMenu:SetSize( 260, 210 )
	TeamMenu:SetTitle( "Team selection menu" )
	TeamMenu:ShowCloseButton( true )
	TeamMenu:SetVisible( true )
	TeamMenu:SetDraggable( false )
	openMenu = TeamMenu
	TeamMenu:MakePopup( )
	function TeamMenu:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function TeamMenu:OnClose()
		openMenu = nil
	end


	if !TeamMenu.Open then
		TeamMenu:MoveTo(ScrW() / 2 - 125,  ScrH() / 2 - 125, 0.5, 0,1)
	end
 
	-- Team 1
	local team_1 = vgui.Create( "DButton", TeamMenu )
	team_1:SetPos( 5, 30 )
	team_1:SetSize( 250, 30 )
	team_1:SetText( "Team 1" )
	team_1:SetColor(Color(255,255,255,255))
	team_1.Paint = function()
   		surface.SetDrawColor( 255, 0, 0, 255 )
    		surface.DrawRect( 0, 0, team_1:GetWide(), team_1:GetTall() )
	end
	team_1.DoClick = function()
		RunConsoleCommand( "TEAM_1" )
		TeamMenu:Close()
	end
 
	local team_2 = vgui.Create( "DButton", TeamMenu )
	team_2:SetPos( 5, 70 )
	team_2:SetSize( 250, 30 )
	team_2:SetText( "Team 2" )
	team_2:SetColor(Color(255,255,255,255))
	team_2.Paint = function()
		surface.SetDrawColor( 0, 0, 255, 255 )
		surface.DrawRect( 0, 0, team_2:GetWide(), team_2:GetTall() )
	end
	team_2.DoClick = function()
		RunConsoleCommand( "TEAM_2" )
		TeamMenu:Close()
	end
 
	local team_3 = vgui.Create( "DButton", TeamMenu )
	team_3:SetPos( 5, 110 )
	team_3:SetSize( 250, 30 )
	team_3:SetText( "Team 3" )
	team_3:SetColor(Color(0,0,0,255))
	team_3.Paint = function()
		surface.SetDrawColor( 0, 255, 0, 255 )
		surface.DrawRect( 0, 0, team_3:GetWide(), team_3:GetTall() )
	end
	team_3.DoClick = function()
		RunConsoleCommand( "TEAM_3" )
		TeamMenu:Close()
	end
 
	local team_4 = vgui.Create( "DButton", TeamMenu )
	team_4:SetPos( 5, 150 )
	team_4:SetSize( 250, 30 )
	team_4:SetText( "Team 4" )
	team_4:SetColor(Color(0,0,0,255))
	team_4.Paint = function()
		surface.SetDrawColor( 255, 255, 0, 255 )
		surface.DrawRect( 0, 0, team_3:GetWide(), team_3:GetTall() )
	end
	team_4.DoClick = function() --Make the player join team 4
		RunConsoleCommand( "TEAM_4" )
		TeamMenu:Close()
	end
 
	local spectate_button = vgui.Create( "DButton", TeamMenu )
	spectate_button:SetPos( 5, 185 )
	spectate_button:SetSize( 250, 20 )
	spectate_button:SetText( "Spectate" )
	spectate_button:SetColor(Color(255,255,255,255))
	spectate_button.Paint = function()
    		draw.RoundedBox( 8, 0, 0, spectate_button:GetWide(), spectate_button:GetTall(), Color( 0,0,0,225 ) )
    		surface.DrawRect( 0, 0, spectate_button:GetWide(), spectate_button:GetTall() )
	end
	spectate_button.DoClick = function()
		RunConsoleCommand( "leave_team" )
    		TeamMenu:Close()
	end
 
 end)

concommand.Add("roll_dice_menu", function(pl,cmd,args)

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end
	local RollthedicePanel = vgui.Create( "DFrame" )
	RollthedicePanel:SetPos( ScrW() / 2 - 90, ScrH() / 2 - 37.5)
	RollthedicePanel:SetSize( 175, 75 )
	RollthedicePanel:SetVisible( true )
	RollthedicePanel:SetTitle("")
	RollthedicePanel:SetDraggable( false )
	RollthedicePanel:ShowCloseButton( false )
	RollthedicePanel:MakePopup()
	function RollthedicePanel:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function RollthedicePanel:OnClose()
		openMenu = nil
	end
	 
	local DermaButton = vgui.Create( "DButton", RollthedicePanel)

	DermaButton:SetText( "Roll the dice" )
	DermaButton:SetPos( 12.5, 12.5)
	DermaButton:SetSize( 150, 50 )
	DermaButton.DoClick = function ()
	    RunConsoleCommand( "roll" ) -- What happens when you press the button
	    RollthedicePanel:Close()
	end

end)

concommand.Add("control_menu", function()

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

	local controlMenu = vgui.Create( "DFrame" )
	controlMenu:SetPos( ScrW() +125, ScrH() / 2 -125 )
	controlMenu:SetSize( 260, 210 )
	controlMenu:SetTitle( "What would you like to do?" )
	controlMenu:ShowCloseButton( true )
	controlMenu:SetVisible( true )
	controlMenu:SetDraggable( false )
	openMenu = controlMenu
	controlMenu:MakePopup( )
	function controlMenu:Paint()
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
	end
	function controlMenu:OnClose()
		openMenu = nil
	end

	if !controlMenu.Open then
		controlMenu:MoveTo(ScrW() / 2 - 125,  ScrH() / 2 - 125, 0.5, 0,1) 
	end
 
	-- Roll the dice time.
	local roll = vgui.Create( "DButton", controlMenu )
	roll:SetPos( 5, 30 )
	roll:SetSize( 250, 30 )
	roll:SetText( "Roll the dice" )
	roll:SetColor(Color(255,255,255,255))
	roll.Paint = function()
    		surface.SetDrawColor( 139, 137, 137, 255 )
    		surface.DrawRect( 0, 0, roll:GetWide(), roll:GetTall() )
	end
	roll.DoClick = function()
		RunConsoleCommand( "roll" )
		controlMenu:Close() 
	end

	-- Buy Property.
	local buy = vgui.Create( "DButton", controlMenu )
	buy:SetPos( 5, 65 )
	buy:SetSize( 250, 30 )
	buy:SetText( "Buy Property" )
	buy:SetColor(Color(255,255,255,255))
	buy.Paint = function()
    		surface.SetDrawColor( 139, 137, 137, 255 )
    		surface.DrawRect( 0, 0, buy:GetWide(), buy:GetTall() )
	end
	buy.DoClick = function()
		RunConsoleCommand( "buy" )
		controlMenu:Close()
	end

	--Auction
	local auction = vgui.Create( "DButton", controlMenu )
	auction:SetPos( 5, 100 )
	auction:SetSize( 250, 30 )
	auction:SetText( "Auction" )
	auction:SetColor(Color(255,255,255,255))
	auction.Paint = function()
    		surface.SetDrawColor( 139, 137, 137, 255 )
    		surface.DrawRect( 0, 0, auction:GetWide(), auction:GetTall() )
	end
	auction.DoClick = function()
		RunConsoleCommand( "auction" )
		controlMenu:Close()
	end

	--End Turn
	local end_turn = vgui.Create( "DButton", controlMenu )
	end_turn:SetPos( 5, 135 )
	end_turn:SetSize( 250, 30 )
	end_turn:SetText( "End Turn" )
	end_turn:SetColor(Color(255,255,255,255))
	end_turn.Paint = function()
    		surface.SetDrawColor( 139, 137, 137, 255 )
    		surface.DrawRect( 0, 0, end_turn:GetWide(), end_turn:GetTall() )
	end
	end_turn.DoClick = function()
		RunConsoleCommand( "end_turn" )
		controlMenu:Close()
	end
 
end)


concommand.Add("close_menus", function()

	if openMenu then
		local x = openMenu
		openMenu = nil
		x:Close()
	end

end)