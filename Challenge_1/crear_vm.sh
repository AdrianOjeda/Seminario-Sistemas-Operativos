
# Verificar que se proporcionen los argumentos requeridos
if [ "$#" -lt 7 ]; then
  echo "Uso: $0 <nombre_vm> <tipo_sistema> <cpus> <ram_gb> <vram_mb> <tamano_disco_gb> <controlador_sata> <controlador_ide>"
  exit 1
fi

# Asignar argumentos a variables
VM_NAME=$1
OS_TYPE=$2
CPUS=$3
RAM_GB=$4
VRAM_MB=$5
DISK_SIZE_GB=$6
SATA_CONTROLLER=$7
IDE_CONTROLLER=$8

# Convertir tamaños de memoria a MB y disco a MB
RAM_MB=$((RAM_GB * 1024))
DISK_SIZE_MB=$((DISK_SIZE_GB * 1024))

# Crear la máquina virtual
VBoxManage createvm --name "$VM_NAME" --ostype "$OS_TYPE" --register

# Configurar memoria y CPUs
VBoxManage modifyvm "$VM_NAME" --cpus $CPUS --memory $RAM_MB --vram $VRAM_MB

# Crear un disco duro virtual
DISK_PATH="$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"
VBoxManage createmedium disk --filename "$DISK_PATH" --size $DISK_SIZE_MB --format VDI

# Crear y asociar un controlador SATA
VBoxManage storagectl "$VM_NAME" --name "$SATA_CONTROLLER" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CONTROLLER" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

# Crear y asociar un controlador IDE para CD/DVD
VBoxManage storagectl "$VM_NAME" --name "$IDE_CONTROLLER" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "$IDE_CONTROLLER" --port 0 --device 0 --type dvddrive --medium emptydrive

# Imprimir configuración de la máquina virtual
echo "Configuración de la máquina virtual $VM_NAME:"
VBoxManage showvminfo "$VM_NAME"

# Mensaje final
echo "Máquina virtual '$VM_NAME' creada y configurada con éxito."