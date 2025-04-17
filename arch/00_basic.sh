#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Apply basic configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_BASIC=true
    fi
fi


if [[ -z "$ARCH_NO_BASIC" ]]; then
    echo -e "${YELLOW}Setting up basic localization${NC}"

    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    hwclock --systohc

    if [ ! -f "/etc/locale.gen.bkp" ]; then
        cp /etc/locale.gen /etc/locale.gen.bkp
        echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
        echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
        locale-gen
    fi

    if [ ! -f "/etc/locale.conf" ]; then
        echo "LANG=en_US.UTF-8" > /etc/locale.conf
    fi

    if [ ! -f "/etc/vconsole.conf" ]; then
        echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
        echo "FONT=ter-132n" >> /etc/vconsole.conf

        pacman -Sy --noconfirm --needed terminus-font
    fi

    echo -e "${YELLOW}Setting hostname and hosts file${NC}"
    if [ ! -f "/etc/hostname" ]; then
        read -rp "Enter hostname: " hostname
        echo "$hostname" > /etc/hostname
        export hostname="$hostname"
        # NOTE: assuming this is running from git folder
        envsubst < ./arch/assets/etc_hosts > /etc/hosts
    fi

    echo -e "${YELLOW}Setting up users and passwords${NC}"
    if ! passwd -S me 2>/dev/null | grep -vq 'NP'; then
        while true; do
            read -s -p "Enter password: " password1
            echo
            read -s -p "Confirm password: " password2
            echo
            if [[ "$password1" == "$password2" ]]; then
                break
            else
                echo -e "${RED}Passwords do not match. Please try again.${NC}"
            fi
        done

        echo "root:$password1" | chpasswd
        echo "Root password set."

        users=(me stream fun)

        for user in "${users[@]}"; do
            if ! id "$user" &>/dev/null; then
                useradd -m -G wheel,audio,video,storage -s /bin/bash "$user"
                echo "$user:$password1" | chpasswd
                echo -e "${VIOLET}Created user '$user' and set password.${NC}"
            fi
        done
    fi

    echo -e "${YELLOW}Making sure lts kernel is installed for fallback${NC}"
    pacman -Sy --noconfirm --needed linux-lts linux-lts-headers

    echo -e "${YELLOW}Enabling multilib repository on pacman${NC}"
    if [ ! -f "/etc/pacman.conf.bkp" ]; then
        cp /etc/pacman.conf /etc/pacman.conf.bkp
        cp ./arch/assets/etc_pacman_conf /etc/pacman.conf
    fi
fi
