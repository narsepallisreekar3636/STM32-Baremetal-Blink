#include <stdint.h>

#define RCC_AHB1ENR   (*(volatile uint32_t*)0x40023830)
#define GPIOA_MODER   (*(volatile uint32_t*)0x40020000)
#define GPIOA_ODR     (*(volatile uint32_t*)0x40020014)

static void delay(volatile uint32_t x)
{
    while (x--) { }
}

int main(void)
{
    // 1. Enable clock for GPIOA
    RCC_AHB1ENR |= (1 << 0);

    // 2. Set PA5 as Output (MODER5 = 01)
    GPIOA_MODER &= ~(3 << (5 * 2));  // Clear bits
    GPIOA_MODER |=  (1 << (5 * 2));  // Set as output

    while (1)
    {
        GPIOA_ODR ^= (1 << 5);  // Toggle PA5 (LD2 LED)
        delay(300000);
    }
}
