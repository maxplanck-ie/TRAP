################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../convert-pscm.cpp \
../matrix_properties.cpp \
../psem.cpp \
../pspm.cpp \
../pssm.cpp \
../read_matrix.cpp \
../write_matrix.cpp 

OBJS += \
./convert-pscm.o \
./matrix_properties.o \
./psem.o \
./pspm.o \
./pssm.o \
./read_matrix.o \
./write_matrix.o 

CPP_DEPS += \
./convert-pscm.d \
./matrix_properties.d \
./psem.d \
./pspm.d \
./pssm.d \
./read_matrix.d \
./write_matrix.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


