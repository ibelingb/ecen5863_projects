module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];
	
	reg [23:0] temp_readdata_left, temp_readdata_right;
	reg [23:0] temp_writedata_left, temp_writedata_right;
	reg [23:0] filtered_writedata_left, filtered_writedata_right;
	reg readData, writeData;
	
	wire [23:0] sample0_writedata_left;
	wire [23:0] sample1_writedata_left;
	wire [23:0] sample2_writedata_left;
	wire [23:0] sample3_writedata_left;
	wire [23:0] sample4_writedata_left;
	wire [23:0] sample5_writedata_left;
	wire [23:0] sample6_writedata_left;
	
	wire [23:0] sample0_writedata_right;
	wire [23:0] sample1_writedata_right;
	wire [23:0] sample2_writedata_right;
	wire [23:0] sample3_writedata_right;
	wire [23:0] sample4_writedata_right;
	wire [23:0] sample5_writedata_right;
	wire [23:0] sample6_writedata_right;
	
	always @(posedge CLOCK_50)
	begin
		// Read data
		if(read_ready == 1'b1)
			begin
			temp_readdata_left = readdata_left;
			temp_readdata_right = readdata_right;
			readData = 1'b1;
			end
		else
			begin
			readData = 1'b0;
			end
		
		// Write data
		if(write_ready == 1'b1)
			begin
			temp_writedata_left = temp_readdata_left;
			temp_writedata_right = temp_readdata_right;
			writeData = 1'b1;
			end
		else
			begin
			writeData = 1'b0;
			end
			
		// Filter Data 
		filtered_writedata_left = (temp_writedata_left >> 3) + 
										  (sample0_writedata_left >> 3) + 
										  (sample1_writedata_left >> 3) + 
										  (sample2_writedata_left >> 3) + 
										  (sample3_writedata_left >> 3) + 
										  (sample4_writedata_left >> 3) + 
										  (sample5_writedata_left >> 3) + 
										  (sample6_writedata_left >> 3);
		filtered_writedata_right = (temp_writedata_right >> 3) + 
											(sample0_writedata_right >> 3) + 
											(sample1_writedata_right >> 3) + 
											(sample2_writedata_right >> 3) + 
											(sample3_writedata_right >> 3) + 
											(sample4_writedata_right >> 3) + 
											(sample5_writedata_right >> 3) + 
											(sample6_writedata_right >> 3);
	end
	
	// Define DFFs for 8 left samples of data. These outputs are passed to the divide by 8 filters above.
	DFF_bus24 leftSample0(temp_writedata_left, CLOCK_50, reset, sample0_writedata_left);
	DFF_bus24 leftSsample1(sample0_writedata_left, CLOCK_50, reset, sample1_writedata_left);
	DFF_bus24 leftSsample2(sample1_writedata_left, CLOCK_50, reset, sample2_writedata_left);
	DFF_bus24 leftSsample3(sample2_writedata_left, CLOCK_50, reset, sample3_writedata_left);
	DFF_bus24 leftSsample4(sample3_writedata_left, CLOCK_50, reset, sample4_writedata_left);
	DFF_bus24 leftSsample5(sample4_writedata_left, CLOCK_50, reset, sample5_writedata_left);
	DFF_bus24 leftSsample6(sample5_writedata_left, CLOCK_50, reset, sample6_writedata_left);

	// Define DFFs for 8 right samples of data. These outputs are passed to the divide by 8 filters above.
	DFF_bus24 rightSample0(temp_writedata_right, CLOCK_50, reset, sample0_writedata_right);
	DFF_bus24 rightSample1(sample0_writedata_right, CLOCK_50, reset, sample1_writedata_right);
	DFF_bus24 rightSample2(sample1_writedata_right, CLOCK_50, reset, sample2_writedata_right);
	DFF_bus24 rightSample3(sample2_writedata_right, CLOCK_50, reset, sample3_writedata_right);
	DFF_bus24 rightSample4(sample3_writedata_right, CLOCK_50, reset, sample4_writedata_right);
	DFF_bus24 rightSample5(sample4_writedata_right, CLOCK_50, reset, sample5_writedata_right);
	DFF_bus24 rightSample6(sample5_writedata_right, CLOCK_50, reset, sample6_writedata_right);
	
	assign writedata_left = filtered_writedata_left;
	assign writedata_right = filtered_writedata_right;
	assign read = readData;
	assign write = writeData;
	
	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule


