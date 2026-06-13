# Adaptation Guide

> This is the heart of the repo. reference-s9 shows what was done; this file shows how to think.

---

## Non-Phone Environments Are First-Class Targets

The phone is the hardest case: broken screen, no root, tight RAM, aggressive battery management, CPU cluster pinning required, FBE autonomy constraint. Every other platform is easier:

| Platform | Easier because |
|---|---|
| Mini PC / NUC | More RAM, no FBE, no LMK, persistent power, real OS scheduler |
| Old laptop | Same as mini PC; may have more cores |
| Desktop | Most RAM and cores; no constraints |
| Raspberry Pi | ARM like the phone, but no FBE, no battery manager, no LMK |

On any of these platforms: skip the `taskset` pinning, remove the wake-lock step, set the heap higher, and ignore the FBE screen-lock constraint. The four gates (`../gates/`) still apply unchanged — they are environment-independent.

An AI agent can derive an environment-specific install from the principles in this file plus the reference data in `../reference-s9/`: read the adaptation points table, substitute the values for the target environment, and verify each step against the relevant gate.

---

## Four-Step Loop

### 1. Read reference-s9 as an Example

[`../reference-s9/`](../reference-s9/) is a real case — S9, Android 10, scrcpy, playit TUR package. Read it to understand what was done. **Not to copy it.**

Every environment is different. The S9 steps may not work directly on your device.

### 2. Evaluate Your Environment Against the Gates

[`../gates/`](../gates/) contains universal verification criteria. Whatever your environment, you must pass these gates:

- [`../gates/saglik.md`](../gates/saglik.md) — TPS/MSPT
- [`../gates/otonomi.md`](../gates/otonomi.md) — reboot + resurrection
- [`../gates/erisim.md`](../gates/erisim.md) — external access
- [`../gates/modlar.md`](../gates/modlar.md) — mod integrity

If you cannot pass a gate, the step is not complete.

### 3. Apply the Decision Framework to Differences

Find where your environment diverges from S9; apply the criteria in [`../method/01-karar-cercevesi.md`](../method/01-karar-cercevesi.md) to that difference. The table below lists known adaptation points.

### 4. Prove Each Step Against Its Gate

Before saying "done," run the relevant gate and record the result. Claims without evidence do not pass.

---

## Known Adaptation Points

| Variable | S9 reference value | What changes in another environment | Fallback / solution |
|---|---|---|---|
| Phone model | SM-G960F (Exynos, arm64) | Different SoC → different CPU cluster layout; taskset core numbers change | Find fast cores with `lscpu` / `/proc/cpuinfo` |
| Android version | Android 10 | Android ≥10 → FBE active → secure lock blocks autonomy | Remove screen lock; see `04-otonomi-deseni.md` |
| Android version | Android 10 | Android <10 → some doze/battery menus absent | See S8/S9 diff notes in the 01 docs |
| RAM | 4 GB total, ~1.57 GB available | Less RAM → lower heap limit; more RAM → raise it | Measure MemAvailable with `cat /proc/meminfo`; heap ≈ MemAvailable × 0.6 |
| CPU cluster | cpu4-7 @2.70 GHz fast | Different phone → different cluster numbers | Skip `taskset` or find the correct cores |
| Non-phone platform | N/A | Mini PC / laptop / desktop / Raspberry Pi: no taskset needed, no wake-lock, no FBE, higher heap | Apply all four gates; omit phone-specific steps |
| Termux version | v0.118.3 (GitHub debug) | Play Store version is abandoned — do not use | F-Droid or GitHub release, arm64 |
| Access tool | scrcpy + ADB | Screen completely dead → DeX; SSH sufficient → SSH | `02-erisim-yontemleri.md` decision table |
| Tunnel | playit TUR package | playit slow / unreachable in region | Alternative tunnel; see `03-tunel-yontemleri.md` |
| Static binary DNS | Resolved in TUR package | Different tunnel tool / older playit / different Android → DNS unresolvable | `proot -b resolv.conf:/etc/resolv.conf <binary>` |
| seccomp / faccessat2 | No issue on Android 10 | Android 12+ blocks `faccessat2` syscall in some static binaries | Run with proot or patched binary |
| Mod versions | 1.21.1 Fabric | Different MC version → mod compatibility changes | Check version compatibility on Modrinth; verify with `gates/modlar.md` |

---

## Starting Questions

Ask yourself before beginning the adaptation:

1. Phone model and Android version? → CPU cluster layout + FBE behavior
2. Screen condition? → access tool selection
3. Network environment? (CGNAT? static IP?) → tunnel selection
4. How much RAM is available? → heap and mod selection

After answering these four questions, project the reference-s9 steps onto your environment and measure against the gates.
