#!/usr/bin/env bash
EXE=$(dirname $0)/../aurora/Aurora.exe

WINEPREFIX=$HOME/.wine-aurora
WINEARCH=win32

wine $EXE
