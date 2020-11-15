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

Write-Message "Wireshark for Windows Builder Help"

Write-Host "If you want to re-run cmake do this.."
Write-Host 'cmake -G "Visual Studio 16 2019" -A x64 ..\wireshark'
Write-Host " "
Write-Host "If you want to clean previous builds do these.."
Write-Host "msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln /t:Clean"
Write-Host 'Remove-Item "c:\development\wsbuild64\run\RelWithDebInfo" -Force -Recurse -ErrorAction SilentlyContinue'
Write-Host " "
Write-Host "If you want run a new build do this.."
Write-Host "msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln"
Write-Host " "
Write-Host "If you want to build the installer do these.."
Write-Host "msbuild /p:Configuration=RelWithDebInfo nsis_package_prep.vcxproj"
Write-Host "msbuild /p:Configuration=RelWithDebInfo nsis_package.vcxproj"
Write-Host " "