# Artemis: backend

Función serverless (Vercel) + base de datos (Supabase) + IA (NVIDIA). Sin dependencias que instalar.

## Qué hace el servidor
- Guarda cuentas, perfiles, proyectos, chats y mensajes en Supabase.
- Contraseñas cifradas (scrypt) y sesiones firmadas.
- La key de NVIDIA vive solo en el servidor.
- Cuenta los 100 mensajes cada 30 minutos por cliente, en el servidor (no se puede saltar).
- Reintenta solo si NVIDIA responde con error 429 o 5xx.
- Rechaza cuentas deshabilitadas, vencidas y perfiles deshabilitados.
- Verifica el login de Google con Google.
- Panel admin protegido con PIN (3 intentos fallidos = bloqueo de 30 s).

## Puesta en marcha
1. **Supabase** (supabase.com): crea un proyecto. En "SQL Editor" pega todo `schema.sql` y ejecútalo.
   En Project Settings > API copia la URL y la `service_role` key (secreta, nunca en el frontend).
2. **GitHub**: sube esta carpeta a un repositorio nuevo (con `api/`, `public/`, `vercel.json`, `package.json`).
3. **Vercel** (vercel.com): "Add New Project", importa el repositorio y antes de desplegar agrega las variables de `.env.example`:
   - `SUPABASE_URL`, `SUPABASE_SERVICE_KEY`
   - `SESSION_SECRET`: una cadena larga al azar (30+ caracteres)
   - `ADMIN_PIN`: tu PIN inicial (4 a 8 números)
   - `NVIDIA_API_KEY` (y opcional `NVIDIA_MODEL`)
   - `GOOGLE_CLIENT_ID` y `WEB3FORMS_KEY` cuando los tengas
4. Despliega. Tu página queda en `https://tu-proyecto.vercel.app`.

## Rutas (todas bajo /api)
Públicas: `POST login`, `POST google`, `POST request`, `POST admin/login`
Cliente (con sesión): `GET me`, `POST password`, `POST profile`, `PUT profile/:id`, `GET hist?profile=`,
`POST project`, `PUT project/:id`, `DELETE project/:id`, `GET chat/:id`, `DELETE chat/:id`, `POST chat`
Admin (con PIN): `GET admin/data`, `POST admin/client`, `PATCH admin/client/:id`, `DELETE admin/client/:id`,
`PATCH admin/profile/:id`, `DELETE admin/request/:id`, `POST admin/request/:id/accept`, `POST admin/pin`

## Notas
- NVIDIA build.nvidia.com es gratis solo para pruebas; para cobrar a clientes revisa sus términos o cambia a un proveedor de pago (solo cambia la URL y la key en `ai()`).
- El admin ya no puede ver contraseñas (están cifradas); al crear un cliente se muestra la contraseña una sola vez, y después solo se puede cambiar.
