module uart_rx_bfm(data);
   input logic   data;
   parameter int baud;
   time 	 baud_period = 1s / baud;

   task read;
      output logic [7:0] rd_data;

      begin
	 $timeformat(-9, 2, " ns", 20);
	 $display("%t: UART RX - Waiting for transmission...", $time);

	 // Start byte
	 @(negedge data);
	 $display("%t: UART RX - Receiving start bit", $time);
	 #(baud_period/2) // Center sample point
	 assert (data == 1'b0);

	 for(int bit_i=7; bit_i>=0; bit_i--) begin
	    // Read bit
	    #(baud_period)
	    $display("%t: UART RX - Receiving bit - '%b'", $time, data);
	    rd_data <= {rd_data[6:0], data};
	 end

	 // End byte
	 #(baud_period)
	 $display("%t: UART RX - Receiving stop bit", $time);
	 assert (data == 1'b1);
	 $display("%t: UART RX - Received byte - '%x'", $time, rd_data);
      end
   endtask // write
endmodule // uart_tx_bfm
