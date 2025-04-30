function clone_or_update() {
    local base_dir=$1
    local repo=$2

    local proj_name=$(basename "$repo" .git)
    local proj_dir="$base_dir/$proj_name"

    if [ ! -d "$proj_dir" ]; then
        echo
        echo -e "${YELLOW}Cloning${NC} $proj_name ${YELLOW}into${NC} $proj_dir"
    else
        git clone "$repo" "$proj_dir"
        # NOTE: speeding up consecutive syncs (making sure updates occur once a day)
        today=$(date +%Y-%m-%d)
        already_ran_today="/tmp/cloned_${proj_name}_${today}"
        if [ -f $already_ran_today ]; then
            echo -e "${YELLOW}Already updated today:${NC} $proj_name"
            return
        fi

        echo -e "${YELLOW}Updating${NC} $proj_name"
        pushd "$proj_dir" &> /dev/null
        git pull
        popd &> /dev/null

        touch $already_ran_today
    fi
}
