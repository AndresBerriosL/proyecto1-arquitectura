# proyecto1-arquitectura : Calculadora FPGA en Verilog

## Descripción del proyecto

Este repositorio contiene el código fuente de una calculadora de 4 bits, diseñada e implementada en una FPGA utilizando el lenguaje de descripción de hardware Verilog. El proyecto abarca desde el diseño lógico de cada componente hasta su programación final sobre hardware real.

## Requisitos

Para compilar y programar el proyecto sobre la FPGA, se requieren las siguientes herramientas, incluidas dentro del paquete `oss-cad-suite`:

- **Yosys**: es utilizado como el sintetizador. Su función es transformar el código Verilog en una representación a nivel de compuertas (netlist), que luego puede ser mapeada al hardware específico de la FPGA.
- **nextpnr-ice40**: es la herramienta encargada del *place and route*. Toma la netlist generada por Yosys y determina en qué posición física de la FPGA se ubicará cada compuerta, además de definir cómo se conectarán entre sí utilizando los recursos de enrutamiento disponibles en el chip.
- **icepack**: convierte el resultado del *place and route* en un archivo binario (bitstream), que es el formato que la FPGA puede interpretar para configurarse.
- **iceprog**: se utiliza para cargar el bitstream generado directamente en la FPGA, programando así el diseño sobre el hardware.

## Estructura del Proyecto
