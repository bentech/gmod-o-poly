 
function RollTheDice( ply )
	if(currentPlayer == ply)then
		if(GAMEMODE.STAGE == ROLL_DICE)then
			sendGameMessage(currentPlayer:Nick() .. " has rolled the dice")
			nextStage()
		end
	end
end
concommand.Add( "roll", RollTheDice )

function BuyProperty( ply )
	if(currentPlayer == ply)then
		if(GAMEMODE.STAGE == BUY_YES_NO)then
			ply:BuyProperty()
		end
	end
end
concommand.Add( "buy", BuyProperty )

function Auction( ply )
	ply:Auction()
end
concommand.Add( "auction", Auction )

function EndTurn( ply )
	ply:EndTurn()
end
concommand.Add( "end_turn", EndTurn )
