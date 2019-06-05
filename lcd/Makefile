.PHONY:all clean

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)

#修改
#BIN  = mp3
BIN  = 

all:$(DEPS) $(OBJS) $(BIN) 


ifneq ("$(wildcard $(DEPS))","")

include $(DEPS)

endif


$(BIN):$(OBJS)
	@echo "SRCS = $(SRCS)"
	@echo "OBJS = $(OBJS)"
	gcc -o $@ $^
%.o:%.c
	gcc -o $@ -c $(filter %.c,$^)

%.d:%.c
	gcc -MM $^ > $@
clean:
	rm -rf $(BIN) $(OBJS) $(DEPS)

