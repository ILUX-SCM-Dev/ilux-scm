#!/usr/bin/env bash
# Crea las etiquetas del repo ILUX-SCM-Dev/ilux-scm.
# Se puede correr varias veces: --force actualiza la etiqueta si ya existe.
#
# Idea: las ETIQUETAS dicen QUÉ es el issue y DÓNDE toca el código.
# La prioridad, el tamaño y el estado NO van aquí: son campos del Project (ver docs/flujo-de-trabajo.md).
set -euo pipefail
REPO="ILUX-SCM-Dev/ilux-scm"

# 1) Borrar las etiquetas por defecto de GitHub (en inglés y se cruzan con las nuestras)
for l in "bug" "documentation" "duplicate" "enhancement" "good first issue" "help wanted" "invalid" "question" "wontfix"; do
  gh label delete "$l" -R "$REPO" --yes 2>/dev/null && echo "borrada: $l" || true
done

crear() { gh label create "$1" -R "$REPO" --color "$2" --description "$3" --force; echo "ok: $1"; }

# 2) Tipo: qué clase de trabajo es (un issue lleva UNA)
crear "tipo: funcionalidad" "1f6feb" "Algo nuevo que hace la app"
crear "tipo: mejora"        "a2eeef" "Cambio a algo que ya existe"
crear "tipo: bug"           "d73a4a" "Algo que funciona mal"
crear "tipo: seguridad"     "b60205" "Riesgo o refuerzo de seguridad"
crear "tipo: pruebas"       "c5def5" "Pruebas automáticas o manuales"
crear "tipo: docs"          "0075ca" "Documentación, manuales, README"
crear "tipo: infra"         "5319e7" "Despliegue, servidor, CI, backups"

# 3) Área: qué parte del código toca (puede llevar las dos)
crear "area: backend"  "0e8a16" "Django / API"
crear "area: frontend" "fbca04" "React"

# 4) Marcas especiales
crear "reto ILUX"          "f9a03f" "Pedido directamente por ILUX"
crear "bloqueado"          "3d3d3d" "Espera algo externo (respuesta de ILUX, datos, etc.)"
crear "decisión pendiente" "d4c5f9" "Hay que decidir en equipo antes de programar"

echo; gh label list -R "$REPO"
