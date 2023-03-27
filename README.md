# A Portable and Configurable Makefile for C/C++ Projects

A Makefile is a build automation tool that automates the management of your project. Although using this Makefile doesn't require familiarity with writing Makefiles, I recommend reading the [GNU Make Manual](https://www.gnu.org/software/make/manual/) if you're interested.

The purpose of this project is to provide a portable, easy-to-configure and beginner friendly Makefile for C/C++ projects.

---

## Features 

1. Interactive option selection with commenting
2. Options for choosing your
	1.  Shell (bash by default)
	2. Language (C vs C++)
	3. Compiler (gcc, g++, clang, clang++, etc.)
	4. Compiler version (c99, c++11, etc.)
	5. Compiler/Linker options
	6. Directory names (src, include, obj, bin)
	7. Target binary name (target by default)
3. Easy-to-use commands for building, running, etc.

---

## Usage

1. Clone the repository to a central location
2. Start a project in any directory
3. In your project directory put your c/c++ source files (.c/.cpp) into a src/ directory
4. Put your header files (.h/.hpp) into an include/ directory
5. Copy the Makefile from the central location to any newly created project directory
6. Configure the Makefile
7. Run the commands to build/run/manage your project

### Supported Commands

- `make` - Builds your project. Your objects files will be put in the obj/ directory, your target binary will be put in the bin/ directory
- `make run` - Builds (see above) and runs your project
- `make clean` - Removes your object and binary directories (obj/ and bin/)
- `make debug` - Runs your program with gdb
- `make memtest` - Runs your program with valgrind (configured for memcheck)
- `make echo | grep "<inner Makefile variable> ="`  - Gives you the value of a variable in your Makefile (eg. SRC = main.c list.c)

### Directories
- `src` - Directory for the C/C++ source files (.c/.cpp)
- `include` - Directory for the C/C++ header files (.h/.hpp)
- `obj` - Directory for the object files (.o)
- `bin` - Directory for the target binary (executable)