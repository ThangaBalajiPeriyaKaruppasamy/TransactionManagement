FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.sln .
COPY FantasyWebApp/*.csproj ./FantasyWebApp/
COPY TestProject1/*.csproj  ./TestProject1/
RUN dotnet restore
COPY . .
WORKDIR /src/FantasyWebApp
RUN dotnet publish -c Release -o /app/publish
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "FantasyWebApp.dll"]
