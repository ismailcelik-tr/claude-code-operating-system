# Claude Code Isletim Modeli

Bu dokuman, README'deki kisa anlatimi uzun soluklu Claude Code projeleri icin uygulanabilir bir isletim modeline donusturur.

## 1. Problem

AI coding oturumlari genellikle basit nedenlerle zorlasir:

- Ajan mevcut proje durumunu bilmez.
- Gecici kararlar kalici mimariyle karisir.
- Ayni kurulum, test ve guvenlik kurallari elle tekrar edilir.
- Uzun soluklu islerde oturumlar arasi devam baglami kaybolur.
- Issue, dokuman, monitoring gibi dis baglamlar ya gec baglanir ya da fazla genis yetkiyle baglanir.

Bu repodaki isletim modeli, her baglam turune net bir ev verir.

## 2. Temel dosyalar

### `CLAUDE.md`

`CLAUDE.md`, kalici davranis kurallari icindir.

Uygun icerikler:

- Proje calisma tarzi
- Build, test ve lint beklentileri
- Mimari sinirlar
- Git workflow kurallari
- Guvenlik kurallari
- Dokumantasyon guncelleme kurallari

Kacinilmasi gerekenler:

- Gecici gorev notlari
- Uzun issue dokumleri
- Ham toplanti notlari
- Surekli degisen implementasyon durumu

Bu dosya sik okunacak kadar kisa kalmalidir.

### `PROJECT_CONTEXT.md`

`PROJECT_CONTEXT.md`, kalici proje bilgisi icindir.

Uygun icerikler:

- Urun amaci
- Hedef kullanicilar
- Domain dili
- Mimari ozet
- Onemli kisitlar
- Non-goals
- Entegrasyon haritasi

Bu dosya yavas degismelidir.

### `SESSION_CONTEXT.md`

`SESSION_CONTEXT.md`, devam baglami icindir.

Uygun icerikler:

- Son tamamlanan is
- Mevcut branch
- Son dokunulan dosyalar
- Calistirilan komutlar
- Test ve lint durumu
- Bilinen sorunlar
- Siradaki onerilen adim

Bu dosya sik degisir ve oturum kapanirken tazelenmelidir.

## 3. Commands, hooks, rules, skills ve agents

| Katman | Ne icin kullanilir? | Ornek |
| --- | --- | --- |
| Custom command | Tekrarlanan manuel workflow | `/continue-session` |
| Hook | Otomatik yasam dongusu veya guvenlik kontrolu | Riskli Bash komutlarini engelleme |
| Rule | Teknolojiye veya klasore ozel kisit | Frontend accessibility kurallari |
| Skill | Tekrar kullanilabilir yontem veya uzmanlik | RAG mimari incelemesi |
| Subagent | Uzman inceleme veya implementasyon rolu | Security reviewer |

## 4. Hooks

Hooks, unutulmasi kolay kontrolleri otomatiklestirmelidir.

Onerilen `SessionStart` kontrolleri:

- Mevcut branch'i goster.
- Commit edilmemis degisiklikleri goster.
- Proje ve oturum baglami dosyalarini oku.
- Acik kararlari goster.
- Paket yoneticisini ve mevcut komutlari tespit et.

Onerilen `Stop` kontrolleri:

- Istenen isin tamamlanip tamamlanmadigini kontrol et.
- Calistirilan test veya lint komutlarini kaydet.
- Session context'i guncelle.
- Implementation state'i guncelle.
- Commit edilmemis degisiklikler icin uyar.

Onerilen `PreToolUse` kontrolleri:

- Yikici komutlari engelle veya onay iste.
- `.env` ve credential dosyalarinin yanlislikla okunmasini engelle.
- Production deploy, database reset veya migration komutlarinda onay iste.

Onerilen `PostToolUse` kontrolleri:

- Kaynak kod degisikliklerinden sonra lint veya typecheck oner.
- Public davranis degisikliklerinden sonra docs guncellemesi oner.
- Feature islerinden sonra implementation state guncellemesi oner.

## 5. MCP servers

MCP server'lari repo dosyalari yeterli olmadiginda kullanin.

Uygun adaylar:

- GitHub issues ve pull requests
- Linear veya Jira task'lari
- Notion urun dokumanlari
- Sentry hatalari
- Database inceleme
- Figma tasarim dosyalari

Varsayilan yaklasim:

- Read-only erisimi tercih et.
- Write access'i yalnizca workflow gercekten gerektiriyorsa ekle.
- Secret veya private customer data aciga cikarma.
- Degisiklik yapmadan once hangi dis baglamin kullanildigini ozetle.

## 6. Plugins

Plugin yazarak baslamayin.

Once repo seviyesinde su dosya ve klasorleri oturtun:

- `CLAUDE.md`
- `PROJECT_CONTEXT.md`
- `SESSION_CONTEXT.md`
- `.claude/commands`
- `.claude/hooks`
- `.claude/rules`
- `.claude/agents`
- `.claude/skills`

Ayni yapi birkac repoda faydasini kanitladiginda plugin olarak paketleyin.

## 7. Pratik kurulum sirasi

Yeni bir proje icin su sirayi kullanin:

1. Claude Code'dan application code'a dokunmadan repoyu incelemesini isteyin.
2. Temel context dosyalarini olusturun.
3. Yalnizca gercekten kullanacaginiz command'lari ekleyin.
4. Productivity hook'larindan once safety hook'larini ekleyin.
5. Gercek proje konvansiyonlari icin rules ekleyin.
6. Review workflow'lari icin agents ekleyin.
7. Tekrar kullanilabilir uzmanliklar icin skills ekleyin.
8. Dis baglam icin MCP server'lari ekleyin.
9. Tekrarlanan kurulumlari plugin'e donusturun.

## 8. Bakim dongusu

Anlamli oturumlarin sonunda:

1. `SESSION_CONTEXT.md` guncelle.
2. `docs/IMPLEMENTATION_STATE.md` guncelle.
3. Kararlar degistiyse `docs/OPEN_DECISIONS.md` guncelle.
4. Kullaniciya gorunen davranis degistiyse user-facing docs guncelle.
5. Hangi kontrollerin calistirildigini kaydet.
6. Kucuk ve incelenebilir commit'ler olustur.
