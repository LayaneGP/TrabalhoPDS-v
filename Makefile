# Compilador e flags
CPP = g++
CPPFLAGS = -std=c++17 -Wall -I include

# Diretórios
SRC_DIR = src
OBJ_DIR = obj
OBJ_TESTS = obj_tests
BIN_DIR = bin
BIN_TESTS_DIR = bin_tests
TESTS_DIR = tests

# Arquivos fonte, objeto e cabeçalho
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC_FILES))
OBJ_FILES_NO_MAIN := $(filter-out $(OBJ_DIR)/main.o,$(OBJ_FILES))
HEADER_FILES := $(wildcard $(SRC_DIR)/*.hpp)

# Nome do executável
EXECUTABLE = $(BIN_DIR)/main

# Lista de arquivos de teste
TEST_FILES := $(wildcard $(TESTS_DIR)/*.cpp)
TEST_OBJ_FILES := $(patsubst $(TESTS_DIR)/%.cpp,$(OBJ_TESTS)/%.o,$(TEST_FILES))
TEST_EXECUTABLES := $(patsubst $(TESTS_DIR)/%.cpp,$(BIN_TESTS_DIR)/%,$(TEST_FILES))

# Alvo principal
all: $(EXECUTABLE)

# Alvo para objetos
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADER_FILES)
	$(CPP) $(CPPFLAGS) -c $< -o $@

# Alvo para objetos de teste
$(OBJ_TESTS)/%.o: $(TESTS_DIR)/%.cpp $(HEADER_FILES) | $(OBJ_TESTS)
	$(CPP) $(CPPFLAGS) -c $< -o $@

# Alvo principal
$(EXECUTABLE): $(OBJ_FILES)
	$(CPP) $(CPPFLAGS) $^ -o $@

# Alvo para cada teste
$(BIN_TESTS_DIR)/%: $(OBJ_TESTS)/%.o $(OBJ_FILES_NO_MAIN)
	$(CPP) $(CPPFLAGS) $^ -o $@

# Alvo para executar todos os testes
test: $(TEST_EXECUTABLES)

# Alvo para limpeza de arquivos gerados
clean:
	@if not exist $(OBJ_DIR) mkdir $(OBJ_DIR)
	@if not exist $(OBJ_TESTS) mkdir $(OBJ_TESTS)
	del /Q $(OBJ_DIR)\*.o
	del /Q $(OBJ_TESTS)\*.o
	del /Q $(BIN_DIR)\*
	del /Q $(BIN_TESTS_DIR)\*

# Faz com que os alvos "test" e "clean" não sejam confundidos com arquivos
.PHONY: all test clean

run: 
	./bin/main

run-post:
	./bin_tests/test_posts.exe

run-rep-usu:
	./bin_tests/test_repositorio_usuarios.exe

run-monitor:
	./bin_tests/test_user_monitor.exe

run-user:
	./bin_tests/test_user.exe