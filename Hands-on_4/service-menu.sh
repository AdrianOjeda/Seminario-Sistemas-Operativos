#!/bin/bash

# Función para mostrar el menú
show_menu() {
    echo "===== MENU ====="
    echo "1. Listar el contenido de un fichero (carpeta)"
    echo "2. Crear un archivo de texto con una línea de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Demostrar uso del comando awk"
    echo "5. Demostrar uso del comando grep"
    echo "6. Salir"
}

# Función para listar el contenido de una carpeta
list_directory() {
    read -p "Introduce la ruta absoluta de la carpeta: " dir
    if [ -d "$dir" ]; then
        echo "Contenido de $dir:"
        ls "$dir"
    else
        echo "La ruta proporcionada no es una carpeta válida."
    fi
}

# Función para crear un archivo de texto con una línea de texto
create_text_file() {
    read -p "Introduce la cadena de texto para almacenar: " text
    read -p "Introduce el nombre del archivo a crear: " file_name
    echo "$text" > "$file_name"
    echo "Archivo $file_name creado con éxito."
}

# Función para comparar dos archivos de texto
compare_files() {
    read -p "Introduce la ruta del primer archivo: " file1
    read -p "Introduce la ruta del segundo archivo: " file2
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        echo "Comparando $file1 y $file2:"
        diff "$file1" "$file2"
    else
        echo "Uno o ambos archivos no existen."
    fi
}

# Función para demostrar el uso del comando awk
demo_awk() {
    echo "Ejemplo de awk: Filtrar y mostrar la primera columna de un archivo."
    read -p "Introduce la ruta del archivo: " file
    if [ -f "$file" ]; then
        awk '{print $1}' "$file"
    else
        echo "El archivo no existe."
    fi
}

# Función para demostrar el uso del comando grep
demo_grep() {
    echo "Ejemplo de grep: Buscar una palabra específica en un archivo."
    read -p "Introduce la ruta del archivo: " file
    read -p "Introduce la palabra a buscar: " word
    if [ -f "$file" ]; then
        grep "$word" "$file"
    else
        echo "El archivo no existe."
    fi
}

# Bucle principal del script
while true; do
    show_menu
    read -p "Elige una opción: " option
    case $option in
        1) list_directory ;;
        2) create_text_file ;;
        3) compare_files ;;
        4) demo_awk ;;
        5) demo_grep ;;
        6) echo "Saliendo del script. ¡Hasta luego!"; exit 0 ;;
        *) echo "Opción no válida. Inténtalo de nuevo." ;;
    esac
done
