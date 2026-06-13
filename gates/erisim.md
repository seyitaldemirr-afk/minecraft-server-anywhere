# Gate: External Access

**What it measures:** Real MC protocol handshake — NOT ping or curl.
It is not enough for a network packet to reach the server; the Minecraft server must complete the full handshake.

**How to run:**

```bash
python -m mcstatus <PLAYIT_ADDRESS> status
```

**Pass criteria:**

The command output returns:
- Version: `1.21.1`
- MOTD
- Player count (e.g. `0/3`)

**Reference value (S9, playit tunnel):**

| Field | Value |
|---|---|
| Address | `<your-tunnel>.gl.joinmc.link` |
| Protocol | Java 1.21.1 |
| Capacity | 0/3 |
| Ping | ~200 ms |

Source: [`../reference-s9/kanit/olcum-panosu.md`](../reference-s9/kanit/olcum-panosu.md)
