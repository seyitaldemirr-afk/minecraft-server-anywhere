# Data Persistence

> In the v2 core, backups are deliberately left out — they are not a required part of the core path. The pattern below is **optional**; apply it only if a persistent world is desired.

---

## When It Is Needed

Backups are not mandatory if the server is for personal / temporary use. Apply the backup pattern if any of the following is true:

- World data must not be lost if the phone fails.
- A world with continuous play by multiple people where progress has value.
- The phone is going to be replaced or moved.

---

## Consistent Archive Pattern

Raw copying while the game is running produces an inconsistent (partially written chunk) archive. Safe sequence:

1. `save-off` — stop automatic saving
2. `save-all flush` — flush all pending writes
3. `tar` — archive the world directory
4. `save-on` — re-enable automatic saving

Skipping this sequence may produce a corrupt archive; a corrupt archive is not a real backup.

---

## Layered Copy

- **First copy:** on the phone, N rotating archives (older ones deleted).
- **Second copy:** periodic transfer to a PC or another device.

Second copy requirement: if the phone dies hardware-wise, the world must be continuable on another device.

---

## Concrete Implementation

The v2 core has no backup script. Those who want to implement it run the `save-off / flush / tar / save-on` pattern as a cron job or manual step. Scheduling is a matter of preference (e.g., every 2 hours); what matters is following the consistent archive sequence.
