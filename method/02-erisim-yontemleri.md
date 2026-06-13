# Access Methods

There are multiple ways to control the phone. Which one to choose depends on the environment and screen condition.

---

## ADB — Core (required)

ADB is the foundation of every path: app installation, sending commands, reboot testing. Setup and enabling "USB debugging" is a well-documented standard covered by thousands of sources:

- Official tools: <https://developer.android.com/tools/releases/platform-tools>

Verification: `adb devices` lists the phone. Nothing else works until this step is complete.

---

## Control With a Broken Screen

### scrcpy (PC + USB)

Displays the phone screen on the PC; injects mouse and keyboard input over ADB. Works even if the touchscreen is broken. Setup:

- <https://github.com/Genymobile/scrcpy>

If the screen is completely dead, scrcpy shows a blank/black image — in that case, use DeX.

### Samsung DeX (if screen is completely dead)

Connect an external monitor + keyboard + mouse via USB-C → HDMI adapter; DeX desktop opens on the monitor even if the phone's own screen is dead. S8/S9 support DeX; original Samsung adapter is not required.

---

## SSH — Optional Comfort

Run `openssh` in Termux to connect over LAN (port 8022) from a PC terminal. The most convenient path for copy-paste and remote management.

**When preferred:** screen is functional and you don't want to keep ADB permanently connected; or remote (same-network) management is needed.

**Caution:** exposing SSH to the outside (internet) is unnecessary risk — LAN access is sufficient.

Setup detail: [`../reference-s9/adimlar.md`](../reference-s9/adimlar.md) (line 09:17).

---

## Decision Table

| Situation | Preference |
|---|---|
| Screen working | scrcpy or direct ADB + SSH |
| Screen broken / touchscreen dead | scrcpy (input injection sufficient) |
| Screen completely dead (no image) | DeX (monitor + keyboard + mouse) |
| Continuous remote management | SSH (LAN) |

Once ADB is trusted, all subsequent operations can be run via scrcpy/SSH — no need to touch the physical screen.
