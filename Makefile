#### 1. Choose shell #################################
SHELL = /bin/bash
######################################################


#### 2. Choose Compiler + Version ####################
#### C compilers
COMP = gcc
#COMP = clang

#### C++ compilers
#COMP = g++
#COMP = clang++

#### Choose Compiler version
COMP += -std=c11		#C11
#COMP += -std=c++17		#CPP17
######################################################


#### 3. Compiler Options #############################
#### Compiler flags
COMPFLAGS = -Wall -pedantic -Wextra -Werror -g -O0 -I. -I$(HEADDIR)

#### Linker flags
LDFLAGS =
######################################################


#### 4. Name your directories ########################
HEADDIR = include
SRCDIR = src
OBJDIR = obj
BINDIR = bin
######################################################


#### 5. Choose the name of your binary ###############
TARGETNAME = target
######################################################


TARGET := $(BINDIR)/$(TARGETNAME)
HEADS = $(wildcard $(HEADDIR)/*.h $(HEADDIR)/*.hpp)
SRCS = $(wildcard $(SRCDIR)/*.cpp $(SRCDIR)/*.cc)
OBJS = $(SRCS:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

$(TARGET): $(OBJS) | $(BINDIR)
	$(COMP) $(LDFLAGS) $(OBJS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp $(HEADS) | $(OBJDIR)
	$(COMP) $(COMPFLAGS) -c $< -o $@

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

