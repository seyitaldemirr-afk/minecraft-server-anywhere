# Autonomy Pattern

> The pattern is described here. Concrete scripts → [`../reference-s9/scripts/`](../reference-s9/scripts/).

---

## Pattern: Four Components

### 1. Boot Trigger

Termux:Boot runs scripts under `~/.termux/boot/` when the phone boots. This is the starting point of autonomy — everything else is triggered from here.

**Prerequisite:** the Termux:Boot app must have been opened manually at least once. Without that first launch it does not acquire the boot permission; nothing is triggered.

### 2. Wake Lock

Android throttles Termux processes on a sleeping CPU. `termux-wake-lock` prevents this restriction. The first thing the boot script does is acquire the wake lock; everything else runs on top of it.

### 3. Self-Resurrecting Loop

If the server crashes, there must be a mechanism to restart it. At this device scale (≤3 players, 4 GB RAM), a single `while` loop is sufficient:

- When the server exits, the loop waits briefly then restarts it.
- More aggressive multi-layer supervision (cron + supervisor) provides no additional gain at this scale and adds complexity.

If scale grows (more players, sustained LMK pressure), additional layers may be considered.

### 4. STOP Contract

Distinguishing intentional shutdown from a crash is critical:

- When a `STOP` file is present, the loop does not restart.
- If the user shuts down the server without a `STOP` file → the loop counts it as a crash and resurrects it.
- Without this contract, "I stopped it" and "the system crashed" are indistinguishable.

---

## FBE / Screen Lock Requirement

Android's file-based encryption (FBE) means: when the phone boots, user data remains encrypted until the first manual unlock.

**If a secure lock (PIN / password / pattern) is set:** Termux data is encrypted → Termux:Boot is not triggered → the server does not come up on its own. Autonomy does not work.

**On a lockless (swipe) device:** boot lands directly on the home screen; Termux:Boot is triggered immediately.

This is an Android security architecture constraint; it cannot be bypassed without root. Deliberate trade-off: security loss vs. autonomy.

---

## Same Pattern, Non-Phone Realization (Linux / systemd)

On a mini PC, laptop, desktop, or Raspberry Pi the four components map onto native Linux primitives — the pattern is identical, only the mechanism changes. The phone-specific parts (wake lock, FBE/screen-lock) simply drop away.

| Component | Phone (Termux) | Linux (systemd) |
|---|---|---|
| Boot trigger | Termux:Boot app | a `systemd` service unit, enabled with `systemctl enable` |
| Wake lock | `termux-wake-lock` | not needed — Linux does not throttle a service on CPU idle |
| Self-resurrecting loop | `while` loop in `run.sh` | `Restart=always` + `RestartSec=10` in the unit |
| STOP contract | `STOP` file checked in the loop | `systemctl stop` (intentional) vs. `Restart=always` (crash); or keep the same `STOP`-file `while` loop inside `ExecStart` |
| FBE / screen lock | must be lockless | not applicable — the OS boots straight into a running state |

A minimal unit expressing the pattern (adapt paths/user to your environment — this is a sketch, not a drop-in recipe):

```ini
[Unit]
Description=Minecraft server
After=network-online.target

[Service]
WorkingDirectory=/home/youruser/mcserver
ExecStart=/home/youruser/mcserver/run.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

The same verification gate applies unchanged: reboot the machine, touch nothing, and prove the server returns from outside.

---

## Verification

Gate: [`../gates/otonomi.md`](../gates/otonomi.md)

The system cannot be called "autonomous" without passing the reboot test. S9 reference values are listed in the same gate.
