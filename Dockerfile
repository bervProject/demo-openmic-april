FROM mcr.microsoft.com/dotnet/sdk:7.0.306 as build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-restore --no-build -o publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0.9 as runtime
WORKDIR /app
COPY --from=build /app/publish /app
CMD [ "dotnet", "Demo.dll" ]