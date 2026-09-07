# proyecto1-arquitectura : Calculadora FPGA en Verilog

## Descripción del proyecto

Este repositorio contiene el código fuente de una calculadora de 4 bits, diseñada e implementada en una FPGA utilizando el lenguaje de descripción de hardware Verilog. El proyecto abarca desde el diseño lógico de cada componente hasta su programación final sobre hardware real.

## Requisitos

Para compilar y programar el proyecto sobre la FPGA, se requieren las siguientes herramientas, incluidas dentro del paquete `oss-cad-suite`:

- **Yosys**: es utilizado como el sintetizador. Su función es transformar el código Verilog en una representación a nivel de compuertas (netlist), que luego puede ser mapeada al hardware específico de la FPGA.
- **nextpnr-ice40**: es la herramienta encargada del *place and route*. Toma la netlist generada por Yosys y determina en qué posición física de la FPGA se ubicará cada compuerta, además de definir cómo se conectarán entre sí utilizando los recursos de enrutamiento disponibles en el chip.
- **icepack**: convierte el resultado del *place and route* en un archivo binario (bitstream), que es el formato que la FPGA puede interpretar para configurarse.
- **iceprog**: se utiliza para cargar el bitstream generado directamente en la FPGA, programando así el diseño sobre el hardware.

## Estructura del proyecto

El proyecto está organizado en múltiples módulos de Verilog, cada uno encargado de una función específica (por ejemplo, sumadores, restadores, desplazadores, controladores de displays, etc.). Estos módulos están interconectados entre sí, lo que permite que cada uno pueda ser reutilizado dentro de otros módulos de mayor nivel.

La forma en que un módulo utiliza a otro es mediante una instancia, es decir, se declara una copia de ese módulo dentro de otro, conectando sus entradas y salidas a las señales correspondientes. Por ejemplo, un módulo que necesite sumar dos valores puede instanciar internamente al módulo `full_adder_1bit`, conectando sus propias señales a las entradas y salidas del sumador, sin necesidad de reescribir la lógica de la suma nuevamente. Esto permite construir circuitos más complejos a partir de bloques más simples, ya verificados y probados.

## Hardware objetivo

Este proyecto está diseñado específicamente para ejecutarse sobre una FPGA Lattice iCE40 HX1K, integrada en la placa de desarrollo Nandland Go Board.

## Instrucciones de uso

La calculadora se controla utilizando los cuatro botones disponibles en la Go Board, de la siguiente manera:

- **Botón superior izquierdo**: incrementa el valor actualmente seleccionado.
- **Botón inferior izquierdo**: disminuye el valor actualmente seleccionado.
- **Botón superior derecho**: confirma o ingresa el valor seleccionado.
- **Botón inferior derecho**: permite utilizar el resultado de la operación anterior como segundo operando.

El flujo de uso de la calculadora es el siguiente:

1. Primero se debe ingresar la operación deseada. El código correspondiente a la operación seleccionada se mostrará en los LED de la placa.
2. A continuación, se debe ingresar el primer operando. Su valor se mostrará en el display de siete segmentos: el primer display indicará el signo y el segundo mostrará el valor en formato hexadecimal.
3. Luego se debe ingresar el segundo operando, siguiendo el mismo criterio de visualización.
4. Una vez confirmados ambos operandos, la calculadora ejecutará automáticamente la operación seleccionada y mostrará el resultado en el display de siete segmentos.
5. Si se vuelve a presionar el botón superior derecho, la calculadora regresará al estado inicial, permitiendo ingresar una nueva operación desde cero.
