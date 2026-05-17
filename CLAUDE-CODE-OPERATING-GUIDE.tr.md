**Notice:** This guide should be reviewed periodically because Claude Code features such as Hooks, Plugins, Skills, MCP Servers, and Subagents may change over time.

## **Claude Code/CLI Çalışma Mimarisi Rehberi**

**CLAUDE.md, PROJECT_CONTEXT.md, SESSION_CONTEXT.md, Hooks, Custom Commands ve Rules** ayrımını net kurmak gerekiyor.

Claude Code’da `CLAUDE.md`, Claude’un her oturum başında okuduğu proje belleği gibi çalışır. Resmi dokümana göre proje seviyesinde `./CLAUDE.md` kullanılabilir; `/init` komutu da mevcut kod tabanını analiz ederek başlangıç `CLAUDE.md` dosyası üretebilir. Ayrıca Claude Code `AGENTS.md` dosyasını doğrudan değil, `CLAUDE.md` üzerinden import edildiğinde okur.

Claude'u şu sırayla kullanmak daha mantıklı;

```text
1. Manuel prompt (/init)
2. CLAUDE.md
3. Custom command
4. Hook
5. Skill
6. Subagent
7. MCP Server
8. Plugin
```

## 1. Proje başında Claude’a verilecek ilk komut

```text
/init
```

Ardından aşağıdaki gibi daha profesyonel bir prompt verilmeli (bir sonraki başlık da incelenmeli):

```text
Create or update the project-level CLAUDE.md file for this repository.

Before writing anything:
1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and project architecture.
6. Do not modify application code.

Create a concise CLAUDE.md file that helps Claude Code work professionally in this project.

The file must include:
- Project overview
- Tech stack
- Repository structure
- Build, run, test, lint commands
- Coding conventions
- Architecture rules
- Git workflow rules
- Testing expectations
- Documentation update rules
- Security rules
- How to use PROJECT_CONTEXT.md and SESSION_CONTEXT.md
- How to update docs/OPEN_DECISIONS.md and docs/IMPLEMENTATION_STATE.md
- Rules for not overengineering
- Rules for asking before making destructive changes

If AGENTS.md exists, import it using @AGENTS.md and add Claude-specific instructions below it.

Keep CLAUDE.md under 200 lines if possible.
Do not include temporary task notes in CLAUDE.md.
Temporary state should go into SESSION_CONTEXT.md.
```

Her projede Claude’a doğrudan kod yazdırmadan önce şunu yaptır:

```text
(Projeyi açıklayan bir cümle ve sonrasında aşağıdaki kısım)

Create or update:
- CLAUDE.md
- PROJECT_CONTEXT.md
- SESSION_CONTEXT.md
- docs/OPEN_DECISIONS.md
- docs/IMPLEMENTATION_STATE.md
- .claude/settings.json
- .claude/commands/
- .claude/hooks/
- .claude/rules/

Do not implement application features yet.

The goal is to make this repository easy to continue across multiple Claude Code sessions with minimal repeated explanation.
```

```text
CLAUDE.md = Claude’un davranış kuralları
PROJECT_CONTEXT.md = projenin kalıcı mimari / ürün bağlamı
SESSION_CONTEXT.md = son oturumun geçici devam notları
OPEN_DECISIONS.md = henüz netleşmemiş kararlar
IMPLEMENTATION_STATE.md = hangi adımlar bitti / sırada ne var
CHANGELOG.md = kullanıcıya veya projeye etki eden değişiklikler
.claude/hooks = otomatik güvenlik, kalite, session başlangıç/bitiş kontrolleri
.claude/commands = tekrar eden iş akışları
.claude/rules = teknolojiye veya klasöre özel kurallar
.claude/agents = Uzman roller
.claude/skills = Tekrar kullanılabilir uzmanlık paketleri
MCP servers = Dış sistem bağlantıları
Plugins = Bunların paylaşılabilir paket hali
```

```text
Ne zaman ne kullanılmalı?

Sürekli geçerli kural → CLAUDE.md
Geçici oturum notu → SESSION_CONTEXT.md
Tekrarlanan manuel iş → Custom command
Otomatik kontrol → Hook
Uzmanlık yöntemi → Skill
Uzman rol → Subagent
Dış sistem erişimi → MCP Server
Yeniden kullanılabilir paket → Plugin
Plugins = Bunların paylaşılabilir paket hali
```

