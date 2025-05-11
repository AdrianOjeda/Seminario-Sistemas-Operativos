#include <stdio.h>
#include <pthread.h>

// Función que imprimirá un mensaje con el ID del hilo
void* imprimir_mensaje(void* arg) {
    int id = *(int*)arg;
    printf("Hilo %d en ejecución.\n", id);
    return NULL;
}
int main() {
    pthread_t hilos[3]; // Arreglo de identificadores de hilo
    int ids[3] = {1, 2, 3};
    for (int i = 0; i < 3; i++) {
        pthread_create(&hilos[i], NULL, imprimir_mensaje, &ids[i]); // Crear h
    }
    for (int i = 0; i < 3; i++) {
        pthread_join(hilos[i], NULL);
    }
    return 0;
}