# Gate: Autonomy

**What it measures:** Zero-touch reboot → server comes up + crash → automatic resurrection.

**Prerequisites:**

- Termux:Boot has been opened manually at least once
- Battery optimization disabled
- **NO PIN / password / pattern on the screen lock**
  When a secure lock is active under Android FBE (file-based encryption),
  Termux data remains encrypted on boot → Termux:Boot is not triggered → server does not come up on its own.

**How to run:**

```bash
adb reboot                                  # touch nothing
python -m mcstatus <ADDRESS> status         # wait for it to come up from the outside

tmux send-keys -t mc "stop" Enter           # WITHOUT a STOP file — crash simulation
python -m mcstatus <ADDRESS> status         # should be back within 10 s
```

**Pass criteria:**

- mc + tunnel come up with zero touch
- `mcstatus` returns version + player count

**Reference value (S9):**

| Scenario | Duration |
|---|---|
| Reboot → server ready (zero touch) | ~114 s |
| Crash → automatic resurrection | ~30 s |

Source: [`../reference-s9/kanit/olcum-panosu.md`](../reference-s9/kanit/olcum-panosu.md)
