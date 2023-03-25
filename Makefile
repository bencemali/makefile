#### 1. Choose your shell ############################
SHELL = /bin/bash
######################################################


#### 2. Choose between C and C++ #####################
LANG = C
#LANG = CPP
######################################################

#### 3. Choose Compiler + Version ####################
#### C compilers
COMP = gcc
#COMP = clang

#### C++ compilers
#COMP = g++
#COMP = clang++

#### Choose Compiler version
#COMP += -std=c11
#COMP += -std=c++17
######################################################


#### 4. Compiler Options #############################
#### Compiler flags
COMPFLAGS = -I. -I$(HEADDIR)
#COMPFLAGS += -Wall
#COMPFLAGS += -Wextra
#COMPFLAGS += -Werror
#COMPFLAGS += -g
#COMPFLAGS += -O0
#COMPFLAGS += -I.
#COMPFLAGS += -pedantic

#### Linker flags
LDFLAGS =
#LDFLAGS += -lm
#LDFLAGS += -static
######################################################


#### 5. Name your directories ########################
HEADDIR = include
SRCDIR = src
OBJDIR = obj
BINDIR = bin
######################################################


#### 6. Choose the name of your binary ###############
TARGETNAME = target
######################################################



TARGET := $(BINDIR)/$(TARGETNAME)

ifeq ($(LANG),C)
HEADS = $(wildcard $(HEADDIR)/*.h)
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
endif
ifeq ($(LANG),CPP)
HEADS = $(wildcard $(HEADDIR)/*.h $(HEADDIR)/*.hpp)
SRCS = $(wildcard $(SRCDIR)/*.cpp $(SRCDIR)/*.cc)
OBJS = $(SRCS:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
endif

$(TARGET): $(OBJS) | $(BINDIR)
	$(COMP) $(LDFLAGS) $(OBJS) -o $@

ifeq ($(LANG),C)
$(OBJDIR)/%.o: $(SRCDIR)/%.c $(HEADS) | $(OBJDIR)
	$(COMP) $(COMPFLAGS) -c $< -o $@
endif
ifeq ($(LANG),CPP)
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp $(HEADS) | $(OBJDIR)
	$(COMP) $(COMPFLAGS) -c $< -o $@
endif

.PHONY: $(BINDIR) $(OBJDIR) clean memtest echo run debug

run: $(TARGET)
	@./$(TARGET)

$(BINDIR) $(OBJDIR):
	@mkdir -p $@

clean:
	rm -rf $(OBJDIR) $(BINDIR)

debug: $(TARGET)
	gdb $(TARGET)

memtest: $(TARGET)
	valgrind --tool=memcheck -s --leak-check=full --show-leak-kinds=all $(TARGET)

echo:
	@echo $(foreach var, $(.VARIABLES), $(info $(var) = $($(var)))) # | grep "... ="

