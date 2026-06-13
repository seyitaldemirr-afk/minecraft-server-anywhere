# Steps — Real Chronology

> The phone screen was working enough to approve the USB debugging prompt; when connected to the PC the "Allow USB debugging" popup was confirmed and "Trust this computer" was selected; "Stay awake while charging" was enabled in developer options; and verification of apps installed via adb was disabled.

---

## Chronology

Format: `HH:MM` · phase · what was done → result. Raw output: `kanit/raw/<file>.txt`.

| Time | Phase | Action / command | Result / note | Raw |
|---|---|---|---|---|
| 09:13 | 0 baseline | adb recon (model, RAM, CPU, battery) | SM-G960F/A10, MemAvail 1.57G, cpu4-7 fast, no Termux | `kanit/raw/00-taban-recon.txt` |
| 09:14 | 1 termux | Termux v0.118.3 + Boot v0.8.1 APK `adb install` | both Success (GitHub signature compatible) | `kanit/raw/01-termux-ssh.txt` |
| 09:17 | 1 ssh | adb input → bootstrap.sh → openssh + authorized_keys + sshd | `SSHD_STARTED rc=0`, user u0_a251, port 8022 | `kanit/raw/01-termux-ssh.txt` |
| 09:18 | 1 ssh | `ssh s9` test from PC | CONNECTED — clean, key-based | `kanit/raw/01-termux-ssh.txt` |
| 09:19 | 1 termux | Termux:Boot opened once + doze whitelist (adb) | com.termux + .boot on whitelist | `kanit/raw/01-termux-ssh.txt` |
| 09:21 | 2 server | repo scp + CRLF strip + `kur.sh` | ⚠️ `pkg upgrade` stalled on openssl.cnf conffile prompt → kur.sh fixed | `kanit/raw/02-kur-sh-log.txt` |
| 09:22 | 2 server | kur.sh (fixed, non-interactive+confold) | playit 1.0.6 (TUR✓), jdk21, Fabric, 6 mods downloaded | `kanit/raw/02-kur-sh-log.txt` |
| 09:25 | 2 server | first launch `run.sh` | **Done (19.565s)**, 11 mods, no Fabric API, no errors | `kanit/raw/02-sunucu-ilk-acilis.txt` |
| 09:26 | 2 server | `mcstatus 192.168.1.105:25565` from PC | Java 1.21.1 / MOTD / 0/3 — LAN access proven ✓ | `kanit/raw/02-sunucu-ilk-acilis.txt` |
| 09:31 | 3 playit | `playit-cli` with no args → looks for systemd (not in Termux) | ⚠️ correct flow: claim + `playitd` daemon → docs/03 + boot fixed | `kanit/raw/04-playit.txt` |
| 09:32 | 3 playit | measurement: spark+fabric-api added temporarily → `spark tps` → removed | TPS 20.0, tick med 4.2ms | `kanit/raw/03-spark-olcum.txt` |
| 09:38 | 3 playit | claim generate/url/exchange + `playitd --secret-path` | agent ONLINE, authenticate OK (public IP 159.146.xx.xx) | `kanit/raw/04-playit.txt` |
|  | 03 playit | Minecraft Java tunnel in panel (user) | _ pending |  |
| 09:39 | 3 playit | `mcstatus <your-tunnel>.gl.joinmc.link` from PC | **external access OK** — end-to-end | `kanit/raw/04-playit.txt` |
| 09:44 | 4 autonomy | crash test: `kill -9` java | run.sh revived it, came back from outside ~30s | `kanit/raw/04-playit.txt` |
| 09:45 | 4 autonomy | **reboot test** `adb reboot` (zero touch) | came back externally at ~114s — mc+playit automatic | `kanit/raw/04-playit.txt` |
| 09:48 | 4 autonomy | post-reboot ssh couldn't be launched blindly via adb-input | screen in AOD — input goes to "clock overlay" — WAKEUP+keyguard dismiss needed late | — |
| 09:55 | 5 management | **whitelist add** (docs/05 method: ssh→`tmux send-keys`) | `Added seyitaldemir` ✓; post-reboot tmux launches mc+playit at boot (autonomy confirmed) | — |
| 09:55 | 5 management | real client login (playit relay 127.54.x) | "not white-listed" → tunnel carried real client traffic (not just mcstatus) | — |
| — | 5 management | **mod addition** method (jar→`mods/`→restart) | actually validated by adding/removing spark+fabric-api | `kanit/raw/03-spark-olcum.txt` |

---

## Documentation Deviations (places where we corrected what was written)

| Document | As written (draft) | Reality | Fix |
|---|---|---|---|
| `kur.sh` | `pkg upgrade -y` | openssl.cnf conffile prompt stalled under ssh | non-interactive + `Dpkg::Options=--force-confold` |
| docs/03 + boot/start-mc | run bare `playit-cli` | `playit-cli` looks for a systemd service (not in Termux) | claim flow (`generate/url/exchange`) + `playitd --secret-path` |
| kur.sh secret | — | top lines of `claim exchange` output are messages | secret = **last line** (`tail -n1`), 64-hex |
| Measurement | `spark tps` (in 6-mod set) | spark requires **fabric-api**, not present in the 6-mod set | spark+fabric-api added temporarily for measurement, then removed |
| docs/04 | boot requirements (2) | FBE: if a secure lock screen exists Termux:Boot won't trigger | "screen lock must not have a PIN/password" requirement added |
| docs/01 | scrcpy link `Genymotion` | wrong organization | corrected to `Genymobile` |