---

```text
Bir şeyi nereye koymalıyım?

1. Claude’un genel davranış kuralı mı?
   → CLAUDE.md
2. Projenin kalıcı mimari / ürün bilgisi mi?
   → PROJECT_CONTEXT.md
3. Son oturumdan kalan geçici devam bilgisi mi?
   → SESSION_CONTEXT.md
4. Tekrar tekrar çalıştırdığım bir iş akışı mı?
   → .claude/commands/
5. Otomatik çalışması gereken güvenlik / kalite kontrolü mü?
   → .claude/hooks/
6. Belirli teknoloji veya klasör için kural mı?
   → .claude/rules/
7. Belirli bir uzmanlık yöntemi mi?
   → .claude/skills/
8. Belirli bir uzman role devredilecek iş mi?
   → .claude/agents/
9. Dış sistemden veri mi gerekiyor?
   → MCP Server
10. Bu yapıyı başka projelere de taşımak mı istiyorum?
   → Plugin
```

## (Alternatif) Proje başlangıcında Claude’a verilecek gelişmiş komut

```text
Create or update the Claude Code operating structure for this repository.

Before writing anything:

1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and architecture.
6. Do not modify application code.

Create or update:

- CLAUDE.md
- PROJECT_CONTEXT.md
- SESSION_CONTEXT.md
- docs/OPEN_DECISIONS.md
- docs/IMPLEMENTATION_STATE.md
- .claude/settings.json
- .claude/commands/
- .claude/hooks/
- .claude/rules/
- .claude/agents/
- .claude/skills/

CLAUDE.md must remain concise and should not include long temporary notes.

Use this separation:

- CLAUDE.md = Claude Code behavior and project operating rules
- PROJECT_CONTEXT.md = permanent product and architecture context
- SESSION_CONTEXT.md = temporary continuation state
- docs/OPEN_DECISIONS.md = unresolved decisions
- docs/IMPLEMENTATION_STATE.md = implementation progress
- .claude/commands = reusable workflows
- .claude/hooks = automated checks and lifecycle scripts
- .claude/rules = technology or folder-specific rules
- .claude/agents = specialized subagent definitions
- .claude/skills = reusable expertise packages

Also recommend whether this project would benefit from MCP servers.

For each suggested MCP server, explain:

- purpose
- read-only or write access
- risks
- setup priority

Do not configure external services unless explicitly asked.
Do not create plugins yet unless the same setup is intended to be reused across multiple repositories.
```

## 2. CLAUDE.md için çekirdek yapı

`CLAUDE.md` şişmemeli. Resmi dokümantasyon da kısa ve net talimatların daha iyi çalıştığını, 200 satır altında kalmanın daha sağlıklı olduğunu söylüyor.

Önerilen yapı:

```md
# Claude Code Instructions

## Project Context

- Always read PROJECT_CONTEXT.md before making architectural or implementation decisions.
- Always read SESSION_CONTEXT.md when continuing a previous session.
- Use README.md for setup and user-facing project overview.
- Use docs/OPEN_DECISIONS.md for unresolved decisions.
- Use docs/IMPLEMENTATION_STATE.md for implementation progress.

## Working Style

- Think before editing.
- Prefer small, reviewable changes.
- Do not overengineer.
- Do not introduce new dependencies without explaining why.
- Do not rewrite large parts of the codebase unless explicitly asked.
- Before destructive actions, ask for confirmation.

## Development Workflow

Before implementation:

1. Understand the task.
2. Inspect relevant files.
3. Create a short plan.
4. Identify risks or open decisions.

During implementation:

1. Keep changes minimal.
2. Follow existing project conventions.
3. Add types and tests where appropriate.
4. Avoid unrelated refactors.

After implementation:

1. Run relevant checks.
2. Summarize changed files.
3. Update SESSION_CONTEXT.md.
4. Update docs/IMPLEMENTATION_STATE.md.
5. Update docs/OPEN_DECISIONS.md if decisions changed.

## Documentation Rules

- Permanent architecture decisions go into PROJECT_CONTEXT.md or ADR files.
- Temporary session notes go into SESSION_CONTEXT.md.
- Completed implementation progress goes into docs/IMPLEMENTATION_STATE.md.
- User-facing changes go into CHANGELOG.md.

## Safety Rules

- Never read or print secrets from .env files.
- Never commit secrets.
- Never run destructive database, filesystem, or deployment commands without confirmation.
- Do not use production credentials unless explicitly instructed.
```

