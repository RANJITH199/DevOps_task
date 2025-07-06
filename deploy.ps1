$ErrorActionPreference = "Stop"

# Find test project
$testProject = Get-ChildItem -Path "super-service/test/*.csproj" | Select-Object -First 1

if (-not $testProject) {
    throw "project file not found"
}

# Build and test
Write-Host "Building and testing..."
dotnet build $testProject.FullName --configuration Release
dotnet test $testProject.FullName --configuration Release --no-build

# Docker operations
Write-Host "Building Docker image..."
docker-compose build

Write-Host "Starting services..."
docker-compose up -d

Write-Host "`nDeployment successful! Access:"
Write-Host "- HTTPS: https://localhost:44300/time ** Not Working ** "
Write-Host "- HTTP: http://localhost:8080/time`n"