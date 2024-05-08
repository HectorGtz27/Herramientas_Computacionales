#!/bin/bash

# Verificar si se proporcionó el intervalo como argumento
if [ -z "$1" ]; then
    echo "Error: Debes proporcionar el intervalo de tiempo en segundos como argumento."
    exit 1
fi

# Almacenar el intervalo de tiempo en una variable
intervalo="$1"

# Verificar si se proporcionó un segundo argumento
if [ -z "$2" ]; then
    echo "Error: Debes proporcionar el número de función a ejecutar como segundo argumento."
    exit 1
fi

# Almacenar el número de función en una variable
numero_funcion="$2"

# Función 1: Mostrar información del sistema operativo
function funcion1 {
    echo "Sistema operativo:"
    uname -a
    echo "Procesador:"
    echo "Modelo del procesador:" $(systeminfo | awk '/Processor/ {print $3,$4}')
    echo "Memoria total del sistema:"
    systeminfo | awk '/Physical Memory/ {print $4,$5}'
    echo "Uso del disco:"
    df -h
    echo "Versión del kernel:"
    uname -r
    echo "Nombre de host:"
    hostname
    echo "Usuarios conectados:"
    echo "No se puede obtener la lista de usuarios conectados en Windows."
    echo "Información de la red:"
    ipconfig
    echo "Tiempo de actividad del sistema:"
    echo "No se puede obtener el tiempo de actividad del sistema en Windows."
}

# Función 2: Mostrar información de la fecha y hora
function funcion2 {
    echo "Fecha y hora actual:"
    date
    echo "Zona horaria:"
    tzutil /g
}

# Llamar a la función correspondiente según el número proporcionado
if [ "$numero_funcion" == "1" ]; then
    funcion1
elif [ "$numero_funcion" == "2" ]; then
    funcion2
else
    echo "Error: El número de función debe ser '1' o '2'."
    exit 1
fi

# Ciclo while para repetir los comandos con el intervalo especificado
while true; do
    if [ "$numero_funcion" == "1" ]; then
        funcion1
    elif [ "$numero_funcion" == "2" ]; then
        funcion2
    fi

    # Esperar el intervalo de tiempo especificado antes de repetir
    sleep $intervalo
    # Limpiar la pantalla para una nueva iteración
    clear
done
