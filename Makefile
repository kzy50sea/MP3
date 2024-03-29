.PHONY:all clean distclean install uninstall

export BUILD_ROOT = $(shell pwd)
export HEAD_PATH  = $(BUILD_ROOT)/include

all:
	make -C lcd
	make -C usb
	make -C media
	make -C math
	make -C app
	
clean:
	rm -f  mp3
	rm -rf app/player.o app/player.d app/mp3
	rm -rf usb/usb.o  usb/usb.d
	rm -rf lcd/lcd.o  lcd/lcd.d
	rm -rf media/media.o media/media.d
	rm -fr app/link_obj/*.o

distclean:
	rm -f  mp3
	rm -fr app/lib_obj
	rm -rf app/link_obj
	rm -rf app/dep
	rm -rf lib/

install:
	cp mp3 /usr/bin
	cp lib/libmath.so /usr/lib
	cp lib/ext_lib/librmvb.so /usr/lib

uninstall:
	rm -f /usr/bin/mp3
	rm -f /usr/lib/libmath.so
	rm -f /usr/lib/librmvb.so

