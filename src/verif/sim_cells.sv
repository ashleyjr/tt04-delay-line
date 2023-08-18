// Simulation
// - Replace the cell with RTL sim models
// - When building will instance sky130 cell
//
// - Allow it to be tunred off to speed up sim

module sky130_fd_sc_hd__inv_1(
   input    logic A,
   output   logic Y
);        
   logic [15:0] sel; 
      
   assign #(sel) Y = (sel != 0) & ~A;  

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
   

