local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local backpack = lp:WaitForChild("Backpack")

-- TOOL
local tool = Instance.new("Tool")
tool.Name = "Valve radio"
tool.CanBeDropped = false

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(0.01, 0.01, 0.01)
handle.Anchored = false
handle.CanCollide = false
handle.Parent = tool

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://2255562649"
mesh.TextureId = "rbxassetid://2255562684"
mesh.Scale = Vector3.new(0.01, 0.01, 0.01)
mesh.Parent = handle

tool.Grip = CFrame.new(1.3, -0.15, 0) * CFrame.Angles(0, math.rad(90), 0)

tool.Parent = backpack

-------------------------------------------------

local audioFiles = {
	"conga_sketch_167bpm_01-04.wav",
	"cossack_sandvich.wav",

	"Half-Life01.mp3","Half-Life02.mp3","Half-Life03.mp3","Half-Life05.mp3",
	"Half-Life06.mp3","Half-Life07.mp3","Half-Life08.mp3","Half-Life09.mp3",
	"Half-Life10.mp3","Half-Life11.mp3","Half-Life12.mp3","Half-Life13.mp3",
	"Half-Life14.mp3","Half-Life15.mp3","Half-Life16.mp3","Half-Life17.mp3",

	"hl2_song1.mp3","hl2_song3.mp3","hl2_song4.mp3","hl2_song7.mp3",
	"hl2_song14.mp3","hl2_song15.mp3","hl2_song16.mp3","hl2_song17.mp3",
	"hl2_song19.mp3","hl2_song20_submix0.mp3","hl2_song20_submix4.mp3",
	"hl2_song23_suitsong3.mp3","hl2_song29.mp3","hl2_song31.mp3","hl2_song32.mp3",

	"looping_radio_mix.wav","mannrobics.wav",
	"portal_4000_degrees_kelvin.mp3","portal_still_alive.mp3",
	"portal_you_cant_escape_you_know.mp3","portal_youre_not_a_good_person.mp3",

	"ravenholm_1.mp3"
}

local repoURL = "https://raw.githubusercontent.com/lautaroleonel1012-commits/valve_radio/main/"
local prefix = "valve_radio_"

-------------------------------------------------

local function ensureFile(file)
	local path = prefix .. file
	if not isfile(path) then
		writefile(path, game:HttpGet(repoURL .. file))
	end
	return getcustomasset(path)
end

-------------------------------------------------

local sound = Instance.new("Sound")
sound.Volume = 1
sound.Parent = handle

local currentFile = nil

local function playRandom()
	local file = audioFiles[math.random(#audioFiles)]
	currentFile = file

	sound:Stop()
	sound.SoundId = ensureFile(file)
	sound:Play()
end

sound.Ended:Connect(playRandom)

-------------------------------------------------
-- BACKGROUND DOWNLOAD
task.spawn(function()
	for _, file in ipairs(audioFiles) do
		ensureFile(file)
		task.wait(0.05)
	end
end)

-------------------------------------------------

tool.Equipped:Connect(function()
	playRandom()
end)

tool.Unequipped:Connect(function()
	sound:Stop()
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if tool.Parent == lp.Character and input.KeyCode == Enum.KeyCode.R then
		playRandom()
	end
end)























