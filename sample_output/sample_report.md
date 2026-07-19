# Server Health Report — 2026-07-19

**Host:** prod-web-01  
**Generated:** 2026-07-19 07:00:03  
**Overall Status:** ⚠️ WARNING

| Warnings | Critical |
|---|---|
| 2 | 0 |

## Disk Usage

| Mount | Filesystem | Used | Available | % Used | Status |
|---|---|---|---|---|---|
| / | /dev/sda1 | 12G | 26G | 32% | ✅ OK |
| /var | /dev/sda2 | 38G | 6.2G | 86% | ⚠️ WARNING |
| /home | /dev/sda3 | 21G | 79G | 21% | ✅ OK |

## Memory & Swap

- **RAM used:** 6,144 MB / 8,000 MB (76%) — ⚠️ WARNING
- **Swap used:** 128 MB / 2,048 MB (6%) — ✅ OK

## Services

| Service | State | Status |
|---|---|---|
| sshd | active | ✅ OK |
| cron | active | ✅ OK |
| nginx | active | ✅ OK |

---
_Generated automatically by the Linux Server Health Check Toolkit._
