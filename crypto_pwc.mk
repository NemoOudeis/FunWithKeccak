## Release
ProjectName            :=fun_with_keccak
ConfigurationName      :=Release
IntermediateDirectory  :=./Release
OutDir                 := $(IntermediateDirectory)
LinkerName             :=g++
SharedObjectLinkerName :=g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.o.i
DebugSwitch            :=-gstab
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E 
ObjectsFileList        :="crypto_pwc.txt"
LinkOptions            :=  
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). 
IncludePCH             := 
RcIncludePath          := 
Libs                   := 
ArLibs                 :=  
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := ar rcus
CXX      := g++
CC       := gcc
CXXFLAGS :=  -O2 -Wall -std=c++11 $(Preprocessors)
CFLAGS   :=  -O2 -Wall $(Preprocessors)


##
## User defined environment variables
##
Objects0=$(IntermediateDirectory)/main$(ObjectSuffix) $(IntermediateDirectory)/KeccakDuplex$(ObjectSuffix) $(IntermediateDirectory)/KeccakF-1600-reference$(ObjectSuffix) $(IntermediateDirectory)/KeccakSponge$(ObjectSuffix) $(IntermediateDirectory)/KeccakHash$(ObjectSuffix) $(IntermediateDirectory)/displayIntermediateValues$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(LinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)

$(IntermediateDirectory)/.d:
	@$(MakeDirCommand) "./Release"

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/main$(ObjectSuffix): main.cpp $(IntermediateDirectory)/main$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "main.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/main$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/main$(DependSuffix): main.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/main$(ObjectSuffix) -MF$(IntermediateDirectory)/main$(DependSuffix) -MM "main.cpp"

$(IntermediateDirectory)/main$(PreprocessSuffix): main.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/main$(PreprocessSuffix) "main.cpp"

$(IntermediateDirectory)/KeccakDuplex$(ObjectSuffix): KeccakDuplex.c $(IntermediateDirectory)/KeccakDuplex$(DependSuffix)
	$(CC) $(SourceSwitch) "KeccakDuplex.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/KeccakDuplex$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/KeccakDuplex$(DependSuffix): KeccakDuplex.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/KeccakDuplex$(ObjectSuffix) -MF$(IntermediateDirectory)/KeccakDuplex$(DependSuffix) -MM "KeccakDuplex.c"

$(IntermediateDirectory)/KeccakDuplex$(PreprocessSuffix): KeccakDuplex.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/KeccakDuplex$(PreprocessSuffix) "KeccakDuplex.c"

$(IntermediateDirectory)/KeccakF-1600-reference$(ObjectSuffix): KeccakF-1600-reference.c $(IntermediateDirectory)/KeccakF-1600-reference$(DependSuffix)
	$(CC) $(SourceSwitch) "KeccakF-1600-reference.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/KeccakF-1600-reference$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/KeccakF-1600-reference$(DependSuffix): KeccakF-1600-reference.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/KeccakF-1600-reference$(ObjectSuffix) -MF$(IntermediateDirectory)/KeccakF-1600-reference$(DependSuffix) -MM "KeccakF-1600-reference.c"

$(IntermediateDirectory)/KeccakF-1600-reference$(PreprocessSuffix): KeccakF-1600-reference.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/KeccakF-1600-reference$(PreprocessSuffix) "KeccakF-1600-reference.c"

$(IntermediateDirectory)/KeccakSponge$(ObjectSuffix): KeccakSponge.c $(IntermediateDirectory)/KeccakSponge$(DependSuffix)
	$(CC) $(SourceSwitch) "KeccakSponge.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/KeccakSponge$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/KeccakSponge$(DependSuffix): KeccakSponge.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/KeccakSponge$(ObjectSuffix) -MF$(IntermediateDirectory)/KeccakSponge$(DependSuffix) -MM "KeccakSponge.c"

$(IntermediateDirectory)/KeccakSponge$(PreprocessSuffix): KeccakSponge.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/KeccakSponge$(PreprocessSuffix) "KeccakSponge.c"

$(IntermediateDirectory)/KeccakHash$(ObjectSuffix): KeccakHash.c $(IntermediateDirectory)/KeccakHash$(DependSuffix)
	$(CC) $(SourceSwitch) "KeccakHash.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/KeccakHash$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/KeccakHash$(DependSuffix): KeccakHash.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/KeccakHash$(ObjectSuffix) -MF$(IntermediateDirectory)/KeccakHash$(DependSuffix) -MM "KeccakHash.c"

$(IntermediateDirectory)/KeccakHash$(PreprocessSuffix): KeccakHash.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/KeccakHash$(PreprocessSuffix) "KeccakHash.c"

$(IntermediateDirectory)/displayIntermediateValues$(ObjectSuffix): displayIntermediateValues.c $(IntermediateDirectory)/displayIntermediateValues$(DependSuffix)
	$(CC) $(SourceSwitch) "displayIntermediateValues.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/displayIntermediateValues$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/displayIntermediateValues$(DependSuffix): displayIntermediateValues.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/displayIntermediateValues$(ObjectSuffix) -MF$(IntermediateDirectory)/displayIntermediateValues$(DependSuffix) -MM "displayIntermediateValues.c"

$(IntermediateDirectory)/displayIntermediateValues$(PreprocessSuffix): displayIntermediateValues.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/displayIntermediateValues$(PreprocessSuffix) "displayIntermediateValues.c"


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) $(IntermediateDirectory)/main$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/main$(DependSuffix)
	$(RM) $(IntermediateDirectory)/main$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/KeccakDuplex$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/KeccakDuplex$(DependSuffix)
	$(RM) $(IntermediateDirectory)/KeccakDuplex$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/KeccakF-1600-reference$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/KeccakF-1600-reference$(DependSuffix)
	$(RM) $(IntermediateDirectory)/KeccakF-1600-reference$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/KeccakSponge$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/KeccakSponge$(DependSuffix)
	$(RM) $(IntermediateDirectory)/KeccakSponge$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/KeccakHash$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/KeccakHash$(DependSuffix)
	$(RM) $(IntermediateDirectory)/KeccakHash$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/displayIntermediateValues$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/displayIntermediateValues$(DependSuffix)
	$(RM) $(IntermediateDirectory)/displayIntermediateValues$(PreprocessSuffix)
	$(RM) $(OutputFile)
	$(RM) $(OutputFile).exe
	$(RM) ".build-release/crypto_pwc"



