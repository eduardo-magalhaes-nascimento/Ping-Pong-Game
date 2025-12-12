## Makefile compatível com Raylib + w64devkit (Windows)

RAYLIB_PATH ?= C:/raylib/raylib
CXX ?= C:/raylib/w64devkit/bin/g++.exe
CXXFLAGS ?= -std=c++17 -Wall -I$(RAYLIB_PATH)/src
LDFLAGS ?= -L$(RAYLIB_PATH)/src -lraylib -lopengl32 -lgdi32 -lwinmm -luser32

BUILD_MODE ?= DEBUG
ifeq ($(BUILD_MODE),DEBUG)
  CXXFLAGS += -g -O0
else
  CXXFLAGS += -O2
endif

# If OBJS is passed (like OBJS=src/*.cpp), use it as source list, otherwise
# use the default src/*.cpp
ifeq ($(strip $(OBJS)),)
  SRCS := $(wildcard src/*.cpp)
else
  SRCS := $(OBJS)
endif

OBJS := $(SRCS:.cpp=.o)

PROJECT_NAME ?= main
TARGET := $(PROJECT_NAME).exe

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

run: $(TARGET)
	./$(TARGET)
