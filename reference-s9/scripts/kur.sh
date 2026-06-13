#!/data/data/com.termux/files/usr/bin/sh
# kur.sh — Fabric 1.21.1 sunucusu + 6 performans modu + playit + otonomi.
# Termux + Termux:Boot KURULU olmalı (bkz. docs/01). Repo kökünden çalıştır:
#   sh scripts/kur.sh
set -e

MCVER=1.21.1
LOADER=0.19.3
INSTALLER=1.1.1
MCDIR="$HOME/mcserver"
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"
REPODIR="$(dirname "$SCRIPTDIR")"
MODS="lithium ferrite-core krypton modernfix scalablelux noisium"

echo "[1/6] Paketler..."
# Non-interaktif + conffile çakışmasında mevcut dosyayı koru (yoksa openssl.cnf gibi
# paketler ssh/script altında interaktif soru sorup takılır).
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get -y -o Dpkg::Options::=--force-confold upgrade
pkg install -y openjdk-21 tmux jq curl tur-repo
pkg install -y playit || echo "  ! playit TUR'dan gelmedi — docs/03'teki elle yola bak."

echo "[2/6] Sunucu dizini + Fabric launcher..."
mkdir -p "$MCDIR/mods"
curl -fL -o "$MCDIR/fabric-server.jar" \
  "https://meta.fabricmc.net/v2/versions/loader/$MCVER/$LOADER/$INSTALLER/server/jar"

echo "[3/6] EULA + server.properties..."
echo "eula=true" > "$MCDIR/eula.txt"
cp "$REPODIR/config/server.properties.ornek" "$MCDIR/server.properties"

echo "[4/6] Performans modları (Modrinth, $MCVER/fabric)..."
for slug in $MODS; do
  url=$(curl -fsSL \
    "https://api.modrinth.com/v2/project/$slug/version?loaders=%5B%22fabric%22%5D&game_versions=%5B%22$MCVER%22%5D" \
    | jq -r '(.[0].files[] | select(.primary==true) | .url) // .[0].files[0].url')
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    echo "  ! $slug için $MCVER/fabric sürümü bulunamadı — elle indir."
    continue
  fi
  echo "  - $slug"
  curl -fsSL -o "$MCDIR/mods/$slug.jar" "$url"
done

echo "[5/6] Otonomi (run.sh + boot script)..."
cp "$SCRIPTDIR/run.sh" "$MCDIR/run.sh"
chmod +x "$MCDIR/run.sh"
mkdir -p "$HOME/.termux/boot"
cp "$SCRIPTDIR/boot/start-mc" "$HOME/.termux/boot/start-mc"
chmod +x "$HOME/.termux/boot/start-mc"

echo
echo "[6/6] BITTI. Elle kalan adımlar:"
echo "  1) Termux:Boot uygulamasını BIR KEZ aç (açılış izni)."
echo "  2) Pil: Termux 'Kısıtlanmamış'; S9'da 'Uyumayan uygulamalar'a ekle (docs/01)."
echo "  3) playit: 'termux-wake-lock; playit-cli' → claim linkini onayla → panelde"
echo "     Minecraft Java tüneli, Local 127.0.0.1:25565 (docs/03)."
echo "  4) İlk başlatma:  tmux new-session -d -s mc \"\$HOME/mcserver/run.sh\""
echo "     Konsol:        tmux attach -t mc   (Done! gör, sonra Ctrl+B D)"
