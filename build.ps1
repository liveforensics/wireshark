function Write-Message {
    Param ([String]$message)

    if ($message)
    {
        Write-Host "$([char]0x1b)[33m*********************************************************************************************************************************************" -ForegroundColor Yellow
        Write-Host "$([char]0x1b)[33m*"
        Write-Host "$([char]0x1b)[33m* " $message
        Write-Host "$([char]0x1b)[33m*"
        Write-Host "$([char]0x1b)[33m*********************************************************************************************************************************************"
        Write-Host "$([char]0x1b)[37m "
    }
}

Write-Message "Build script based on instructions @ https://www.wireshark.org/docs/wsdg_html_chunked/ChSetupWin32.html"

Write-Message "Installing chocolatey"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Message "Installing Python 3"
choco install -y python3

Write-Message "Installing Nano - because, well why not!"
choco install -y nano

Write-Message "Installing Perl - eek!"
choco install -y activeperl
# choco install -y strawberryperl

Write-Message "Installing git"
choco.exe install -y git

Write-Message "Installing Java"
choco install -y openjdk11

Write-Message "Installing CMake"
choco install -y cmake

Write-Message "Installing Asciidoctor"
choco install -y asciidoctorj xsltproc docbook-bundle

Write-Message "Installing winflexbison"
choco install -y winflexbison3

Write-Message "Creating development folders"
New-Item -ItemType Directory -Path c:\Development
New-Item -ItemType Directory -Path c:\Development\wsbuild64

Write-Message "Installing vs community edition"
choco install -y visualstudio2019community visualstudio2019-workload-nativedesktop

Write-Message "Pulling NSIS"
$downloadUrl = "https://nav.dl.sourceforge.net/project/nsis/NSIS%203/3.06.1/nsis-3.06.1-setup.exe"
Invoke-WebRequest -Uri $downloadUrl -OutFile c:\temp\nsis.exe
if(Test-Path c:\temp\nsis.exe)
{
    Write-Message "Installing NSIS"
    Set-Location C:\Temp
    .\nsis.exe /S /NCRC /D=c:\nsis
}
#

