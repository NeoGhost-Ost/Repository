# Sistema de Anéis (Ring System) - Roblox

Este sistema gerencia a progressão do jogador através de uma sequência de anéis no minigame.

## 📁 Arquivos

1. **ServerScript_RingManager.lua** - Script principal do servidor
2. **LocalScript_RingUI.lua** - Script de UI completo com logs
3. **LocalScript_RingUI_UpdateOnly.lua** - Versão simplificada (apenas atualiza atributo)

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
- Cria/atualiza atributo string "ring" no Viewport
- Mostra o número do ring atual (0, 1, 2, etc.)
- Localização: `Glider > Frame > Viewport`

## 🛠️ Instalação

### 1. ServerScript (ServerScript_RingManager.lua)
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
        ├── Ring 1 (próximo ring)
        ├── Ring 2 (ring seguinte)
        └── ... (quantos rings você quiser)
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
   - ✅ Próximo ring é clonado
   - ✅ Atributo UI é atualizado
4. **Repetição**: Processo continua até não haver mais rings

## 🔧 Personalização

### Adicionar Mais Rings
Simplesmente adicione mais rings na pasta Rings:
- Ring 3, Ring 4, Ring 5, etc.

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
   - Verifique se o modelo tem partes sólidas
   - Certifique-se de que CanCollide = true nas partes

2. **Som não toca**
   - Verifique se existe "RingSound" no SoundService
   - Confirme se o som não está mutado

3. **UI não atualiza**
   - Verifique a estrutura: Glider > Frame > Viewport
   - Confirme se o LocalScript está no local correto

4. **Próximo ring não aparece**
   - Verifique se existe Ring 1, Ring 2, etc. na pasta Rings
   - Confirme se os nomes estão corretos ("Ring 1", "Ring 2")

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