#!/data/data/com.termux/files/usr/bin/sh
# run.sh — sunucuyu çalıştırır; çökerse 10 sn sonra yeniden başlatır.
# STOP dosyası varsa durur (kasıtlı durdurma ile çökmeyi ayırır).
#   Kalıcı durdur:  touch ~/mcserver/STOP ; (konsolda) stop
#   Tekrar başlat:  rm -f ~/mcserver/STOP ; tmux new-session -d -s mc "$HOME/mcserver/run.sh"
cd "$HOME/mcserver" || exit 1
while [ ! -f STOP ]; do
  java -Xms1G -Xmx1G -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -jar fabric-server.jar nogui
  [ -f STOP ] && break
  echo "$(date) — sunucu durdu, 10 sn sonra yeniden başlatılıyor..."
  sleep 10
done
