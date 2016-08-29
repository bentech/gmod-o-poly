ActiveGame = {}

function ActiveGame.New(name, host, players, board)
	local newGame = {}
	setmetatable(newGame,{__index = ActiveGame})
	newGame.name = name
	newGame.host = host
	--Convert players into currentplayers


	newGame.players = {}
	for _, v in pairs(players)
		local player = CurrentPlayer.New(pl)
		table.insert(newGame.players, player)
	end


	newGame.board = board
	newGame.stage = Stage.NOT_STARTED
	return newGame
end

function ActiveGame:GetStage()
	return self.stage
end

function ActiveGame:StartGame()

	self.stage = Stage.NOT_STARTED
	self.currentPlayer = nil
	self.first = true
	--Play some fancy music hehe
	for k,v in pairs(self.players)do
		v:SendLua( 'surface.PlaySound("music/HL2_song23_SuitSong3.mp3")' )
	end


	-- MOVE EVERYONE TO STARTING POSITIONS

	self.positions = {}

	for k,v in pairs(self.players)do
		self.positions[k] = 0
	end

	--red:SetPos(Vector(v:GetPos().x, v:GetPos().y + 70, v:GetPos().z + 15))
	--blue:SetPos(Vector(v:GetPos().x + 25, v:GetPos().y + 70, v:GetPos().z + 15))
	--green:SetPos(Vector(v:GetPos().x, v:GetPos().y + 95, v:GetPos().z + 15))
	--yellow:SetPos(Vector(v:GetPos().x + 25, v:GetPos().y + 95, v:GetPos().z + 15))
		
	-- SET EVERYONES CASH to 1500
	for _,pl in pairs(self.players)do
		pl:SetMoney(1500)
	end
	
end

function ActiveGame:printAll(message)
	for _,pl in pairs(self.players)do
		pl:ChatPrint(message)
	end
end

function ActiveGame:ProcessStage()
	if not self.stageBusy then
		self.stageBusy = true
		self:InternalNextStage()
	end
end

function ActiveGame:nextStage(stage)
	if stage then
		self.stage = stage
	else
		self.stage = self.stage + 1
	end
	self.stageBusy = false
end

function ActiveGame:nextPlayer()


end

