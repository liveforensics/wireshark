## Overview

This is a Windows Image which contains all the build tools you need to build the Windows version of Wireshark. It is based on the Wireshark build guide https://www.wireshark.org/docs/wsdg_html_chunked/ChSetupWin32.html

Please note that I've only tested this on the 64 bit version of Wireshark.

Also note that the image is based on *mcr.microsoft.com/windows/servercore:2004-amd64*, so you'll need to make sure you're running a version of Windows with build version of 2004 or greater. I'm currently using Docker Desktop for Windows v2.5.0.1 running on Windows 10 20H2.

## Prerequisites

Because of licensing requirements, it doesn't look like I can easiliy incorporate the Qt framework into the image, so you will have to install Qt locally and use a mapped volume to allow the running container to use the libraries contained within it. I used https://www.qt.io/download to get the Open Source version - QT Online Installer.

I've cloned the github Wireshark repo into c:\code.

## Quickstart

I've installed Qt framework (v5.12.9) in C:\qt.

If you want the built binaries to be automatically exported from the container, you will need to map a volume to c:\outfiles in the container. I've created a folder for the build artifacts in c:\code\built-binaries.

`docker run -it --rm --name wireshark -v C:\qt\5.12.9\msvc2017_64:c:\qt -v c:\code\built-binaries:c:\outfiles -v c:\code\wireshark:c:\development\wireshark liveforensics/wireshark:2004`

The container should open in c:\development\wsbuild64. If you want to check some locations:

wireshark source is in c:\development\wireshark

You can switch to that folder and run a git pull to update the source.

Qt is in c:\Qt - This should be the contents of the msvc2017_64 folder from your local install.

Back inside of c:\development\wsbuild64, I've created a PowerShell script which will do all the work for you. You can view it with 

`cat .\go.ps1`

and you can run it with

`.\go.ps1`

## Help

From inside the running container - c:\development\wsbuild64 (the starting folder) just run

`.\help.ps1`

## Environment Variables

QT5_BASE_DIR="c:\Qt"

if you need to change this at runtime (for example you've mapped -v c:\qt:c:\qt) then simply add this to your docker run command.

`--env QT5_BASE_DIR=C:\qt\Qt5.12.9\5.12.9\msvc2017_64`

## Source Files

`git clone https://github.com/liveforensics/wireshark.git`

## Building the Image from source

You need to have an instance of Docker running and you need to make sure docker-compose is installed. Docker needs to be setup to run Windows containers, so you need to be running on a Windows host.

I like to use docker-compose, so once you've cloned the github repo and switched into it's wireshark folder, just run

`docker-compose build`

It'll take a while because it's freaking huge! It's got python AND perl AND visual studio AND java AND other stuff.

## Alternate Windows Images

If you're running an older version of Windows, and want to build a compatible image, just modify the FROM line at the top of the Dockerfile for an appropriate version of servercore. e.g. 1803 or 1909.

## Qt inside the container

If you are happy to create your own containers, you could use liveforensics/wireshark:2004 as your base image and copy the appropriate chunk of the qt install folders into the container itself. Remember to also fix up the QT5_BASE_DIR environment variable.

## TODO

 I've added the NSIS tools into the container and included the build commands in the go.ps1 file, but as you will see the commands are commented out because so far I haven't been able to successfully build the installer.