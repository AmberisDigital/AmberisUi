# Changelog

Versionen nach Semver: Farbton oder Abstand ändern = Minor, Klasse umbenennen
oder entfernen = Major (mit Hinweis hier).

## 0.2.0

### Neu

- `.btn-collapse`: Button mit Icon und Text, auf dem Handy (bis 576 px)
  nur das Icon, quadratisch wie `.btn-icon`. Der Text steht in
  `.btn-text`, der Button braucht ein `aria-label`:

  ```haml
  = link_to edit_path, class: "btn btn-sm btn-light border btn-collapse", "aria-label": "Bearbeiten" do
    %i.bi.bi-pencil{ "aria-hidden": "true" }
    %span.btn-text Bearbeiten
  ```

  Nur für eindeutige Icons (Bearbeiten, Löschen, Vorschau): Auf dem Handy
  gibt es keinen Tooltip.

### Behoben

- Modals auf dem Handy: Die Höhe richtet sich nach dem sichtbaren Bereich
  (`dvh`, `vh` als Fallback). Mit `vh` zählte der Platz hinter der
  Adressleiste mit, und der Kopf mit dem Schließen-Button konnte oben aus
  dem Bild rutschen. `.modal-dialog-scrollable` ist nur so hoch wie sein
  Inhalt; lange Wörter im Modal-Body brechen um.

## 0.1.2

### Behoben

- `btn-outline-secondary`, `-danger`, `-success`, `-warning`, `-dark` …
  hatten keinen Rahmen (nur beim Hover): `.btn` setzte
  `border: 1px solid transparent` und überdeckte Bootstraps
  `--bs-btn-border-color`. Der Fehler stammt aus Cares altem Stylesheet.

## 0.1.1

### Behoben

- Menüeinträge im Handy-Menü (Offcanvas) sehen aus wie in der Sidebar:
  aktive Fläche, Akzentbalken, Icon-Farben. Die Regeln galten nur in
  `.sidebar`; jetzt auch in `.sidebar-nav`.

## 0.1.0

### Neu

- Gerüst der Rails-Engine `amberis_ui`.
- Farb-API: `$brand-primary`, `$brand-accent`, `$brand-success`,
  `$brand-warning`, `$brand-danger`, `$brand-info`, `$brand-bg` und
  `$brand-*-dark` für den Dark Mode; Standardwerte aus AmberisCare.
- Farb-Tokens (CSS-Variablen) hell und dunkel.
- Kontrast-Prüfung beim Kompilieren (`@warn` unter 4,5:1).
- Neutral-Paletten: `$neutral-palette: warm` (Standard, Care/Cockpit) oder
  `cool` (grau-grün, Flow) — Hintergrund, Text, Rahmen, Flächen und
  Schattenfarbe; Dark Mode für beide gleich.
- `.required` für Pflichtfeld-Labels (roter Stern), aus AmberisFlow.
- Schrift DM Sans selbst ausgeliefert (variable woff2 aus
  `@fontsource-variable/dm-sans` 5.3.0, SIL OFL 1.1) — vorher war sie in
  allen Apps angegeben, aber nirgends geladen; es galt die Systemschrift.
- Aus AmberisCare übernommen, unverändert: Tokens (Schatten, Radien,
  Abstände, UI-Höhen, Touch-Größen, Dark Mode mit Bootstrap-Anpassungen),
  Bootstrap-Konfiguration, `base/` (Reset, Typografie, Layout),
  Komponenten (Buttons, Karten, Modal, Formulare, Seitenleiste, Topbar,
  Tabellen, Badges, Avatar, Tabs, Navigation, Flash) und allgemeine Helper.
  Kompiliert identisch zu Care bis auf die gerundeten Farbwerte (Dark-Mode-
  Primär `rgb(217, 149, 63)` statt `#D9963F`).

### Geändert gegenüber Care

- `.text-warning` nutzt `--warning` (Orange-Rot) statt des alten `#b45309`.
- Warme statt kalte Grautöne: neue Tokens `--border-hover` (Feld-Hover,
  Scrollbalken) und `--backdrop` (Modal-Hintergrund); gestreifte
  Tabellenzeilen `--surface-2` (vorher fest `#fcfcfd`, auch im Dark Mode);
  `.bg-secondary-soft` = `--hover-bg`.
- Entfernt: die ungenutzte Schiebe-Seitenleiste ≤ 768 px
  (`.sidebar-open`, `.sidebar-overlay`, `.sidebar-toggle`). Unter `lg`
  gilt nur das Offcanvas.
- `.nav-pills` nur noch in `_tabs.scss` (gleiche Werte wie bisher wirksam).
- Karten-Innenabstand `--space-4` (16 px) statt 15 px.
- `p` ist nicht mehr grau, sondern erbt die Textfarbe.
- Seitentitel einheitlich 22 px: `h1` 26 → 22 px, `h2` 22 → 20 px,
  `.topbar-title` 22,4 → 22 px. Seitentitel als `h1` **ohne** `.hX`-Klasse
  schreiben (`h1.h4` war 16 px, `h1.h3` 18 px).
