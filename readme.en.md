<div align="center">

## zapretik 1.9.9.1

minimalistic fork of  
<a href="https://github.com/Flowseal/zapret-discord-youtube">Flowseal/zapret-discord-youtube</a> and  
<a href="https://github.com/sch-izo/shizapret">sch-izo/shizapret</a>,  
maintained by <a href="https://github.com/Vanilla-SilQ-HD">Vanilla-SilQ-HD</a>.

**goal** — provide a convenient, “ready‑to‑use” zapret bundle for Windows:
- combined strategies (including `shizapret.bat`);
- up‑to‑date domain / ip lists from <a href="https://github.com/bol-van/rulist">bol-van/rulist</a>;
- simple `service.bat` with auto‑update checks and list/bin updaters.

</div>

> [!WARNING]
>
> ### ANTIVIRUS NOTE
> WinDivert is a packet interception/filtering driver required for zapret to work.
> It may be flagged as a “hacktool” or PUA by some antivirus products, but by itself it is **not** malware.
> See [`readme.md` in zapret-win-bundle](https://github.com/bol-van/zapret-win-bundle/blob/master/readme.md#antiviruses) for details.

> [!IMPORTANT]
> All binaries in [`bin`](./bin) are taken from  
> [`bol-van/zapret-win-bundle/zapret-winws`](https://github.com/bol-van/zapret-win-bundle/tree/master/zapret-winws).  
> Always verify what you run, especially when downloading archives from the internet.

## ⚙️ Quick start

1. **Enable Secure DNS (DNS over HTTPS)** in your browser / OS.
2. **Download** the latest `zapretik-….zip` from  
   [`Releases`](https://github.com/Vanilla-SilQ-HD/Zapretik/releases/latest).
3. **Unblock the archive** in file properties if Windows shows the “Unblock” checkbox.
4. **Extract** to a simple path without Cyrillic or special characters (e.g. `C:\zapretik`).
5. Use one of:
   - run a strategy `.bat` directly (for testing);
   - or use `service.bat` to install a strategy as a Windows service.

## ℹ️ Key files

- **`general*.bat`** — manual start of different DPI‑bypass strategies.  
  Use these to test which strategy works best for your ISP and region.

- **`service.bat`** — main service manager:
  - **`Install Service`** — install selected strategy as an auto‑start service;
  - **`Remove Services`** — remove strategy service and WinDivert services;
  - **`Check Status`** — show service status and verify required files in `bin\`
    (`winws.exe`, `WinDivert*.sys`, `WinDivert.dll`, `cygwin1.dll`);
  - **`Game filter`** — toggle game‑oriented rules (high TCP/UDP ports).  
    After changing the mode restart the strategy;
  - **`Ipset filter`** — enable/disable filtering based on `ipset-all.txt`;
  - **`Auto-update check`** — on/off automatic version check of **zapretik**
    (this repository) at startup;
  - **`Update list-general`** — refresh `list-general.txt` with domains from  
    [`bol-van/rulist`](https://github.com/bol-van/rulist);
  - **`Update ipset-all`** — refresh `ipset-all.txt` with IP ranges from `rulist`;
  - **`Update bin files`** — download / update `winws.exe` and WinDivert binaries  
    from [`zapret-win-bundle/zapret-winws`](https://github.com/bol-van/zapret-win-bundle/tree/master/zapret-winws);
  - **`Run Diagnostics`** — common environment checks (services, drivers, DNS, hosts, conflicts);
  - **`Run Tests`** — open PowerShell test suite (`utils/test zapret.ps1`).

## 🧩 Strategies (short)

- `general-alt*.bat` — alternative HTTP/TLS strategies for YouTube / Discord.
- `general-fake-tls-auto*.bat` — automatic fake‑TLS‑based strategies.
- `general-simple-fake*.bat` — simpler “fake” strategies for weaker DPI.
- `shizapret.bat` — combined profile (Discord, YouTube, games, Roblox, WebRTC, etc.).

Try different ones until you find a stable combination for your provider.

## 🧰 Lists

Main user‑editable files in `lists\`:

- `list-general-user.txt` — additional domains to bypass;
- `list-exclude-user.txt` — domains to exclude from bypass;
- `ipset-all.txt` — networks / IP ranges;
- `ipset-exclude-user.txt` — IPs / ranges to exclude from ipset filter.

All `*-user.txt` files are created automatically on first run.

## 💾 Updates and safety

- Use `Update list-general` and `Update ipset-all` in `service.bat` to keep
  blocklists in sync with `bol-van/rulist`.  
  Downloads are atomic: if something goes wrong, the previous version is kept.
- Use `Update bin files` to refresh `winws.exe` and WinDivert binaries from
  the original zapret Windows bundle.
- Enable `Auto-update check` if you want `service.bat` to inform you when a new
  `zapretik` version is released.

## ⚖️ License and credits

- License: **MIT** (`license.txt`);
- Binaries in `bin\` — from  
  [`bol-van/zapret-win-bundle`](https://github.com/bol-van/zapret-win-bundle);
- Original ideas and configs:
  - [`bol-van/zapret`](https://github.com/bol-van/zapret);
  - [`Flowseal/zapret-discord-youtube`](https://github.com/Flowseal/zapret-discord-youtube);
  - [`sch-izo/shizapret`](https://github.com/sch-izo/shizapret).

