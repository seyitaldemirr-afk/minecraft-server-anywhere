# Gate: Mod Integrity

**What it measures:**

(a) SHA-512 / PK verification for each jar — file is not corrupted or tampered with.
(b) Startup log contains `Done (Xs)!` and has zero `Incompatible` / `requires ... missing` lines.

**How to run:**

(a) Hash verification — generate SHA-512 for each jar, compare against the expected SHA-512 from the download source (Modrinth):

```bash
sha512sum ~/mcserver/mods/*.jar
```

Every hash produced must match exactly the expected SHA-512 on the relevant mod's Modrinth version page.

(b) Startup log — `Done (Xs)!` present, no incompatibility/missing dependency:

```bash
grep -E "Done \(|Incompatible|missing" latest.log
```

Expected output: only the `Done (Xs)!` line — zero `Incompatible` or `missing` lines.

**Pass criteria:**

- `Done (Xs)!` log entry present
- Lines containing `Incompatible`: 0
- Lines containing `requires ... missing`: 0

**Reference value (S9):**

| Metric | Value |
|---|---|
| Mod count | 6 (without Fabric API) |
| Startup time | 19.6 s |
| Incompatibility / missing dependency | 0 |

Source: measurement value [`../reference-s9/kanit/olcum-panosu.md`](../reference-s9/kanit/olcum-panosu.md);
mod list / clean startup [`../reference-s9/adimlar.md`](../reference-s9/adimlar.md)
