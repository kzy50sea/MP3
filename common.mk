.PHONY:all clean

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)

#修改
#BIN := $(addprefix /home/linux/Makefile/Lesson/study/day03/test4/,$(BIN))
BIN := $(addprefix $(BUILD_ROOT)/,$(BIN))


#修改
#LINK_OBJ_DIR = /home/linux/Makefile/Lesson/study/day03/test4/app/link_obj
LINK_OBJ_DIR = $(BUILD_ROOT)/app/link_obj
$(shell mkdir -p $(LINK_OBJ_DIR))

#添加存放依赖目录
DEP_DIR =$(BUILD_ROOT)/app/dep
$(shell mkdir -p $(DEP_DIR))


OBJS :=$(addprefix $(LINK_OBJ_DIR)/,$(OBJS))
DEPS :=$(addprefix $(DEP_DIR)/,$(DEPS))

LINK_OBJ  = $(wildcard $(LINK_OBJ_DIR)/*.o)
LINK_OBJ += $(OBJS)

#1.修改
#BIN  = mp3
#2.定义到子模块Makefile文件中
#BIN  = 

all:$(DEPS) $(OBJS) $(BIN) 


ifneq ("$(wildcard $(DEPS))","")

include $(DEPS)

endif


#$(BIN):$(OBJS)
$(BIN):$(LINK_OBJ)
	@echo "LINK_OBJ = $(LINK_OBJ)"
	gcc -o $@ $^ 

$(LINK_OBJ_DIR)/%.o:%.c
	gcc -o $@ -c $(filter %.c,$^)

#%.d:%.c
$(DEP_DIR)/%.d:%.c
	#gcc -MM $^ > $@
	#gcc -MM $^ | sed 's,\(.*\).o[ :]*,$(LINK_OBJ_DIR)/\1.o $@:,g'  > $@
	gcc -MM $(filter %.c,$^) | sed 's,\(.*\).o[ :]*,$(LINK_OBJ_DIR)/\1.o $@:,g'  > $@
clean:
	rm -rf $(BIN) $(OBJS) $(DEPS)

