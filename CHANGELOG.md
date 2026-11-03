# Changelog

Versionen nach Semver: Farbton oder Abstand ändern = Minor, Klasse umbenennen
oder entfernen = Major (mit Hinweis hier).

## Unveröffentlicht

### Neu

- Gerüst der Rails-Engine `amberis_ui`.
- Farb-API: `$brand-primary`, `$brand-accent`, `$brand-success`,
  `$brand-warning`, `$brand-danger`, `$brand-info`, `$brand-bg` und
  `$brand-*-dark` für den Dark Mode; Standardwerte aus AmberisCare.
- Farb-Tokens (CSS-Variablen) hell und dunkel.
- Kontrast-Prüfung beim Kompilieren (`@warn` unter 4,5:1).
- Aus AmberisCare übernommen, unverändert: Tokens (Schatten, Radien,
  Abstände, UI-Höhen, Touch-Größen, Dark Mode mit Bootstrap-Anpassungen),
  Bootstrap-Konfiguration, `base/` (Reset, Typografie, Layout),
  Komponenten (Buttons, Karten, Modal, Formulare, Seitenleiste, Topbar,
  Tabellen, Badges, Avatar, Tabs, Navigation, Flash) und allgemeine Helper.
  Kompiliert identisch zu Care bis auf die gerundeten Farbwerte (Dark-Mode-
  Primär `rgb(217, 149, 63)` statt `#D9963F`).
