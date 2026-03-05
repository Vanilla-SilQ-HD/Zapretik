## Changelog

### 1.9.8 (Vanilla-SilQ-HD)

- **Версия**: обновление локальной версии до `1.9.8` (`service.bat`, `.service/version.txt`).
- **Форк**: репозиторий позиционирован как форк проектов `Flowseal/zapret-discord-youtube` и `sch-izo/shizapret` с сохранением MIT‑лицензии.
- **Стратегии**:
  - добавлен `shizapret.bat` с объединённой стратегией (Discord, YouTube, игры, WebRTC, Roblox);
  - сохранены все оригинальные `general*.bat` из `Flowseal`.
- **Обновление списков**:
  - добавлен `utils/update-rulist-lists.bat` для загрузки:
    - `list-general.txt` из `bol-van/rulist` (`reestr_hostname.txt`),
    - `ipset-all.txt` из `bol-van/rulist` (`reestr_smart4.txt`);
  - интеграция в `service.bat` — пункты меню:
    - `12. Update list-general` (hosts из rulist),
    - `13. Update ipset-all` (IP‑подсети из rulist).
- **UX `service.bat`**:
  - переупорядочено и переименовано меню:
    - блок `UPDATES (Flowseal)` — обновления из `.service` оригинального репозитория;
    - блок `ADVANCED LIST UPDATES (bol-van/rulist)` — обновление списков по базе Роскомнадзора;
  - исправлена обработка пустого ввода в `Game Filter`;
  - улучшена устойчивость `IPSet Filter` и вспомогательных скриптов.
- **Прочее**:
  - мелкие исправления в скриптах PowerShell/Batch (устойчивость загрузки через `curl`/`Invoke-WebRequest`).

