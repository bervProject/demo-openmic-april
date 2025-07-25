FROM mcr.microsoft.com/dotnet/sdk:9.0.303 as build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-restore --no-build -o publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0.7 as runtime
WORKDIR /app
COPY --from=build /app/publish /app
CMD [ "dotnet", "Demo.dll" ]