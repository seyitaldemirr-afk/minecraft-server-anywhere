# Minecraft Server Anywhere — Free, Self-Hosted, No Port-Forwarding

**English** · [🇹🇷 Türkçe](README.tr.md)

> The quality of paid hosting, at zero cost, on a device you already own.

Run a real Minecraft server — mods, persistent world, always-on, reachable from anywhere — without a static IP, without touching your router, without a monthly bill.

---

## What You Get in 30 Seconds

- A **real Fabric server** (not a plugin hack) with performance mods, running on hardware you already own.
- **Publicly reachable** via a [playit.gg](https://playit.gg) tunnel — no port-forwarding, no static IP, no router config.
- **Zero-touch autonomy**: server and tunnel come back up automatically after a reboot or crash — no human interaction needed.
- **$0 cost**: every piece of software in this stack is free and open-source.

---

## Why This Beats the Alternatives

| | Free hosts (Aternos…) | Paid hosting | Normal self-host | **This project** |
|---|---|---|---|---|
| **Cost** | Free | $3–10 / month | Free | **$0** |
| **Server sleeps when idle?** | Yes — waits for a player to wake it | No | No | **No** |
| **Port-forward / static IP needed?** | No | No | Yes | **No** |
| **Your data, your hardware** | No — hosted elsewhere | No | Yes | **Yes** |
| **Real mod support (Fabric/Forge)** | Limited | Yes | Yes | **Yes** |

Free hosts sleep, restrict mods, and are out of your control. Paid hosting costs money every month. Normal self-hosting requires router access and a static IP that most ISPs don't give for free. This project solves all three.

---

## Works Anywhere — The Phone Is the Hardest Case

The reference implementation runs on a **Samsung Galaxy S9 with a broken screen** — Android 10, no root, tight RAM, aggressive battery management, no physical interaction possible. If the recipe works here, it is much easier on every other target:

| Target | Extra difficulty vs. phone |
|---|---|
| Old laptop / desktop | Less: no RAM pressure, no battery management, no CPU-cluster pinning |
| Mini PC / NUC | Less: same as above, typically headless-friendly |
| Raspberry Pi | Slightly different: ARM, Debian, fewer Android-specific steps |
| Android phone (working screen) | Same category; screen usability makes setup easier |

**This is not a phone repo.** The phone case is the hardest test. Read the recipe, adapt it to your environment, prove success with the same four verification gates.

### AI Agent Install

Hand the repo to an AI agent, tell it your environment, and it will derive the install path for you. See [`AGENTS.md`](AGENTS.md) for the full orchestration contract — requirement-gathering protocol, decision authority, and the four gates an agent must pass before claiming "done".

---

## Proof — Real Device, Not Theory

Measured on Samsung Galaxy S9 (SM-G960F), Android 10. Stack: Fabric 1.21.1 (loader 0.19.3), OpenJDK 21, 6 server-side performance mods (lithium, ferritecore, krypton, modernfix, scalablelux, noisium), playit.gg tunnel.

| Measurement | Result |
|---|---|
| First boot `Done (Xs)!` | **19.565 s** (including world generation) |
| Idle TPS / tick median | **20.0 TPS** · **4.2 ms** median (95th pct: 7.8 ms) |
| Reboot → server up (zero touch) | **~114 s** |
| Crash → auto-recovery | **~30 s** |
| External reach (mcstatus via playit) | **OK** — Java 1.21.1, 0/3, ping ~200 ms |
| RAM available while server runs | **786 MB** free (target: >600 MB — met) |

Raw logs and the full measurement board live in [`reference-s9/kanit/olcum-panosu.md`](reference-s9/kanit/olcum-panosu.md) and [`reference-s9/kanit/raw/`](reference-s9/kanit/raw/).

---

## Install Index

Follow the `method/` guides in order. Each step has a gate that proves it is complete before you move on. `reference-s9/` is the worked example for the Galaxy S9 — use it for orientation, not as a copy-paste recipe.

| Step | Guide | Proven by |
|---|---|---|
| 0 — Goals & acceptance criteria | [`method/00-hedefler.md`](method/00-hedefler.md) | (read; defines what "done" means) |
| 1 — Decision framework | [`method/01-karar-cercevesi.md`](method/01-karar-cercevesi.md) | (read; shapes your environment-specific path) |
| 2 — Access methods | [`method/02-erisim-yontemleri.md`](method/02-erisim-yontemleri.md) | [`gates/erisim.md`](gates/erisim.md) |
| 3 — Tunnel methods (playit / alternatives) | [`method/03-tunel-yontemleri.md`](method/03-tunel-yontemleri.md) | [`gates/erisim.md`](gates/erisim.md) |
| 4 — Autonomy pattern | [`method/04-otonomi-deseni.md`](method/04-otonomi-deseni.md) | [`gates/otonomi.md`](gates/otonomi.md) |
| 5 — Data persistence | [`method/05-veri-kaliciligi.md`](method/05-veri-kaliciligi.md) | [`gates/saglik.md`](gates/saglik.md) |
| 6 — Adaptation guide (your environment) | [`method/06-uyarlama-rehberi.md`](method/06-uyarlama-rehberi.md) | All four gates |
| Verification gates (all environments) | [`gates/`](gates/) | [`gates/saglik.md`](gates/saglik.md) · [`gates/otonomi.md`](gates/otonomi.md) · [`gates/erisim.md`](gates/erisim.md) · [`gates/modlar.md`](gates/modlar.md) |

Do not claim "done" until all four gates pass.

---

## Stack Summary

- **Minecraft server**: Fabric 1.21.1 · loader 0.19.3
- **Runtime**: OpenJDK 21
- **Performance mods**: lithium, ferritecore, krypton, modernfix, scalablelux, noisium
- **Tunnel**: [playit.gg](https://playit.gg) (persistent address, no router config, free tier)
- **Termux** (Android only): provides the Linux shell environment on the phone
- **ADB + scrcpy** (Android only): headless access from a controlling PC

---

## Honest Limits (No Root)

This recipe requires no root. Two edge cases worth knowing:

1. **Extended power outage**: If the battery fully drains and the phone powers off, it will not auto-power-on when plugged back in. One press of the power button is needed. On continuous power, this only happens after a very long outage.
2. **Unknown Wi-Fi**: If the phone joins a new Wi-Fi network for the first time, the password prompt requires a brief interaction. On your home network, this never comes up.

On non-phone targets (laptop, mini PC, Raspberry Pi, desktop) these constraints do not apply.

---

## License

MIT — see [`LICENSE`](LICENSE).

---

*Keywords for search: free minecraft server, self-hosted minecraft, minecraft on old phone, minecraft on Android, Raspberry Pi minecraft server, no port forwarding minecraft, playit minecraft, zero cost minecraft server, minecraft without static IP.*
