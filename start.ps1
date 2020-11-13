# mix n match your favourite arguments
#
# docker run -it --rm --name wireshark-builder              liveforensics/wireshark:2004
#
# -v g:\code\wireshark-master:c:\development\wireshark 
# -v C:\qt\5.12.9\msvc2017_64:c:\qt
# -v g:\code\build-binaries:c:\development\wsbuild64\run
#
# --env QT5_BASE_DIR=C:\qt\Qt5.12.9\5.12.9\msvc2017_64
# --env QT5_BASE_DIR=C:\qt
#
#
#

docker run -it --rm --name wireshark-builder -v g:\code\build-binaries:c:\development\wsbuild64\run -v g:\code\wireshark-master:c:\development\wireshark --env NSISDIR=c:\nsis\bin --env QT5_BASE_DIR=C:\qt\Qt5.12.9\5.12.9\msvc2017_64 liveforensics/wireshark:2004

