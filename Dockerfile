# �ϥ� .NET 8 SDK �ظm�M��
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# �ƻs�ѨM��פαM����
COPY . .

# �٭� NuGet �M��
RUN dotnet restore ElsaServer/ElsaServer.csproj

# �ظm ElsaServer
RUN dotnet publish ElsaServer/ElsaServer.csproj -c Release -o /app/publish

# ���涥�q�M��
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# �ƻs�o�G�ɮ�
COPY --from=build /app/publish .

# �}��w�]��
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# �Ұ����ε{��
ENTRYPOINT ["dotnet", "ElsaServer.dll"]