## 3. Hook mantığını doğru konumlandırmak

`CLAUDE.md` Claude’a **nasıl davranması gerektiğini söyler**.
Hook ise belirli olaylarda **otomatik komut çalıştırır**.

Resmi Claude Code dokümanına göre `SessionStart` hook’u yeni oturumda veya resume edildiğinde çalışır; geliştirme bağlamı yüklemek, son değişiklikleri göstermek veya environment hazırlamak için uygundur.

```text
Başlangıç Hook’u/SessionStart Hook:
- Confirm current git branch
- Show uncommitted changes summary
- Read PROJECT_CONTEXT.md if present
- Read SESSION_CONTEXT.md if present
- Read docs/OPEN_DECISIONS.md if present
- Read docs/IMPLEMENTATION_STATE.md if present
- Detect package manager
- Check dependency install state
- Check whether lockfile exists
- Print recommended next steps as additional context
```

Bitiş hook’u için de `Stop` hook’u kullanılabilir. Claude Code dokümantasyonunda `Stop` hook’unun Claude’un durmadan önce belirli kriterleri kontrol etmesi için kullanılabileceği örnekleniyor.

```text
Bitiş Hook'u/Stop Hook:
- Check whether requested task is actually complete
- Check whether tests/lint were run or explain why not
- Update SESSION_CONTEXT.md
- Update docs/IMPLEMENTATION_STATE.md
- Update docs/OPEN_DECISIONS.md
- Update CHANGELOG.md if user-visible behavior changed
- Summarize modified files
- Warn about uncommitted changes
```

## 4. Hook tarafına eklenebilecek en değerli şeyler

Claude Code’da `PreToolUse` hook’u, Claude bir tool çağrısı yapmadan önce çalışır ve çağrıyı allow/deny/ask/defer şeklinde kontrol edebilir. Bu özellikle güvenlik için çok değerlidir.

Profesyonel kullanım için:

### Güvenlik Hook’ları

```text
PreToolUse / Bash:
- rm -rf, sudo rm, chmod -R 777 gibi riskli komutları engelle
- production deploy komutlarında kullanıcı onayı iste
- migration, db reset, docker volume prune gibi komutlarda onay iste
- .env, secrets, credentials dosyalarını okumayı engelle
```

### Kod Kalitesi Hook’ları

`PostToolUse`, Claude bir tool’u başarıyla çalıştırdıktan sonra devreye girer. Resmi dokümantasyonda `Write|Edit` sonrasında lint çalıştırma örneği veriliyor.

```text
PostToolUse / Write|Edit:
- Değişen dosya TypeScript ise npm run typecheck veya npm run lint öner
- Python ise ruff / mypy / pytest öner
- Flutter ise flutter analyze öner
- Backend ise ilgili testleri çalıştır
```

### Dokümantasyon Hook’ları

```text
PostToolUse / Write|Edit:
- Eğer architecture/ veya src/core gibi kritik dosyalar değiştiyse docs/IMPLEMENTATION_STATE.md güncelle
- Eğer public API değiştiyse README veya API dokümantasyonunu kontrol et
- Eğer karar değiştiyse docs/OPEN_DECISIONS.md veya ADR güncelle
```

### Git Hook Mantığı

```text
SessionStart:
- current branch
- last commit
- uncommitted files
- changed files summary

Stop:
- modified files
- files not tested
- suggested commit message
- changelog candidate
```

### Dependency Guard

```text
PreToolUse / Bash:
- npm install, pip install, brew install, flutter pub add gibi komutlarda neden gerektiğini açıklat
- package.json / pyproject.toml / pubspec.yaml değişirse lockfile kontrolü yap
```

## 5. `.claude/settings.json` nerede durmalı?

