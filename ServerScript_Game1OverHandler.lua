-- ServerScript - Colocar em ServerScriptService
-- Gerencia o evento Game1Over quando jogador completa todos os rings

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Aguardar o RemoteEvent Game1Over
local game1OverEvent = ReplicatedStorage:WaitForChild("Game1Over")

-- Tabela para armazenar jogadores que completaram o jogo
local completedPlayers = {}

-- Função para limpar objetos do jogador no workspace
local function cleanupPlayerObjects(player)
    print("Limpando objetos do jogador " .. player.Name .. " após completar o jogo...")
    
    -- Limpar Blowers do jogador
    local blowers = Workspace:FindFirstChild("Blowers_" .. player.Name)
    if blowers then
        blowers:Destroy()
        print("Blowers removidos para " .. player.Name)
    end
    
    -- Limpar qualquer ring restante do jogador
    for i = 0, 23 do
        local ring = Workspace:FindFirstChild("Ring" .. i .. "_" .. player.Name)
        if ring then
            ring:Destroy()
            print("Ring " .. i .. " removido para " .. player.Name)
        end
    end
end

-- Função para executar ações quando o jogo termina
local function onGame1Over(player)
    print("🎉 GAME1 OVER! Jogador " .. player.Name .. " completou todos os 23 rings!")
    
    -- Marcar jogador como completado
    completedPlayers[player.UserId] = true
    
    -- Limpar objetos do workspace
    cleanupPlayerObjects(player)
    
    -- Aqui você pode adicionar mais lógicas para quando o jogo termina:
    -- - Dar recompensas ao jogador
    -- - Mostrar tela de vitória
    -- - Salvar estatísticas
    -- - Teleportar jogador para área de lobby
    -- - Etc.
    
    -- Exemplo: Dar pontos ao jogador (se você tiver um sistema de pontos)
    -- local leaderstats = player:FindFirstChild("leaderstats")
    -- if leaderstats then
    --     local points = leaderstats:FindFirstChild("Points")
    --     if points then
    --         points.Value = points.Value + 1000 -- Dar 1000 pontos por completar
    --     end
    -- end
    
    print("Processamento de Game1Over concluído para " .. player.Name)
end

-- Conectar ao evento Game1Over
game1OverEvent.OnServerEvent:Connect(function(player)
    -- Verificar se o jogador já completou (evitar duplicatas)
    if completedPlayers[player.UserId] then
        print("Jogador " .. player.Name .. " já completou o jogo anteriormente.")
        return
    end
    
    onGame1Over(player)
end)

-- Limpar dados quando jogador sair
Players.PlayerRemoving:Connect(function(player)
    completedPlayers[player.UserId] = nil
    print("Dados de Game1Over limpos para " .. player.Name)
end)

print("Game1OverHandler carregado e pronto!")