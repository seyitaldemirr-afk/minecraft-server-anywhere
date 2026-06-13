# AGENTS.md — Agent Orchestration Contract

This file is the authoritative instruction set for any AI agent working in this repo.
CLAUDE.md points here. Read this file first, in full, before touching anything else.

---

## 0. How to Execute (before doing anything)

You are about to install on a real device. Work from the repo's **actual files**, not from
web-page summaries — summaries drop the exact commands and will make you improvise and hit
walls this repo already solves.

1. **Get the repo verbatim.** `git clone` this repository (or fetch raw files from
   `raw.githubusercontent.com/.../main/<path>`) and read the real file contents — especially
   `reference-s9/scripts/kur.sh`, `run.sh`, and `reference-s9/scripts/boot/start-mc`. Do NOT
   rely on summarized fetches of GitHub pages.
2. **Prefer the tested script over improvising.** `reference-s9/scripts/kur.sh` already does,
   in order: add `tur-repo` + install `playit`, install Java 21 / tmux / jq / curl, download
   the Fabric launcher, copy `config/server.properties.ornek`, fetch the 6 performance mods
   from Modrinth, and install `run.sh` + the Termux:Boot script. **Adapt and run this script;
   do not rewrite it from memory.** On a non-phone target, translate its steps per `method/06`.
3. **Tunnel = interactive claim, not a headless API.** playit needs a claim link the **user
   approves in a browser**, then a Java tunnel pointing to `127.0.0.1:25565`. Use the TUR
   `playit-cli` claim flow (`method/03-tunel-yontemleri.md` + `reference-s9/adimlar.md`). Do
   **not** try to reverse-engineer `api.playit.gg`.
4. **Run Termux-side steps inside Termux** (push the repo to the phone and run `kur.sh` in a
   real Termux session), not via fragile non-interactive SSH one-shots — `tmux` needs `TMPDIR`
   set and a real session, which SSH-driven one-shots break.
5. **Platform gotchas.**
   - Android phone over USB must be in **File Transfer (MTP)** mode with **USB debugging
     authorized**; after a factory reset it reverts to "charging only" and `adb devices` shows
     nothing until the user switches the mode and re-approves the trust prompt on the screen.
   - Samsung **Play Protect** may stall `adb install` with an on-screen prompt — confirm it, or
     temporarily `adb shell settings put global verifier_verify_adb_installs 0` (restore after).
   - On **Windows Git Bash**, set `MSYS_NO_PATHCONV=1` for `/sdcard/...` paths.

---

## 1. What This Repo Is — Reading Order

**This is not a phone repo.** It is an adaptable, free self-host recipe for running a
Minecraft server on any idle device. The hardest test case is a broken-screen, no-root,
tight-RAM Android phone (Samsung Galaxy S9). Mini PC, old laptop, desktop, and Raspberry
Pi are strictly easier targets.

Read in this order:

1. `method/00-hedefler.md` — mission, goals, acceptance criteria, three core principles.
2. `method/01-karar-cercevesi.md` — the decision framework (version, loader, mods, tunnel,
   autonomy) and the criteria behind each choice, so you can re-decide for your environment.
3. `method/06-uyarlama-rehberi.md` — how to adapt the recipe to a new environment.
4. `gates/` — the four universal verification gates (see Section 4). Read all four files.
5. `reference-s9/` — a frozen worked example for one specific environment (Galaxy S9,
   Android 10, scrcpy, playit TUR package).

**WARNING: `reference-s9/` is a worked example for one specific environment. Do NOT copy
its commands blindly. Adapt using `method/` and prove success with `gates/`.**

---

## 2. Requirement-Gathering Protocol

Before starting any installation, setup, or adaptation work, ask the user for ALL of the
following. Do not proceed until you have answers to every item.

1. **Target device + OS** — Phone model and Android version (e.g. Samsung Galaxy S9 /
   Android 10), OR platform type (mini PC / NUC, Raspberry Pi model, old laptop, desktop)
   and OS (Ubuntu 22.04, Debian 12, Windows, etc.).
2. **Screen and access tool** — Is the phone screen usable or broken? Which access method
   is available or preferred: ADB + scrcpy, Samsung DeX, SSH, or a physical keyboard/display?
3. **Controlling PC OS** — The OS of the PC used to manage the device (Windows 10/11,
   macOS, Ubuntu, etc.).
4. **Home network** — Does the user have access to the home Wi-Fi router admin panel?
   Is the internet connection behind CGNAT? Is a static IP available?
5. **Target player count** — How many concurrent players? (The reference case is 3.)
6. **Content mods** — Does the user want visual/item/content mods (Modrinth/Fabric mods),
   or vanilla/performance-only?

---

## 3. Environment-Based Decision Authority and Approval Thresholds

### Autonomous decisions (no approval needed)

The agent MAY read runtime artifacts and make decisions independently:
- Parse `latest.log`, server boot output, `mcstatus` probe results.
- Select CPU heap size based on `cat /proc/meminfo` (MemAvailable × 0.6).
- Choose access method using the decision table in `method/02-erisim-yontemleri.md`.
- Choose tunnel method using `method/03-tunel-yontemleri.md`.
- Skip phone-specific steps (taskset, wake-lock, FBE screen-lock removal) when the target
  is a non-phone platform.
- Apply adaptation substitutions from the table in `method/06-uyarlama-rehberi.md`.

### Actions that REQUIRE explicit user approval before execution

The following actions must be described to the user, risks disclosed, and approval received
before the agent proceeds:

| Action | Required disclosure |
|---|---|
| Debloating (disabling system packages via `pm disable-user`) | Disabling system packages can break device functionality; list which packages will be disabled. |
| Anything requiring root (`su`, Magisk, root-dependent tools) | Root access is out of scope for this recipe; state that explicitly and ask if the user wants to deviate. |
| Any paid or subscription service | Name the service, its cost, and why it is being considered. |
| Setting `online-mode=false` in `server.properties` | Disables Minecraft account authentication; any client can join with any username. Disclose this risk to the user before applying. |
| Any other security relaxation | Describe the exposure and get explicit consent. |

---

## 4. Definition of Success

**Do not claim "installed", "done", or "working" until all four gates pass.**

Run each gate and record the output:

| Gate file | What it verifies | Pass condition |
|---|---|---|
| `gates/saglik.md` | Server health — TPS and tick timing | TPS ≈ 20.0; tick median ≤ 40 ms; 95th percentile < 50 ms |
| `gates/otonomi.md` | Autonomy — server and tunnel survive a reboot with zero human interaction | `mcstatus` returns successfully after a cold reboot without any manual step |
| `gates/erisim.md` | External reach — players outside the home network can connect | `mcstatus <playit-address>` shows the server; capacity shown as `0/N` |
| `gates/modlar.md` | Mod integrity — Fabric mod jars loaded, no startup incompatibility | Server log shows all mods loaded; no `incompatible mods` error |

If any gate does not pass, the corresponding step is not complete. Do not move on; fix the
failure and re-run the gate.

---

## 5. Secret Hygiene

Never write the following into any repo file, commit, log snippet, or agent output that
could be committed:

- playit tunnel secret or API token
- SSH private keys or passphrases
- Minecraft account credentials
- The user's home public IP address (appears in `mcstatus` probes, server logs, and
  playit dashboard output — redact before pasting)
- Any other credential, token, or PII

If a log or command output contains a secret or home IP, redact it (replace with
`<REDACTED>`) before including it in any file or message intended for the repo.
