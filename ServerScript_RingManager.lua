-- ServerScript - Colocar em ServerScriptService
-- Gerencia a colisão com os anéis e progressão do jogo

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- RemoteEvent para comunicar com o cliente sobre mudanças de ring
local ringUpdateEvent = ReplicatedStorage:FindFirstChild("RingUpdate")
if not ringUpdateEvent then
    ringUpdateEvent = Instance.new("RemoteEvent")
    ringUpdateEvent.Name = "RingUpdate"
    ringUpdateEvent.Parent = ReplicatedStorage
end

-- RemoteEvent para Game1Over
local game1OverEvent = ReplicatedStorage:FindFirstChild("Game1Over")
if not game1OverEvent then
    game1OverEvent = Instance.new("RemoteEvent")
    game1OverEvent.Name = "Game1Over"
    game1OverEvent.Parent = ReplicatedStorage
end

-- Tabela para rastrear o progresso de cada jogador
local playerRingProgress = {}

-- Função para encontrar todas as partes de um modelo recursivamente
local function getAllPartsInModel(model)
    local parts = {}
    
    local function searchParts(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("BasePart") then
                table.insert(parts, child)
            elseif child:IsA("Model") or child:IsA("Folder") then
                searchParts(child)
            end
        end
    end
    
    searchParts(model)
    return parts
end

-- Função para configurar detecção de toque em um ring
local function setupRingTouchDetection(ring, player, currentRingNumber)
    local parts = getAllPartsInModel(ring)
    
    for _, part in pairs(parts) do
        local connection
        connection = part.Touched:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local hitPlayer = Players:GetPlayerFromCharacter(hit.Parent)
                if hitPlayer == player then
                    print("Jogador " .. player.Name .. " tocou no Ring " .. currentRingNumber)
                    
                    -- Tocar o som
                    local ringSound = SoundService:FindFirstChild("RingSound")
                    if ringSound then
                        ringSound:Play()
                    else
                        warn("Som RingSound não encontrado no SoundService!")
                    end
                    
                    -- Desconectar todas as conexões deste ring
                    connection:Disconnect()
                    
                    -- Deletar o ring atual
                    ring:Destroy()
                    
                    -- Verificar se é o Ring 23 (último ring)
                    if currentRingNumber == 23 then
                        print("Jogador " .. player.Name .. " completou todos os rings! Acionando Game1Over...")
                        game1OverEvent:FireServer(player)
                        -- Limpar dados do jogador
                        playerRingProgress[player.UserId] = nil
                        return
                    end
                    
                    -- Atualizar progresso do jogador
                    local nextRingNumber = currentRingNumber + 1
                    playerRingProgress[player.UserId] = nextRingNumber
                    
                    -- Enviar atualização para o cliente (próximo número)
                    ringUpdateEvent:FireClient(player, nextRingNumber)
                    
                    -- Tentar clonar o próximo ring
                    cloneNextRing(player, nextRingNumber)
                    
                    break -- Sair do loop após o primeiro toque
                end
            end
        end)
    end
end

-- Função para clonar o próximo ring
function cloneNextRing(player, ringNumber)
    local game1Folder = ReplicatedStorage:FindFirstChild("Game1")
    if not game1Folder then
        warn("Pasta Game1 não encontrada no ReplicatedStorage!")
        return
    end
    
    local ringsFolder = game1Folder:FindFirstChild("Rings")
    if not ringsFolder then
        warn("Pasta Rings não encontrada em Game1!")
        return
    end
    
    -- Verificar se ainda há rings para clonar (até Ring 23)
    if ringNumber <= 23 then
        local nextRing = ringsFolder:FindFirstChild("Ring " .. ringNumber)
        if nextRing then
            -- Clonar o próximo ring
            local clonedRing = nextRing:Clone()
            clonedRing.Name = "Ring" .. ringNumber .. "_" .. player.Name
            clonedRing.Parent = Workspace
            
            -- Configurar detecção de toque no novo ring
            setupRingTouchDetection(clonedRing, player, ringNumber)
            
            print("Ring " .. ringNumber .. " clonado para " .. player.Name)
        else
            warn("Ring " .. ringNumber .. " não encontrado na pasta Rings!")
        end
    else
        print("Limite de rings atingido para " .. player.Name)
    end
end

-- Função para inicializar um jogador no sistema de rings
local function initializePlayerRings(player)
    -- Procurar pelo Ring0 do jogador no workspace
    local ring0 = Workspace:FindFirstChild("Ring0_" .. player.Name)
    if ring0 then
        playerRingProgress[player.UserId] = 0
        setupRingTouchDetection(ring0, player, 0)
        print("Sistema de rings inicializado para " .. player.Name)
    else
        -- Tentar novamente após um pequeno delay
        wait(1)
        initializePlayerRings(player)
    end
end

-- Monitorar quando novos rings são adicionados ao workspace
Workspace.ChildAdded:Connect(function(child)
    if string.match(child.Name, "Ring0_") then
        local playerName = string.gsub(child.Name, "Ring0_", "")
        local player = Players:FindFirstChild(playerName)
        if player then
            wait(0.1) -- Pequeno delay para garantir que o objeto está totalmente carregado
            initializePlayerRings(player)
        end
    end
end)

-- Limpar dados quando jogador sair
Players.PlayerRemoving:Connect(function(player)
    playerRingProgress[player.UserId] = nil
    print("Dados de rings limpos para " .. player.Name)
end)

print("RingManager carregado e pronto!")