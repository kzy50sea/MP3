.PHONY:all clean

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)

#修改
BIN := $(addprefix $(BUILD_ROOT)/,$(BIN))


#修改
LINK_OBJ_DIR = $(BUILD_ROOT)/app/link_obj
$(shell mkdir -p $(LINK_OBJ_DIR))

#添加存放依赖目录
DEP_DIR =$(BUILD_ROOT)/app/dep
$(shell mkdir -p $(DEP_DIR))


#添加库的链接目录
LIB_OBJ_DIR = $(BUILD_ROOT)/app/lib_obj
$(shell mkdir -p $(LIB_OBJ_DIR))

LIB_DIR = $(BUILD_ROOT)/lib
$(shell mkdir -p $(LIB_DIR))


#默认.o文件存放的路径
OBJ_DIR = $(LINK_OBJ_DIR)

#需要静态库时相应.o文件存放的路径
ifneq ("$(LIB)","")
OBJ_DIR = $(LIB_OBJ_DIR)
endif


#动态库对应的.o文件的路基
ifneq ("$(DLL)","")
OBJ_DIR = $(LIB_OBJ_DIR)
PIC     = -fPIC
endif


#修改
OBJS :=$(addprefix $(OBJ_DIR)/,$(OBJS))
DEPS :=$(addprefix $(DEP_DIR)/,$(DEPS))
LIB  :=$(addprefix $(LIB_DIR)/,$(LIB))
DLL  :=$(addprefix $(LIB_DIR)/,$(DLL))


 



LINK_OBJ  = $(wildcard $(LINK_OBJ_DIR)/*.o)
LINK_OBJ += $(OBJS)


LIB_DEP  = $(wildcard $(LIB_DIR)/*.a) $(wildcard $(LIB_DIR)/*.so)
LIB_DEP  += $(wildcard $(LIB_DIR)/ext_lib/*.a) $(wildcard $(LIB_DIR)/ext_lib/*.so)

LINK_LIB_NAME = $(patsubst lib%,-l%,$(basename $(notdir $(LIB_DEP))))


#1.修改
#BIN  = mp3
#2.定义到子模块Makefile文件中
#BIN  = 

all:$(DEPS) $(OBJS) $(LIB) $(DLL) $(BIN) 


ifneq ("$(wildcard $(DEPS))","")

include $(DEPS)

endif


#$(BIN):$(LINK_OBJ) $(LIB_DEP)
$(BIN):$(LINK_OBJ) 
	#echo "LINK_OBJ = $(LINK_OBJ)"
	#gcc -o $@ $^ -L$(LIB_DIR) $(LINK_LIB_NAME)
	#gcc -o $@ $^ -L$(LIB_DIR) $(LINK_LIB_NAME)
	gcc -o $@ $^ -L$(LIB_DIR) -L$(LIB_DIR)/ext_lib $(LINK_LIB_NAME)

$(LIB):$(OBJS)
	ar rcs $@ $^

$(DLL):$(OBJS)
	gcc -shared -o $@ $^

$(OBJ_DIR)/%.o:%.c
	#gcc -I$(HEAD_PATH) -o $@ -c $(filter %.c,$^)
	gcc -I$(HEAD_PATH) -o $@ -c $(PIC) $(filter %.c,$^)

$(DEP_DIR)/%.d:%.c
	gcc -I$(HEAD_PATH) -MM $(filter %.c,$^) | sed 's,\(.*\)\.o[ :]*,$(OBJ_DIR)/\1.o $@:,g'  > $@
clean:
	rm -rf $(BIN) $(OBJS) $(DEPS)

