all: windows linux zip

clean:
	rm -rf build

windows:
	mkdir -p build/linux
	godot -v --export "Linux/X11" ../build/linux/bounce.x86_64 project/project.godot

linux:
	mkdir -p build/windows
	godot -v --export "Windows Desktop" ../build/windows/bounce.exe project/project.godot

zip: windows linux
	mkdir -p build/zip
	mkdir -p build/zip/src
	rsync -av --progress project build/zip/src --exclude .import
	echo "This project was built using [Godot Engine](https://godotengine.org)." > build/zip/src/README.md
	mkdir -p build/zip/release/linux
	mkdir -p build/zip/release/windows
	cp -r build/windows/* build/zip/release/windows
	cp -r build/linux/* build/zip/release/linux
	cp LICENSE build/zip
	echo "Windows and Linux binaries are provided. You can also [play online!](https://doctor-g.github.io/GGJ21)" > build/zip/release/README.md
	mkdir -p build/zip/press
	cp raw_assets/promotional/*png build/zip/press
	cd build/zip;	zip bounce.zip -r .
