<p align="center">
  <img src="https://cdn.simpleicons.org/claude/000000" width="120" height="120" alt="Claude logosu">
</p>

<h1 align="center">Claude Code Operating System</h1>

<p align="center">
  <a href="./LICENSE"><img alt="Lisans: MIT" src="https://img.shields.io/badge/License-MIT-2ea44f?style=flat-square"></a>
  <a href="./README.md"><img alt="Dil: İngilizce ve Türkçe" src="https://img.shields.io/badge/Language-EN%20%2F%20TR-1f6feb?style=flat-square"></a>
  <img alt="Claude Code" src="https://img.shields.io/badge/Built%20for-Claude%20Code-000000?style=flat-square">
  <img alt="Şablonlar dahil" src="https://img.shields.io/badge/Templates-Included-6f42c1?style=flat-square">
  <img alt="AI ajan hazır" src="https://img.shields.io/badge/AI%20Agents-Ready-ff7b72?style=flat-square">
</p>

<p align="center">
  Uzun soluklu Claude Code projeleri için pratik bir repo işletim modeli.
  <br>
  <a href="./README.md">English README</a> | <a href="./CLAUDE-CODE-OPERATING-GUIDE.tr.md">Tam rehber</a> | <a href="./templates/claude-code-os">Şablonlar</a> | <a href="./docs/OPERATING-MODEL.tr.md">İşletim modeli</a>
</p>

> [!NOTE]
> Claude Code tarafındaki hooks, skills, plugins, MCP server’ları ve subagent’lar gibi özellikler zaman içinde değişebilir. Bu nedenle, bu repoyu periyodik olarak gözden geçirilmesi gereken yaşayan bir işletim modeli olarak düşünün.

## Bu repository neden var?

Modern yapay zekâ destekli geliştirme süreçleri, prompt tabanlı kodlamadan kalıcı yapay zekâ işletim sistemlerine evriliyor. Bu repository, Claude Code gibi yapay zekâ kodlama ajanları için uzun soluklu yazılım projelerinin nasıl yapılandırılabileceğini araştırıyor.

Yani amaç, her oturumda aynı proje bağlamını tekrar tekrar anlatmak yerine, repoya kalıcı bir yapay zeka işletim katmanı kazandırmak. Bu katman; talimatlardan, proje bağlamından, oturum notlarından, custom command’lardan, hook’lardan, kurallardan, skill’lerden, subagent’lardan ve dış sistem entegrasyonlarından oluşur.

## Ana fikir

Claude Code en verimli haline, repo kendi çalışma düzenini açıkladığında yaklaşır.

Temel ayrım şu şekilde kurulabilir:

| Dosya veya klasör | Amaç |
| --- | --- |
| `CLAUDE.md` | Claude Code’un bu projedeki kalıcı davranış kuralları |
| `PROJECT_CONTEXT.md` | Kalıcı ürün, mimari ve domain bağlamı |
| `SESSION_CONTEXT.md` | Son oturumdan kalan geçici devam notları |
| `docs/OPEN_DECISIONS.md` | Netleşmemiş kararlar |
| `docs/IMPLEMENTATION_STATE.md` | Biten, devam eden ve sıradaki işler |
| `.claude/commands/` | Tekrar kullanılabilir slash-command workflow’ları |
| `.claude/hooks/` | Otomatik yaşam döngüsü, güvenlik ve kalite kontrolleri |
| `.claude/rules/` | Teknolojiye veya klasöre özel kurallar |
| `.claude/agents/` | Uzman subagent rol tanımları |
| `.claude/skills/` | Tekrar kullanılabilir uzmanlık paketleri |
| MCP servers | Dış sistemlere kontrollü erişim |
| Plugins | Commands, hooks, skills, agents ve MCP ayarlarını taşınabilir paket haline getirme |

## Önerilen ilerleme sırası

Küçük başlayın. Yapıyı, gerçek bir devam ettirme veya kalite problemi çözdürdüğü ölçüde genişletin.

```text
1. Manuel prompt veya /init
2. CLAUDE.md
3. PROJECT_CONTEXT.md ve SESSION_CONTEXT.md
4. Custom commands
5. Hooks
6. Rules
7. Skills
8. Subagents
9. MCP servers
10. Plugins
```

