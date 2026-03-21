.PHONY: config build clean
config:
	cmake -Bbuild -S.
build:
	cmake --build build
clean:
	rm ./build -rf

