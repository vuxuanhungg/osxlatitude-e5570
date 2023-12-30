# Disable command printing
@echo -off

echo "This script will tweak Dell Latitude E5570 Bios version v1.34.3 to macOS requirements"

echo "Disable CFG Lock"
setup_var.efi 0x109 0x0 -n Setup

echo "Set DVMT Pre-allocated to 64MB"
setup_var.efi 0x432 0x2 -n Setup

echo "Set DVMT Total Gfx Mem to MAX"
setup_var.efi 0x433 0x3 -n Setup

echo "Disable CSM Support"
setup_var.efi 0xD83 0x0 -n Setup

echo "Enable XHCI Hand-off"
setup_var.efi 0x1B 0x1 -n UsbSupport
