#Reproducir video RCA desde dos Arduinos

<p>Este proyecto genera una señal de video RCA desde dos arduinos, uno está conectado un lector de tarjeta SD con su respectiva <a href="http://www.arduino.cc/en/Reference/SD">librería</a>, el otro genera la señal de video mediante la librería <a href="https://github.com/Avamander/arduino-tvout/">TVout</a>. Ambos se conectan mediante comunicación I2C y un pin en modo de semáforo para parar y continuar la comunicación.</p>

![Conexiones de los arduinos](archive/circuit_image.png)

[!WARNING]
El autor de este proyecto posee un arduino uno con un shield con lector de tarjetas SD por lo que no está completamente seguro de las conexiones del lector de tarjetas del diagrama, así como también posee un arduino nano sin pines SDA y SCL por lo que usa los pines A4 y A5. Tome este diagrama como una guía e investigue cuales son los pines reales para su lector de tarjetas y los pines SDA y SCL, así como considerar que la librería TVout reserva los pines D7 y D9 para generar la imagen de video, puede poner el pin de semáforo donde estime conveniente.  

<p>Por otro lado, si ya conoces algo de la librería TVout sabrás que la señal de video que se produce tiene solo pixeles de un bit, solo blanco y negro, además de que la resolución máxima es de 120 x 96 pixeles, por lo cual si quieres tener un video grabado deberías por lo menos hacerle un post-procesado para que se pueda entender la imagen. Por esto, dentro de los archivos deje un archivo de Processing con funciones que dibujan en el void draw() o en el buffer que se le indique la imagen entregada con un filtro bayer o "bit map", está en sus versiones 2x2, 4x4 y 8x8. Además intentar usar imágenes con alto contraste y poco detalle para lograr un mejor entendimiento de las imagenes.</p>

![Ejemplo de imagen con efecto bitmap tipo cowboy](archive/cowboyExample.gif) 
![Ejemplo de imagen con efecto bitmap tipo robot](archive/robotExample.gif)
