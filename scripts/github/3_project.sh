#!/usr/bin/env bash
# Crea el GitHub Project de la organización, lo enlaza al repo y le agrega los campos propios.
# Requiere el permiso "project" en gh:  gh auth refresh -s project
#
# Lo que gh NO puede hacer (se hace en la web, ver docs/flujo-de-trabajo.md):
#   cambiar las opciones de Status, crear el campo Iteración, las vistas y los workflows.
set -euo pipefail
OWNER="ILUX-SCM-Dev"
REPO_NAME="ilux-scm"

NUM=$(gh project create --owner "$OWNER" --title "ILUX SCM" --format json --jq '.number')
echo "Project creado: número $NUM"

# Enlazar: el Project aparece en la pestaña Projects del repo
gh project link "$NUM" --owner "$OWNER" --repo "$REPO_NAME"

# Prioridad: qué se hace primero cuando hay varias cosas en "Por hacer"
gh project field-create "$NUM" --owner "$OWNER" --name "Prioridad" \
  --data-type SINGLE_SELECT --single-select-options "Alta,Media,Baja"

# Tamaño: estimación gruesa. S = menos de 1 día, M = 2-3 días, L = una semana (si es más, dividir el issue)
gh project field-create "$NUM" --owner "$OWNER" --name "Tamaño" \
  --data-type SINGLE_SELECT --single-select-options "S,M,L"

echo
echo "Listo. Guarda este número para el siguiente script:  $NUM"
echo "Web: https://github.com/orgs/$OWNER/projects/$NUM"
