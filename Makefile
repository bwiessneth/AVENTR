CXX=g++
CXXFLAGS=-O2 -Wall

# Add source files to $(SRC)
SRC = \
src/MSG.cpp \
src/tools.cpp \
src/Config.cpp \
src/EntityPort.cpp \
src/GenericSignal.cpp \
src/VHDLEntity.cpp \
src/VHDLParser.cpp \
src/OFileHandler.cpp \
src/FODGWriter.cpp \
src/FODG.cpp\
src/SVGWriter.cpp \
src/SVG.cpp\
src/DWMarkup.cpp \
src/Markdown.cpp \
src/LaTeX.cpp \
src/OutputGenerator.cpp \
src/VEC.cpp

# Build $(OBJS)
OBJS=$(patsubst src%.cpp,build%.o, $(SRC))

# Output binary directory and name
ifeq ($(OS),Windows_NT)
BIN = bin/VEC.exe
else
BIN = bin/VEC
endif

all: VEC

# Create build directory
$(OBJS): | build
build:
	@mkdir -p $@

# Build obj files
build/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build executable
VEC: $(OBJS)
	[ -d "bin" ] || mkdir bin
	$(CXX) $(CXXFLAGS) -o $(BIN) $(OBJS)	

# Remove all intermediate files
.PHONY: clean
clean:
	rm -rf $(OBJS) *.AppImage AppDir bin build\

# Remove binary
.PHONY: uninstall
uninstall:
	./install.sh / --uninstall

install:
	./install.sh /

format:
	clang-format -i src/*
