################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hal/CortexM3/cortex_nvic.c 

OBJS += \
./hal/CortexM3/cortex_nvic.o 

C_DEPS += \
./hal/CortexM3/cortex_nvic.d 


# Each subdirectory must supply rules for building sources it contributes
hal/CortexM3/%.o: ../hal/CortexM3/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers\mss_ace -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers\mss_uart -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers_config -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\drivers_config\mss_ace -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\hal -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\SoftConsole\Voltage_Monitor_MSS_MSS_CM3_0\Voltage_Monitor_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


