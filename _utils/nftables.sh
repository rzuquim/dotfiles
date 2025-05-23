
function nft_rule_add() {
    local placeholder="$1"
    local nftables_rules="$2"
    local input_file="/etc/nftables.conf"
    local output_file="/tmp/nftables.conf"

    # Use awk to replace the placeholder with the rule block
    awk -v rules="$nftables_rules" -v tag="$placeholder" '
    {
        if ($0 ~ "# " tag) {
            print rules
        } else {
            print $0
        }
    }' "$input_file" > "$output_file"
}
