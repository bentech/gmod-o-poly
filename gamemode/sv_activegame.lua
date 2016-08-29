ActiveGame = {}

function ActiveGame.New(name, host, players, board)
	local newGame = {}
	setmetatable(newGame,{__index = ActiveGame})
	newGame.name = name
	newGame.host = host
	newGame.players = players
	newGame.board = board
	newGame.stage = NOT_STARTED
	return newGame
end

function ActiveGame:ProcessStage()
	print(self.name)
	PrintTable(self)
end

function ActiveGame:GetStage()
	return self.stage
end