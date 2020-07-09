[CmdletBinding()]
param
(
    [Parameter()]
    [Switch]$TagLatest
)
$ErrorActionPreference = "Stop"
. $(Join-Path $PSScriptRoot ".\build.config.ps1")

$HEALTH_ADDRESS="google.com"
$BASE_IMAGE=$env:DOCKER_BASE_IMAGE
$imageFullName = ("{0}/{1}:{2}-windowsservercore-{3}" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $env:DOCKER_APPLICATION_VERSION,$env:DOCKER_IMAGE_TAG)
$imageLatestName = ("{0}/{1}:latest" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE)

$dockerArgs=@(
    'build',
    '--build-arg',"BASE_IMAGE=$BASE_IMAGE",
    '--build-arg',"HEALTH_ADDRESS=$HEALTH_ADDRESS",
    '.','-t',$imageFullName
)

Start-Process -FilePath 'docker.exe' -ArgumentList $dockerArgs -NoNewWindow -Wait

if($TagLatest) {
    Write-Host "Tagging image $imageFullName as latest"
    Start-Process -FilePath 'docker.exe' -ArgumentList 'tag',$imageFullName,$imageLatestName -NoNewWindow -Wait
}