function ActiveGame:InternalNextStage()
	print(Stage:toString(self.stage))
	

	if(self.stage > Stage.END_GAME)then
		return
	end

	if(self.stage == Stage.NOT_STARTED)then
		self:printAll("The Game is loading")
		self:nextStage(Stage.GAME_STARTING)
	elseif(self.stage == Stage.WAITING_FOR_PLAYERS)then
		self:printAll("A game is starting, please join")
		timer.Simple( 6, function()
			self:nextStage(Stage.GAME_STARTING)
		end)
	elseif(self.stage == Stage.GAME_STARTING)then
			
		--TODO: Check for players in area or ready

		self:printAll("The game is about to begin")
		self:StartGame()

		self:nextStage(Stage.PICK_RANDOM_START)

		
	elseif(self.stage == Stage.PICK_RANDOM_START)then
		self:printAll("The game has started, dices will roll to decide who goes first")
		
		self:nextStage(Stage.ROLL_DICE_TO_START)
	elseif(self.stage == Stage.ROLL_DICE_TO_START)then

		self.highestNumber = 0
		self.higestPlayer = false
		timer.Create( "pickaplayertostart", 0.55, table.Count(self.players) + 1, function()
			local pl = self:getnextPlayer()		
			if pl then

				if not self.startPlayer or self.startPlayer != pl then
					if not startPlayer then
						self.startPlayer = pl
					end
					math.randomseed( os.time() + math.random(-900,900) )
					local roll = math.random(4,256)
					if(self.highestNumber < roll)then
					   self.highestNumber = roll
					   self.higestPlayer = pl
					end
				
					self:printAll(pl:Nick().." rolled a "..math.Round(math.sqrt(roll)))
				else
					self:nextStage(Stage.PICK_HIGHEST)
					timer.Stop( "pickaplayertostart" )
				end
			end
			
		end )
		--randomplayer:ChatPrint("Roll the dice, Bitch..")
		--randomplayer:Roll()
	elseif(self.stage == Stage.PICK_HIGHEST)then
		self.currentPlayer = self.higestPlayer
		self:printAll(self.higestPlayer:Nick() .. " rolled the higest number and now can start first!")
		self:nextStage()
		
	elseif(self.stage == Stage.ROLL_DICE)then
		local pl = false
		if(first == true)then
			pl = self.currentPlayer
			first = false
		else
			pl = self:getnextPlayer()
			self:printAll("It is " .. pl:Nick() .. " turn!")
		end

		self.currentPlayer = pl

		pl:ConCommand( "roll_dice_menu")
		--net.Start( "roll_dice_menu" )
		--	net.WriteBit( true )
		--net.Send(pl)
		timer.Create("rolltimer", 7, 1, function()
			if(self.stage == Stage.ROLL_DICE)then
				self:printAll(self:currentPlayer:Nick() .. " has rolled automatically, hurry up next time!")
				self:nextStage()
			end
		end)
	elseif(self.stage == Stage.DICE_LAND)then
		self:printAll("roll " .. self:currentPlayer:Nick() .. " roll!")
		timer.Destroy("rolltimer")
		self.currentPlayer:ConCommand( "close_menus")
		self.currentPlayer:Roll()
	elseif(self.stage == Stage.LAND_BOARD)then
		
		--TODO: What did we land on
		self:nextStage()

	elseif(self.stage == Stage.GOTO_JAIL)then
		self.currentPlayer:GoToJail() 
		self:printAll(currentPlayer:Nick() .. " has been sent to jail!")
		timer.Simple( 3, function()
			self:nextPlayer()
		end)

		
	elseif(self.stage == Stage.BUY_YES_NO)then
		self:printAll(currentPlayer:Nick() .. " can choose to buy!")
		self.currentPlayer:ConCommand( "buy_property_menu "..currentPlayer:GetPosition(currentPlayer:Team()))
		timer.Create("propertypass", 20, 1, function()
			if(self.stage == BUY_YES_NO)then
				self:nextStage(END_TURN)
			end
		end)
	elseif(self.stage == Stage.AUCTION)then
	
		self:printAll(currentPlayer:Nick() .. " is actioning!")
		self.stage = MANAGE_PROPERTY_STAGE
		self:processStage()
	elseif(self.stage == Stage.TRADE)then
	
		self:printAll(currentPlayer:Nick() .. " can trade!")
		self.stage = MANAGE_PROPERTY_STAGE
		self:processStage()
	elseif(self.stage == Stage.CHECK_DOUBLE)then

		self:printAll(currentPlayer:Nick() .. " has doubles!")
		self.stage = MANAGE_PROPERTY_STAGE
		self:processStage()
	elseif(self.stage == Stage.MANAGE_PROPERTY_STAGE)then
	
		self:printAll(currentPlayer:Nick() .. " is managing!")
		self.stage = END_TURN
		self:processStage()
	elseif(self.stage == Stage.END_TURN)then
		--CHECK GAME END

		timer.Destroy("propertypass")
		self.stage = ROLL_DICE--auto next player
		self:processStage()
	end

end

function ActiveGame:getnextPlayer()
	if not game.SinglePlayer() and table.Count(self.players) <= 1 then
		self:printAll("Error only 1 player cant find next player!")
		return false
	end

	if not self.currentPlayer then
		local plstart = math.random(1,table.maxn(self.players))
		local i = 1
		for _, pl in pairs(self.players)do
			if(i == plstart)then
				self.currentPlayer = pl
				return self.currentPlayer
			end
			i=i+1
		end
	end
			
	local found = false
	for _, pl in pairs(self.players)do
		if(found)then
			self.currentPlayer = pl
			return pl
		end
		if(self.currentPlayer == pl)then
			found = true
		end
	end
	print(" FOUND 2")

	return table.GetFirstValue(self.players)
	--return table.GetFirstKey(self.players)
	
end


util.AddNetworkString( "roll_dice_menu" )