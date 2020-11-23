/* part3.c
 * Author: Brian Ibeling
 *
 * This program uses the A9 Private Timer to increment a timer at 0.2 sec
 * to display 'de1-SoC' on the 7-segment display on the DE1-SoC board.
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
			segmentValue = 0x39; // C
			break;
		case 1:
			segmentValue = 0x5C; // o
			break;
		case 2:
			segmentValue = 0x6D; // S
			break;
		case 3:
			segmentValue = 0x40; // -
			break;
		case 4:
			segmentValue = 0x06; // 1
			break;
		case 5:
			segmentValue = 0x4F; // E
			break;
		case 6:
			segmentValue = 0x5E; // d
			break;
		default:
			segmentValue = 0x00; // Empty
			break;
	}

	return (segmentValue);
}

uint8_t decrementDisplay(uint8_t segment) {
	if(segment == 0) {
		segment = 12;
	} else {
		segment -= 1;
	}

	return segment;
}

int main(void)
{
	/* Declare volatile pointers to I/O registers (volatile means that the locations
	 * will not be cached, even in registers) */
	volatile int * MPcore_private_timer_ptr	= (int *) MPCORE_PRIV_TIMER;
	volatile int * HEX3_HEX0_ptr			= (int *) HEX3_HEX0_BASE;
	volatile int * HEX5_HEX4_ptr			= (int *) HEX5_HEX4_BASE;
	volatile int * KEY_ptr = (int *) KEY_BASE;
	
	int counter = 40000000;						// timeout = 1/(200 MHz) x 200x10^8 = .2 sec
	int HEX30_bits = 0x0000000F;				// initial pattern for HEX displays
	int HEX54_bits = 0x0000000F;				// initial pattern for HEX displays

	uint8_t S0 = 5;
	uint8_t S1 = 4;
	uint8_t S2 = 3;
	uint8_t S3 = 2;
	uint8_t S4 = 1;
	uint8_t S5 = 0;

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

		// Increment S[0-5] variables when timer expires
		S0 = decrementDisplay(S0);
		S1 = decrementDisplay(S1);
		S2 = decrementDisplay(S2);
		S3 = decrementDisplay(S3);
		S4 = decrementDisplay(S4);
		S5 = decrementDisplay(S5);

		// Set each 7-segment based on the value of each counter
		SEGMENT0 = convertToSegmentDisplay(S5);
		SEGMENT1 = convertToSegmentDisplay(S4);
		SEGMENT2 = convertToSegmentDisplay(S3);
		SEGMENT3 = convertToSegmentDisplay(S2);
		SEGMENT4 = convertToSegmentDisplay(S1);
		SEGMENT5 = convertToSegmentDisplay(S0);
		HEX30_bits = (SEGMENT0 | (SEGMENT1 << 8) | (SEGMENT2 << 16) | (SEGMENT3 << 24));
		HEX54_bits = (SEGMENT4 | (SEGMENT5 << 8));

		*(HEX3_HEX0_ptr) = HEX30_bits; // display pattern on HEX3 ... HEX0
		*(HEX5_HEX4_ptr) = HEX54_bits; // display pattern on HEX5 ... HEX4
	}
}
