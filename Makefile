#### 1. Choose your shell ############################
SHELL = /bin/bash
######################################################


#### 2. Choose between C and C++ #####################
LANG = C
#LANG = CPP
######################################################


#### 3. Choose Compiler + Version ####################
#### C compilers
COMP = gcc          # GNU C Compiler
#COMP = clang       # Clang C Compiler
#COMP = icc         # Intel C Compiler
#COMP = tcc         # Tiny C Compiler

#### C++ compilers
#COMP = g++         # GNU C++ Compiler
#COMP = clang++     # Clang C++ Compiler
#COMP = icpc        # Intel C++ Compiler
#COMP = t++         # Tiny C++ Compiler

#### Choose Compiler version
#COMP += -std=c99       # C99
#COMP += -std=c11       # C11
#COMP += -std=c17       # C17
#COMP += -std=c18       # C18
#COMP += -std=c2x       # C2x

#COMP += -std=c++98     # C++98
#COMP += -std=c++03     # C++03
#COMP += -std=c++14     # C++14
#COMP += -std=c++17     # C++17
#COMP += -std=c++2a     # C++2a
######################################################


#### 4. Compiler/Linker Options #############################
#### Compiler flags
COMPFLAGS = -I.                     # include current directory
COMPFLAGS += -I$(HEADDIR)           # include header directory
COMPFLAGS += -Wall                  # enable all warnings
COMPFLAGS += -Wextra                # enable extra warnings
COMPFLAGS += -Werror                # treat warnings as errors
COMPFLAGS += -g                     # enable debug symbols
COMPFLAGS += -O0                    # no optimization
#COMPFLAGS += -O1                   # optimize
#COMPFLAGS += -O2                   # optimize more
#COMPFLAGS += -O3                   # do not use
COMPFLAGS += -I.                    # include current directory
COMPFLAGS += -pedantic              # enable pedantic warnings
#COMPFLAGS += -fstack-protector     # enable stack protection
#COMPFLAGS += -fsanitize            # enable all sanitizers
#COMPFLAGS += -march=native         # enable native architecture optimizations
#COMPFLAGS += -mtune=native         # enable native cpu optimizations

#### Linker flags
LDFLAGS =
#LDFLAGS += -L/path/to/lib          # link library directory
#LDFLAGS += -lm                     # link math library
#LDFLAGS += -static                 # link statically
#LDFLAGS += -static-libgcc          # link libgcc statically
#LDFLAGS += -static-libstdc++       # link libstdc++ statically
#LDFLAGS += -pthread                # link pthread library
#LDFLAGS += -nostdlib               # do not link standard libraries
#LDFLAGS += -nolibc                 # do not link libc
#LDFLAGS += -nostartfiles           # do not link start files
#LDFLAGS += -nodefaultlibs          # do not link default libraries
#LDFLAGS += -lSDL2                  # link SDL2 library
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
