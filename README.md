# Detalles del proyecto
**Tarea II:** Diseño digital sincrónico en HDL 
**Integrantes del proyecto:** Felipe Sánchez Segura y Gabriel Morgan Ovares
# 1. Introducción 
Este proyecto desarrolla un sistema digital sincrónico implementado en una FPGA que permite capturar dos números decimales positivos de hasta tres dígitos, ingresados a través de un teclado hexadecimal tipo matricial, y desplegar la suma de estos en un conjunto de cuatro displays de 7 segmentos. El diseño se ha implementado en SystemVerilog, cumpliendo con los principios de sincronización y estructuración modular vistos en clase. 
### 1.1 Objetivo General
Desarrollar un sistema digital sincrónico en HDL que ejecute la captura, procesamiento y visualización de dos números decimales ingresados desde un teclado hexadecimal.
### 1.2 Objetivos específicos
-  Implementar la lectura del teclado con un eliminador de rebote (debouncer)
- Controlar la carga de los datos con una FSM.
- Almacenar dos operandos A y B en registros.
- Realizar la suma aritmética en BCD.
- Multiplexar los datos para su despliegue en 7 segmentos.
- Validar el diseño mediante simulaciones.
# 2. Descripción general del sistema
El sistema se divide en **tres subsistemas** principales, interconectados y sincronizados:
#### 2.1. Lectura de teclado
- Escaneo por contador de 2 bits.
- Decodificación fila-columna.
- Eliminación de rebote.
- FSM de carga que registra unidades, decenas y centenas.
#### 2.2. Suma aritmética
- Los operandos se cargan en BCD.
- Se suman en tres niveles (unidades, decenas, centenas) con sumadores BCD.
- Resultado también en BCD (sin conversión binaria intermedia).
#### 2.3. Despliegue
- Mux de selección de fuente: muestra A, B o suma.
- Multiplexor 4:1 para seleccionar dígito activo.
- Mux one-hot para activar ánodos.
- Codificador BCD a 7 segmentos.
# 3. Diagramas de bloques
#### 3.1. Diagrama general del sistema
En el presente diagrama se muestra un esquema general de las conexiones del sistema. Se tiene como entrada las filas, el reloj y un botón de reset que reinicia el sistema. Como salida se tiene la suma de los operandos y los operandos en el sistema de despliegue de siete segmentos.

![general](https://github.com/user-attachments/assets/99685757-58ac-471e-8477-881628774878)

#### 3.2. FSM carga de dígitos
Esta máquina de estados es la encargada de cargar los dígitos de unidades, decenas y centenas en función de una señal de control llamada `tecla`. Este pulso proviene del sistema de lectura y es el encargado de señalar si se ha presionado una tecla o no. Cuando ya se han cargado todos los dígitos, esta máquina da como salida una señal `load_out`, la cual será una señal de control en la siguiente máquina de estados.

![fsm_digitos](https://github.com/user-attachments/assets/2ec186ff-6dc1-4a6f-8c7b-db221712ca19)

#### 3.3. FSM carga de operandos
Esta máquina de estados es la encargada de cargar los dos operandos a ser sumados. En la FSM anterior `load_out` pasa a ser `RDY` y será la señal de control de esta máquina. Si se cargan los primeros 3 dígitos, este se guarda en un registro y espera la siguiente señal. Las salidas de esta máquina de estados funcionan también como señales de control para el sistema de despliegue.

![fsm_carga](https://github.com/user-attachments/assets/b8dad678-9dbc-44bd-bd85-38d2e9eecbf0)


### 3.4. Sistema de lectura de teclado
Este subsistema permite capturar los dígitos ingresados desde un teclado hexadecimal matricial. Utiliza un contador de 2 bits para generar el barrido lógico de columnas, mientras se monitorean las filas para detectar pulsaciones. Las señales pasan por un debouncer que elimina rebotes mecánicos y generan un pulso limpio (`tecla`). Luego, un decodificador identifica la tecla presionada a partir de la combinación fila-columna. La FSM de carga controla la secuencia de registro de las unidades, decenas y centenas en formato BCD.

![lectura](https://github.com/user-attachments/assets/bdda6799-824a-4770-8cb6-62beba2346c8)


#### 3.5. Sistema de suma 
Este bloque almacena los dos operandos en registros independientes controlados por las señales `LD_A` y `LD_B`. Una vez ambos operandos están cargados, el módulo de suma realiza la operación aritmética en formato BCD. El resultado se entrega también en BCD y es utilizado por el subsistema de despliegue.
![suma](https://github.com/user-attachments/assets/784f67eb-61b0-4650-b688-fe462cbb4d50)


#### 3.6. Sistema de despliegue
Este sistema muestra los operandos A, B y la suma mediante un selector y un controlador de siete segmentos. La señal `sel_out` viene codificada de la salida de la FSM de operandos.

![display](https://github.com/user-attachments/assets/bdd7bd71-792e-4f79-8d9b-c88fa8e1583d)


# 4. Simulaciones y consumo de recursos
En esta sección se muestra el tb ejecutado para comprobar el funcionamiento del sistema, así también como el consumo de recursos.
### 4.1. Testbench
![tb](https://github.com/user-attachments/assets/c57b065e-c0a8-418f-b206-bf014b10ad23)

### 4.2. Consumo de recursos
```
=== module_top ===
   Number of wires:                216
   Number of wire bits:            421
   Number of public wires:         216
   Number of public wire bits:     421
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                248
     ALU                            18
     DFF                             9
     DFFR                            8
     DFFRE                          50
     GND                             1
     IBUF                            6
     LUT1                           76
     LUT2                            7
     LUT3                            4
     LUT4                           21
     MUX2_LUT5                      20
     MUX2_LUT6                       8
     MUX2_LUT7                       2
     MUX2_LUT8                       1
     OBUF                           16
     VCC                             1
```
# 5. Problemas encontrados durante el proyecto
Durante el desarrollo del proyecto, se identificaron los siguientes desafíos:
1. **Manejo del tiempo y coordinación en el equipo**  
    La distribución de tareas y la coordinación entre los miembros del grupo no fue la óptima al inicio del proyecto, lo que ocasionó retrasos en fases críticas como la integración y pruebas. Esto se  puede resolver mejorando la comunicación, definiendo responsabilidades específicas para cada integrante y fechas de avance para cada parte del proyecto.

2. **Implementación del sistema de lectura del teclado y debouncing**  
    La lectura confiable del teclado hexadecimal presentó dificultades, principalmente por el manejo de rebotes y la sincronización con el reloj del sistema. Inicialmente, los rebotes provocaban múltiples registros incorrectos. Se solucionó implementando un módulo de eliminador de rebote basado en flip-flops y un contador, y sincronizando su salida con la FSM de carga.

3. **Transición del diseño RTL a la implementación física**  
    Al pasar de simulación a implementación en la FPGA, surgieron problemas relacionados con tiempos de respuesta, incompatibilidades de conexión y frecuencia de operación. Algunos módulos que funcionaban en simulación no reaccionaban correctamente en hardware real. Esto obligó a depurar señales internas, revisar restricciones de pines y ajustar los divisores de frecuencia para el teclado y los displays. A pesar de los esfuerzos, no se pudo realizar la implementación física del diseño en HDL.
# 6. Referencias
[1] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3

[2] Andrew House. Hex Keypad Explanation. Nov. de 2009. url: https://www-ug.eecg.toronto.edu/ msl/nios_devices/datasheets/hex_expl.pdf.
