# 使用 .NET 8 SDK 建置專案
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 複製解決方案及專案檔
COPY . .

# 還原 NuGet 套件
RUN dotnet restore ElsaServer/ElsaServer.csproj

# 建置 ElsaServer
RUN dotnet publish ElsaServer/ElsaServer.csproj -c Release -o /app/publish

# 執行階段映像
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# 複製發佈檔案
COPY --from=build /app/publish .

# 開放預設埠
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# 啟動應用程式
ENTRYPOINT ["dotnet", "ElsaServer.dll"]