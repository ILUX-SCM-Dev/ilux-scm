# Flujo de trabajo — ILUX SCM

Todo el trabajo vive en el Project **ILUX SCM** de la organización `ILUX-SCM-Dev`.
Si no hay issue, no se programa.

## 1. Las piezas y para qué sirve cada una

| Pieza | Responde a | Ejemplo |
|---|---|---|
| **Issue** | ¿Qué hay que hacer? | "Reto ILUX: devoluciones" |
| **Etiquetas** | ¿Qué tipo de trabajo es y qué parte del código toca? | `tipo: bug`, `area: frontend` |
| **Milestone** | ¿En qué entrega sale? | `v1.0 Demo a ILUX` |
| **Status** (Project) | ¿En qué va? | En progreso |
| **Prioridad** (Project) | ¿Qué va primero? | Alta |
| **Tamaño** (Project) | ¿Cuánto trabajo es? | M |
| **Iteración** (Project) | ¿En qué quincena se hace? | Iteración 2 |
| **Assignee** | ¿Quién lo hace? | Matías |

Regla: la planeación (estado, prioridad, tamaño, iteración) va en campos del Project, no en etiquetas.
Así no hay dos lugares diciendo cosas distintas.

## 2. Estados (Status)

- **Backlog**: existe, pero aún no está listo o no es para esta iteración.
- **Por hacer**: claro y priorizado; el siguiente que esté libre lo toma.
- **En progreso**: alguien lo tiene asignado y tiene rama abierta.
- **En revisión**: hay un Pull Request esperando que otro lo revise.
- **Hecho**: el PR se mezcló a `main` (el issue se cierra solo).

## 3. Ramas, commits y Pull Requests

1. Tomar un issue → asignármelo → moverlo a **En progreso**.
2. Crear rama desde `main` actualizado:
   ```bash
   git switch main && git pull
   git switch -c feat/12-devoluciones      # tipo/numero-descripcion
   ```
   Tipos de rama: `feat/`, `fix/`, `docs/`, `chore/`, `test/`.
3. Commits pequeños con prefijo: `feat: ...`, `fix: ...`, `docs: ...`, `test: ...`, `chore: ...`.
4. Subir y abrir PR:
   ```bash
   git push -u origin feat/12-devoluciones
   gh pr create --fill
   ```
   En la descripción escribir `Cierra #12` para que el issue se cierre solo al mezclar.
5. **Otro integrante** revisa y aprueba. Nadie mezcla su propio PR sin revisión.
6. Mezclar con **Squash and merge** y borrar la rama.

Nunca se hace push directo a `main` (el plan gratis no permite bloquearlo en repos privados, así que es un acuerdo del equipo).

## 4. Cuando ILUX pide algo nuevo

1. Crear issue con la plantilla **Reto o pedido de ILUX**.
2. Dejarlo en **Backlog** con `decisión pendiente` hasta tener claro el alcance.
3. Cuando esté claro: dividir en issues pequeños (tamaño S o M), ponerles milestone y prioridad.
