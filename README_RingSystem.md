# Sistema de Anéis (Ring System) - Roblox

Este sistema gerencia a progressão do jogador através de uma sequência de anéis no minigame.

## 📁 Arquivos

1. **ServerScript_RingManager.lua** - Script principal do servidor
2. **ServerScript_Game1OverHandler.lua** - Gerencia o fim do jogo (Ring 23)
3. **LocalScript_RingUI.lua** - Script de UI completo com logs
4. **LocalScript_RingUI_UpdateOnly.lua** - Versão simplificada (apenas atualiza atributo)

## 🎯 Funcionalidades

### ✅ Detecção de Colisão
- Detecta quando o jogador toca em qualquer parte do modelo Ring
- Funciona com modelos complexos (múltiplas partes)
- Apenas o jogador correto pode ativar seu próprio ring

### ✅ Progressão de Rings
- Deleta o ring atual quando tocado
- Clona automaticamente o próximo ring (Ring 1, Ring 2, etc.)
- Cada jogador tem sua própria sequência independente

### ✅ Sistema de Audio
- Toca o som "RingSound" do SoundService quando ring é tocado
- Som é reproduzido para todos os jogadores

### ✅ Atualização de UI
- Cria/atualiza atributo string "ring" no Viewport (cria automaticamente se não existir)
- Mostra o número do próximo ring (1, 2, 3... até 24 quando completa)
- Localização: `Glider > Frame > Viewport`

### ✅ Sistema Game1Over
- Aciona evento "Game1Over" quando jogador completa Ring 23
- Limpa automaticamente objetos do jogador (Blowers e Rings)
- Sistema de prevenção de duplicatas
- Preparado para recompensas e lógicas customizadas

## 🛠️ Instalação

### 1. ServerScripts
**ServerScript_RingManager.lua:**
```
Localização: ServerScriptService
Tipo: ServerScript
```

**ServerScript_Game1OverHandler.lua:**
```
Localização: ServerScriptService
Tipo: ServerScript
```

### 2. LocalScript de UI
Escolha UMA das duas opções:

**Opção A - Completa (com logs):**
```
Arquivo: LocalScript_RingUI.lua
Localização: StarterPlayerScripts OU dentro do ScreenGui Glider
Tipo: LocalScript
```

**Opção B - Simplificada:**
```
Arquivo: LocalScript_RingUI_UpdateOnly.lua
Localização: StarterPlayerScripts OU dentro do ScreenGui Glider
Tipo: LocalScript
```

### 3. Som Necessário
```
Localização: SoundService
Nome: RingSound
Tipo: Sound object
```

## 📋 Estrutura Necessária

### ReplicatedStorage
```
ReplicatedStorage
└── Game1
    └── Rings
        ├── Ring 0 (modelo inicial)
        ├── Ring 1, Ring 2, Ring 3...
        ├── Ring 20, Ring 21, Ring 22
        └── Ring 23 (último ring - aciona Game1Over)
```

### PlayerGui
```
PlayerGui
└── Glider (ScreenGui)
    └── Frame
        └── Viewport <- Atributo "ring" será criado aqui
```

### SoundService
```
SoundService
└── RingSound (Sound)
```

## 🎮 Como Funciona

1. **Inicialização**: Sistema detecta quando Ring0_PlayerName aparece no Workspace
2. **Colisão**: Jogador toca em qualquer parte do ring
3. **Ações Simultâneas**:
   - ✅ Som "RingSound" é reproduzido
   - ✅ Ring atual é deletado
   - ✅ Atributo UI é atualizado com próximo número
   - ✅ Próximo ring é clonado (se não for Ring 23)
4. **Ring 23**: Quando tocado, aciona Game1Over e limpa objetos
5. **Repetição**: Processo continua de Ring 0 até Ring 23

## 🔧 Personalização

### Modificar Quantidade de Rings
Para alterar o limite de 23 rings, modifique estas linhas no ServerScript_RingManager.lua:
```lua
-- Linha da verificação do Ring final
if currentRingNumber == 23 then

-- Linha do limite de clonagem
if ringNumber <= 23 then
```

### Modificar Localização da UI
Altere estas linhas no LocalScript:
```lua
local gliderGui = playerGui:FindFirstChild("SeuScreenGui")
local frame = gliderGui:FindFirstChild("SeuFrame")
local viewport = frame:FindFirstChild("SeuViewport")
```

### Trocar o Som
Mude o nome do som no ServerScript:
```lua
local ringSound = SoundService:FindFirstChild("SeuSom")
```

### Adicionar Efeitos Visuais
No ServerScript, após `ring:Destroy()`, adicione:
```lua
-- Exemplo: Efeito de partículas
local explosion = ReplicatedStorage.Effects.RingExplosion:Clone()
explosion.Parent = Workspace
explosion.Position = ring.PrimaryPart.Position
```

## 🐛 Troubleshooting

### Problemas Comuns

1. **Ring não detecta toque**
   - ✅ Sistema funciona com CanCollide = false
   - Verifique se o modelo tem partes (BasePart)
   - Certifique-se de que o jogador tem Humanoid no Character

2. **Som não toca**
   - Verifique se existe "RingSound" no SoundService
   - Confirme se o som não está mutado

3. **UI não atualiza**
   - Verifique a estrutura: Glider > Frame > Viewport
   - Confirme se o LocalScript está no local correto

4. **Próximo ring não aparece**
   - Verifique se existem Ring 1 até Ring 23 na pasta Rings
   - Confirme se os nomes estão corretos ("Ring 1", "Ring 2", etc.)

6. **Game1Over não aciona**
   - Certifique-se de que existe Ring 23 na pasta Rings
   - Verifique se ServerScript_Game1OverHandler.lua está instalado

5. **Sistema não inicializa**
   - Certifique-se de que o Ring0_PlayerName foi criado pelo sistema anterior
   - Verifique os logs no Output para mensagens de erro

## 📊 Logs de Debug

O sistema inclui logs detalhados:
- ✅ Inicialização do sistema
- ✅ Detecção de toques
- ✅ Clonagem de rings
- ✅ Atualizações de UI
- ❌ Erros e avisos

## 🔗 Integração

Este sistema funciona em conjunto com:
- `ServerScript_Game1Manager.lua` (cria o Ring0 inicial)
- `LocalScript_PlayButton.lua` (inicia o jogo)

Certifique-se de que todos os scripts estão instalados para funcionamento completo.