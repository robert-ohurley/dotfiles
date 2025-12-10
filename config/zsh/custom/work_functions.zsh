fixpostgres() {
  # own data directory
  sudo chown -R 999:999 /home/rob/dev/vivi-local-cloud/tmp/db/16.6
  sudo find /home/rob/dev/vivi-local-cloud/tmp/db/16.6 -type d -exec chmod 700 {} \;
  sudo find /home/rob/dev/vivi-local-cloud/tmp/db/16.6 -type f -exec chmod 600 {} \;

  # pg_hba_dev.conf must also be readable by postgres
  sudo chown 999:999 /home/rob/dev/vivi-local-cloud/pg_hba_dev.conf
  sudo chmod 600 /home/rob/dev/vivi-local-cloud/pg_hba_dev.conf
}

imx_to_staging() {
  if [ -z "$1" ]; then
    echo "Usage: imx_to_staging <IP_ADDRESS>"
    return 1
  fi

  local host="$1"
  local key="$HOME/.ssh/id_rsa_box"

  echo "→ Connecting to ${host} and switching to staging.vivi.io…"
  ssh -i "$key" root@"$host" 'bash -s' <<'EOF'
set -euo pipefail

echo "staging.vivi.io" > /data/conf/cloud

: > /data/conf/id

echo "✔ Done: /data/conf/cloud set to staging.vivi.io and id reset"
reboot
EOF
}

imx_to_prod() {
  if [ -z "$1" ]; then
    echo "Usage: imx_back_to_prod <IP_ADDRESS>"
    return 1
  fi

  local host="$1"
  local key="$HOME/.ssh/id_rsa_box"

  echo "→ Connecting to ${host} and restoring /data/conf from /data/conf_old…"
  ssh -i "$key" root@"$host" 'bash -s' <<'EOF'
set -euo pipefail

echo "api.vivi.io" > /data/conf/cloud

echo "✔ Restored /data/conf."
: > /data/conf/id
reboot
EOF
}

goldfinger_to_staging() {
  if [ -z "$1" ]; then
    echo "Usage: goldfinger_to_staging <serial|ip[:port]>"
    return 1
  fi

  local target="$1"

  adb connect "$target" >/dev/null 2>&1 || true
  adb -s "$target" root >/dev/null 2>&1 || true

  adb -s "$target" shell <<'EOF'
set -e
CONF_DIR="/data/data/io.vivi.receiver/files/data/conf"

# Ensure directory exists
mkdir -p "$CONF_DIR"

# Set staging cloud and reset id
printf '%s\n' "staging.vivi.io" > "$CONF_DIR/cloud"
: > "$CONF_DIR/id" || true

if command -v pkill >/dev/null 2>&1; then
  pkill -f node || true
elif command -v killall >/dev/null 2>&1; then
  killall node || true
else
  for pid in $(ps | grep '[n]ode' | awk '{print $2}'); do
    kill "$pid" || true
  done
fi

echo "✔ Updated $CONF_DIR/cloud to staging.vivi.io, reset id, terminated node (if any)"
reboot
EOF
}

goldfinger_to_prod() {
  adb kill-server
  if [ -z "$1" ]; then
    echo "Usage: goldfinger_back_to_prod <serial|ip[:port]>"
    return 1
  fi

  local target="$1"
  adb connect "$target" >/dev/null 2>&1 || true

  adb -s "$target" root >/dev/null 2>&1 || true

  adb -s "$target" shell <<'EOF'
set -e
mkdir -p /data/data/io.vivi.receiver/files/data/conf
echo "api.vivi.io" > /data/data/io.vivi.receiver/files/data/conf/cloud
echo "✔ cloud set to api.vivi.io"
reboot
EOF
}

imx_reboot() {
  if [ -z "$1" ]; then
    echo "Usage: imx_reboot <IP_ADDRESS>"
    return 1
  fi

  local host="$1"
  local key="$HOME/.ssh/id_rsa_box"

  ssh -i "$key" root@"$host" 'bash -s' <<'EOF'
set -euo pipefail
reboot
EOF
}

goldfinger_reboot() {
  adb kill-server
  if [ -z "$1" ]; then
    echo "Usage: goldfinger_reboot <ip>"
    return 1
  fi

  local target="$1"
  adb connect "$target" >/dev/null 2>&1 || true
  adb -s "$target" root >/dev/null 2>&1 || true
  adb -s "$target" shell <<'EOF'
set -e
reboot
EOF
}


gold() {
  ./gradlew --stop
  ./gradlew clean

	# Build install supervisor
  ./gradlew :app-supervisor:assembleGoldfingerDebug;
  --no-build-cache --refresh-dependencies --rerun-tasks --stacktrace

  ./gradlew :app-supervisor:installGoldFingerDebug;
  --no-build-cache --refresh-dependencies --rerun-tasks --stacktrace

	# Build install canvas
	./gradlew :app-canvas:assembleGoldfingerDebug;
  --no-build-cache --refresh-dependencies --rerun-tasks --stacktrace

	./gradlew :app-canvas:installGoldfingerDebug;
  --no-build-cache --refresh-dependencies --rerun-tasks --stacktrace

    receiver_restart;
}
