`default_nettype none
`timescale 1fs/1fs
//`define WAVES
module tb ();

   `ifdef WAVES
   initial begin
      $dumpfile ("tb.vcd");
      $dumpvars (0, tb);
      #1;
   end
   `endif
   
   wire [7:0] uo_out;
   wire [7:0] ui_in;
   wire [7:0] uio_out;
   wire [7:0] uio_in;
   wire [7:0] uio_oe;
   wire clk;
   wire rst_n;
   wire ena;
   
   tt_um_ashleyjr_delay_line u_dut (
      .ui_in      (ui_in),    // Dedicated inputs
      .uo_out     (uo_out),   // Dedicated outputs
      .uio_in     (uio_in),   // IOs: Input path
      .uio_out    (uio_out),  // IOs: Output path
      .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena        (ena),      // enable - goes high when design is selected
      .clk        (clk),      // clock
      .rst_n      (rst_n)     // not reset
   );

endmodule