Claude Code’da proje ayarları `.claude/settings.json` içine konur ve repo ile paylaşılabilir. Kişisel ayarlar için `.claude/settings.local.json` kullanılır; bu dosya commit edilmemelidir.

Önerilen yapı: (Bunu proje başlangıcında Claude'a danışmak gerekir, içerik değişebilir.)

```text
project-root/
├── CLAUDE.md
├── PROJECT_CONTEXT.md
├── SESSION_CONTEXT.md
├── CHANGELOG.md
├── docs/
│   ├── OPEN_DECISIONS.md
│   └── IMPLEMENTATION_STATE.md
├── .claude/
│   ├── settings.json
│   ├── hooks/
│   │   ├── session-start.sh
│   │   ├── stop.sh
│   │   ├── guard-bash.sh
│   │   └── post-edit-check.sh
│   ├── commands/
│   │   ├── continue-session.md
│   │   ├── implement-step.md
│   │   ├── review-changes.md
│   │   └── close-session.md
│   └── rules/
│       ├── security.md
│       ├── testing.md
│       ├── documentation.md
│       ├── frontend.md
│       ├── backend.md
│       └── ai-rag.md (projeden projeye değişir)
```

**Örnek `.claude/settings.json`**

```text
Create a .claude/settings.json file for this repository.

Configure professional Claude Code hooks:
- SessionStart should run .claude/hooks/session-start.sh
- Stop should run .claude/hooks/stop.sh
- PreToolUse for Bash should run .claude/hooks/guard-bash.sh
- PostToolUse for Write|Edit should run .claude/hooks/post-edit-check.sh

Also configure safe permissions:
- Deny reading .env files
- Deny reading secrets folders
- Deny destructive shell commands unless explicitly approved

Do not create overly broad permissions.
Keep the configuration suitable for a team-shared repository.
```

Yaklaşık şöyle bir dosya hedeflenebilir:

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(./config/credentials.json)"
    ]
  },
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/session-start.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/stop.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/guard-bash.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/post-edit-check.sh"
          }
        ]
      }
    ]
  }
}
```

## 7. Custom command’lar eklemek de verim katar

Hook’lar otomatik çalışır. Ama tekrar tekrar kullandığın iş akışları için custom command daha iyi olur.

Örneğin:

```text
.claude/commands/continue-session.md
.claude/commands/implement-step.md
.claude/commands/review-changes.md
.claude/commands/close-session.md
.claude/commands/create-context.md
.claude/commands/update-docs.md
```

### `/continue-session`

```md
Read PROJECT_CONTEXT.md and SESSION_CONTEXT.md first.

Then:

1. Summarize the current project state.
2. List pending tasks.
3. Identify the next safest implementation step.
4. Do not modify code until you present a short plan.
```

### `/implement-step`

```md
Implement only the requested step: $ARGUMENTS

Requirements:

- Do not move beyond this step.
- Keep changes minimal and typed.
- Follow CLAUDE.md.
- Update docs/IMPLEMENTATION_STATE.md.
- Update SESSION_CONTEXT.md.
- Explain how to verify locally.
```

### `/close-session`

```md
Prepare the project for continuation in a future Claude Code session.

Update:

- SESSION_CONTEXT.md
- docs/IMPLEMENTATION_STATE.md
- docs/OPEN_DECISIONS.md
- CHANGELOG.md if relevant

Include:

- Completed work
- Pending work
- Modified files
- Commands run
- Tests/lint status
- Known issues
- Next recommended step

Do not modify application code unless required for documentation consistency.
```

## 8. Skills Mantığı: Tekrar Kullanılabilir Uzmanlık Paketleri

**Skills**, Claude’a belirli bir işi daha kaliteli yapması için verilen tekrar kullanılabilir uzmanlık paketleri gibi düşünülebilir.

Basit ayrım şöyle kurulabilir:

```text
CLAUDE.md = Bu projede Claude nasıl davranmalı?
Command = Ben bu işi tekrar tekrar nasıl tetiklerim?
Skill = Claude bu işi hangi uzmanlıkla / yöntemle yapmalı?
Subagent = Bu iş için hangi uzman rol devreye girmeli?
MCP Server = Claude hangi dış sisteme bağlanabilmeli?
Plugin = Bunların paketlenmiş ve paylaşılabilir hali
```

Skills özellikle şu durumlarda değerlidir:

```text
- Tekrar eden ama tek komutla anlatılamayacak kadar karmaşık işler
- Belirli kalite standartları gerektiren işler
- Projeden projeye taşınabilecek uzmanlıklar
- Kod inceleme, güvenlik analizi, RAG pipeline tasarımı, test stratejisi gibi alanlar
```

Örnek skill fikirleri:

```text
skills/
├── code-review/
│   └── SKILL.md
├── security-review/
│   └── SKILL.md
├── rag-architecture/
│   └── SKILL.md
├── react-native-mobile/
│   └── SKILL.md
├── flutter-mobile/
│   └── SKILL.md
├── backend-api-design/
│   └── SKILL.md
└── documentation-writer/
    └── SKILL.md
