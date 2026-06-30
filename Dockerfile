FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Proje dosyasını kopyala ve restore et
COPY *.csproj ./
RUN dotnet restore

# Geri kalan her şeyi kopyala ve projeyi derle
COPY . ./
RUN dotnet publish -c Release -o out

# Çalışma ortamını hazırla
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# API'nin dış dünyaya açacağı port (Render free plan için varsayılan 8080 veya 80'dir)
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "GembirdsAPI.dll"]
