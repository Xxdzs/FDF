NAME:=fdf.exe

# Folders
SOURCE_PATH := src
CACHE_PATH  := cache
HEADER_PATH := include

# Files
FILES   = $(shell find $(SOURCE_PATH) -name '*.c')
OBJECTS = $(subst $(SOURCE_PATH),$(CACHE_PATH),$(FILES:.c=.o))
DEPFILES= $(OBJECTS:.o=.d)

# ===== Libraries =====
LFT_PATH := Libft
LFT_NAME := ft
LFT = $(LFT_PATH)/lib$(LFT_NAME).a

MLX_PATH := MinilibX
MLX_NAME := mlx
MLX = $(MLX_PATH)/lib$(MLX_NAME).a

LIBS_NAME = $(LFT_NAME) $(MLX_NAME) m
LIBS_PATH = $(LFT_PATH) $(MLX_PATH)
LIBS = $(LFT) $(MLX)
# =====================

# ===== Compiler =====
CC ?= gcc

LDFLAGS += $(addprefix -L,$(LIBS_PATH))
LDLIBS  += $(addprefix -l,$(LIBS_NAME))

# Configuration results
MLX_CONFIG = $(MLX:.a=.mk)
include $(MLX_CONFIG)

CPPFLAGS += -Wall -Wextra
CPPFLAGS += $(addprefix -I,$(HEADER_PATH) $(LFT_PATH)/include $(MLX_PATH)/$(MLX_FOLDER))
# ====================

all: $(NAME)

include $(wildcard $(DEPFILES))

$(MLX_CONFIG):
	( cd $(@D) ; ./configure )

$(NAME): $(LIBS)
$(NAME): $(OBJECTS)
	$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@

$(CACHE_PATH)/%.o: $(SOURCE_PATH)/%.c | $(CACHE_PATH)
	$(CC) $(CPPFLAGS) -MMD -c -o $@ $<

%.a:
	@make -C $(@D)

$(CACHE_PATH):
	mkdir $@

test:
	@echo -e $(IFLAG)
	@echo objects $(OBJECTS)

clean:
	$(RM) -r $(CACHE_PATH)

fclean: clean
	$(RM) $(NAME)

re: fclean
	@$(MAKE) all --no-print-directory

.PHONY: all clean fclean re
