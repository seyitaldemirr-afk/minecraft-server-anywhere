# Measurement Dashboard

| Measurement | Value | How |
|---|---|---|
| First launch `Done (Xs)!` | **19.565 s** (first launch, including worldgen) | latest.log |
| Idle server RSS / HWM | **1111 / 1142 MB** (first-launch peak) | `/proc/$pid/status` |
| MemAvailable (server running) | **786 MB** (>600 target met) | /proc/meminfo |
| Idle server TPS / tick | **20.0 TPS** · tick med **4.2 ms** / 95% **7.8 ms** / max 94 | `spark tps` (spark added temporarily, then removed) |
| 1 player TPS / tick | _ (player pending) | `spark tps` |
| LAN access (PC→phone) | **OK** — Java 1.21.1, 0/3 | `mcstatus 192.168.1.105:25565` |
| Reboot → server up time | **~114 s** (zero touch; including ~30s boot) | stopwatch + mcstatus |
| Crash → auto-recovery time | **~30 s** (kill -9 → run.sh) | run.sh + mcstatus |
| External access (mcstatus, playit) | **OK** — `<your-tunnel>.gl.joinmc.link` Java 1.21.1, 0/3, ping ~200ms | `python -m mcstatus <address> status` |
