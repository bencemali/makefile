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
#COMP = icc
#COMP = tcc

#### C++ compilers
#COMP = g++
#COMP = clang++
#COMP = icpc
#COMP = t++

#### Choose Compiler version
#COMP += -std=c99
#COMP += -std=c11
#COMP += -std=c17
#COMP += -std=c18
#COMP += -std=c2x

#COMP += -std=c++98
#COMP += -std=c++03
#COMP += -std=c++14
#COMP += -std=c++17
#COMP += -std=c++2a
######################################################


#### 4. Compiler/Linker Options #############################
#### Compiler flags
# include current directory
COMPFLAGS = -I.
# include header directory
COMPFLAGS += -I$(HEADDIR)
# enable all warnings
COMPFLAGS += -Wall
# enable extra warnings
COMPFLAGS += -Wextra
# treat warnings as errors
COMPFLAGS += -Werror
# enable debug symbols
COMPFLAGS += -g
# no optimization
COMPFLAGS += -O0
# optimize
#COMPFLAGS += -O1
# optimize more
#COMPFLAGS += -O2
# do not use
#COMPFLAGS += -O3
# include current directory
COMPFLAGS += -I.
# enable pedantic warnings
COMPFLAGS += -pedantic
# enable stack protection
#COMPFLAGS += -fstack-protector
# enable all sanitizers
#COMPFLAGS += -fsanitize
# enable native architecture optimizations
#COMPFLAGS += -march=native
# enable native cpu optimizations
#COMPFLAGS += -mtune=native

#### Linker flags
LDFLAGS =
# link library directory
#LDFLAGS += -L/path/to/lib
# link math library
#LDFLAGS += -lm
# link statically
#LDFLAGS += -static
# link libgcc statically
#LDFLAGS += -static-libgcc
# link libstdc++ statically
#LDFLAGS += -static-libstdc++
# link pthread library
#LDFLAGS += -pthread
# do not link standard libraries
#LDFLAGS += -nostdlib
# do not link libc
#LDFLAGS += -nolibc
# do not link start files
#LDFLAGS += -nostartfiles
# do not link default libraries
#LDFLAGS += -nodefaultlibs
# link SDL2 library
#LDFLAGS += -lSDL2
# link OpenGL library
#LDFLAGS += -lGL
# link GLEW library
#LDFLAGS += -lGLEW
# link X11 library
#LDFLAGS += -L/usr/X11R6/lib
# link GLUT library
#LDFLAGS += -lglut
# link GLU library
#LDFLAGS += -lGLU
# link Xi library
#LDFLAGS += -lXi
# link Xmu library
#LDFLAGS += -lXmu
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
