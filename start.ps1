# mix n match your favourite arguments
#
# docker run -it --rm --name wireshark-builder              liveforensics/wireshark:2004
#
# -v g:\code\wireshark-master:c:\development\wireshark 
# -v C:\qt\5.15.1\msvc2019_64:c:\qt
# -v g:\code\build-binaries:c:\development\wsbuild64\run
#
# --env QT5_BASE_DIR=C:\qt\5.15.1\msvc2019_64
# --env QT5_BASE_DIR=C:\qt
# --env Qt5Core_DIR=c:\qt\lib\cmake\qt5core
#
#

docker run -it --rm --name wireshark-builder `
    -v C:\qt:c:\qt `
    -v g:\code\build-binaries:c:\development\wsbuild64\run `
    -v g:\code\wireshark-master:c:\development\wireshark `
    --env QT5_BASE_DIR=C:\qt\5.12.9\msvc2017_64 `
    liveforensics/wireshark:2004

