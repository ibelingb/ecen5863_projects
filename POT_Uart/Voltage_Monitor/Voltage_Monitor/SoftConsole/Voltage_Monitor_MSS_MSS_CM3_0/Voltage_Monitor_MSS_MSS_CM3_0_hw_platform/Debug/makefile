################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include hal/CortexM3/subdir.mk
-include hal/CortexM3/GNU/subdir.mk
-include drivers_config/mss_ace/subdir.mk
-include drivers/mss_uart/subdir.mk
-include drivers/mss_gpio/subdir.mk
-include drivers/mss_ace/subdir.mk
-include CMSIS/subdir.mk
-include CMSIS/startup_gcc/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: libVoltage_Monitor_MSS_MSS_CM3_0_hw_platform.a

# Tool invocations
libVoltage_Monitor_MSS_MSS_CM3_0_hw_platform.a: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU Archiver'
	arm-none-eabi-ar -r "libVoltage_Monitor_MSS_MSS_CM3_0_hw_platform.a" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean::
	-$(RM) $(OBJS)$(C_DEPS)$(ARCHIVES) libVoltage_Monitor_MSS_MSS_CM3_0_hw_platform.a
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
