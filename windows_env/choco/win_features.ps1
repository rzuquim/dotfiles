# windows  features

cinst TelnetClient -source windowsFeatures
cinst Microsoft-Hyper-V-All Containers Microsoft-Windows-Subsystem-Linux -source windowsFeatures
cinst docker-for-windows -dvy
# TODO: enable WSL2 (simplified version) https://docs.microsoft.com/en-us/windows/wsl/install-win10 and install ubuntu wsl-ubuntu-2004 (if it is required)
