# IP of your 200 Series box
export VIVI_BOX_IP="10.0.0.119"
export VIVI_RECEIVER_HOME="/data/data/io.vivi.receiver/files/home"
export VIVI_ANDROID_ID="io.vivi.receiver"
export VIVI_CANVAS_MAINACTIVITY="$VIVI_ANDROID_ID/.canvas.MainActivity"

function receiver_backend_staging() {
	# vivi-receiver: Change connected device's backend to use staging
	conf_dir="/data/data/io.vivi.receiver/files/data/conf";
	adb shell "echo staging.vivi.io > $conf_dir/cloud";
	adb shell "cat /dev/null > $conf_dir/id";
	adb reboot;
}

function receiver_backend_production() {
	# vivi-receiver: Change connected device's backend to use production
	conf_dir="/data/data/io.vivi.receiver/files/data/conf";
	adb shell "echo api.vivi.io > $conf_dir/cloud";
	adb shell "cat /dev/null > $conf_dir/id";
	adb reboot;
}

function receiver_setup() {
    # Post cloning receiver setup: Fetch Termux / vivi-box
    ./scripts/fetch_termux_files.sh
    ./scripts/bundle_vivi_box.sh -f
}

# Apply changes made to app-canvas/vivi-box
alias bundlebox="./scripts/bundle_vivi_box.sh -k"

# Requires installing scrcpy. 
# Show Android screen on your local computer
# For some boxes recevier_show will not work so you can use recevier_show2 to use a different encoding
alias recevier_show="scrcpy --encoder 'OMX.google.h264.encoder'"
alias recevier_show2="scrcpy --encoder 'OMX.amlogic.video.encoder.avc'"


# Show all Vivi Packages installed on the Device
alias adb_vivi_packages="adb shell pm list packages | grep vivi"

# Start vivi-receiver on the current adb device
alias receiver_start="adb shell am start $VIVI_CANVAS_MAINACTIVITY"

function receiver_stop() {
	# Stop vivi-receiver on the current adb device
	adb shell am force-stop io.vivi.receiver;
	adb shell am force-stop io.vivi.receiver.background;
}

function receiver_restart() {
	# Restart vivi-receiver on the current adb device
	receiver_stop;
	receiver_start;
}

function receiver_uninstall() {
	# Uninstall vivi-receiver from the connected device
	adb uninstall io.vivi.receiver;
	adb uninstall io.vivi.receiver.supervisor;
	adb uninstall io.vivi.receiver.app-canvas;
}

function receiver_uninstall_hard() {
	# Uninstall vivi-receiver from connected adb device
	# Sometimes receiver_uninstall is not guaranteed to work 
	# This will attempt to uninstall_receiver and hard remove 
	# The files where we install files for the receiver
	adb shell "rm -rf /data/app/io.vivi.receiver* /data/data/io.vivi.receiver*"
}

function receiver_install_moonraker() {
	# Install the Moonraker Dev Build
	./gradlew :app-canvas:assembleGoldFingerDebug
	./gradlew :app-canvas:installMoonrakerDebug;
    receiver_restart;
}

function receiver_install_goldfinger() {
    # Build install supervisor
    ./gradlew :app-supervisor:assembleGoldfingerDebug;
    ./gradlew :app-supervisor:installGoldFingerDebug;
	# Build install canvas
	./gradlew :app-canvas:assembleGoldfingerDebug;
	./gradlew :app-canvas:installGoldfingerDebug;
    receiver_restart;
}


