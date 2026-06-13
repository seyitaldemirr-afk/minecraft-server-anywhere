# Gate: Server Health

**What it measures:** TPS (ticks per second) and tick duration (MSPT — milliseconds per tick).

**How to run:**

```
spark tps
```

> **v2 DAILY deviation — important:** spark requires a `fabric-api` dependency.
> The 6-mod set deliberately excludes fabric-api.
> spark + fabric-api are added **temporarily** for measurement; **removed** once measurement is complete.

**Pass criteria:**

- TPS ≈ 20.0
- Tick median ≤ 40 ms
- Tick 95p < 50 ms

**Reference value (empty server, S9):**

| Metric | Value |
|---|---|
| TPS | 20.0 |
| Tick median | 4.2 ms |
| Tick 95p | 7.8 ms |

Source: [`../reference-s9/kanit/olcum-panosu.md`](../reference-s9/kanit/olcum-panosu.md)
