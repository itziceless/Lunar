local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local delfile = delfile or function(file)
	writefile(file, '')
end

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/itziceless/Lunar/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

local function wipeFolder(path)
	if not isfolder(path) then return end
	for _, file in listfiles(path) do
		if file:find('loader') then continue end
		if isfile(file) and select(1, readfile(file):find('--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.')) == 1 then
			delfile(file)
		end
	end
end

for _, folder in {'newvape', 'newvape/games', 'newvape/profiles', 'newvape/assets', 'newvape/libraries', 'newvape/guis'} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

if not shared.VapeDeveloper then
	local _, subbed = pcall(function()
		return game:HttpGet('https://github.com/itziceless/Lunar')
	end)
	local commit = subbed:find('currentOid')
	commit = commit and subbed:sub(commit + 13, commit + 52) or nil
	commit = commit and #commit == 40 and commit or 'main'
	if commit == 'main' or (isfile('newvape/profiles/commit.txt') and readfile('newvape/profiles/commit.txt') or '') ~= commit then
		wipeFolder('newvape')
		wipeFolder('newvape/games')
		wipeFolder('newvape/guis')
		wipeFolder('newvape/libraries')
	end
	writefile('newvape/profiles/commit.txt', commit)
end

local users = {
	-- Iceless
	"IWatchNorthAzzJiggle", 
	"IAteSaviDaughterOut", 
	"IIIIlIIlIlIIlllllllI", 
	"IdkPochinnn", 
	"wedidmissionarypos",
	-- Zeref
	"ImNotZeref",
	"ClutchNorius",
	"InSandWeTrust",
	-- North
	"epixatures",
	"AmaelaePf",
	"IIQZero",
	"Eternaliza",
	"Arcadegofan",
	-- Zurkry
	"zurkry",
	"zurkryalt2",
	"XxdinostomperXx",
	-- Inquisitor
	"xInquisit0r", -- banned
	"roblox_user_70057463",
	"th_eoiscominginbed",
	-- Yard
	"anbuJBZ",
	"JacksonTheCube"
}

local ingame = game:GetService("Players").LocalPlayer.Name
local whitelisted = false

for _, v in pairs(users) do 
    if v == ingame then
        whitelisted = true
        break
    end
end

if whitelisted then
	return loadstring(downloadFile('newvape/main.lua'), 'main')()
	else
	game:GetService("Players").LocalPlayer:Kick('Not Whitelisted, please Whitelist in our discord server, https://discord.gg/ryDhGJkEyP (also in youre clipboard)')
	setclipboard("https://discord.gg/ryDhGJkEyP")
end
