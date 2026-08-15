# rezepte-content

Rezeptdaten (Markdown) für die App **RezepteWeb** – getrennt vom App-Code, damit Rezept-Änderungen keinen Rebuild der Webseite auslösen.

## Aufbau

- `recipes/*.md` – Rezepte als Markdown (Source of Truth)
- `recipes/index.json` – generiertes Manifest (wird NICHT von Hand gepflegt)

## So funktioniert es

- Die App liest `recipes/index.json` zur Laufzeit von `https://raw.githubusercontent.com/GrafCode404/rezepte-content/main/recipes/index.json`.
- `index.json` wird automatisch neu erzeugt:
  - von der Webseite aus beim Speichern (Editor schreibt `.md` + `index.json`),
  - zusätzlich per Workflow (`.github/workflows/regenerate-index.yml`) bei jedem Push auf `main` – Absicherung für direkte Edits über die GitHub-Weboberfläche.

## Neues Rezept hinzufügen

Eine neue `*.md`-Datei in `recipes/` anlegen. Format:

- Erste Zeile: Titel als `# Überschrift`
- Danach Fakten als Bullets `* **Schlüssel:** Wert`
- Zutaten-Tabelle mit Spalten `1x / 2x / 3x`
- `## Anleitungen` mit `### Unterüberschriften`

`recipes/index.json` NICHT manuell editieren – es wird automatisch erzeugt.
