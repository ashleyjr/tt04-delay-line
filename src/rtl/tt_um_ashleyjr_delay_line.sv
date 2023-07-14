module tt_um_ashleyjr_delay_line(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   logic [7:0] data;
   logic       valid;
   logic       rst;

   assign rst = rst_n;

   x_uart_rx #(
      .p_clk_hz   (50000000   ),
      .p_baud     (115200     )
   ) u_rx(
      .i_clk      (clk        ),
      .i_rst      (rst        ),
      .i_rx       (ui_in[0]   ),
      .o_valid    (valid      ),    
      .o_data     (data       )
   );

   x_uart_tx #(
      .p_clk_hz   (50000000   ),
      .p_baud     (115200     )
   ) u_rx(
      .i_clk      (clk        ),
      .i_rst      (rst        ),
      .i_data     (data       ),
      .o_tx       (uo_out[0]  ),
      .i_valid    (valid      ),
      .o_accept   ()
   ); 

endmodule
