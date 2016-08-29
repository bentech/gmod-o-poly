------------------------------------------------------------------
-- Game Manager
-- Type: Server Side
-- Author: Bentech
-- Description:
-- Manages the allocation of different games when started
------------------------------------------------------------------

local gamesTable = {} --Games

GameManager = {}
GameManager.games = {}

function GameManager:CreateGame(host, players, board)

	local game = ActiveGame.New("GAME"..RandomString(10), host, players, board)

	table.insert(self.games, game)

	return game

end

--One game at a time (Process in loops)
local lastProcessed = -1

function GameManager:ProcessGames()

	if(#self.games == 0)then
		return
	end

	if(lastProcessed >= #self.games)then
		lastProcessed = 1
	else
		lastProcessed = lastProcessed + 1
	end

	print(lastProcessed)

	local game = self.games[lastProcessed]

	if(game:GetStage() == Stage.COMPLETE)then
		table.RemoveByValue( self.games, item )
		return
	end

	game:ProcessStage()

end

hook.Add("Think", "MonoGameLogic", function() GameManager["ProcessGames"](GameManager) end)

function GameManager:IsStarted(game)
	return game:GetStage() >=0
end

function RandomString(length)
	length = length or 1
	if length < 1 then return nil end
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(48, 122))
	end
	return table.concat(array)
end