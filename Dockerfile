#Step 0: Choose base
FROM mcr.microsoft.com/dotnet/sdk:6.0

WORKDIR /usr/src/app

Run dotnet dev-certs https --trust

COPY . .
