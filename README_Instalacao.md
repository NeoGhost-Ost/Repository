# Scripts Luau para Minigame Roblox

Este projeto contém dois scripts Luau para implementar um sistema de minigame no Roblox Studio.

## Arquivos

1. **LocalScript_PlayButton.lua** - LocalScript para o botão Play
2. **ServerScript_Game1Manager.lua** - ServerScript para gerenciar o jogo

## Instalação

### 1. LocalScript (LocalScript_PlayButton.lua)
- Coloque este script dentro do **ImageButton** chamado "Play"
- Caminho completo: `StarterGui > Minigames > Frame > Glider > Play (ImageButton)`
- Certifique-se de que é um **LocalScript**

### 2. ServerScript (ServerScript_Game1Manager.lua)
- Coloque este script no **ServerScriptService**
- Certifique-se de que é um **ServerScript** (não LocalScript)

## Estrutura Necessária no ReplicatedStorage

Certifique-se de que você tem a seguinte estrutura no ReplicatedStorage:

```
ReplicatedStorage
└── Game1
    ├── Blowers (pasta com objetos)
    └── Rings
        └── Ring 0 (objeto)
```

## Estrutura Necessária no StarterGui

```
StarterGui
└── Minigames (ScreenGui)
    └── Frame
        └── Glider
            └── Play (ImageButton) <- LocalScript aqui
```

## Funcionalidades

### O que o sistema faz:

1. **Clique no Botão**: Quando um jogador clica no botão "Play", dispara o RemoteEvent "Game1Start"

2. **Clonagem de Objetos**: 
   - Clona a pasta "Blowers" do ReplicatedStorage para o Workspace
   - Clona o objeto "Ring 0" do ReplicatedStorage para o Workspace
   - Os objetos clonados são nomeados com o nome do jogador (ex: "Blowers_PlayerName")

3. **Atributos**: O ServerScript adiciona um atributo string chamado "Player" com o nome do jogador

4. **Múltiplos Jogadores**: Suporta múltiplos jogadores simultaneamente

5. **Limpeza Automática**: Remove os objetos clonados quando o jogador sai do servidor

## Logs de Debug

Os scripts incluem mensagens de print() para debug:
- Confirmação de cliques no botão
- Status de clonagem de objetos
- Avisos se objetos necessários não forem encontrados
- Confirmação de limpeza quando jogadores saem

## Troubleshooting

### Problemas Comuns:

1. **"Pasta Game1 não encontrada"**: Verifique se existe a pasta Game1 no ReplicatedStorage

2. **"Pasta Blowers não encontrada"**: Certifique-se de que existe a pasta Blowers dentro de Game1

3. **"Ring 0 não encontrado"**: Verifique se existe o objeto "Ring 0" na pasta Rings

4. **Botão não funciona**: Certifique-se de que o LocalScript está dentro do ImageButton correto

5. **RemoteEvent não funciona**: Verifique se ambos os scripts estão nos locais corretos (LocalScript no botão, ServerScript no ServerScriptService)

## Personalização

Você pode modificar facilmente:
- Nomes dos objetos clonados
- Adicionar mais objetos para clonar
- Modificar a lógica de limpeza
- Adicionar efeitos visuais ou sonoros