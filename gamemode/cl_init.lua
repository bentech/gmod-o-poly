include ("shared.lua")
include ("money.lua")
include ("cl_hud.lua")
include ("cl_nametags.lua")
include ("cl_scoreboard.lua")
include ("sh_boards.lua")
include ("sh_board_gb.lua")
include ("cl_propertycard.lua")
include ("cl_properties.lua")
include ("cl_menus.lua")


function GM:OnSpawnMenuOpen(ply)
	LocalPlayer():ConCommand("CardList")
end

 