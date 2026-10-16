# 🤖 Sala con aspiradora robot

Simulación interactiva, vista desde arriba, de una sala con una aspiradora robot, un sofá individual, una lámpara y una mesa. Al tocar un destino, el robot calcula el camino, lo dibuja, muestra la distancia y se mueve hasta allí.

## Características

- Camino calculado con A\* evitando los muebles.
- Distancia en metros (50 px = 1 m) sobre cada tramo.
- Camino en **rojo** si el destino es la mesa y en **azul** para los demás.
- **Recorrido completo:** sofá → lámpara → mesa, con las líneas numeradas que se quedan dibujadas.
- **Vectores:** flechas por tramo, vector resultante (verde) con sus componentes, módulo y ángulo.
- Botones para ir a cada mueble, a la base, activar o desactivar vectores y borrar las líneas.
- Funciona en computadora y en celular (táctil).

## Cómo usarlo

Es un solo archivo, sin dependencias ni instalación.

1. Descarga o clona el repositorio.
2. Abre `index.html` en el navegador.

## Publicarlo con GitHub Pages

1. Sube `index.html` y `README.md` a un repositorio.
2. Ve a **Settings → Pages**.
3. En **Source** elige la rama `main` y la carpeta `/ (root)`, y guarda.
4. Espera un minuto: la página quedará en `https://TU-USUARIO.github.io/NOMBRE-DEL-REPO/`.

## Tecnologías

HTML, CSS y JavaScript puro con `<canvas>`.
