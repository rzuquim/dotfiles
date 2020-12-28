function confirm($path) {
    if (-not (Test-Path $path)) { return $true }
    $confirm = Read-Host -Prompt "There is already a $path available. Are you sure you want to overwrite it? (y/N)"
    return $confirm.StartsWith('y') -or $confirm.StartsWith('Y')
}

# ##############
# Git
# ##############
if (confirm("~/.gitconfig")) {
  Read-Host -Prompt "Check if .gitconfig is properly configured (email, user...) and press enter to continue."
  cp .\common\.gitconfig ~/.gitconfig -Force
}

# ##############
# Vim
# ##############

if (confirm("~/.ideavimrc")) {
  cp .\common\.vimrc ~/.ideavimrc -Force
  cp .\common\.vimrc ~/.vimrc -Force
}

# ##############
# Profile
# ##############

if (confirm($PROFILE)) {
  $profileDir = Split-Path $PROFILE
  cp .\windows_env\profile.ps1 $PROFILE -Force
  rm $profileDir\profile -Recurse -Force
  cp .\windows_env\profile $profileDir -Recurse -Force
}

& $profile
