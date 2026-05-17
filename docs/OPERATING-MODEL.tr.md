# Claude Code İşletim Modeli

Bu doküman, README’deki kısa anlatımı uzun soluklu Claude Code projeleri için uygulanabilir bir işletim modeline dönüştürür.

## 1. Problem

AI coding oturumları genellikle basit nedenlerle zorlaşır:

- Ajan mevcut proje durumunu bilmez.
- Geçici kararlar kalıcı mimariyle karışır.
- Aynı kurulum, test ve güvenlik kuralları elle tekrar edilir.
- Uzun soluklu işlerde oturumlar arası devam bağlamı kaybolur.
- Issue, doküman, monitoring gibi dış bağlamlar ya geç bağlanır ya da fazla geniş yetkiyle bağlanır.

Bu repodaki işletim modeli, her bağlam türüne net bir ev verir.

## 2. Temel dosyalar

### `CLAUDE.md`

`CLAUDE.md`, kalıcı davranış kuralları içindir.

Uygun içerikler:

- Proje çalışma tarzı
- Build, test ve lint beklentileri
- Mimari sınırlar
- Git workflow kuralları
- Güvenlik kuralları
- Dokümantasyon güncelleme kuralları

Kaçınılması gerekenler:

- Geçici görev notları
- Uzun issue dökümleri
- Ham toplantı notları
- Sürekli değişen implementasyon durumu

Bu dosya sık okunacak kadar kısa kalmalıdır.

### `PROJECT_CONTEXT.md`

`PROJECT_CONTEXT.md`, kalıcı proje bilgisi içindir.

Uygun içerikler:

- Ürün amacı
- Hedef kullanıcılar
- Domain dili
- Mimari özet
- Önemli kısıtlar
- Non-goals
- Entegrasyon haritası

Bu dosya yavaş değişmelidir.

### `SESSION_CONTEXT.md`

`SESSION_CONTEXT.md`, devam bağlamı içindir.

Uygun içerikler:

- Son tamamlanan iş
- Mevcut branch
- Son dokunulan dosyalar
- Çalıştırılan komutlar
- Test ve lint durumu
- Bilinen sorunlar
- Sıradaki önerilen adım

Bu dosya sık değişir ve oturum kapanırken tazelenmelidir.

## 3. Commands, hooks, rules, skills ve agents

| Katman | Ne için kullanılır? | Örnek |
| --- | --- | --- |
| Custom command | Tekrarlanan manuel workflow | `/continue-session` |
| Hook | Otomatik yaşam döngüsü veya güvenlik kontrolü | Riskli Bash komutlarını engelleme |
| Rule | Teknolojiye veya klasöre özel kısıt | Frontend accessibility kuralları |
| Skill | Tekrar kullanılabilir yöntem veya uzmanlık | RAG mimari incelemesi |
| Subagent | Uzman inceleme veya implementasyon rolü | Security reviewer |

## 4. Hooks

Hooks, unutulması kolay kontrolleri otomatikleştirmelidir.

Önerilen `SessionStart` kontrolleri:

- Mevcut branch’i göster.
- Commit edilmemiş değişiklikleri göster.
- Proje ve oturum bağlamı dosyalarını oku.
- Açık kararları göster.
- Paket yöneticisini ve mevcut komutları tespit et.

Önerilen `Stop` kontrolleri:

- İstenen işin tamamlanıp tamamlanmadığını kontrol et.
- Çalıştırılan test veya lint komutlarını kaydet.
- Session context’i güncelle.
- Implementation state’i güncelle.
- Commit edilmemiş değişiklikler için uyar.

Önerilen `PreToolUse` kontrolleri:

- Yıkıcı komutları engelle veya onay iste.
- `.env` ve credential dosyalarının yanlışlıkla okunmasını engelle.
- Production deploy, database reset veya migration komutlarında onay iste.

Önerilen `PostToolUse` kontrolleri:

- Kaynak kod değişikliklerinden sonra lint veya typecheck öner.
- Public davranış değişikliklerinden sonra docs güncellemesi öner.
- Feature işlerinden sonra implementation state güncellemesi öner.

## 5. MCP servers

MCP server’ları repo dosyaları yeterli olmadığında kullanın.

Uygun adaylar:

- GitHub issues ve pull requests
- Linear veya Jira task’ları
- Notion ürün dokümanları
- Sentry hataları
- Database inceleme
- Figma tasarım dosyaları

Varsayılan yaklaşım:

- Read-only erişimi tercih et.
- Write access’i yalnızca workflow gerçekten gerektiriyorsa ekle.
- Secret veya private customer data açığa çıkarma.
- Değişiklik yapmadan önce hangi dış bağlamın kullanıldığını özetle.

## 6. Plugins

Plugin yazarak başlamayın.

Önce repo seviyesinde şu dosya ve klasörleri oturtun:

- `CLAUDE.md`
- `PROJECT_CONTEXT.md`
- `SESSION_CONTEXT.md`
- `.claude/commands`
- `.claude/hooks`
- `.claude/rules`
- `.claude/agents`
- `.claude/skills`

Aynı yapı birkaç repoda faydasını kanıtladığında plugin olarak paketleyin.

## 7. Pratik kurulum sırası

Yeni bir proje için şu sırayı kullanın:

1. Claude Code’dan application code’a dokunmadan repoyu incelemesini isteyin.
2. Temel context dosyalarını oluşturun.
3. Yalnızca gerçekten kullanacağınız command’ları ekleyin.
4. Productivity hook’larından önce safety hook’larını ekleyin.
5. Gerçek proje konvansiyonları için rules ekleyin.
6. Review workflow’ları için agents ekleyin.
7. Tekrar kullanılabilir uzmanlıklar için skills ekleyin.
8. Dış bağlam için MCP server’ları ekleyin.
9. Tekrarlanan kurulumları plugin’e dönüştürün.

## 8. Bakım döngüsü

Anlamlı oturumların sonunda:

1. `SESSION_CONTEXT.md` güncelle.
2. `docs/IMPLEMENTATION_STATE.md` güncelle.
3. Kararlar değiştiyse `docs/OPEN_DECISIONS.md` güncelle.
4. Kullanıcıya görünen davranış değiştiyse user-facing docs güncelle.
5. Hangi kontrollerin çalıştırıldığını kaydet.
6. Küçük ve incelenebilir commit’ler oluştur.
