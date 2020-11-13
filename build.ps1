Write-Host "Build script based on instructions @ https://www.wireshark.org/docs/wsdg_html_chunked/ChSetupWin32.html"

Write-Host "Installing chocolatey"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing Python 3"
choco install -y python3

Write-Host "Installing Perl - eek!"
choco install -y activeperl

Write-Host "Installing git"
choco.exe install -y git

Write-Host "Installing Java"
choco install -y openjdk11

Write-Host "Installing CMake"
choco install -y cmake

# Write-Host "Installing Asciidoctor"
# choco install -y asciidoctorj xsltproc

Write-Host "Installing winflexbison"
choco install -y winflexbison3

Write-Host "Creating development folder"
New-Item -ItemType Directory -Path c:\Development
New-Item -ItemType Directory -Path c:\Development\wsbuild64

Write-Host "Installing vs community edition"
choco install -y visualstudio2019community visualstudio2019-workload-nativedesktop

# Copy-Item '\\192.168.200.111\docker-shared\Qt5.12.9.zip' 'c:\temp\Qt5.12.9.zip'
# if(Test-Path 'c:/temp/Qt5.12.9.zip')
# {
#     Write-Host "Installing QT"
#     Expand-Archive -Path 'c:/temp/Qt5.12.9.zip' -DestinationPath 'c:\qt';
#     Remove-Item -Path 'c:/temp/Qt5.12.9.zip' -Force
# }
