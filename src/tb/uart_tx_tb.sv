module uart_tx_tb;

   parameter int  baud_c = 9600;
   time		  period = 1s/baud_c;

   logic clk  = 0;
   logic data;

   logic [7:0] rd_data;


   initial begin
      forever begin
	 #(period/2) clk = ~clk;
      end
   end

   initial begin
      repeat(10) @(posedge clk);
      dut_tx.write(8'haa);
      repeat(10) @(posedge clk);
      dut_tx.write(8'h33);
      repeat(10) @(posedge clk);
      dut_tx.write(8'h3c);
      dut_tx.write(8'h3c);
   end

   initial begin
      dut_rx.read(rd_data);
      assert(rd_data == 8'haa);

      dut_rx.read(rd_data);
      assert(rd_data == 8'h33);

      dut_rx.read(rd_data);
      assert(rd_data == 8'h3c);

      dut_rx.read(rd_data);
      assert(rd_data == 8'h3c);

      $display("============================");
      $display("======= TEST PASSED! =======");
      $display("============================");
      $finish;
   end


   initial begin
      #(100*period)

      $display("============================");
      $display("======= TEST FAILED! =======");
      $display("============================");
      $finish;
   end

   // DUT
   uart_tx_bfm dut_tx(clk, data);
   uart_rx_bfm #(.baud(baud_c)) dut_rx(data);
endmodule // uart_tx_tb
