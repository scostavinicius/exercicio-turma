# Nome do projeto
PROJ_NAME = programa

# Compilador
CXX = g++

# Diretório dos arquivos 
H_DIR = include
CPP_DIR = src
OBJS_DIR = objects

# Arquivos .cpp dentro e fora de /src
CPP_SOURCE = $(wildcard $(CPP_DIR)/*.cpp) $(wildcard *.cpp)

# Arquivos .h dentro de /include
H_SOURCE = $(wildcard $(H_DIR)/*.h)

# Arquivos .o dentro de /objects
# Essa linha irá pegar o padrão .cpp dentro da lista de arquivos CPP_SOURCE e irá
# substituí-los por $(OBJS_DIR)/%.o, ou seja, arquivos .o no diretório de objetos
OBJS = $(patsubst %.cpp, $(OBJS_DIR)/%.o, $(notdir $(CPP_SOURCE))) #notdir para não tentar criar algo em /src

# Flags
CXX_FLAGS = -g -Wall -pedantic

#
# Compilação e ligação
#

# Executa o target all ao digitar "make all"
all: $(PROJ_NAME) # Tem como pré-requisito o projeto "programa"

# Para construir o "programa"
$(PROJ_NAME): $(OBJS) # Tem como pré-requisito os arquivos objeto
	$(CXX) $(OBJS) -o $(PROJ_NAME)

# Constrói cada arquivo objeto, compilando cada arquivo .cpp em .o
$(OBJS_DIR)/%.o: $(CPP_DIR)/%.cpp $(H_DIR)/%.h
#O compilador irá adicionar as Flags e compilar cada arquivo .cpp de acordo com o target objeto
	$(CXX) $(CXX_FLAGS) -c $< -o $@ 

# Constrói o arquivo objeto para a main
$(OBJS_DIR)/main.o: main.cpp $(H_SOURCE)
	$(CXX) $(CXX_FLAGS) -c $< -o $@

clean:
	del /Q $(OBJS_DIR)\*.o
	@if exist $(PROJ_NAME).exe del $(PROJ_NAME).exe