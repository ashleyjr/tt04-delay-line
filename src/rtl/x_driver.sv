module x_driver(
   input    logic          i_clk,
   input    logic          i_rst_n, 
   // RX
   input    logic          i_valid,
   input    logic [7:0]    i_data,
   // Tx
   output   logic          o_valid,
   input    logic          i_accept,
   output   logic [7:0]    o_data,
   // Delay line
   input    logic          i_dl_valid,
   input    logic [31:0]   i_dl
);
   logic [31:0]   data_d;
   logic [31:0]   data_q;  
   logic [31:0]   data_in;
   logic [31:0]   data_out;
   logic          data_en;

   logic          valid_en;
   logic          valid_d;
   logic          valid_q;

   logic          capture;
   logic          p0_capture;
   logic          p1_capture;
   
   logic          load_en;
   logic          unload_en;
   logic          dl_en;

   // Data
   assign data_in = {data_q[27:0],i_data[7:4]};

   assign data_out = {data_q[23:0], 8'h00};

   assign data_d = (load_en ) ? data_in : 
                   (capture ) ? i_dl :
                                data_out; 
  
   assign data_en = load_en | i_accept |
                    (i_dl_valid & capture);

   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)         data_q <= 'd0;
      else if(data_en)     data_q <= data_d;
   end   
   
   // Hold valid
   assign valid_d = unload_en;

   assign valid_en = unload_en | i_accept;
   
   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)         valid_q <= 'd0;
      else if(valid_en)    valid_q <= valid_d;
   end   
  
   // Delay for the capture
   assign p0_capture = dl_en;

   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)   p1_capture <= 'd0;
      else           p1_capture <= p0_capture;
   end  

   assign capture = p0_capture | p1_capture;

   // Decode 
   assign load_en   = (i_data[3:0] == 4'h0) & i_valid;
   assign unload_en = (i_data[3:0] == 4'h1) & i_valid;
   assign dl_en     = (i_data[3:0] == 4'h2) & i_valid;
   
   // Drive Valid
   assign o_valid = valid_q;  

   // Drive write data
   assign o_data = data_q[31:24];

endmodule
