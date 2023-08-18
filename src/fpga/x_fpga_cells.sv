// FPGA
// - Replace with standard RTL to we 
//   can target and FPGA
//
// - Don't expect the delay line to work,
//   just to test the UART

module sky130_fd_sc_hd__inv_1(
   input    logic A,
   output   logic Y
);        
   logic [15:0] sel; 
      
   assign Y = ~A;  

endmodule

module sky130_fd_sc_hd__dfrtp_1(
   input  logic CLK,
   input  logic D,
   input  logic RESET_B,
   output logic Q
);
   always@(posedge CLK or negedge RESET_B) begin
      if(!RESET_B)   Q <= 'd0;
      else           Q <= D;
   end 
endmodule
   

