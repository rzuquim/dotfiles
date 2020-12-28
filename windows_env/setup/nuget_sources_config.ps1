. .\windows_env\skip_step.ps1
proposeSkip "Register nuget"

if ($email) {
    $nugetUser = $email
} else {
    $nugetUser = Read-Host -Prompt "Please enter Inoa Nuget User"
}

$nugetPassword = Read-Host -Prompt "Please enter Inoa Nuget Password"

$apiKey = Read-Host -Prompt "Please paste Inoa Nuget API Key"

nuget sources add -Name 'Inoa' -source 'https://inoanugetgallery.azurewebsites.net/api/v2' -User $nugetUser -pass $nugetPassword
nuget setapikey $apiKey -Source 'https://inoanugetgallery.azurewebsites.net'
