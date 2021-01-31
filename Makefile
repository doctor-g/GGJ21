all: windows linux

windows:
	mkdir -p build/linux
	godot -v --export "Linux/X11" ../build/linux/bounce.x86_64 project/project.godot

linux:
	mkdir -p build/windows
	godot -v --export "Windows Desktop" ../build/windows/bounce.exe project/project.godot
