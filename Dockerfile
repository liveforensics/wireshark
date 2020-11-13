# escape=`

FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Wireshark Build Container"

# Restore the default Windows shell for correct batch processing.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN mkdir c:\temp
ADD build.ps1 c:\temp\build.ps1
RUN c:\temp\build.ps1

WORKDIR c:\development
RUN git clone 'https://gitlab.com/wireshark/wireshark.git'
ADD go.ps1 c:\Development\wsbuild64\go.ps1

# # Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]
s
RUN SETX /M Path "%Path%;C:\\program files\\cmake\\bin;"
ENV QT5_BASE_DIR="c:\Qt\Qt5.12.9\5.12.9\msvc2017_64"
ENV WIRESHARK_BASE_DIR="C:\Development"
ENV WIRESHARK_LIB_DIR="c:\wireshark-win64-libs"

WORKDIR c:\development\wsbuild64
RUN call "c:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\vc\\Auxiliary\\Build\\vcvars64.bat" && cmake -G "Visual Studio 16 2019" -A x64 ..\wireshark

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\vc\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]