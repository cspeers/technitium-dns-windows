[CmdletBinding()]
param
(
    [Parameter()]
    [switch]$TagLatest
)
$ErrorActionPreference = "Stop"
. $(Join-Path $PSScriptRoot ".\build.config.ps1")

$imageFullName = ("{0}/{1}:{2}-{3}" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $env:DOCKER_APPLICATION_VERSION,$env:DOTNET_VERSION)
$imageLatestName = ("{0}/{1}:latest" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE)

Write-Host `Pushing $imageFullName`
Start-Process -FilePath 'docker.exe' -ArgumentList 'push',$imageFullName -NoNewWindow -Wait

if($TagLatest){
    Write-Host "Tagging image as latest"
    Start-Process -FilePath 'docker.exe' -ArgumentList 'push',$imagelatestName -NoNewWindow -Wait
}