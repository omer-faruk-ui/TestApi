FROM  mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

COPY *.csproj .

RUN dotnet restore

COPY . ./

RUN dotnet publish --no-restore -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
ENV ASPNETCORE_HTTP_PORTS=1000
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "JenkinsTestAPI.dll"]