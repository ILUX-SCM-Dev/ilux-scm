#!/usr/bin/env bash
# Crea los issues iniciales y los mete al Project.
# Uso:  ./scripts/github/4_issues_iniciales.sh <numero_del_project>
# Córrelo UNA sola vez (si lo repites, duplica los issues).
set -euo pipefail
OWNER="ILUX-SCM-Dev"
REPO="ILUX-SCM-Dev/ilux-scm"
NUM="${1:?Falta el número del Project (lo imprimió 3_project.sh)}"

issue() {  # titulo, etiquetas (separadas por coma), milestone, cuerpo
  local url
  url=$(gh issue create -R "$REPO" --title "$1" --label "$2" --milestone "$3" --body "$4")
  gh project item-add "$NUM" --owner "$OWNER" --url "$url" >/dev/null
  echo "ok: $url  $1"
}

# ---------- v1.0 Demo a ILUX ----------
issue "Actualizar README con la estructura backend/ frontend/ docs/" \
  "tipo: docs" "v1.0 Demo a ILUX" \
"El repo se reorganizó: Django quedó en \`backend/\`. El README todavía explica la estructura vieja.

- [ ] Cómo levantar el proyecto (\`cd backend && ./iniciar.sh\`)
- [ ] Dónde poner \`data/BASE_DE_DATOS_MATERIAL.xls\` (no se sube al repo)
- [ ] Cómo compilar el front (\`frontend/\` → \`npm run build\`)"

issue "Revisión de seguridad antes de la demo" \
  "tipo: seguridad,area: backend" "v1.0 Demo a ILUX" \
"La app la va a usar una empresa real: la seguridad es prioridad.

- [ ] Ninguna clave real en el repo ni impresa por los scripts (\`iniciar.*\` muestra la clave del admin de prueba)
- [ ] \`DJANGO_SECRET_KEY\` y \`DJANGO_DEBUG=0\` siempre por variable de entorno fuera de desarrollo
- [ ] Revisar permisos de cada endpoint de la API (quién puede ver/crear remisiones y firmas)
- [ ] Límite de intentos de inicio de sesión
- [ ] \`python manage.py check --deploy\` sin avisos"

issue "CI: correr las pruebas automáticas en cada Pull Request" \
  "tipo: infra,tipo: pruebas" "v1.0 Demo a ILUX" \
"Crear un workflow de GitHub Actions que instale \`backend/requirements.txt\` y corra \`python manage.py test\` en cada PR hacia \`main\`.
Así nadie mezcla código que rompe lo que ya funcionaba."

issue "Plan de pruebas y guion de la demo a ILUX" \
  "tipo: pruebas" "v1.0 Demo a ILUX" \
"- [ ] Lista de casos a probar en celular (escaneo, cantidades, firma, PDF/Excel, sin señal)
- [ ] Datos de demostración realistas
- [ ] Guion paso a paso para la demo de diciembre"

issue "Cargar la base de datos definitiva de materiales" \
  "tipo: funcionalidad,area: backend,bloqueado" "v1.0 Demo a ILUX" \
"Hoy se usa la base de prueba. Jorge (Compras y Almacén) entregará la definitiva con lo que sí se usa.

Bloqueado hasta recibir el archivo."

# ---------- v1.1 Retos fase 2 ----------
issue "Reto ILUX: flujo completo desde la remisión hasta los costos" \
  "tipo: funcionalidad,reto ILUX,decisión pendiente" "v1.1 Retos fase 2" \
"Planteado por ILUX. Completar el alcance después de la reunión del martes:
- ¿Qué costos quieren ver (por proyecto, por material, por periodo)?
- ¿De dónde salen los precios? (hoy la app NO muestra precios)
- ¿Quién puede ver esa información?

Cuando el alcance esté claro, dividir en issues más pequeños."

issue "Reto ILUX: devoluciones de material" \
  "tipo: funcionalidad,reto ILUX,decisión pendiente" "v1.1 Retos fase 2" \
"Planteado por ILUX, lo profundizarán más adelante. Preguntas a resolver:
- ¿Se devuelve contra una remisión existente o es un documento nuevo?
- ¿Quién recibe y firma la devolución?
- ¿Se permiten devoluciones parciales?"

issue "Identificar herramientas y equipos que no tienen código impreso" \
  "tipo: funcionalidad,decisión pendiente" "v1.1 Retos fase 2" \
"Solo los materiales traen el código impreso; en herramientas y equipos se borra con el uso.
Decidir cómo identificarlos (etiqueta propia con QR/código, búsqueda por nombre, etc.)."

# ---------- v2.0 Despliegue y entrega ----------
issue "Definir infraestructura de despliegue" \
  "tipo: infra,decisión pendiente" "v2.0 Despliegue y entrega" \
"- [ ] Hosting y dominio (ej. scm.ilux.com.co)
- [ ] Base de datos de producción (¿PostgreSQL en vez de SQLite?)
- [ ] Copias de seguridad de la base y de las firmas (\`media/\`)
- [ ] HTTPS"

issue "Calcular el costo anual de mantener la app" \
  "tipo: docs" "v2.0 Despliegue y entrega" \
"El desarrollo es gratis para ILUX; se presenta el costo anual (hosting, dominio, soporte) en enero."

issue "Evaluar integración de correo (Mailbux / Outlook)" \
  "tipo: infra,decisión pendiente" "v2.0 Despliegue y entrega" \
"ILUX usa Mailbux como plataforma de correo y Outlook en la oficina. El profesor asesor advierte riesgos.
Decidir si la app enviará correos (ej. remisión firmada en PDF) y con qué servicio."

issue "Manual de uso y capacitación para ILUX" \
  "tipo: docs" "v2.0 Despliegue y entrega" \
"- [ ] Manual corto para almacén y para quien recibe/firma
- [ ] Sesión de capacitación"

echo; echo "Issues creados y agregados al Project $NUM."
