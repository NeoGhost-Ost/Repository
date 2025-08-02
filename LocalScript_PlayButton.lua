-- LocalScript - Colocar dentro do ImageButton Play
-- Caminho: StarterGui > Minigames > Frame > Glider > Play (ImageButton)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local button = script.Parent -- O ImageButton Play

-- Criar ou obter o RemoteEvent
local remoteEvent = ReplicatedStorage:FindFirstChild("Game1Start")
if not remoteEvent then
    remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "Game1Start"
    remoteEvent.Parent = ReplicatedStorage
end

-- Função para quando o botão for clicado
local function onButtonClicked()
    print("Botão Play clicado por: " .. player.Name)
    remoteEvent:FireServer() -- Dispara o evento para o servidor
end

-- Conectar o clique do botão
button.MouseButton1Click:Connect(onButtonClicked)