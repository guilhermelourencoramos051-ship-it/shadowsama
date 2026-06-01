# ⚔️ TSB Admin Tool v2.0

**The Strongest Battlegrounds - Sistema Completo de Admin & Player Tool**

---

## 📋 Características Principais

### 🔑 Sistema de Autenticação
- **Versão Admin**: Apenas `LOS67ZITOSDIZEN67` - Sem necessidade de KEY
- **Versão Free**: Requer KEY semanal automática
- **Keys Automáticas**: Geradas via semana do ano com palavras do anime
- **Override Remoto**: Gerenciável via Pastebin/Gist

### 🎮 Compatibilidade
- **PlaceID**: 10449761463 (TSB)
- **Executor**: Solara ou similar (com suporte a `game:HttpGet`)
- **UI**: CoreGui (AntiDetect)
- **Multiplataforma**: PC e Mobile

---

## 📁 Arquivos do Projeto

```
shadowsama/
├── launcher.lua          # Menu de seleção de scripts
├── main_admin.lua        # Script completo (Admin)
├── main_free.lua         # Script para jogadores (Free)
└── README.md            # Este arquivo
```

---

## 🚀 Como Usar

### Execução Rápida
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/guilhermelourencoramos051-ship-it/shadowsama/main/launcher.lua"))()
```

### Fluxo de Uso
1. **Execute o Launcher**
2. **Selecione a versão**:
   - Admin: Acesso automático (se for LOS67ZITOSDIZEN67)
   - Free: Digite a KEY semanal
3. **Utilize as abas de funcionalidades**

---

## ⚔️ Funcionalidades - Versão Admin

### 1. **ABA COMBATE**
- ⚡ No Stun (Agressivo) - Desancora + Limpa BodyVelocity + Estado Running
- 👻 Anti-Ragdoll - Impede quedas/ragdoll
- 🛡️ Auto Block - Detecta inimigos (22 studs) e bloqueia automaticamente
- 💪 Auto Punch - Socas automáticas perto de inimigos
- 🌟 Auto Awakening - Ativa Ultimate (G) automaticamente
- 💚 God Mode - Cura contínua infinita
- ⬆️ No Knockback - Zera velocidade lateral do HRP
- 🧲 Noclip - Atravessa paredes

### 2. **ABA DASH**
- 💨 No Dash CD - Zera atributos de cooldown de dash (RenderStepped)

### 3. **ABA STATS**
- 🏃 WalkSpeed Blindado - Força WalkSpeed 20
- 📈 JumpPower Blindado - Força JumpPower 50

### 4. **ABA TP**
- TP para Spawn
- TP para Inimigo Mais Próximo
- ⬆️ TP Jump - Pula 50 studs pra cima
- ✈️ Fly Mode (WASD + Space/Shift para subir/descer)

### 5. **ABA ARENA**
- 🏟️ Arena Sub (Seguidor) - Segue inimigo mantendo distância de ataque

### 6. **ABA VISUALS**
- 👁️ Player ESP - Highlight 3D em todos jogadores
- ⭐ Inf Jump - Pulo infinito

### 7. **ABA UTILS**
- 🔄 Rejoin - Reconecta no mesmo servidor

### 8. **ABA TROLL** (Apenas Admin)
- 🌀 Fling - Arremessa com física absurda
- ❄️ Congelar - Ancora o personagem do alvo
- ☠️ Eliminar - Zera vida do alvo
- 👞 Kickar - Desconecta o alvo

**Comandos de Chat** (Apenas Admin pode usar):
- `;fling Nome`
- `;freeze Nome`
- `;kill Nome`
- `;kick Nome`

---

## 💨 Funcionalidades - Versão Free

- ⚡ No Stun
- 👻 Anti-Ragdoll
- 🛡️ Auto Block
- 💪 Auto Punch
- 💚 God Mode
- 💨 No Dash CD
- TP para Spawn
- TP para Inimigo Mais Próximo
- ✈️ Fly Mode
- 👁️ Player ESP
- ⭐ Inf Jump
- 🔄 Rejoin

---

## 🔐 Sistema de Keys

### Geração Automática Semanal
```lua
-- Baseado em: Ano × 1000 + Semana do Ano
-- Palavras: Alpha, Beta, Delta, ShadowGarden, CidKagenou, etc.
-- Formato: "Alpha-Beta-Delta-22"
```

### Validação
- KEY digitada comparada com KEY remota (Pastebin)
- Erro visual (vermelho) se KEY incorreta
- "KEY INVÁLIDA!" por 2 segundos

### Override Admin
- Mudar KEY no Pastebin automaticamente
- Todos os Free users desconectados instantaneamente

---

## 🎨 Design Visual

- **Tema**: The Eminence in Shadow
- **Cores Principais**:
  - Roxo: `RGB(138, 43, 226)`
  - Roxo Escuro: `RGB(25, 25, 112)`
  - Magenta: `RGB(255, 20, 147)`
  - Preto: `RGB(10, 10, 10)`

- **UI Elements**:
  - Header arrastável
  - Botões Minimizar/Fechar
  - Sistema de Abas
  - Toggles (ON/OFF)
  - Scroll Layout

---

## ⌨️ Atalhos de Teclado

| Tecla | Ação |
|-------|------|
| `]` | Abrir/Fechar Menu |
| `WASD` | Voar (Fly Mode ativo) |
| `Space` | Subir (Fly Mode) |
| `Shift` | Descer (Fly Mode) |
| `Space` | Pulo Infinito (Inf Jump ativo) |

---

## 🛡️ Segurança & Proteção

- ✅ Anti-duplicação via `_G.TSBLauncherLoaded`
- ✅ UI no CoreGui (AntiDetect)
- ✅ Reconexão automática ao respawnar
- ✅ Limpeza de conexões ao fechar
- ✅ Validação de Admin (apenas LOS67ZITOSDIZEN67)

---

## 📊 Estrutura de Código

### Launcher
- Menu de seleção com validação de KEY
- Detecta Admin automaticamente
- Carrega script selecionado via GitHub

### Main Admin
- 8 abas com todas funcionalidades
- Sistema de Toggle com callbacks
- Conexões RenderStepped/Heartbeat
- Limpeza automática ao fechar

### Main Free
- 5 abas (sem Troll)
- Mesma estrutura de UI
- Validação de KEY
- Recursos limitados

---

## 🔧 Configuração

### Alterar KEY Pastebin
Edite no `launcher.lua`:
```lua
local KEYS_PASTEBIN_URL = "https://pastebin.com/raw/YOURKEY"
```

### Alterar Discord Link
```lua
local DISCORD_LINK = "https://discord.gg/JtE2rx2eGx"
```

### Alterar PlaceID
Procure por `10449761463` nos arquivos

---

## 📝 Changelog

### v2.0
- ✅ Launcher com seleção múltipla
- ✅ Versões Admin e Free separadas
- ✅ Sistema de KEY semanal automático
- ✅ Override remoto via Pastebin
- ✅ Discord Link no Launcher
- ✅ UI melhorada com Abas
- ✅ Minimizar/Expandir
- ✅ Suporta todos os placeid TSB

---

## ⚠️ Disclaimer

Este script é para **fins educacionais e de entretenimento**. Use por sua conta e risco em servidores privados ou autorizados. Roblox pode banir contas por uso de exploits.

---

## 👤 Autor

**LOS67ZITOSDIZEN67**

Discord: https://discord.gg/JtE2rx2eGx

---

*Atualizado: 2026-06-01*
*Versão: 2.0 Beta*