$env:DOCKER_REPO = "cspeers"
$env:DOCKER_IMAGE = "technitium-dns"
$env:DOCKER_APPLICATION_VERSION = "11.4.1"
$env:DOTNET_VERSION="7.0"
$env:DOTNET_VERSION_TAG="sdk:$env:DOTNET_VERSION"
$env:DOCKER_BASE_IMAGE="mcr.microsoft.com/dotnet/$env:DOTNET_VERSION_TAG"