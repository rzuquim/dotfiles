
function all_users_have_passphrase() {
    for user in $@; do
        pass=$(passwd -S $user 2>/dev/null | awk '{print $2}')
        if [[ "$pass" != "P" ]]; then
            return 1 # false
        fi
    done
    return 0 # true
}
