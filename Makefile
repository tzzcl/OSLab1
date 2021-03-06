CC = gcc
CFLAGS = -m32 -O2 -I./include 
LDFLAGS = -m32 -melf_i386 

CFILES = $(shell find src/ -name "*.c")
SFILES = $(shell find src/ -name "*.S")
OBJS = $(CFILES:.c=.o) $(SFILES:.S=.o)
QEMU = qemu-system-i386

litenes.img: litenes
	@cd boot; make
	cat boot/bootblock litenes > litenes.img
litenes: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o litenes

-include $(patsubst %.o, %.d, $(OBJS))

.PHONY: clean
play: litenes.img
	$(QEMU) litenes.img
clean:
	@cd boot; make clean
	rm -f litenes litenes.img $(OBJS) $(OBJS:.o=.d)