```

Örnek `rag-architecture/SKILL.md`:

```md
# RAG Architecture Skill

Use this skill when designing, reviewing, or improving a Retrieval-Augmented Generation system.

## Goals

- Prefer simple, inspectable architecture.
- Separate ingestion, chunking, embedding, retrieval, reranking, prompting, and generation.
- Avoid overengineering in MVP stages.
- Make local development possible before adding cloud dependencies.
- Document every major architectural decision.

## Checklist

Before implementation:

1. Identify document types.
2. Define chunking strategy.
3. Define embedding model.
4. Define vector database.
5. Define retrieval strategy.
6. Define role-based prompting if needed.
7. Define evaluation strategy.

## Rules

- Do not hide too much logic inside opaque framework chains.
- Prefer explicit retrieval and prompt construction.
- Keep architecture explainable for portfolio projects.
- Update ADR files when a major decision is made.
```

```text
Komutlar workflow içindir.
Skills uzmanlık içindir.

Yanlış:
"review-code" diye her şeyi command yapmak.

Daha doğrusu:
Command: /review-changes
Skill: code-review
Subagent: code-reviewer
```

---

## 9. MCP Server’lar: Claude Code’a Dış Sistem Erişimi Verme

**MCP Server**, Claude Code’un dış araçlara, API’lere, veri kaynaklarına veya servislerine kontrollü şekilde bağlanmasını sağlar.

```text
Claude Code tek başına terminal + dosya sistemi üzerinde çalışır.
MCP Server ise Claude’a yeni kabiliyetler kazandırır.

Örnek:
- GitHub issue’larını okumak
- Linear task’larını çekmek
- Notion dokümanlarını aramak
- PostgreSQL veritabanını sorgulamak
- Figma tasarımlarına erişmek
- Sentry hatalarını incelemek
- AWS kaynaklarını listelemek
```

MCP Server’lar özellikle şu işler için değerlidir:

```text
- Proje yönetimi araçlarına bağlanmak
- Dokümantasyon kaynaklarını okumak
- Issue / ticket / task bağlamı almak
- Veritabanı veya log analizi yapmak
- Kurumsal sistemlere güvenli entegrasyon sağlamak
```

Örnek kullanım senaryosu:

```text
Bir backend projesinde Claude’a sadece kodu değil, aynı zamanda:
- GitHub issue içeriğini
- Linear task açıklamasını
- Notion PRD dokümanını
- Sentry hata kaydını
okutup daha doğru çözüm üretmesini sağlayabilirsin.
```

| İhtiyaç                               | Kullanılacak yapı |
| ------------------------------------- | ----------------- |
| Dosyadaki kuralları Claude’a öğretmek | `CLAUDE.md`       |
| Tekrarlanan iş akışını başlatmak      | Custom command    |
| Uzmanlık / metodoloji kazandırmak     | Skill             |
| Dış sistemlere bağlanmak              | MCP Server        |
| Belirli işi uzman ajana devretmek     | Subagent          |
| Hepsini paketleyip paylaşmak          | Plugin            |

---

Örnek MCP kullanım politikası:

```md
## MCP Usage Rules

- Use MCP servers only when repository files are not enough.
- Prefer read-only access unless write access is explicitly needed.
- Do not expose secrets, credentials, tokens, or private customer data.
- For production systems, ask before making destructive or write operations.
- Summarize what external context was used before implementing changes.
```

Claude’a verilecek örnek prompt:

```text
Review this repository and suggest which MCP servers would provide real value.

