function Write-Message {
    Param ([String]$message)

    if ($message)
    {
        Write-Host "$([char]0x1b)[33m*********************************************************************************************************************************************" -ForegroundColor Yellow
        Write-Host "*"
        Write-Host "* " $message
        Write-Host "*"
        Write-Host "*********************************************************************************************************************************************"
        Write-Host "$([char]0x1b)[37m "
    }
}

$startTime = Get-Date

Write-Message "Running CMake"
cmake -G "Visual Studio 16 2019" -A x64 ..\wireshark

Write-Message "Cleaning up any previous builds"
msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln /t:Clean
if(Test-Path "c:\development\wsbuild64\run\RelWithDebInfo")
{
    Remove-Item "c:\development\wsbuild64\run\RelWithDebInfo" -Force -Recurse 
}

Write-Message "Building Wireshark"
msbuild /p:Configuration=RelWithDebInfo Wireshark.sln

if(Test-Path 'C:\Development\wsbuild64\run\RelWithDebInfo\Wireshark.exe')
{
    Write-Host "Successfully Built Wireshark"
    if(Test-Path "c:\outfiles")
    {
        Copy-Item -Path "c:\development\wsbuild64\run\RelWithDebInfo" -Destination "c:\outfiles" -Recurse -Force
    }
    # if(Test-Path 'c:\development\wsbuild64\nsis_package_prep.vcxproj')
    # {
    #     Write-Host "Creating the Installer"
    #     msbuild /p:Configuration=RelWithDebInfo nsis_package_prep.vcxproj
    #     msbuild /p:Configuration=RelWithDebInfo nsis_package.vcxproj
    # }
}
else 
{
    Write-Error "Failed to build Wireshark"
}

$endTime = Get-Date

$diff = New-TimeSpan -Start $startTime -End $endTime

Write-Message "Build took: " $diff.TotalMinutes " minutes"