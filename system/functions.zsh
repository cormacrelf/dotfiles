osleep () {
	osascript -e "tell application \"System Events\" to sleep"
}
setvol () {
	osascript -e "set Volume $1"
}
