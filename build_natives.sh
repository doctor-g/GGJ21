#!/bin/bash
#
# Build the Linux and Windows versions of the game.

mkdir -p build/linux
godot -v --export "Linux/X11" ../build/linux/bounce.x86_64 project/project.godot

mkdir -p build/windows
godot -v --export "Windows Desktop" ../build/windows/bounce.exe project/project.godot
