module uart_tx_bfm(clk, data);
   input  logic clk;
   output logic data;

   initial data = 1;

   task write;
      input logic [7:0] wr_data;

      begin
	 $timeformat(-9, 2, " ns", 20);
	 $display("%t: UART TX - Transmitting - '%x'", $time, wr_data);

	 // Start byte
	 @(posedge clk);
	 data <= 1'b0;
	 $display("%t: UART TX - Transmitting start bit", $time);

	 for(int bit_i=7; bit_i>=0; bit_i--) begin
	    // Write bit
	    @(posedge clk);
	    $display("%t: UART TX - Transmitting bit - '%b'", $time, wr_data[bit_i]);
	    data <= wr_data[bit_i];
	 end

	 // End byte
	 @(posedge clk);
	 $display("%t: UART TX - Transmitting stop bit", $time);
	 data <= 1'b1;
	 @(posedge clk);
      end
   endtask // write
endmodule // uart_tx_bfm
