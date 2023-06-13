# Integrantes
- Juan Camilo Valencia Hincapié
- Junior Antonio Muñoz Henao
- Santiago Valencia Mejía
- Jhon Freddy Guerra Martínez

---

# Proyecto Final - Multimedia Interactiva

## Referencias utilizadas:
1. https://www.minijuegos.com/juego/arkanoid-online
2. https://www.youtube.com/watch?v=Ghf8gBEZICc
3. https://www.youtube.com/watch?v=atuFSv2bLa8
4. https://www.youtube.com/watch?v=dv13gl0a-FA
5. https://itch.io/

## Video:
- **Multimedia Interactiva:** https://drive.google.com/file/d/1Q5JNKEuopwg9mp1ByzB7z_5Tcltrcljq/view

## Descripción y fuente de inspiración:
La fuente de inspiración para este proyecto es sin duda el 'Boom' de los videojuegos que tiene su origen 
en las décadas de los 80's y 90's. Juegos como el mítico Arkanoid, así como el ecosistema sonoro y visual 
que lo acompañan, dieron pie al surgimiento de 'Pulse Arcade', un conjunto de 3 minijuegos Indie & Retro llamados 'Runner', 'Arkanoid' y 'Commander', donde en cada uno de ellos y con el objetivo de añadirles un toque mucho más interactivo, el jugador podrá controlar su posición por medio de señales OSC a través de un dispositivo móvil, y además, para el caso del juego 'Commander', los disparos emitidos por la nave se realizan por medio de la voz humana. 

Luego de finalizar cada partida en cualquiera de los 3 minijuegos disponibles, el jugador podrá conocer los puntos obtenidos conforme al avance logrado al mejor estio retro.  

---

# Proyecto de Generación de Imágenes

## Referencias utilizadas:
1. https://www.generativehut.com/post/using-processing-for-music-visualization
2. https://www.youtube.com/@Airroom/playlists
3. https://www.instagram.com/p/CpQbawrtPHr/
4. https://www.instagram.com/p/CpQpEeSrwaK/?igshid=YmMyMTA2M2Y%3D
5. https://www.instagram.com/p/CpW9WYpORdZ/?igshid=YmMyMTA2M2Y%3D

## Video:
- **DancingStar Kite:** https://drive.google.com/file/d/1xCbpK3hGxBdUTleS3rWIpl4BFYb5tWgD/view?usp=sharing
- **DancingStar Hanabi:** https://drive.google.com/file/d/1ou7Ebcri7nM0en6dMcTFNX-b438tfHsn/view?usp=sharing

## Descripción y fuente de inspiración:
La idea tras este proyecto surgió a partir del tutorial del primer enlace, el cual hace uso de los datos de un archivo de audio para la generación de visuales. Partiendo de este punto se utilizaron como guía los tutoriales de Processing del segundo enlace y se implementó la figura central de las visuales y todos los aspectos técnicos relacionados al color y a su movimiento.

El trabajo logrado muestra como varía el comportamiento de nuestro elemento principal (estrella) en función de los tonos musicales percibidos en la pista de audio en un momento determinado, así que, por ejemplo, el comportamiento frente a tonos suaves refleja poco movimiento y una sensación de calma en la estrella, mientras que el comportamiento frente a tonos fuertes o explosivos en la pista de audio, muestra como la estrella adquiere una conducta más caótica y con mayor destello de colores.

Finalmente, y con la intención de añadir aleatoriedad y un fondo para las visuales, se emplearon como fuente de inspiración los ejemplos de los enlaces 3, 4 y 5  y se crearon 2 versiones del proyecto, una a partir del tercer enlace (carpeta DancingStar_Hanabi) y otra a partir del cuarto y quinto enlace (carpeta DancingStar_Kite).

---

# Proyecto de Generación de Audio

## Referencias utilizadas:
- https://abletunes.com/product/sample-packs/free-trap-samples-drum-kits#

## Video:
- **DancingStar PureStar:** https://drive.google.com/file/d/1YVtOHE9EI0QV4MuQsobY0ilGSCeG-fGC/view?usp=sharing

## Descripción y fuente de inspiración:
La fuente de inspiración para este proyecto son los samples de trapstep que se encuentran en el enlace de las referencias. Se partió de lo implementado anteriormente en el proyecto de generación de imágenes y se fusionaron las dos versiones presentadas (DancingStar Kite y DancingStar Hanabi), las cuales tienen como diferencia el uso de fondos distintos.

Se hace uso de cinco samples controlados mediante Pure Data: uno de voz, dos de 808's y dos de snares, y la información que se envia a Processing a partir de estos es utilizada de la siguiente forma (el nombre de cada sample coincide con el nombre que poseen internamente en Pure Data):

- **voice:** activa las lineas presentes en de la version "Kite" del proyecto de generación de imágenes.
- **a2:** controla la rotación de la estrella.
- **a4b:** genera un efecto de rotación mediante el dibujado de las estrellas internas en ángulos distintos.
- **a3:** genera un efecto de destello en la estrella.
- **a4:** activa los círculos presentes en de la version "Hanabi" del proyecto de generación de imágenes.

