# Mission, Vision, Goals

> **This is not a phone repo.** It is an adaptable, free self-host recipe whose hardest test case happens to be a phone — a broken-screen, no-root, tight-RAM, aggressively battery-managed Android device. If the recipe works there, it works everywhere. A mini PC, old laptop, desktop, or Raspberry Pi is a strictly easier target: more RAM, no FBE lock, no LMK pressure, no CPU cluster pinning gymnastics.

## Mission

Turn an idle Android phone with a broken screen into a provably working Minecraft server — no static IP, no modem configuration, no fees required — regardless of the owner's environment.

## Vision

The repo is not a guide — it is adaptable installation intelligence. A human or an agent reads it, builds the path for their own environment, and proves success by passing the same universal verification gates. The S9 case is an immutable reference example — not a recipe to copy, but a solved example that teaches how to think.

## Three Principles

1. **Determinism is the proof, not the recipe.** The S9 concrete case is the reference; it is not a sequence of steps to be repeated in every environment.
2. **Steps adapt; gates do not.** The installation path changes per environment; the verification criteria (`../gates/`) do not.
3. **No "it works" claim is accepted without measurement.** Every acceptance criterion is proven numerically or at the protocol level.

---

## Binding Goals

| Goal | Acceptance criterion | Gate |
|---|---|---|
| At most 3 players | `mcstatus` shows capacity as `0/3` | [`../gates/erisim.md`](../gates/erisim.md) |
| Real mod support (not plugins) | Mod jars loaded on Fabric loader; no incompatibility at startup | [`../gates/modlar.md`](../gates/modlar.md) |
| Measured smoothness (TPS/MSPT) | TPS ≈ 20.0; tick median ≤ 40 ms; 95p < 50 ms | [`../gates/saglik.md`](../gates/saglik.md) |
| Autonomy — no human touch after reboot | mc + tunnel come up with zero interaction; `mcstatus` returns | [`../gates/otonomi.md`](../gates/otonomi.md) |
| Persistent address, no modem config | playit address is stable; stays the same even if the phone's network changes | [`../gates/erisim.md`](../gates/erisim.md) |
| World persistence | World data intact after server restarts | (data gate — see `../method/05-veri-kaliciligi.md`) |
| PC / headless management | Commands sent via ADB + Termux; physical screen not required | [`../gates/erisim.md`](../gates/erisim.md) |
| 0 cost, no root | Hardware already present; software open-source/free; no step requires root | — |