## Hızlı başlangıç

Başlangıç şablonunu yeni veya mevcut bir projeye kopyalayın:

```bash
cp -R templates/claude-code-os/. /path/to/your-project/
```

Sonra Claude Code’a şunu söyleyin:

```text
Create or update the Claude Code operating structure for this repository.

Before writing anything:
1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and architecture.
6. Do not modify application code.

Update the Claude Code operating files so this project can continue across multiple sessions with minimal repeated explanation.
Keep CLAUDE.md concise and put temporary state in SESSION_CONTEXT.md.
```

## Repo içeriği

```text
.
|-- CLAUDE-CODE-OPERATING-GUIDE.md
|-- CLAUDE-CODE-OPERATING-GUIDE.tr.md
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- LICENSE
|-- README.md
|-- README.tr.md
|-- SECURITY.md
|-- docs/
|   |-- OPERATING-MODEL.md
|   `-- OPERATING-MODEL.tr.md
|-- examples/
|   `-- starter-layout/
`-- templates/
    `-- claude-code-os/
        |-- CLAUDE.md
        |-- PROJECT_CONTEXT.md
        |-- SESSION_CONTEXT.md
        |-- CHANGELOG.md
        |-- docs/
        `-- .claude/
```

## Ne nereye konur?

| İhtiyaç | Konum |
| --- | --- |
| Claude’un her zaman uyması gereken kural | `CLAUDE.md` |
| Kalıcı mimari veya ürün bilgisi | `PROJECT_CONTEXT.md` |
| Son yarım kalan oturumdan devam notu | `SESSION_CONTEXT.md` |
| Tekrarlanan manuel workflow | `.claude/commands/` |
| Otomatik güvenlik veya kalite kontrolü | `.claude/hooks/` |
| Belirli teknoloji veya klasör için kural | `.claude/rules/` |
| Tekrar kullanılabilir yöntem veya uzmanlık | `.claude/skills/` |
| Uzman role devredilecek iş | `.claude/agents/` |
| Dış proje verisi | MCP server |
| Birden çok projeye taşınacak paket | Plugin |

## Şablonun içerdikleri

- Şişmeyen, okunabilir bir `CLAUDE.md`.
- Kalıcı proje bağlamı ile geçici oturum notlarını ayıran dosyalar.
- Session start ve stop hook örnekleri.
- Riskli komutlar ve secret dosyaları için Bash guard örnekleri.
- `continue-session`, `implement-step`, `review-changes`, `close-session` gibi tekrar kullanılabilir command prompt’ları.
- Code review, security review ve documentation maintenance için subagent rol örnekleri.
- Test, güvenlik ve dokümantasyon güncelleme kuralları.

## Tasarım prensipleri

- Talimatları her oturumda okunabilecek kadar kısa tut.
- Kalıcı proje bilgisini geçici oturum bilgisinden ayır.
- Büyük yeniden yazımlar yerine küçük ve incelenebilir değişiklikleri tercih et.
- Netleşmemiş kararları görünür yap; ajanın sessizce tahmin etmesine izin verme.
- Hooks otomatik kontroller için, commands tekrar eden workflow’lar için, skills uzmanlık için, agents ise uzman rol denetimi için kullanılır.
- MCP server’ları yalnızca repo dosyaları yeterli olmadığında ekle.
- Plugin’e ancak aynı yapı birden fazla projede kendini kanıtladığında geç.

## İlgili dokümanlar

- [Operating model](./docs/OPERATING-MODEL.md)
- [Tam Claude Code çalışma mimarisi rehberi](./CLAUDE-CODE-OPERATING-GUIDE.tr.md)
- [İngilizce tam rehber](./CLAUDE-CODE-OPERATING-GUIDE.md)
- [Türkçe işletim modeli](./docs/OPERATING-MODEL.tr.md)
- [Starter layout örneği](./examples/starter-layout/README.md)
- [Şablon paketi](./templates/claude-code-os)

## Yasal not

Bu proje bağımsız bir topluluk rehberidir. Anthropic veya Claude ile resmi bir bağlantısı yoktur. Claude ve Claude Code ilgili sahiplerinin markalarıdır.

## Lisans

MIT. Bkz. [LICENSE](./LICENSE).
