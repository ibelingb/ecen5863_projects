#include <stdio.h>

#define NUM_VALUES (7)

// List of numbers
int numList[NUM_VALUES] = {4, 6, 3, 2, 4, 23, 10};

int main(void)
{
    int largestNum = 0;
    int i = 0;

    printf("List of Numbers: [%d, %d, %d, %d, %d, %d, %d]\n", 
            numList[0], numList[1], numList[2], numList[3], numList[4], numList[5], numList[6]);

    // Set initial value, iterate through list and find the largest number    
    largestNum = numList[0];
    for(i=1; i<NUM_VALUES; i++) {
        if (largestNum < numList[i]) {
            largestNum = numList[i];
        }
    }

    // Print largest number
    printf("Printing Largest Number from list:\n");
    printf("%d\n", largestNum);
    
    return 0;
}