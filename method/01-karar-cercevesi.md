# Decision Framework — Stack Selection

Every choice carries a criterion. A different environment can make a different choice against the same criterion.

---

## Version: 1.21.1

**Criterion:** breadth of mod ecosystem + viability on constrained hardware.

1.21.1 is the de facto LTS of modding; all performance mods on Modrinth support this version. Newer versions require Java 25 + ~4 GB RAM: on a 4 GB RAM phone, heap + system overhead → tight squeeze. The elimination criterion is not the hardware itself but mod ecosystem size + RAM balance.

## Loader: Fabric

**Criterion:** overhead on low-end hardware + performance mod ecosystem.

Forge is designed for desktop scale; startup overhead and memory usage are noticeably higher. Fabric stays lightweight on constrained hardware, and the lithium family (all performance mods) is developed exclusively for Fabric. A different mod requirement may call for a different loader — at that point this trade-off should be re-evaluated.

## Performance Mods (6 mods)

**Criterion:** measured gain in each domain — game logic / memory / network / startup / lighting & generation; no Fabric API dependency.

| Mod | Target area |
|---|---|
| lithium | game logic optimization |
| ferritecore | memory (RAM) usage |
| krypton | network stack |
| modernfix | startup time + memory |
| scalablelux | lighting engine |
| noisium | world generation |

**Deliberate exclusions:**

- **C2ME** — multi-threads chunk I/O; harmful on low core counts (especially under LMK pressure). Criterion: core count and memory pressure.
- **VMP** — no measurable gain at low player counts (≤3). Criterion: concurrent player count.

## JVM Parameters

Concrete values → [`../reference-s9/ortam.md`](../reference-s9/ortam.md).

**Decision rationale:** G1GC provides predictable pauses on a narrow heap; `MaxGCPauseMillis` is for protecting the tick budget. Pinning to fast CPU cores with `taskset` (`cpu4-7`) is necessary for this phone architecture (big.LITTLE). RAM differs per device — heap limit must be recalculated.
