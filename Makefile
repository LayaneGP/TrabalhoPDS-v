# Makefile para projeto C++

# Compilador e flags
CC = g++
CCFLAGS = -std=c++11 -Wall -I include

# Diretórios
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
INCLUDE_DIR = include
TEST_DIR = tests

# Arquivos fonte, objeto e cabeçalho
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC_FILES))
HEADER_FILES := $(wildcard $(INCLUDE)/*.hpp)
OBJ_NO_MAIN := $(filter-out obj/main.o, $(wildcard $(OBJ_DIR)/*.o))

# Nome do executável
EXECUTABLE = $(BIN_DIR)/main

# Alvo principal
all: $(EXECUTABLE)

# Alvo para objetos
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADER_FILES)
	$(CC) $(CCFLAGS) -c $^ -o $@

# Alvo principal
$(EXECUTABLE): $(OBJ_FILES)
	$(CC) $(CCFLAGS) $^ -o $@

# Alvo para limpeza de arquivos gerados
clean:
	del /Q $(OBJ_DIR)\*.o
	del /Q $(BIN_DIR)\*
	del /Q $(TEST_DIR)\*.o
	del /Q $(TEST_DIR)\*.exe

run: 
	./bin/main

test:
# g++ tests/test_posts.cpp tests/doctest.hpp -I include $(OBJ_NO_MAIN) -o tests/test_post.exe
	$(CC) $(CCFLAGS) -c tests/test_posts.cpp -o obj/test_posts.o
	$(CC) $(CCFLAGS) tests/doctest.hpp $(OBJ_NO_MAIN) -o tests/test_posts.exe

post: $(OBJ_FILES)
	$(CC) $(CCFLAGS) $^ -o tests/test_posts

test-post:
	./tests/test_posts
