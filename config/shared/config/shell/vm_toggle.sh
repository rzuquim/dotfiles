vm_mod_toggle() {
    local VBOX_CONF="/usr/lib/modprobe.d/virtualbox.conf"

    # Check if VirtualBox is currently loaded
    if lsmod | grep -qw vboxdrv; then
        echo "VirtualBox is active. Switching to KVM..."

        # Terminate VirtualBox background processes
        killall VBoxSVC VBoxHeadless 2>/dev/null

        # Unload VirtualBox modules
        sudo modprobe -r vboxnetadp vboxnetflt vboxdrv

        # Comment out the KVM blacklist lines to allow KVM to load
        if [ -f "$VBOX_CONF" ]; then
            sudo sed -i 's/^ *install kvm/# install kvm/g' "$VBOX_CONF"
            echo "Disabled KVM blacklist in $VBOX_CONF."
        fi

        # Load KVM module
        sudo modprobe kvm_intel

        # Verify the switch
        if lsmod | grep -qw kvm; then
            echo "Success: KVM is now active."
        else
            echo "Error: Failed to load KVM modules."
        fi

        # Check if KVM is currently loaded
    elif lsmod | grep -qw kvm; then
        echo "KVM is active. Switching to VirtualBox..."

        # Unload KVM modules
        sudo modprobe -r kvm_intel kvm

        # Uncomment the KVM blacklist lines to restore VirtualBox default behavior
        if [ -f "$VBOX_CONF" ]; then
            sudo sed -i 's/^ *# *install kvm/install kvm/g' "$VBOX_CONF"
            echo "Restored KVM blacklist in $VBOX_CONF."
        fi

        # Load VirtualBox modules
        sudo modprobe vboxdrv vboxnetflt vboxnetadp

        # Verify the switch
        if lsmod | grep -qw vboxdrv; then
            echo "Success: VirtualBox is now active."
        else
            echo "Error: Failed to load VirtualBox modules."
        fi

        # Fallback if neither module is loaded
    else
        echo "Neither hypervisor is active. Defaulting to KVM..."
        if [ -f "$VBOX_CONF" ]; then
            sudo sed -i -E 's/^#[[:space:]]*(install[[:space:]]+kvm(_amd|_intel)?[[:space:]].*)/\1/' "$VBOX_CONF"
        fi
        sudo modprobe kvm_intel
        echo "Success: KVM loaded."
    fi

    echo "Checking if enabled:"
    lsmod | grep "vbox|kvm"
    ls /dev/kvm
}
