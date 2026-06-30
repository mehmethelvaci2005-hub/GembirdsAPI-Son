FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Bütün dosyaları içeri al
COPY . ./

# Proje klasörünün içine gir
WORKDIR /app/GembirdsAPI

# Kodları toparla ve derle
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Çalıştırma ortamını hazırla
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Derlenen hazır dosyaları çek
COPY --from=build-env /app/GembirdsAPI/out .

# Render için port ayarı
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

# Motoru ateşle
ENTRYPOINT ["dotnet", "GembirdsAPI.dll"]
