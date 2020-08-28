#EXE="$STORE/aurora/Aurora.exe"
EXE="./Aurora.exe"
#DB="$STORE/aurora/AuroraDB.db"

WINEPREFIX=$HOME/.wine-aurora
WINEARCH=win32
SAVEDIR=$HOME/wine-aurora

mkdir -p $SAVEDIR
# Init starting DB
if [[ ! -a $SAVEDIR/AuroraDB.db ]]; then
  install -m 660 "$DB" "$SAVEDIR/"
fi

# Aurora saves in PWD, so we cd to SAVEDIR
cd $SAVEDIR

# Wine path added in flake.nix
$WINE $EXE
