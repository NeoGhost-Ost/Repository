-- ServerScript - Colocar em ServerScriptService
-- Gerencia o jogo quando o RemoteEvent Game1Start for acionado

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Criar ou obter o RemoteEvent
local remoteEvent = ReplicatedStorage:FindFirstChild("Game1Start")
if not remoteEvent then
    remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "Game1Start"
    remoteEvent.Parent = ReplicatedStorage
end

-- Tabela para armazenar jogadores ativos
local activePlayers = {}

-- Função para clonar objetos para um jogador específico
local function cloneObjectsForPlayer(player)
    print("Clonando objetos para o jogador: " .. player.Name)
    
    -- Verificar se as pastas existem no ReplicatedStorage
    local game1Folder = ReplicatedStorage:FindFirstChild("Game1")
    if not game1Folder then
        warn("Pasta Game1 não encontrada no ReplicatedStorage!")
        return
    end
    
    local blowersFolder = game1Folder:FindFirstChild("Blowers")
    local ringsFolder = game1Folder:FindFirstChild("Rings")
    
    if not blowersFolder then
        warn("Pasta Blowers não encontrada em Game1!")
        return
    end
    
    if not ringsFolder then
        warn("Pasta Rings não encontrada em Game1!")
        return
    end
    
    local ring0 = ringsFolder:FindFirstChild("Ring 0")
    if not ring0 then
        warn("Ring 0 não encontrado na pasta Rings!")
        return
    end
    
    -- Clonar a pasta Blowers
    local clonedBlowers = blowersFolder:Clone()
    clonedBlowers.Name = "Blowers_" .. player.Name -- Nomear com o nome do jogador
    clonedBlowers.Parent = Workspace
    
    -- Clonar o Ring 0
    local clonedRing = ring0:Clone()
    clonedRing.Name = "Ring0_" .. player.Name -- Nomear com o nome do jogador
    clonedRing.Parent = Workspace
    
    -- Adicionar atributo ao script com o nome do jogador
    script:SetAttribute("Player", player.Name)
    
    -- Armazenar o jogador na tabela de jogadores ativos
    activePlayers[player.UserId] = {
        player = player,
        blowers = clonedBlowers,
        ring = clonedRing
    }
    
    print("Objetos clonados com sucesso para: " .. player.Name)
    print("Atributo 'Player' definido como: " .. player.Name)
end

-- Função para limpar objetos quando jogador sair
local function cleanupPlayerObjects(player)
    local playerData = activePlayers[player.UserId]
    if playerData then
        -- Remover objetos clonados
        if playerData.blowers and playerData.blowers.Parent then
            playerData.blowers:Destroy()
        end
        if playerData.ring and playerData.ring.Parent then
            playerData.ring:Destroy()
        end
        
        -- Remover da tabela
        activePlayers[player.UserId] = nil
        
        print("Objetos limpos para o jogador: " .. player.Name)
    end
end

-- Conectar o RemoteEvent
remoteEvent.OnServerEvent:Connect(function(player)
    print("RemoteEvent Game1Start acionado por: " .. player.Name)
    
    -- Verificar se o jogador já está ativo no jogo
    if activePlayers[player.UserId] then
        print("Jogador " .. player.Name .. " já está no jogo!")
        return
    end
    
    -- Clonar objetos para o jogador
    cloneObjectsForPlayer(player)
end)

-- Limpar objetos quando jogador sair do servidor
Players.PlayerRemoving:Connect(cleanupPlayerObjects)

print("Script Game1Manager carregado e pronto!")