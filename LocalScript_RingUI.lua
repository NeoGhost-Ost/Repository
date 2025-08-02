-- LocalScript - Colocar em StarterPlayerScripts ou dentro do ScreenGui Glider
-- Atualiza a UI quando o jogador passa pelos rings

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Aguardar o PlayerGui carregar
local playerGui = player:WaitForChild("PlayerGui")

-- Função para encontrar o viewport
local function findViewport()
    local gliderGui = playerGui:FindFirstChild("Glider")
    if not gliderGui then
        warn("ScreenGui 'Glider' não encontrado!")
        return nil
    end
    
    local frame = gliderGui:FindFirstChild("Frame")
    if not frame then
        warn("Frame não encontrado dentro de Glider!")
        return nil
    end
    
    local viewport = frame:FindFirstChild("Viewport")
    if not viewport then
        warn("Viewport não encontrado dentro de Frame!")
        return nil
    end
    
    return viewport
end

-- Função para criar ou atualizar o atributo ring
local function updateRingAttribute(ringNumber)
    local viewport = findViewport()
    if viewport then
        viewport:SetAttribute("ring", tostring(ringNumber))
        print("Atributo 'ring' atualizado para: " .. ringNumber)
    end
end

-- Aguardar o RemoteEvent
local ringUpdateEvent = ReplicatedStorage:WaitForChild("RingUpdate")

-- Conectar ao evento de atualização de ring
ringUpdateEvent.OnClientEvent:Connect(function(ringNumber)
    print("Recebida atualização de ring: " .. ringNumber)
    updateRingAttribute(ringNumber)
end)

-- Inicializar com ring 0 quando o script carregar
wait(1) -- Pequeno delay para garantir que a UI está carregada
updateRingAttribute(0)

print("RingUI LocalScript carregado e pronto!")