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

   logic          edge_capture;
   logic          p0_edge;
   logic          p1_edge;
   logic          p2_edge;
   logic [31:0]   data_shl;
   logic [31:0]   edge_oh;
   logic [4:0]    edge_bin;

   logic          load_en;
   logic          unload_en;
   logic          dl_en;
   logic          edge_en;

   // Data
   assign data_in = {data_q[27:0],i_data[7:4]};

   assign data_out = {data_q[23:0], 8'h00};

   assign data_d = (load_en               ) ? data_in: 
                   (capture | edge_capture) ? i_dl:
                   (p2_edge               ) ? {3'b000, edge_bin, 24'h000000}:
                                              data_out; 
  
   assign data_en = load_en | i_accept | p2_edge |
                    (i_dl_valid & (capture | edge_capture));

   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)         data_q <= 'd0;
      else if(data_en)     data_q <= data_d;
   end   
   
   // Hold valid
   assign valid_d = unload_en | p2_edge;

   assign valid_en = unload_en | p2_edge | i_accept;
   
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

   // Delay for the edge detect
   assign p0_edge = edge_en;

   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)   p1_edge <= 'd0;
      else           p1_edge <= p0_edge;
   end  
   
   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)   p2_edge <= 'd0;
      else           p2_edge <= p1_edge;
   end  

   assign edge_capture = p0_edge | p1_edge;

   // Edge detect
   assign data_shl = data_q << 1;
   assign edge_oh  = data_shl & ~data_q; 
   assign edge_bin =  
      (edge_oh[30]) ? 5'h1F:
      (edge_oh[29]) ? 5'h1E:
      (edge_oh[28]) ? 5'h1D:
      (edge_oh[27]) ? 5'h1C:
      (edge_oh[26]) ? 5'h1B:
      (edge_oh[25]) ? 5'h1A:
      (edge_oh[24]) ? 5'h19:
      (edge_oh[23]) ? 5'h18:
      (edge_oh[22]) ? 5'h17:
      (edge_oh[21]) ? 5'h16:
      (edge_oh[20]) ? 5'h15:
      (edge_oh[19]) ? 5'h14:
      (edge_oh[18]) ? 5'h13:
      (edge_oh[17]) ? 5'h12:
      (edge_oh[16]) ? 5'h11:
      (edge_oh[15]) ? 5'h10:
      (edge_oh[14]) ? 5'h0F:
      (edge_oh[13]) ? 5'h0E:
      (edge_oh[12]) ? 5'h0D:
      (edge_oh[11]) ? 5'h0C:
      (edge_oh[10]) ? 5'h0B:
      (edge_oh[9] ) ? 5'h0A:
      (edge_oh[8] ) ? 5'h09:
      (edge_oh[7] ) ? 5'h08:
      (edge_oh[6] ) ? 5'h07:
      (edge_oh[5] ) ? 5'h06:
      (edge_oh[4] ) ? 5'h05:
      (edge_oh[3] ) ? 5'h04:
      (edge_oh[2] ) ? 5'h03:
      (edge_oh[1] ) ? 5'h02:
      (edge_oh[0] ) ? 5'h01:
                      5'h00; 
   // Decode 
   assign load_en   = (i_data[3:0] == 4'h0) & i_valid; // Shift in data
   assign unload_en = (i_data[3:0] == 4'h1) & i_valid; // Shift out data
   assign dl_en     = (i_data[3:0] == 4'h2) & i_valid; // Take a full 32-bit sample
   assign edge_en   = (i_data[3:0] == 4'h3) & i_valid; // Take an edge detect 5-bit sample and send
   
   // Drive Valid
   assign o_valid = valid_q;  

   // Drive write data
   assign o_data = data_q[31:24];

endmodule
