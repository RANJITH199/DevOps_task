# Local Deployment Guide

This guide walks through the steps to deploy the source code locally using PowerShell and Docker.

## Prerequisites
- Docker installed
- PowerShell
- .NET SDK (if applicable to your project)

## Deployment Steps

### 1. File Setup
Create these three files in your project's root directory:

1. `deploy.ps1` - PowerShell deployment script
2. `Dockerfile` - Docker image configuration
3. `docker-compose.yml` - Container orchestration configuration

### 2. Running the Deployment
Execute the deployment script:
```powershell
.\deploy.ps1
The script will:
1.	Check for project files in the root directory (or use specified path)
2.	Build and test the project
3.	Build the Docker image using the Dockerfile
4.	Create and start containers using docker-compose
 ## Verify Deployment
Check running containers:
docker ps
Access your application at the localhost URL shown in the VS Code terminal.

## Making Changes
To apply code or configuration changes:
1.	Stop existing containers:

docker-compose down
2.	Make your changes
3.	Re-run the deployment script:
.\deploy.ps1
## Docker Optimization
The Dockerfile uses multi-stage builds to:
•	Keep the final image size small
•	Separate build dependencies from runtime
•	Optimize layer caching