#!/bin/bash

echo -e "${CYAN}Setting up users${NC}"

# ensuring zsh is available
pacman -S --noconfirm --needed zsh

if ! all_users_have_passphrase "root"; then
    user_pass="${passphrase}_ROOT"
    echo "root:$user_pass" | chpasswd
    echo -e "${YELLOW}root password set${NC}"
fi

for user in "${users[@]}"; do
    if ! id "$user" &>/dev/null; then
        user_pass="${passphrase}_${user^^}"
        useradd -m -G audio,video,storage -s /usr/bin/zsh "$user"
        echo "$user:$user_pass" | chpasswd
        echo -e "${YELLOW}Created user '$user' and set password.${NC}"
    fi

    if [ "$user" = "me" ]; then
        usermod -a -G wheel,docker $user
        su - me -c "mkdir -p /home/me/.config/git"
    fi

    if [ "$user" = "stream" ]; then
        groupadd -f stream
        usermod -a -G stream $user
    fi

    if [ "$user" = "fun" ]; then
        groupadd -f gaming
        usermod -a -G gaming $user
    fi
done

if [ ! -f /etc/sudoers.bkp ]; then
    echo -e "${CYAN}Setting up sudo${NC}"
    pacman -S --noconfirm --needed sudo
    cp /etc/sudoers /etc/sudoers.bkp
fi

cp ./_assets/etc/sudoers /etc/sudoers
