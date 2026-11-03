# amberis_ui

Gemeinsames Aussehen für die Amberis-Apps (Cockpit, Flow, Care): Bootstrap-
Konfiguration, Design-Tokens, Komponenten und Layout-Partials. Jede App setzt
**nur ihre Farben** — Abstände, Schrift, Komponenten und Layout sind überall
gleich. Hintergrund und Plan: `docs/layout.md` in AmberisCockpit.

> Stand: Farb-API, Tokens, Basis-Styles, Komponenten (aus AmberisCare
> übernommen) und die Schrift DM Sans. Layout-Partials, Helper, Stimulus
> und Styleguide folgen (siehe CHANGELOG).

## Was drin ist

| Ordner / Datei | Inhalt |
|---|---|
| `_colors.scss` | Farb-API (`$brand-*`), Neutraltöne, Ableitungen, Bootstrap-Farben |
| `_config.scss` | Bootstrap-Einstellungen: Radien, Schriftfamilie |
| `_contrast.scss` | Kontrast-Prüfung beim Kompilieren |
| `_tokens.scss` | CSS-Variablen: Farben, Schatten, Radien, Abstände (`--space-*`), UI-Höhen (Touch 44 px), Dark Mode inkl. Bootstrap-Anpassungen |
| `base/` | Schrift DM Sans (`@font-face`), Reset, Typografie, App-Layout, Admin-Hinweis, Fußzeile |
| `app/assets/fonts/amberis_ui/` | DM Sans als variable woff2 (alle Stärken, normal und kursiv, Latin + Latin-Erweitert), Lizenz SIL OFL 1.1 |
| `components/` | Buttons, Karten, Modal, Formulare inkl. Tom Select, Seitenleiste, Topbar, Tabellen inkl. Handy-Karten, Badges, Avatar, Tabs, Navigation, Flash/Toasts |
| `utilities/_helpers.scss` | allgemeine Helfer-Klassen |

Tom Selects Grundstil bindet die Bibliothek selbst ein (vor den
Formular-Styles, die ihn anpassen).

Nicht enthalten — bindet die App nach `@import "amberis_ui"` selbst ein:
Icon-Schrift (`bootstrap-icons`), Trix, Kalender und app-eigene Seiten
unter `pages/`.

## Einbinden

```ruby
# Gemfile der App
gem "amberis_ui", git: "git@github.com:AmberisDigital/AmberisUi.git", tag: "v0.1.0"
```

```scss
// app/assets/stylesheets/application.scss
$brand-primary: #9C5D0D;   // optional — Standard ist Amber (Care)
$brand-accent:  #C77C1E;
@import "amberis_ui";
```

`amberis_ui` bindet Bootstrap und Tom Select selbst ein; in der App kein
eigenes `@import "bootstrap"` oder `@import "tom-select-rails/…"`. dartsass-rails findet die Dateien ohne weitere
Konfiguration, weil die Asset-Pfade der Engine automatisch Sass-Load-Paths sind.

## Farben

Nur diese Variablen darf eine App setzen, **vor** `@import "amberis_ui"`:

| Variable | Wofür | Standard |
|---|---|---|
| `$brand-primary` | Flächen und Text (Buttons, Links). Weiß darauf braucht 4,5:1. | `#9C5D0D` |
| `$brand-accent` | Akzente: Icons, aktiver Menüpunkt, zarte Flächen, Fokus-Ring | `#C77C1E` |
| `$brand-success`, `$brand-warning`, `$brand-danger`, `$brand-info` | Status | Grün, Orange-Rot, Rot, Blau |
| `$brand-bg` | Seitenhintergrund | `#FAF6EF` |
| `$brand-primary-dark` | Markenfarbe im Dark Mode | aus `$brand-accent` abgeleitet |
| `$brand-success-dark` … `$brand-info-dark` | Status im Dark Mode | helle Töne |

Daraus leitet die Bibliothek Hover, Gedrückt, `--primary-soft`,
`--primary-line`, Fokus-Ring und den Dark Mode ab. Bootstraps `$primary`,
`$secondary` … setzt die Bibliothek selbst; eine App überschreibt sie nicht.

**Kontrast-Prüfung:** Beim Kompilieren erscheint eine Warnung, wenn ein
Text-/Flächen-Paar unter 4,5:1 (WCAG AA) liegt, z. B.

```
WARNING: amberis_ui: Weiß auf $brand-primary hat Kontrast 3.3:1 (white auf #C77C1E), nötig sind 4.5:1.
```

Je App:

| App | `$brand-primary` | `$brand-accent` |
|---|---|---|
| Care, Cockpit | `#9C5D0D` | `#C77C1E` (Amber) |
| Flow | folgt | Smaragd |

## Entwickeln

Gleichzeitig an Bibliothek und App arbeiten, ohne jedes Mal einen Tag zu setzen:

```sh
cd ~/development/AmberisCare
bundle config local.amberis_ui ~/development/AmberisUi
```

Bundler nimmt dann den lokalen Stand (Branch muss zum Gemfile passen).
Wieder lösen: `bundle config unset local.amberis_ui`.

Tests:

```sh
bundle install
bundle exec rake
```

## Versionen

Neue Versionen werden in den Apps bewusst über den Tag übernommen. Semver:
Farbton oder Abstand ändern = Minor, Klasse umbenennen oder entfernen = Major
mit Hinweis im CHANGELOG.
