concommand.Add("testStart", function(pl,cmd,args)

	if not pl:IsAdmin() then
		return
	end

	GameManager:CreateGame(pl, {pl}, Boards["GB"])




end)	