# ================================
# STM32F446RE BARE-METAL MAKEFILE
# ================================

TARGET = main
CPU = -mcpu=cortex-m4 -mthumb
CFLAGS = $(CPU) -O2 -Wall -ffreestanding -nostdlib -nostartfiles
LDFLAGS = -T linker/stm32f446.ld -Wl,--gc-sections

# Toolchain
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

# Source files
SRCS = \
    src/main.c \
    src/system_stm32f446.c \
    startup/startup_stm32f446.s

# Build target
all: $(TARGET).elf $(TARGET).bin

$(TARGET).elf: $(SRCS) linker/stm32f446.ld
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET).elf $(LDFLAGS)

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

# Flash using STM32CubeProgrammer CLI
flash:
	"C:/ST/STM32CubeIDE_1.19.0/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.win32_2.2.200.202503041107/tools/bin/STM32_Programmer_CLI.exe" -c port=SWD -d $(TARGET).bin 0x08000000

clean:
clean:
clean:
	del /f main.elf
	del /f main.bin
