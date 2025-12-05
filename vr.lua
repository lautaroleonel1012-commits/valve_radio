local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local backpack = lp:WaitForChild("Backpack")


local tool = Instance.new("Tool")
tool.Name = "Valve radio"
tool.CanBeDropped = false


local handle = Instance.new("Part")
handle.Name = "Handle"
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
mesh.Scale = Vector3.new(0.01, 0.01, 0.01) -- << CORRECTO
mesh.Parent = handle


tool.GripPos = Vector3.new(0.6, -1, 0)
tool.GripUp = Vector3.new(0, 1, 0)
tool.GripRight = Vector3.new(0, 0, 0)
tool.GripForward = Vector3.new(0, 0, 0)

tool.Parent = backpack


local audioFiles = {
	"conga_sketch_167bpm_01-04.wav",
	"cossack_sandvich.wav",

	"Half-Life01.mp3","Half-Life02.mp3","Half-Life03.mp3","Half-Life05.mp3",
	"Half-Life06.mp3","Half-Life07.mp3","Half-Life08.mp3","Half-Life09.mp3",
	"Half-Life10.mp3","Half-Life11.mp3","Half-Life12.mp3","Half-Life13.mp3",
	"Half-Life14.mp3","Half-Life15.mp3","Half-Life16.mp3","Half-Life17.mp3",

	"hl2_song1.mp3","hl2_song3.mp3","hl2_song4.mp3","hl2_song7.mp3","hl2_song9.mp3",
	"hl2_song14.mp3","hl2_song15.mp3","hl2_song16.mp3","hl2_song17.mp3",
	"hl2_song18.mp3","hl2_song19.mp3","hl2_song20_submix0.mp3","hl2_song20_submix4.mp3",
	"hl2_song22.mp3","hl2_song23_suitsong3.mp3","hl2_song25_remix3.mp3",
	"hl2_song29.mp3","hl2_song31.mp3","hl2_song32.mp3",

	"looping_radio_mix.wav",
	"mannrobics.wav",
	"portal_4000_degrees_kelvin.mp3",
	"portal_still_alive.mp3",
	"portal_you_cant_escape_you_know.mp3",
	"portal_youre_not_a_good_person.mp3",

	"ravenholm_1.mp3"
}

local repoURL = "https://raw.githubusercontent.com/lautaroleonel1012-commits/valve_radio/main/"


for _, file in ipairs(audioFiles) do
	local url = repoURL .. file

	pcall(function()
		writefile("valve_radio_" .. file, game:HttpGet(url))
	end)
end


local sounds = {}
local currentSound = nil

for _, file in ipairs(audioFiles) do
	local sound = Instance.new("Sound")
	sound.SoundId = getcustomasset("valve_radio_" .. file)
	sound.Volume = 1
	sound.Parent = handle
	sound.Looped = false
	table.insert(sounds, sound)
end


local function playRandom()
	if currentSound then
		currentSound:Stop()
	end

	currentSound = sounds[math.random(1, #sounds)]
	currentSound:Play()
end

for _, s in ipairs(sounds) do
	s.Ended:Connect(playRandom)
end


tool.Equipped:Connect(function()
	playRandom()
end)

tool.Unequipped:Connect(function()
	if currentSound then
		currentSound:Stop()
	end
end)


UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if tool.Parent == lp.Character and input.KeyCode == Enum.KeyCode.R then
		playRandom()
	end
end)
