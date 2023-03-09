[CmdletBinding()]
param
(
    [Parameter()]
    [Switch]$TagLatest
)
$ErrorActionPreference = "Stop"
. $(Join-Path $PSScriptRoot ".\build.config.ps1")

$BASE_IMAGE=$env:DOCKER_BASE_IMAGE
$imageFullName = ("{0}/{1}:{2}-{3}" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $env:DOCKER_APPLICATION_VERSION,$env:DOTNET_VERSION)
$imageLatestName = ("{0}/{1}:latest" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE)

Write-Information "Building ${imageFullName} from  ${BASE_IMAGE}"

$dockerArgs=@(
    'build',
    '--build-arg',"BASE_IMAGE=$BASE_IMAGE",
    '.\','-t',$imageFullName
)

Start-Process -FilePath 'docker.exe' -ArgumentList $dockerArgs -NoNewWindow -Wait

if($TagLatest.IsPresent -eq $true) {
    Write-Information "Tagging image ${imageFullName} as latest -> ${imageLatestName}"
    Start-Process -FilePath 'docker.exe' -ArgumentList 'tag',$imageFullName,$imageLatestName -NoNewWindow -Wait
}