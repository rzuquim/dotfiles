
function nft_rule_add() {
    local placeholder="$1"
    local rules_file="$2"
    local input_file="/etc/nftables.conf"
    local output_file="/tmp/nftables.conf"

    # Use awk to replace the placeholder with the rule block
    # awk -v rules="$nftables_rules" -v tag="$placeholder" '
    # {
    #     if ($0 ~ "# " tag) {
    #         print rules
    #     } else {
    #         print $0
    #     }
    # }' "$input_file" > "$output_file"

    awk -v tag="$placeholder" -v rfile="$rules_file" '
    $0 ~ tag {
        while ((getline line < rfile) > 0) print line
        close(rfile)
        next
    }
    { print }
    ' "$input_file" > "$output_file"

    sudo cp /etc/nftables.conf /etc/nftables.conf.bkp
    # sudo mv /tmp/nftables.conf /etc/nftables.conf
}
