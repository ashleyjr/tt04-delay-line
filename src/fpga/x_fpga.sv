module x_fpga(
   input    wire  i_clk,
   input    wire  i_rst_n,
   input    wire  i_rx,
   output   wire  o_tx
);
   wire       pll_clk;
   wire [7:0] ui_in; 
   wire [7:0] uo_out;
   wire [7:0] uio_in;
   wire [7:0] uio_ou;
   wire [7:0] uio_oe;
   wire       ena; 

   assign ui_in[0] = i_rx;
   assign o_tx     = uo_out[0];
  
   // PLL
   // - 12MHz In
   // - 48MHz Out
   SB_PLL40_CORE #(
      .FEEDBACK_PATH ("SIMPLE"   ),
      .PLLOUT_SELECT ("GENCLK"   ),
      .DIVR          (4'd0       ),
      .DIVF          (7'd62      ),
      .DIVQ          (3'd4       ),
      .FILTER_RANGE  (3'b001     )  
      // Always 1 https://www.reddit.com/r/yosys/comments/3yrq6d/are_plls_supported_on_the_icestick_hw/
   ) u_sb_pll40_core (
      .LOCK          (           ),
      .RESETB        (i_rst_n    ),
      .BYPASS        (1'b0       ),
      .REFERENCECLK  (i_clk      ),
      .PLLOUTCORE    (pll_clk    )
   );

   tt_um_ashleyjr_delay_line u_dut(
      .ui_in    (ui_in     ),  
      .uo_out   (uo_out    ), 
      .uio_in   (uio_in    ), 
      .uio_out  (uio_ou    ),
      .uio_oe   (uio_oe    ), 
      .ena      (ena       ),    
      .clk      (pll_clk   ),    
      .rst_n    (i_rst_n   ) 
   );

endmodule
