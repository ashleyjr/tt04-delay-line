module x_delay_line(
   input    logic          i_clk,
   input    logic          i_rst_n,  
   output   logic [31:0]   o_data,
   output   logic          o_valid 
); 
   (* keep = "true" *) logic           start_q;
   (* keep = "true" *) logic           start_d;
   (* keep = "true" *) logic           valid_q;
   (* keep = "true" *) logic           valid_d;
   (* keep = "true" *) logic           bulk_0; 
   (* keep = "true" *) logic           bulk_1;
   (* keep = "true" *) logic           bulk_2; 
   (* keep = "true" *) logic           bulk_3; 
   (* keep = "true" *) logic           bulk_4; 
   (* keep = "true" *) logic           bulk_5; 
   (* keep = "true" *) logic           bulk_6; 
   (* keep = "true" *) logic           bulk_7; 
   (* keep = "true" *) logic           bulk_8; 
   (* keep = "true" *) logic           bulk_9;
   (* keep = "true" *) logic           bulk_10; 
   (* keep = "true" *) logic           bulk_11;
   (* keep = "true" *) logic           bulk_12;
   (* keep = "true" *) logic           bulk_13;
   (* keep = "true" *) logic           bulk_14;
   (* keep = "true" *) logic           bulk_15;
   (* keep = "true" *) logic           dl_0; 
   (* keep = "true" *) logic           dl_1;
   (* keep = "true" *) logic           dl_2; 
   (* keep = "true" *) logic           dl_3; 
   (* keep = "true" *) logic           dl_4; 
   (* keep = "true" *) logic           dl_5; 
   (* keep = "true" *) logic           dl_6; 
   (* keep = "true" *) logic           dl_7; 
   (* keep = "true" *) logic           dl_8; 
   (* keep = "true" *) logic           dl_9;
   (* keep = "true" *) logic           dl_10; 
   (* keep = "true" *) logic           dl_11;
   (* keep = "true" *) logic           dl_12;
   (* keep = "true" *) logic           dl_13;
   (* keep = "true" *) logic           dl_14;
   (* keep = "true" *) logic           dl_15;
   (* keep = "true" *) logic           dl_16;
   (* keep = "true" *) logic           dl_17;
   (* keep = "true" *) logic           dl_18;
   (* keep = "true" *) logic           dl_19;
   (* keep = "true" *) logic           dl_20;
   (* keep = "true" *) logic           dl_21;
   (* keep = "true" *) logic           dl_22;
   (* keep = "true" *) logic           dl_23;
   (* keep = "true" *) logic           dl_24;
   (* keep = "true" *) logic           dl_25;
   (* keep = "true" *) logic           dl_26;
   (* keep = "true" *) logic           dl_27;
   (* keep = "true" *) logic           dl_28;
   (* keep = "true" *) logic           dl_29;
   (* keep = "true" *) logic           dl_30;
   (* keep = "true" *) logic           dl_31;
   (* keep = "true" *) logic           dl_32;
   (* keep = "true" *) logic           data_0; 
   (* keep = "true" *) logic           data_1;
   (* keep = "true" *) logic           data_2; 
   (* keep = "true" *) logic           data_3; 
   (* keep = "true" *) logic           data_4; 
   (* keep = "true" *) logic           data_5; 
   (* keep = "true" *) logic           data_6; 
   (* keep = "true" *) logic           data_7; 
   (* keep = "true" *) logic           data_8; 
   (* keep = "true" *) logic           data_9;
   (* keep = "true" *) logic           data_10; 
   (* keep = "true" *) logic           data_11;
   (* keep = "true" *) logic           data_12;
   (* keep = "true" *) logic           data_13;
   (* keep = "true" *) logic           data_14;
   (* keep = "true" *) logic           data_15;
   (* keep = "true" *) logic           data_16;
   (* keep = "true" *) logic           data_17;
   (* keep = "true" *) logic           data_18;
   (* keep = "true" *) logic           data_19;
   (* keep = "true" *) logic           data_20;
   (* keep = "true" *) logic           data_21;
   (* keep = "true" *) logic           data_22;
   (* keep = "true" *) logic           data_23;
   (* keep = "true" *) logic           data_24;
   (* keep = "true" *) logic           data_25;
   (* keep = "true" *) logic           data_26;
   (* keep = "true" *) logic           data_27;
   (* keep = "true" *) logic           data_28;
   (* keep = "true" *) logic           data_29;
   (* keep = "true" *) logic           data_30;
   (* keep = "true" *) logic           data_31; 
   
   // Drive delay line
   //
   // - Always toggle the flop driving the delay line
   // - Ideally the clock would drive the delay line but timing issues
   // - Output valid signal
    
   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)   start_q <= 'd0;
      else           start_q <= start_d;
   end 
  
   assign valid_d = start_q;

   always@(posedge i_clk or negedge i_rst_n) begin
      if(!i_rst_n)   valid_q <= 'd0;
      else           valid_q <= valid_d;
   end

   assign o_valid = valid_q;
  
   // Bulk section
   //
   // - At the SS corner 
   // - Will bring the rising to start of the delay line

   (* keep = "true" *) x_delay_line_bulk u_bulk_0  (.i_dl(start_q ), .o_inv(start_d),.o_dl(bulk_0  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_1  (.i_dl(bulk_0  ), .o_inv(),       .o_dl(bulk_1  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_2  (.i_dl(bulk_1  ), .o_inv(),       .o_dl(bulk_2  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_3  (.i_dl(bulk_2  ), .o_inv(),       .o_dl(bulk_3  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_4  (.i_dl(bulk_3  ), .o_inv(),       .o_dl(bulk_4  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_5  (.i_dl(bulk_4  ), .o_inv(),       .o_dl(bulk_5  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_6  (.i_dl(bulk_5  ), .o_inv(),       .o_dl(bulk_6  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_7  (.i_dl(bulk_6  ), .o_inv(),       .o_dl(bulk_7  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_8  (.i_dl(bulk_7  ), .o_inv(),       .o_dl(bulk_8  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_9  (.i_dl(bulk_8  ), .o_inv(),       .o_dl(bulk_9  ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_10 (.i_dl(bulk_9  ), .o_inv(),       .o_dl(bulk_10 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_11 (.i_dl(bulk_10 ), .o_inv(),       .o_dl(bulk_11 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_12 (.i_dl(bulk_11 ), .o_inv(),       .o_dl(bulk_12 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_13 (.i_dl(bulk_12 ), .o_inv(),       .o_dl(bulk_13 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_14 (.i_dl(bulk_13 ), .o_inv(),       .o_dl(bulk_14 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_15 (.i_dl(bulk_14 ), .o_inv(),       .o_dl(bulk_15 ));
   (* keep = "true" *) x_delay_line_bulk u_bulk_16 (.i_dl(bulk_15 ), .o_inv(),       .o_dl(dl_0    ));

   (* keep = "true" *) x_delay_line_cell u_dl_0    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_0 ),.o_dl(dl_1 ),.o_data(data_0 ));
   (* keep = "true" *) x_delay_line_cell u_dl_1    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_1 ),.o_dl(dl_2 ),.o_data(data_1 ));
   (* keep = "true" *) x_delay_line_cell u_dl_2    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_2 ),.o_dl(dl_3 ),.o_data(data_2 ));
   (* keep = "true" *) x_delay_line_cell u_dl_3    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_3 ),.o_dl(dl_4 ),.o_data(data_3 ));
   (* keep = "true" *) x_delay_line_cell u_dl_4    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_4 ),.o_dl(dl_5 ),.o_data(data_4 ));
   (* keep = "true" *) x_delay_line_cell u_dl_5    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_5 ),.o_dl(dl_6 ),.o_data(data_5 ));
   (* keep = "true" *) x_delay_line_cell u_dl_6    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_6 ),.o_dl(dl_7 ),.o_data(data_6 ));
   (* keep = "true" *) x_delay_line_cell u_dl_7    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_7 ),.o_dl(dl_8 ),.o_data(data_7 ));
   (* keep = "true" *) x_delay_line_cell u_dl_8    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_8 ),.o_dl(dl_9 ),.o_data(data_8 ));
   (* keep = "true" *) x_delay_line_cell u_dl_9    (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_9 ),.o_dl(dl_10),.o_data(data_9 ));
   (* keep = "true" *) x_delay_line_cell u_dl_10   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_10),.o_dl(dl_11),.o_data(data_10));
   (* keep = "true" *) x_delay_line_cell u_dl_11   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_11),.o_dl(dl_12),.o_data(data_11));
   (* keep = "true" *) x_delay_line_cell u_dl_12   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_12),.o_dl(dl_13),.o_data(data_12));
   (* keep = "true" *) x_delay_line_cell u_dl_13   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_13),.o_dl(dl_14),.o_data(data_13));
   (* keep = "true" *) x_delay_line_cell u_dl_14   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_14),.o_dl(dl_15),.o_data(data_14));
   (* keep = "true" *) x_delay_line_cell u_dl_15   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_15),.o_dl(dl_16),.o_data(data_15));
   (* keep = "true" *) x_delay_line_cell u_dl_16   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_16),.o_dl(dl_17),.o_data(data_16));
   (* keep = "true" *) x_delay_line_cell u_dl_17   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_17),.o_dl(dl_18),.o_data(data_17));
   (* keep = "true" *) x_delay_line_cell u_dl_18   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_18),.o_dl(dl_19),.o_data(data_18));
   (* keep = "true" *) x_delay_line_cell u_dl_19   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_19),.o_dl(dl_20),.o_data(data_19));
   (* keep = "true" *) x_delay_line_cell u_dl_20   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_20),.o_dl(dl_21),.o_data(data_20)); 
   (* keep = "true" *) x_delay_line_cell u_dl_21   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_21),.o_dl(dl_22),.o_data(data_21));
   (* keep = "true" *) x_delay_line_cell u_dl_22   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_22),.o_dl(dl_23),.o_data(data_22));
   (* keep = "true" *) x_delay_line_cell u_dl_23   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_23),.o_dl(dl_24),.o_data(data_23));
   (* keep = "true" *) x_delay_line_cell u_dl_24   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_24),.o_dl(dl_25),.o_data(data_24));
   (* keep = "true" *) x_delay_line_cell u_dl_25   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_25),.o_dl(dl_26),.o_data(data_25));
   (* keep = "true" *) x_delay_line_cell u_dl_26   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_26),.o_dl(dl_27),.o_data(data_26));
   (* keep = "true" *) x_delay_line_cell u_dl_27   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_27),.o_dl(dl_28),.o_data(data_27));
   (* keep = "true" *) x_delay_line_cell u_dl_28   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_28),.o_dl(dl_29),.o_data(data_28));
   (* keep = "true" *) x_delay_line_cell u_dl_29   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_29),.o_dl(dl_30),.o_data(data_29));
   (* keep = "true" *) x_delay_line_cell u_dl_30   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_30),.o_dl(dl_31),.o_data(data_30));
   (* keep = "true" *) x_delay_line_cell u_dl_31   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_31),.o_dl(dl_32),.o_data(data_31));
   (* keep = "true" *) x_delay_line_cell u_dl_32   (.i_clk(i_clk),.i_rst_n(i_rst_n),.i_dl(dl_32),.o_dl(),     .o_data());    
  
   // Signal names
   // - Keep flat signal names for ngspice sims

   assign o_data = { data_31, 
                     data_30,
                     data_29, 
                     data_28, 
                     data_27, 
                     data_26, 
                     data_25, 
                     data_24, 
                     data_23, 
                     data_22, 
                     data_21,  
                     data_20,
                     data_19,
                     data_18,
                     data_17,
                     data_16,
                     data_15,
                     data_14,
                     data_13,
                     data_12,
                     data_11,
                     data_10,
                     data_9,
                     data_8,
                     data_7,
                     data_6,
                     data_5,
                     data_4,
                     data_3,
                     data_2,
                     data_1,
                     data_0}; 
endmodule
