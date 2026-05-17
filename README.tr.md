<p align="center">
  <img src="https://cdn.simpleicons.org/claude/000000" width="120" height="120" alt="Claude logosu">
</p>

<h1 align="center">Claude Code Operating System</h1>

<p align="center">
  <a href="./LICENSE"><img alt="Lisans: MIT" src="https://img.shields.io/badge/License-MIT-2ea44f?style=flat-square"></a>
  <a href="./README.md"><img alt="Dil: Ingilizce ve Turkce" src="https://img.shields.io/badge/Language-EN%20%2F%20TR-1f6feb?style=flat-square"></a>
  <img alt="Claude Code" src="https://img.shields.io/badge/Built%20for-Claude%20Code-000000?style=flat-square">
  <img alt="Sablonlar dahil" src="https://img.shields.io/badge/Templates-Included-6f42c1?style=flat-square">
  <img alt="AI ajan hazir" src="https://img.shields.io/badge/AI%20Agents-Ready-ff7b72?style=flat-square">
</p>

<p align="center">
  Uzun soluklu Claude Code projeleri icin pratik bir repo isletim modeli.
  <br>
  <a href="./README.md">English README</a> | <a href="./templates/claude-code-os">Sablonlar</a> | <a href="./docs/OPERATING-MODEL.tr.md">Isletim modeli</a>
</p>

> [!NOTE]
> Claude Code tarafindaki hooks, skills, plugins, MCP servers ve subagents gibi ozellikler zamanla degisebilir. Bu repoyu, periyodik olarak gozden gecirilmesi gereken bir isletim modeli olarak dusunun.

## Bu repository neden var?

Modern AI-assisted development is shifting from:
- prompt-based coding
to:
- persistent AI operating systems

This repository explores how to structure long-running software projects for AI coding agents such as Claude Code.

Yani amac, her oturumda ayni proje baglamini tekrar tekrar anlatmak yerine, repoya kalici bir yapay zeka isletim katmani kazandirmak. Bu katman; talimatlardan, proje baglamindan, oturum notlarindan, custom command'lardan, hook'lardan, kurallardan, skill'lerden, subagent'lardan ve dis sistem entegrasyonlarindan olusur.

## Ana fikir

Claude Code en verimli haline, repo kendi calisma duzenini acikladiginda yaklasir.

Temel ayrim su sekilde kurulabilir:

| Dosya veya klasor | Amac |
| --- | --- |
| `CLAUDE.md` | Claude Code'un bu projedeki kalici davranis kurallari |
| `PROJECT_CONTEXT.md` | Kalici urun, mimari ve domain baglami |
| `SESSION_CONTEXT.md` | Son oturumdan kalan gecici devam notlari |
| `docs/OPEN_DECISIONS.md` | Netlesmemis kararlar |
| `docs/IMPLEMENTATION_STATE.md` | Biten, devam eden ve siradaki isler |
| `.claude/commands/` | Tekrar kullanilabilir slash-command workflow'lari |
| `.claude/hooks/` | Otomatik yasam dongusu, guvenlik ve kalite kontrolleri |
| `.claude/rules/` | Teknolojiye veya klasore ozel kurallar |
| `.claude/agents/` | Uzman subagent rol tanimlari |
| `.claude/skills/` | Tekrar kullanilabilir uzmanlik paketleri |
| MCP servers | Dis sistemlere kontrollu erisim |
| Plugins | Commands, hooks, skills, agents ve MCP ayarlarini tasinabilir paket haline getirme |

## Onerilen ilerleme sirasi

Kucuk baslayin. Yapiyi, gercek bir devam ettirme veya kalite problemi cozdurdugu olcude genisletin.

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

## Hizli baslangic

Baslangic sablonunu yeni veya mevcut bir projeye kopyalayin:

```bash
cp -R templates/claude-code-os/. /path/to/your-project/
```

Sonra Claude Code'a sunu soyleyin:

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

## Repo icerigi

```text
.
|-- README.md
|-- README.tr.md
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
        |-- docs/
        `-- .claude/
```

## Ne nereye konur?

| Ihtiyac | Konum |
| --- | --- |
| Claude'un her zaman uymasi gereken kural | `CLAUDE.md` |
| Kalici mimari veya urun bilgisi | `PROJECT_CONTEXT.md` |
| Son yarim kalan oturumdan devam notu | `SESSION_CONTEXT.md` |
| Tekrarlanan manuel workflow | `.claude/commands/` |
| Otomatik guvenlik veya kalite kontrolu | `.claude/hooks/` |
| Belirli teknoloji veya klasor icin kural | `.claude/rules/` |
| Tekrar kullanilabilir yontem veya uzmanlik | `.claude/skills/` |
| Uzman role devredilecek is | `.claude/agents/` |
| Dis proje verisi | MCP server |
| Birden cok projeye tasinacak paket | Plugin |

## Sablonun icerdikleri

- Sismeyen, okunabilir bir `CLAUDE.md`.
- Kalici proje baglami ile gecici oturum notlarini ayiran dosyalar.
- Session start ve stop hook ornekleri.
- Riskli komutlar ve secret dosyalari icin Bash guard ornekleri.
- `continue-session`, `implement-step`, `review-changes`, `close-session` gibi tekrar kullanilabilir command prompt'lari.
- Code review, security review ve documentation maintenance icin subagent rol ornekleri.
- Test, guvenlik ve dokumantasyon guncelleme kurallari.

## Tasarim prensipleri

- Talimatlari her oturumda okunabilecek kadar kisa tut.
- Kalici proje bilgisini gecici oturum bilgisinden ayir.
- Buyuk yeniden yazimlar yerine kucuk ve incelenebilir degisiklikleri tercih et.
- Netlesmemis kararlari gorunur yap; ajanin sessizce tahmin etmesine izin verme.
- Hooks otomatik kontroller icin, commands tekrar eden workflow'lar icin, skills uzmanlik icin, agents ise uzman rol denetimi icin kullanilir.
- MCP server'lari yalnizca repo dosyalari yeterli olmadiginda ekle.
- Plugin'e ancak ayni yapi birden fazla projede kendini kanitladiginda gec.

## Ilgili dokumanlar

- [Operating model](./docs/OPERATING-MODEL.md)
- [Turkce isletim modeli](./docs/OPERATING-MODEL.tr.md)
- [Starter layout ornegi](./examples/starter-layout/README.md)
- [Sablon paketi](./templates/claude-code-os)

## Yasal not

Bu proje bagimsiz bir topluluk rehberidir. Anthropic veya Claude ile resmi bir baglantisi yoktur. Claude ve Claude Code ilgili sahiplerinin markalaridir.

## Lisans

MIT. Bkz. [LICENSE](./LICENSE).
