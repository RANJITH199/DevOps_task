# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src

COPY super-service/src/SuperService.csproj ./src/
COPY super-service/test/SuperService.UnitTests.csproj ./test/
COPY *.sln ./

# Restore dependencies
RUN dotnet restore "src/SuperService.csproj"

COPY super-service/src ./src
COPY super-service/test ./test

RUN dotnet build "src/SuperService.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "src/SuperService.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SuperService.dll"]