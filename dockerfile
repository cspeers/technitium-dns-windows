ARG BASE_IMAGE="mcr.microsoft.com/dotnet/core/sdk:3.1"
FROM ${BASE_IMAGE}

LABEL maintainer="cspeers"
ARG INSTALL_URL="https://download.technitium.com/dns/DnsServerPortable.tar.gz"


RUN md C:\temp
RUN md C:\App
RUN md C:\certs

WORKDIR C:/Temp

ADD ${INSTALL_URL} install.tar.gz
RUN tar.exe -zxvf install.tar.gz -C C:\App

WORKDIR C:/App
RUN rd C:\Temp /q /s

EXPOSE 5380/tcp
EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 853/tcp
EXPOSE 443/tcp

VOLUME [ "C:/App/config" ]
VOLUME [ "C:/certs" ]

ENTRYPOINT ["dotnet", "DnsServerApp.dll"]

#HEALTHCHECK --interval=60s --timeout=30s --start-period=10s --retries=3 CMD pwsh -Command {Invoke-RestMethod "http://$($ENV:COMPUTERNAME):5380"}

