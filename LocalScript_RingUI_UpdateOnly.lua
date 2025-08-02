-- LocalScript - Versão Simplificada (Apenas Atualiza Atributo)
-- Colocar em StarterPlayerScripts ou dentro do ScreenGui Glider
-- Esta versão apenas atualiza o atributo string sem lógica adicional

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Aguardar o RemoteEvent
local ringUpdateEvent = ReplicatedStorage:WaitForChild("RingUpdate")

-- Conectar ao evento e atualizar apenas o atributo
ringUpdateEvent.OnClientEvent:Connect(function(ringNumber)
    local gliderGui = playerGui:FindFirstChild("Glider")
    if gliderGui then
        local frame = gliderGui:FindFirstChild("Frame")
        if frame then
            local viewport = frame:FindFirstChild("Viewport")
            if viewport then
                -- Criar o atributo se não existir
                viewport:SetAttribute("ring", tostring(ringNumber))
            end
        end
    end
end)

-- Inicializar com "0" (criar o atributo se não existir)
spawn(function()
    wait(1)
    local gliderGui = playerGui:FindFirstChild("Glider")
    if gliderGui then
        local frame = gliderGui:FindFirstChild("Frame")
        if frame then
            local viewport = frame:FindFirstChild("Viewport")
            if viewport then
                -- Criar o atributo ring se não existir
                viewport:SetAttribute("ring", "0")
            end
        end
    end
end)