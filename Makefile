## # CC and flags
## CC = g++
## CXXFLAGS = -std=c++11 -g -Wall
## 
## # folders
## INCLUDE_FOLDER = ./include/
## BIN_FOLDER = ./bin/
## OBJ_FOLDER = ./obj/
## SRC_FOLDER = ./src/
## 
## 
## # all sources, objs, and header files
## MAIN = main
## TARGET = main.exe
## SRC = $(wildcard $(SRC_FOLDER)*.cpp)
## OBJ = $(patsubst $(SRC_FOLDER)%.cpp, $(OBJ_FOLDER)%.o, $(SRC))
## 
## # compile
## $(OBJ_FOLDER)%.o: $(SRC_FOLDER)%.cpp
## 	$(CC) $(CXXFLAGS) -c $< -o $@ -I$(INCLUDE_FOLDER)
## 
## all: $(OBJ)
## 	$(CC) $(CXXFLAGS) -o $(BIN_FOLDER)$(TARGET) $(OBJ) 
## 
## clean:
## 	@rm -rf $(OBJ_FOLDER)* $(BIN_FOLDER)*
## 
## run:
## 	@$(BIN_FOLDER)$(TARGET)


# Makefile para compilar e executar um programa C++ com testes

# Compiler
CXX := g++
# Flags para o compilador
CXXFLAGS := -std=c++17 -Wall -Wextra -Iinclude

# Diretórios
BIN_DIR := bin
BIN_TESTS_DIR := bin_tests
OBJ_DIR := obj
INCLUDE_DIR := include
SRC_DIR := src
TEST_DIR := tests
OBJ_TEST_DIR := obj_tests

# Arquivos fonte
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))
OBJS_TEST := $(patsubst $(TEST_DIR)/%.cpp, $(OBJ_TEST_DIR)/%.o, $(SRCS))


TEST_SRCS := $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJS := $(patsubst $(TEST_DIR)/%.cpp, $(OBJ_TEST_DIR)/%.o, $(TEST_SRCS))

# Nome do executável
TARGET := $(BIN_DIR)/main.exe

# Nome do executável de testes
TEST_TARGET := $(BIN_TESTS_DIR)/test_my_program

# Regras de compilação
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_TEST_DIR)/%.o: $(TEST_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Regras principais
build: $(TARGET) $(TEST_TARGET)

test: $(TEST_TARGET)
	@./$(TEST_TARGET)

run: $(TARGET)
	@./$(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_TARGET): $(TEST_OBJS) $(filter-out $(OBJ_DIR)/main.o, $(OBJS))
	$(CXX) $(CXXFLAGS) $^ -o $@

# Limpar arquivos intermediários e executáveis
clean:
	@rm -rf $(OBJ_DIR)/* $(BIN_DIR)/* $(BIN_TESTS_DIR)/* $(OBJ_TEST_DIR)/*

# Fazer clean e build
rebuild: clean build

.PHONY: build test run clean rebuild



##############################################


# Makefile para compilar e executar um programa C++ com testes

# Compiler
CXX := g++
# Flags para o compilador
CXXFLAGS := -std=c++17 -Wall -Wextra -I$(INCLUDE_DIR)

# Diretórios
BIN_DIR := bin
BIN_TESTS_DIR := bin_tests
OBJ_DIR := obj
OBJ_TEST_DIR := obj_tests
INCLUDE_DIR := include
SRC_DIR := src
TEST_DIR := tests

# Arquivos fonte
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

TEST_SRCS := $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJS := $(patsubst $(TEST_DIR)/%.cpp, $(OBJ_TEST_DIR)/%.o, $(TEST_SRCS))

# Nome do executável
TARGET := $(BIN_DIR)/main.exe

# Nome do executável de testes
TEST_TARGET := $(BIN_TESTS_DIR)/test_my_program

# Regras de compilação
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_TEST_DIR)/%.o: $(TEST_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Regras principais
build: $(TARGET) $(TEST_TARGET)

test: $(TEST_TARGET)
	@./$(TEST_TARGET)

run: $(TARGET)
	@./$(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_TARGET): $(TEST_OBJS) $(filter-out $(OBJ_DIR)/main.o, $(OBJS))
	$(CXX) $(CXXFLAGS) $^ -o $@

# Limpar arquivos intermediários e executáveis
clean:
	@rm -rf $(OBJ_DIR)/* $(BIN_DIR)/* $(BIN_TESTS_DIR)/* $(OBJ_TEST_DIR)/*

# Fazer clean e build
rebuild: clean build

.PHONY: build test run clean rebuild
