# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/fxiao/CS211/lab0/cs211_lab0/CS211

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/fxiao/CS211/lab0/cs211_lab0/CS211/build

# Include any dependencies generated for this target.
include CMakeFiles/CacheSim.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/CacheSim.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/CacheSim.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CacheSim.dir/flags.make

CMakeFiles/CacheSim.dir/src/MainCache.cpp.o: CMakeFiles/CacheSim.dir/flags.make
CMakeFiles/CacheSim.dir/src/MainCache.cpp.o: ../src/MainCache.cpp
CMakeFiles/CacheSim.dir/src/MainCache.cpp.o: CMakeFiles/CacheSim.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/fxiao/CS211/lab0/cs211_lab0/CS211/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/CacheSim.dir/src/MainCache.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CacheSim.dir/src/MainCache.cpp.o -MF CMakeFiles/CacheSim.dir/src/MainCache.cpp.o.d -o CMakeFiles/CacheSim.dir/src/MainCache.cpp.o -c /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MainCache.cpp

CMakeFiles/CacheSim.dir/src/MainCache.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CacheSim.dir/src/MainCache.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MainCache.cpp > CMakeFiles/CacheSim.dir/src/MainCache.cpp.i

CMakeFiles/CacheSim.dir/src/MainCache.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CacheSim.dir/src/MainCache.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MainCache.cpp -o CMakeFiles/CacheSim.dir/src/MainCache.cpp.s

CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o: CMakeFiles/CacheSim.dir/flags.make
CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o: ../src/MemoryManager.cpp
CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o: CMakeFiles/CacheSim.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/fxiao/CS211/lab0/cs211_lab0/CS211/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o -MF CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o.d -o CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o -c /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MemoryManager.cpp

CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MemoryManager.cpp > CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.i

CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/MemoryManager.cpp -o CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.s

CMakeFiles/CacheSim.dir/src/Cache.cpp.o: CMakeFiles/CacheSim.dir/flags.make
CMakeFiles/CacheSim.dir/src/Cache.cpp.o: ../src/Cache.cpp
CMakeFiles/CacheSim.dir/src/Cache.cpp.o: CMakeFiles/CacheSim.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/fxiao/CS211/lab0/cs211_lab0/CS211/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/CacheSim.dir/src/Cache.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CacheSim.dir/src/Cache.cpp.o -MF CMakeFiles/CacheSim.dir/src/Cache.cpp.o.d -o CMakeFiles/CacheSim.dir/src/Cache.cpp.o -c /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/Cache.cpp

CMakeFiles/CacheSim.dir/src/Cache.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CacheSim.dir/src/Cache.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/Cache.cpp > CMakeFiles/CacheSim.dir/src/Cache.cpp.i

CMakeFiles/CacheSim.dir/src/Cache.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CacheSim.dir/src/Cache.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/fxiao/CS211/lab0/cs211_lab0/CS211/src/Cache.cpp -o CMakeFiles/CacheSim.dir/src/Cache.cpp.s

# Object files for target CacheSim
CacheSim_OBJECTS = \
"CMakeFiles/CacheSim.dir/src/MainCache.cpp.o" \
"CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o" \
"CMakeFiles/CacheSim.dir/src/Cache.cpp.o"

# External object files for target CacheSim
CacheSim_EXTERNAL_OBJECTS =

CacheSim: CMakeFiles/CacheSim.dir/src/MainCache.cpp.o
CacheSim: CMakeFiles/CacheSim.dir/src/MemoryManager.cpp.o
CacheSim: CMakeFiles/CacheSim.dir/src/Cache.cpp.o
CacheSim: CMakeFiles/CacheSim.dir/build.make
CacheSim: CMakeFiles/CacheSim.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/fxiao/CS211/lab0/cs211_lab0/CS211/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable CacheSim"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CacheSim.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CacheSim.dir/build: CacheSim
.PHONY : CMakeFiles/CacheSim.dir/build

CMakeFiles/CacheSim.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CacheSim.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CacheSim.dir/clean

CMakeFiles/CacheSim.dir/depend:
	cd /home/fxiao/CS211/lab0/cs211_lab0/CS211/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/fxiao/CS211/lab0/cs211_lab0/CS211 /home/fxiao/CS211/lab0/cs211_lab0/CS211 /home/fxiao/CS211/lab0/cs211_lab0/CS211/build /home/fxiao/CS211/lab0/cs211_lab0/CS211/build /home/fxiao/CS211/lab0/cs211_lab0/CS211/build/CMakeFiles/CacheSim.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CacheSim.dir/depend

