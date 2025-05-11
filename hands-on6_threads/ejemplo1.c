#include <stdio.h>
#include <pthread.h>
// Función que ejecutará el hilo



void* tarea(void* arg) {
    printf("Hola desde el hilo!\n");
        return NULL;
    }
    int main() {
        pthread_t hilo; // Declaración de hilo
        pthread_create(&hilo, NULL, tarea, NULL); // Crear el hilo que ejecuta 'ta
        pthread_join(hilo, NULL); // Esperar a que el hilo termine
        printf("Hilo finalizado."); // Mensaje después de que el hilo ha terminado
        return 0;
}