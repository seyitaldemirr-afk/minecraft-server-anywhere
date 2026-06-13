# Minecraft Server Anywhere — Ücretsiz, Kendi Sunucun, Port Yönlendirmeden

**Türkçe** · [🇬🇧 English](README.md)

> Ücretli hosting kalitesi, sıfır maliyetle, elinde zaten olan bir cihazda.

Gerçek bir Minecraft sunucusu — mod desteğiyle, kalıcı dünyayla, her zaman açık, her yerden erişilebilir — statik IP olmadan, modemi kurcalamadan, aylık ücret ödemeden.

---

## 30 Saniyede Ne Elde Ediyorsun

- Elinde zaten olan bir cihazda çalışan, **gerçek bir Fabric sunucusu** (plugin hilesiz) — performans modlarıyla birlikte.
- [playit.gg](https://playit.gg) tüneli sayesinde **dünyanın her yerinden erişilebilir** — port yönlendirmesi yok, statik IP yok, modem ayarı yok.
- **Sıfır dokunuşlu otonomi**: yeniden başlatma veya çökmede sunucu ve tünel otomatik olarak ayağa kalkar — insan müdahalesi gerekmez.
- **₺0 maliyet**: yığındaki her yazılım ücretsiz ve açık kaynak.

---

## Bu Senin İçin mi?

**Şunlardan biriysen uygun:**
- Prize takılı bırakabileceğin atıl bir cihazın var — eski bir telefon, mini PC, Raspberry Pi ya da yedek bir laptop.
- Arkadaşların veya ailen için küçük bir sunucu istiyorsun (birkaç oyuncu).
- Gerçek mod desteği ve kalıcı bir dünya istiyorsun; sıfır maliyetle, modemi kurcalamadan.
- Teknik bir rehberi takip etmekten rahatsız değilsin — ya da repoyu senin yerine onu izleyen bir yapay zeka ajanına veriyorsun.

**Muhtemelen senin için değil, eğer:**
- Aynı anda onlarca oyuncu için büyük, herkese açık bir sunucu gerekiyorsa — eski telefon ~3 oyuncuda tıkanır; bu, ölçek için değil küçük gruplar için tasarlandı.
- Hiçbir teknik adım ve kurulum olmadan tek tıkla hosting istiyorsan.
- Garantili 7/24 kurumsal kesintisizlik veya SLA gerekiyorsa — bu, ev donanımı ve ev internet bağlantısıyla çalışır.

---

## Neden Alternatiflerden Daha İyi

| | Ücretsiz hostlar (Aternos…) | Ücretli hosting | Normal öz-barındırma | **Bu proje** |
|---|---|---|---|---|
| **Maliyet** | Ücretsiz | 100–300 ₺ / ay | Ücretsiz | **₺0** |
| **Sunucu boştayken uyuyor mu?** | Evet — oyuncu bekleyene kadar uyur | Hayır | Hayır | **Hayır** |
| **Port yönlendirme / statik IP gerekli mi?** | Hayır | Hayır | Evet | **Hayır** |
| **Kendi verini, kendi cihazını kullanıyor musun?** | Hayır — başkasının sunucusu | Hayır | Evet | **Evet** |
| **Gerçek mod desteği (Fabric/Forge)** | Kısıtlı | Evet | Evet | **Evet** |

Ücretsiz hostlar uyuyor, modları kısıtlıyor ve kontrolün dışında. Ücretli hosting her ay para istiyor. Normal öz-barındırma çoğu ISP'nin ücretsiz vermediği statik IP ve modem erişimi gerektiriyor. Bu proje üçünü birden çözüyor.

---

## Her Yerde Çalışır — Telefon En Zor Durum

Referans uygulama **ekranı kırık bir Samsung Galaxy S9** üzerinde çalışıyor — Android 10, root yok, sıkışık RAM, agresif pil yönetimi, fiziksel etkileşim imkansız. Tarif burada çalışıyorsa, diğer tüm hedeflerde çok daha kolay:

| Hedef | Telefona kıyasla zorluk |
|---|---|
| Eski laptop / masaüstü | Daha az: RAM baskısı yok, pil yönetimi yok, CPU kümesi pinleme yok |
| Mini PC / NUC | Daha az: aynısı, genellikle başsız erişim dostu |
| Raspberry Pi | Biraz farklı: ARM, Debian, Android'e özgü adımlar yok |
| Android telefon (ekranı çalışıyor) | Aynı kategori; kurulum daha kolay |

**Bu bir telefon reposu değil.** Telefon vakası en zor test senaryosudur. Tarifi oku, kendi ortamına uyarla, aynı dört doğrulama kapısından geç — bitti.

### Yapay Zeka Ajanıyla Kurulum

Repoyu bir yapay zeka ajanına ver, ortamını anlat ve senin için kurulum yolunu türetsin. Tam orkestrasyon sözleşmesi — gereksinim toplama protokolü, karar otoritesi ve bir ajanın "tamam" demeden önce geçmesi gereken dört kapı — için bkz. [`AGENTS.md`](AGENTS.md).

---

## Kanıt — Gerçek Cihaz, Teori Değil

Samsung Galaxy S9 (SM-G960F), Android 10 üzerinde ölçüldü. Yığın: Fabric 1.21.1 (loader 0.19.3), OpenJDK 21, 6 sunucu tarafı performans modu (lithium, ferritecore, krypton, modernfix, scalablelux, noisium), playit.gg tüneli.

| Ölçüm | Sonuç |
|---|---|
| İlk açılış `Done (Xs)!` | **19.565 s** (dünya oluşturma dahil) |
| Boşta TPS / tick medyanı | **20.0 TPS** · **4.2 ms** medyan (95. yüzdelik: 7.8 ms) |
| Yeniden başlatma → sunucu açık (sıfır dokunuş) | **~114 s** |
| Çökme → otomatik kurtarma | **~30 s** |
| Dış erişim (mcstatus, playit üzerinden) | **OK** — Java 1.21.1, 0/3, ping ~200 ms |
| Sunucu çalışırken boş RAM | **786 MB** (hedef: >600 MB — sağlandı) |

Ham loglar ve tam ölçüm panosu: [`reference-s9/kanit/olcum-panosu.md`](reference-s9/kanit/olcum-panosu.md) ve [`reference-s9/kanit/raw/`](reference-s9/kanit/raw/).

---

## Kurulum Dizini

`method/` rehberlerini sırayla izle. Her adımın, bir sonrakine geçmeden önce tamamlandığını kanıtlayan bir kapısı var. `reference-s9/` Galaxy S9 için tamamlanmış örnektir — yönelim için kullan, kopyala-yapıştır tarifiymiş gibi değil.

| Adım | Rehber | Kanıtı |
|---|---|---|
| 0 — Hedefler ve kabul kriterleri | [`method/00-hedefler.md`](method/00-hedefler.md) | (oku; "bitti" ne demek onu tanımlar) |
| 1 — Karar çerçevesi | [`method/01-karar-cercevesi.md`](method/01-karar-cercevesi.md) | (oku; ortamına özgü yolu şekillendirir) |
| 2 — Erişim yöntemleri | [`method/02-erisim-yontemleri.md`](method/02-erisim-yontemleri.md) | [`gates/erisim.md`](gates/erisim.md) |
| 3 — Tünel yöntemleri (playit / alternatifler) | [`method/03-tunel-yontemleri.md`](method/03-tunel-yontemleri.md) | [`gates/erisim.md`](gates/erisim.md) |
| 4 — Otonomi deseni | [`method/04-otonomi-deseni.md`](method/04-otonomi-deseni.md) | [`gates/otonomi.md`](gates/otonomi.md) |
| 5 — Veri kalıcılığı | [`method/05-veri-kaliciligi.md`](method/05-veri-kaliciligi.md) | [`gates/saglik.md`](gates/saglik.md) |
| 6 — Uyarlama rehberi (kendi ortamın) | [`method/06-uyarlama-rehberi.md`](method/06-uyarlama-rehberi.md) | Dört kapının tamamı |
| Doğrulama kapıları (tüm ortamlar) | [`gates/`](gates/) | [`gates/saglik.md`](gates/saglik.md) · [`gates/otonomi.md`](gates/otonomi.md) · [`gates/erisim.md`](gates/erisim.md) · [`gates/modlar.md`](gates/modlar.md) |

Dört kapının tamamı geçmeden "tamam" deme.

---

## Yığın Özeti

- **Minecraft sunucusu**: Fabric 1.21.1 · loader 0.19.3
- **Çalışma zamanı**: OpenJDK 21
- **Performans modları**: lithium, ferritecore, krypton, modernfix, scalablelux, noisium
- **Tünel**: [playit.gg](https://playit.gg) (kalıcı adres, modem ayarı yok, ücretsiz katman)
- **Termux** (yalnızca Android): telefonda Linux kabuk ortamını sağlar
- **ADB + scrcpy** (yalnızca Android): kontrol PC'sinden başsız erişim

---

## Dürüst Sınırlar (Root Yok)

Bu tarif root gerektirmez. Bilinmesi gereken iki uç durum:

1. **Uzun süreli güç kesintisi**: Pil tamamen boşalır ve telefon kapanırsa, şarj takıldığında otomatik açılmaz. Bir güç tuşuna basmak yeterlidir. Sürekli güçte bu durum yalnızca çok uzun bir kesintiden sonra yaşanır.
2. **Yeni Wi-Fi ağı**: Telefon ilk kez yeni bir ağa bağlanmaya çalışırsa şifre ekranı çıkar. Ev ağında bu hiç yaşanmaz.

Telefon dışı hedeflerde (laptop, mini PC, Raspberry Pi, masaüstü) bu kısıtlar geçerli değildir.

---

## Yol Haritası

Yeterli ilgi olursa planlananlar:

- 📹 **Kurulum videoları** — adım adım anlatımlar.
- 🖥️ **Ortama özel rehberler** — Raspberry Pi, mini PC, eski laptop ve masaüstü için ayrı talimatlar (uyarlanabilir yöntemin ötesinde).
- 📁 **Daha fazla gerçek kurulum referansı** — başka cihazlarda dondurulmuş, kanıta dayalı çözülmüş örnekler (mevcut Galaxy S9 vakası gibi).

Bunlar talebe bağlı. İşine yarayacaksa **repoyu yıldızla**, güncellemeler için **takip et (watch)**, ya da cihazını/ortamını anlatan bir **issue aç** — sırada ne geliştireceğimi böyle ölçüyorum.

---

## Lisans

MIT — bkz. [`LICENSE`](LICENSE).

---

*Arama anahtar kelimeleri: eski telefon minecraft sunucusu, ücretsiz minecraft sunucusu, kendi minecraft sunucun, modemsiz minecraft, port yönlendirmeden minecraft, playit minecraft, Android minecraft sunucusu, Raspberry Pi minecraft sunucusu, ücretsiz öz-barındırma.*
