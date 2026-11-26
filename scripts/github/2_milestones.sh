#!/usr/bin/env bash
# Crea los milestones (entregas) del repo. gh no tiene comando propio para esto, así que se usa la API.
# Un milestone = una entrega con fecha. Cada issue pertenece a UNO; GitHub muestra el % cerrado.
# Ajusta las fechas si el cronograma cambia (también se pueden editar luego en Issues → Milestones).
set -euo pipefail
REPO="ILUX-SCM-Dev/ilux-scm"

crear() {  # titulo, descripcion, fecha (AAAA-MM-DD o vacío)
  local args=(-f title="$1" -f description="$2")
  [ -n "$3" ] && args+=(-f due_on="$3T23:59:59Z")
  gh api "repos/$REPO/milestones" "${args[@]}" --silent && echo "ok: $1" || echo "ya existía (o error): $1"
}

crear "v1.0 Demo a ILUX" \
  "Pruebas internas, ajustes de seguridad y demostración a ILUX (diciembre 2026)." "2026-12-18"
crear "v1.1 Retos fase 2" \
  "Retos que plantee ILUX: flujo remisión → costos, devoluciones. Fecha por definir tras la reunión." ""
crear "v2.0 Despliegue y entrega" \
  "Despliegue real, costo anual de mantenimiento, capacitación y entrega a ILUX (enero 2027)." "2027-01-29"

echo; gh api "repos/$REPO/milestones" --jq '.[] | "#\(.number)  \(.title)  vence: \(.due_on // "sin fecha")"'
