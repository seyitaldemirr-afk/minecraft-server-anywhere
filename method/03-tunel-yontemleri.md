# Tunnel Methods

---

## Why a Tunnel (General)

A home modem assigns a dynamic IP, may be behind CGNAT, and may require port forwarding. The lowest-friction way around these obstacles: instead of opening a port outward, the phone establishes a tunnel **outward**; traffic enters this tunnel from the playit infrastructure.

Result: no modem configuration, no static IP. Moving the phone to a different network does not change the address.

---

## playit.gg — Selected Method

**Selection criterion:** "the friend installs nothing."

VPN-based solutions (Tailscale, ZeroTier, etc.) require every connecting player to install a client — this conflicts with the goal. With playit, the friend simply types the given address into Minecraft; nothing else to install.

**Additional benefits:** free; stable address tied to the playit account (portable even if the device changes); outbound tunnel → CGNAT / dynamic IP / modem configuration are irrelevant.

Concrete setup flow → [`../reference-s9/adimlar.md`](../reference-s9/adimlar.md).

### DNS Note on Android

playit binaries are statically compiled (musl); they cannot use Android's system DNS resolver. **In v2 the TUR package resolved this internally** — proot is no longer needed.

However, this is a general property of static binaries. A different tunnel tool, a different Android version, or a different binary build format may trigger the same issue. The general fix in that case: use `proot` to expose a fake `/etc/resolv.conf` (pointing to a real public DNS). Flow:

```
proot -b /path/to/resolv.conf:/etc/resolv.conf <binary>
```

This adaptation point is also listed in the `06-uyarlama-rehberi.md` table.

---

## Alternative Paths

| Method | When suitable | Drawback |
|---|---|---|
| Modem port forwarding | Controllable modem + static IP | Update required when IP changes; does not work behind CGNAT |
| Tailscale / ZeroTier | Only familiar players, can install a client | Every friend must install a client |
| Cloudflare Tunnel | Advanced; full control over the server | Complex setup; additional configuration needed for MC protocol |

These alternatives are considered when the playit free quota is exceeded or it is unreachable in the region. The verification criterion does not change: [`../gates/erisim.md`](../gates/erisim.md).
