#!/bin/bash

# Verifica que el script reciba los argumentos necesarios
if [ "$#" -ne 8 ]; then
  echo "Uso: $0 <nombre_vm> <tipo_os> <cpus> <ram_gb> <vram_mb> <disk_size_gb> <controlador_sata> <controlador_ide>"
  exit 1
fi

# Asignación de argumentos a variables
NOMBRE_VM=$1
TIPO_OS=$2
CPUS=$3
RAM=$(($4 * 1024))  # Convertir GB a MB
VRAM=$5
DISK_SIZE=$(($6 * 1024))  # Convertir GB a MB
CONTROLADOR_SATA=$7
CONTROLADOR_IDE=$8

# Creación de la máquina virtual
VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_OS" --register
if [ $? -ne 0 ]; then
  echo "Error al crear la máquina virtual."
  exit 1
fi

# Configuración de la máquina virtual
VBoxManage modifyvm "$NOMBRE_VM" --cpus $CPUS --memory $RAM --vram $VRAM --nic1 nat
if [ $? -ne 0 ]; then
  echo "Error al configurar la máquina virtual."
  exit 1
fi

# Creación del disco duro virtual
DISK_PATH="$HOME/VirtualBox VMs/$NOMBRE_VM/${NOMBRE_VM}_disk.vdi"
VBoxManage createmedium disk --filename "$DISK_PATH" --size $DISK_SIZE --format VDI
if [ $? -ne 0 ]; then
  echo "Error al crear el disco duro virtual."
  exit 1
fi

# Creación y configuración del controlador SATA
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_SATA" --add sata --controller IntelAHCI
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR_SATA" --port 0 --device 0 --type hdd --medium "$DISK_PATH"
if [ $? -ne 0 ]; then
  echo "Error al configurar el controlador SATA."
  exit 1
fi

# Creación y configuración del controlador IDE
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_IDE" --add ide
if [ $? -ne 0 ]; then
  echo "Error al configurar el controlador IDE."
  exit 1
fi

# Imprimir configuración final
echo "Configuración de la máquina virtual '$NOMBRE_VM':"
VBoxManage showvminfo "$NOMBRE_VM"

echo "Script ejecutado con éxito."
