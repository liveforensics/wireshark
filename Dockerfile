# escape=`

FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Wireshark Build Container"

# Restore the default Windows shell for correct batch processing.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN mkdir c:\temp
ADD build.ps1 c:\temp\build.ps1
RUN c:\temp\build.ps1

ADD go.ps1 c:\Development\wsbuild64\go.ps1
ADD help.ps1 c:\Development\wsbuild64\help.ps1


# # Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

RUN SETX /M Path "%Path%;C:\\program files\\cmake\\bin;c:\\nsis;"
ENV QT5_BASE_DIR="c:\Qt"
ENV WIRESHARK_BASE_DIR="C:\Development"
ENV WIRESHARK_LIB_DIR="c:\wireshark-win64-libs"
ENV NSISDIR="c:\nsis\bin"
ENV NSISCONFDIR="c:\nsis"

WORKDIR c:\development\wsbuild64

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\vc\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]