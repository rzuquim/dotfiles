. .\windows_env\skip_step.ps1
proposeSkip "Generate SSH Key"

$email = Read-Host -Prompt "SSH Key e-mail"
ssh-keygen -t ed25519 -C "$email"

cat ~\.ssh\*.pub | clip
Write-Host "Your public key is on the clipboard, paste it on github and gitlab"

start-process -FilePath https://github.com/settings/keys
start-process -FilePath https://gitlab.com/-/profile/keys
