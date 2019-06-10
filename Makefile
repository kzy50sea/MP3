.PHONY:all clean distclean

export BUILD_ROOT = $(shell pwd)
export HEAD_PATH  = $(BUILD_ROOT)/include

all:
	make -C lcd
	make -C usb
	make -C media
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