Consider:
- GitHub integration
- Linear or Jira integration
- Notion documentation
- Database inspection
- Error monitoring
- Cloud provider access

Do not configure anything yet.

For each recommended MCP server, explain:
- Why it is useful
- What risks it introduces
- Whether it should be read-only or writable
- Which workflows it improves
```

---

## 10. Plugins: Komut, Skill, Hook, MCP ve Agent Yapılarını Paketleme

**Plugin**, Claude Code ekosisteminde tekrar kullanılabilir uzantı paketi gibi düşünülebilir. Resmi Claude Code plugin açıklamasında plugins; custom slash commands, specialized agents, hooks ve MCP servers gibi yapıları bir araya getiren eklentiler olarak tanımlanır.

Yani plugin şu işe yarar:

```text
Tek bir projede kullandığın iyi Claude Code ayarlarını,
başka projelere veya takım arkadaşlarına taşınabilir hale getirir.
```

Örnek plugin mantığı:

```text
my-claude-code-plugin/
├── commands/
│   ├── review-changes.md
│   ├── close-session.md
│   └── implement-step.md
├── agents/
│   ├── code-reviewer.md
│   ├── security-reviewer.md
│   └── test-engineer.md
├── skills/
│   ├── backend-api-design/
│   │   └── SKILL.md
│   └── rag-architecture/
│       └── SKILL.md
├── hooks/
│   ├── guard-bash.sh
│   └── post-edit-check.sh
└── README.md
```

Kendi rehberinde plugin’i şu şekilde açıklayabilirsin:

```text
Başlangıçta her projeye plugin yazmak şart değil.

Önce:
- CLAUDE.md
- PROJECT_CONTEXT.md
- SESSION_CONTEXT.md
- .claude/commands
- .claude/hooks
- .claude/rules

oturtulur.

Sonra aynı yapıları 3-4 projede tekrar kullanmaya başladıysan,
bunları plugin haline getirmek mantıklı olur.
```

## 11. Subagent Tanımlamaları: İşi Uzman Ajanlara Bölme

**Subagent**, Claude’un belirli bir işi daha uzman bir role devretmesi için kullanılan yapı gibi düşünülebilir.

Subagent özellikle şu durumlarda faydalıdır:

```text
- Kod inceleme
- Test yazma
- Güvenlik analizi
- RAG pipeline değerlendirme
- Frontend UI kontrolü
- Backend API tasarım kontrolü
- DevOps / deployment değerlendirmesi
- Dokümantasyon kalite kontrolü
```

Örnek subagent yapısı:

```text
.claude/agents/
├── code-reviewer.md
├── security-reviewer.md
├── test-engineer.md
├── backend-architect.md
├── mobile-architect.md
├── rag-engineer.md
└── documentation-maintainer.md
```

Örnek `code-reviewer.md`:

```md
# Code Reviewer Agent

## Role

You are a senior code reviewer.

## Responsibilities

- Review code for correctness, maintainability, readability, and security.
- Identify unnecessary complexity.
- Check whether the implementation follows CLAUDE.md.
- Check whether tests are needed.
- Avoid rewriting code unless explicitly asked.

## Review Checklist

1. Does the change solve the requested task?
2. Is the implementation minimal?
3. Are types and error handling sufficient?
4. Are there hidden side effects?
5. Are tests missing?
6. Is documentation affected?
7. Are there security or performance risks?

## Output Format

Return:

- Summary
- Issues found
- Suggested improvements
- Required fixes
- Optional improvements
```

Örnek `rag-engineer.md`:

```md
# RAG Engineer Agent

## Role

You are a RAG systems engineer focused on local, explainable, portfolio-quality AI systems.

## Responsibilities

- Review ingestion pipeline.
- Review chunking strategy.
- Review embedding model choice.
- Review vector database usage.
- Review retrieval quality.
- Review prompt construction.
- Review evaluation approach.

## Rules

- Prefer explicit, understandable RAG pipelines.
- Do not overuse frameworks.
- Keep MVP scope realistic.
- Make architecture decisions visible in ADR files.
- Consider local hardware limits.
```

Örnek `security-reviewer.md`:

```md
# Security Reviewer Agent

## Role

