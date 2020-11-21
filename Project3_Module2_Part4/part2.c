/* part2.c
 *
 * This program uses the A9 Private Timer to increment a timer at 0.01 sec
 * This time is then displayed to the 7-segment display on the DE1-SoC board.
 * 
 *
 * This application utilized example code found from the DE1-SoC projects provided with
 * the Intel FPGA Monitor Program. This including how to setup the A9 Timer, 7-segment
 * display, and push-button interrupts.
 */

#include "address_map_arm.h"
#include "stdint.h"

// Convert uint8_t values to 7-segment display
uint8_t convertToSegmentDisplay(uint8_t input) {
	uint8_t segmentValue;
	switch (input) {
		case 0:
			segmentValue = 0x3F;
			break;
		case 1:
			segmentValue = 0x06;
			break;
		case 2:
			segmentValue = 0x5B;
			break;
		case 3:
			segmentValue = 0x4F;
			break;
		case 4:
			segmentValue = 0x66;
			break;
		case 5:
			segmentValue = 0x6D;
			break;
		case 6:
			segmentValue = 0x7C;
			break;
		case 7:
			segmentValue = 0x07;
			break;
		case 8:
			segmentValue = 0xFF;
			break;
		case 9:
			segmentValue = 0x67;
			break;
	}

	return (segmentValue);
}

int main(void)
{
	/* Declare volatile pointers to I/O registers (volatile means that the locations
	 * will not be cached, even in registers) */
	volatile int * MPcore_private_timer_ptr	= (int *) MPCORE_PRIV_TIMER;
	volatile int * HEX3_HEX0_ptr			= (int *) HEX3_HEX0_BASE;
	volatile int * HEX5_HEX4_ptr			= (int *) HEX5_HEX4_BASE;
	volatile int * KEY_ptr = (int *) KEY_BASE;
	
	int counter = 2000000;						// timeout = 1/(200 MHz) x 200x10^8 = .01 sec
	int HEX30_bits = 0x0000000F;				// initial pattern for HEX displays
	int HEX54_bits = 0x0000000F;				// initial pattern for HEX displays

	uint8_t DD0 = 0;
	uint8_t DD1 = 0;
	uint8_t SS0 = 5;
	uint8_t SS1 = 4;
	uint8_t MM0 = 9;
	uint8_t MM1 = 5;

	uint8_t SEGMENT0 = 0;
	uint8_t SEGMENT1 = 0;
	uint8_t SEGMENT2 = 0;
	uint8_t SEGMENT3 = 0;
	uint8_t SEGMENT4 = 0;
	uint8_t SEGMENT5 = 0;

	*(MPcore_private_timer_ptr) = counter;		// write to timer load register
	*(MPcore_private_timer_ptr + 2) = 0b011;	// mode = 1 (auto), enable = 1

	while(1)
	{
		while (*(MPcore_private_timer_ptr + 3) == 0)
			;								 // wait for timer to expire
		*(MPcore_private_timer_ptr + 3) = 1; // reset timer flag bit

		// Check if button pressed to run/stop app
		if (*KEY_ptr != 0)
		{
			while(*KEY_ptr != 0);
		}

		// Increment DD0 variable when timer expires
		// Increment all other individual segments based on rollover events from the preceding counter
		DD0 += 1;
		if (DD0 == 10)
		{
			DD0 = 0;
			DD1 += 1;
		}
		if (DD1 == 10)
		{
			DD1 = 0;
			SS0 += 1;
		}
		if (SS0 == 10)
		{
			SS0 = 0;
			SS1 += 1;
		}
		if (SS1 == 6)
		{
			SS1 = 0;
			MM0 += 1;
		}
		if (MM0 == 10)
		{
			MM0 = 0;
			MM1 += 1;
		}
		if (MM1 == 6)
		{
			// Reset MM values to 0, wrapping MM segments
			MM0 = 0;
			MM1 = 0;
		}

		// Set each 7-segment based on the value of each counter
		SEGMENT0 = convertToSegmentDisplay(DD0);
		SEGMENT1 = convertToSegmentDisplay(DD1);
		SEGMENT2 = convertToSegmentDisplay(SS0);
		SEGMENT3 = convertToSegmentDisplay(SS1);
		SEGMENT4 = convertToSegmentDisplay(MM0);
		SEGMENT5 = convertToSegmentDisplay(MM1);
		HEX30_bits = (SEGMENT0 | (SEGMENT1 << 8) | (SEGMENT2 << 16) | (SEGMENT3 << 24));
		HEX54_bits = (SEGMENT4 | (SEGMENT5 << 8));

		*(HEX3_HEX0_ptr) = HEX30_bits; // display pattern on HEX3 ... HEX0
		*(HEX5_HEX4_ptr) = HEX54_bits; // display pattern on HEX5 ... HEX4
	}
}
