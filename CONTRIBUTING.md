# Contributing to minecraft-server-anywhere

Thanks for wanting to help. This project has an unusual shape, so contributions look a
little different from a typical code repo. The single most valuable thing you can add is
**proof that the recipe works on a new device or environment.**

The canonical language is English. `README.tr.md` is the Turkish landing — Turkish
contributions and questions are welcome too.

---

## Ways to contribute

### 1. A new real install reference (most valuable)

The repo's credibility comes from frozen, evidence-backed worked examples. Right now there
is one: [`reference-s9/`](reference-s9/) (Galaxy S9). If you install on a different device —
another phone, a mini PC, a Raspberry Pi, an old laptop — you can contribute a new reference
under `reference-<your-device>/`, mirroring the structure of `reference-s9/`:

- `ortam.md` — your exact environment (device, OS, RAM, CPU, access tool).
- `adimlar.md` — the real chronology of what you actually ran (deviations included).
- `kanit/` — raw logs plus a measurement board with the four gate results.

Please open an issue first (use the **New install reference** template) so we can coordinate.

### 2. Adapt the method for an environment

Improve [`method/`](method/) — especially [`method/06-uyarlama-rehberi.md`](method/06-uyarlama-rehberi.md) —
with environment-specific guidance you learned the hard way. Keep it as *decision criteria
and adaptation*, never a device-locked recipe.

### 3. Docs, translations, fixes

Typos, clearer wording, a translation into another language, broken links — all welcome.

### 4. Report what happened

Tried it and it worked? Tell us — it might become a reference. Didn't work? Open a
**Didn't work on my device** issue with your environment and logs. That feedback is how the
recipe gets more robust.

---

## The three principles (please keep these)

1. **Determinism is proof, not a recipe.** Concrete commands belong in a `reference-*`
   worked example, not in `method/`. `method/` holds the *why* and the decision criteria.
2. **Steps adapt, gates don't.** Your steps may differ from ours; success is still proven
   by the same four [`gates/`](gates/).
3. **No "it works" without measurement.** Back every claim with a gate result — `spark tps`,
   the reboot test, `mcstatus`, mod hashes.

---

## Before you open a pull request

- **Mask all secrets and PII.** No playit secrets, tokens, SSH keys, or your home public IP.
  Real evidence is welcome; private or live values get redacted — e.g. `159.146.xx.xx`,
  `<your-tunnel>.gl.joinmc.link`.
- Keep prose clean and concise.
- One topic per pull request.
- Be kind. See the [Code of Conduct](CODE_OF_CONDUCT.md).

---

## Not sure where to start?

Open an issue describing your device and environment. Even "I'd like to try this on X" helps
gauge demand and prioritize the [roadmap](README.md#roadmap).