You are a security-focused reviewer.

## Responsibilities

- Detect secret leakage.
- Review authentication and authorization logic.
- Review unsafe shell commands.
- Review dependency risks.
- Review file upload and input validation paths.
- Review production deployment risks.

## Hard Rules

- Never print secrets.
- Never suggest bypassing security controls.
- Ask before destructive operations.
- Treat production credentials as highly sensitive.
```

Subagent kullanımı için Claude’a verilecek örnek prompt:

```text
Use the appropriate subagents to review the current implementation.

Required reviews:
- code-reviewer
- security-reviewer
- test-engineer
- documentation-maintainer

Do not modify code yet.

Return:
1. Findings by subagent
2. Required fixes
3. Optional improvements
4. Suggested next implementation step
```

---

## 12. Skills, MCP, Plugins ve Subagent’ları Mevcut Dosya Yapısına Ekleme

Mevcut önerdiğin yapıyı şu şekilde genişletebilirsin:

```text
project-root/
├── CLAUDE.md
├── PROJECT_CONTEXT.md
├── SESSION_CONTEXT.md
├── CHANGELOG.md
├── docs/
│   ├── OPEN_DECISIONS.md
│   ├── IMPLEMENTATION_STATE.md
│   └── ADR/
├── .claude/
│   ├── settings.json
│   ├── settings.local.json
│   ├── hooks/
│   │   ├── session-start.sh
│   │   ├── stop.sh
│   │   ├── guard-bash.sh
│   │   └── post-edit-check.sh
│   ├── commands/
│   │   ├── continue-session.md
│   │   ├── implement-step.md
│   │   ├── review-changes.md
│   │   ├── close-session.md
│   │   └── create-context.md
│   ├── agents/
│   │   ├── code-reviewer.md
│   │   ├── security-reviewer.md
│   │   ├── test-engineer.md
│   │   ├── backend-architect.md
│   │   ├── mobile-architect.md
│   │   └── rag-engineer.md
│   ├── skills/
│   │   ├── code-review/
│   │   │   └── SKILL.md
│   │   ├── security-review/
│   │   │   └── SKILL.md
│   │   ├── rag-architecture/
│   │   │   └── SKILL.md
│   │   └── documentation/
│   │       └── SKILL.md
│   └── rules/
│       ├── security.md
│       ├── testing.md
│       ├── documentation.md
│       ├── frontend.md
│       ├── backend.md
│       └── ai-rag.md
```

---

## 13. CLAUDE.md İçine Bu Yapılar Nasıl Yazılmalı?

`CLAUDE.md` dosyasını şişirmemek için bütün agent, skill ve MCP detaylarını içine gömmemek gerekir. Bunun yerine `CLAUDE.md` sadece yönlendirici olmalı.

Eklenebilecek bölüm:

```md
## Claude Code Extensions

This project may use Claude Code extensions such as commands, hooks, rules, skills, subagents, MCP servers, and plugins.

### Commands

Reusable workflows are stored in:

- .claude/commands/

Use commands for repeated workflows such as:

- continuing a session
- implementing a specific step
- reviewing changes
- closing a session

### Hooks

Automation and safety checks are stored in:

- .claude/hooks/

Hooks may be used for:

- session start context loading
- stop-time session summary
- dangerous bash command prevention
- post-edit lint/test suggestions

### Rules

Project-specific rules are stored in:

- .claude/rules/

Use these rules when working in relevant parts of the codebase.

### Skills

Reusable expertise packs are stored in:

- .claude/skills/

Use skills when a task requires a specific methodology, such as:

- code review
- security review
- RAG architecture
- documentation writing
- mobile architecture

### Subagents

Specialized agents are stored in:

- .claude/agents/

Use subagents for focused review or implementation support.

Examples:

- code-reviewer
- security-reviewer
- test-engineer
- backend-architect
- mobile-architect
- rag-engineer
- documentation-maintainer

### MCP Servers

Use MCP servers only when repository context is not enough.

MCP servers may provide access to:

- GitHub
- Linear / Jira
- Notion
- Figma
- databases
- monitoring tools
- cloud providers

Rules:

- Prefer read-only access by default.
- Ask before write operations.
- Never expose secrets.
- Summarize external context used.
```

---
