#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        execlp("ls", "ls", "-l", NULL);
        perror("Error al ejecutar ls");
    } else {
        wait(NULL);
        printf("Proceso padre esperando al hijo.\n");
    }
    return 0;
}