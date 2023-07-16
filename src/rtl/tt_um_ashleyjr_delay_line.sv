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
   logic [7:0] rx_data;
   logic       rx_valid;
    
   logic [7:0] tx_data;
   logic       tx_valid;
   logic       tx_accept; 

   logic       rst;

   // Tie off unused outputs
   assign uo_out[7:1] = 7'h00;
   assign uio_out     = 8'h00;
   assign uio_oe      = 8'h00;

   // Reverse reset
   assign rst = ~rst_n;

   // UART
   x_uart_rx #(
      .p_clk_hz   (50000000   ),
      .p_baud     (115200     )
   ) u_rx(
      .i_clk      (clk        ),
      .i_rst      (rst        ),
      .i_rx       (ui_in[0]   ),
      .o_valid    (rx_valid   ),    
      .o_data     (rx_data    )
   );

   x_uart_tx #(
      .p_clk_hz   (50000000   ),
      .p_baud     (115200     )
   ) u_tx(
      .i_clk      (clk        ),
      .i_rst      (rst        ),
      .i_data     (tx_data    ),
      .o_tx       (uo_out[0]  ),
      .i_valid    (tx_valid   ),
      .o_accept   (tx_accept  )
   ); 

   // Driver
   x_driver u_driver(
      .i_clk      (clk        ),
      .i_rst      (rst        ),
      // Rx
      .i_valid    (rx_valid   ),
      .i_data     (rx_data    ),
      // Tx
      .o_valid    (tx_valid   ),
      .i_accept   (tx_accept  ),
      .o_data     (tx_data    )
   );

endmodule
