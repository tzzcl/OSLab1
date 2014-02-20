CC = gcc
CFLAGS = -O2 -I./include -Wall -Werror
LDFLAGS = -lallegro -lallegro_main -lallegro_primitives

CFILES = $(shell find src/ -name "*.c")
SFILES = $(shell find src/ -name "*.S")
OBJS = $(CFILES:.c=.o) $(SFILES:.S=.o)
QEMU = qemu-system-i386
litenes: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o litenes

-include $(patsubst %.o, %.d, $(OBJS))

.PHONY: clean

clean:
	rm -f litenes $(OBJS) $(OBJS:.o=.d)
