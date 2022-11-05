module uart_tx_tb;

   logic clk  = 0;
   logic data;
   
   initial begin
      forever begin
	 #10 clk = ~clk;
      end
   end

   initial begin
      repeat(10) @(posedge clk);
      dut.write(8'haa);
      repeat(10) @(posedge clk);
      dut.write(8'h33);
      repeat(10) @(posedge clk);
      dut.write(8'h3c);
      dut.write(8'h3c);
   end

   // DUT
   uart_tx_bfm dut(clk, data);
endmodule // uart_tx_tb
