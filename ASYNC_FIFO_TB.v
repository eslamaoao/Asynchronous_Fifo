/*
module Async_fifo_tb ;

  parameter D_SIZE = 16 ;                         // data size
  parameter A_SIZE = 3  ;                         // address size
  parameter P_SIZE = 4  ;                         // pointer width

  reg                    i_w_clk;              // write domian operating clock
  reg                    i_w_rstn;             // write domian active low reset  
  reg                    i_w_inc;              // write control signal 
  reg                    i_r_clk;              // read domian operating clock
  reg                    i_r_rstn;             // read domian active low reset 
  reg                    i_r_inc;              // read control signal
  reg   [D_SIZE-1:0]     i_w_data;             // write data bus 
  wire  [D_SIZE-1:0]     o_r_data;             // read data bus
  wire                   o_full;               // fifo full flag
  wire                   o_empty;              // fifo empty flag

   //----------------------- Define testbench parameters ------------------------------

  parameter Write_CLK_PERIOD = 12.5 ; // 80 MHz
  parameter Read_CLK_PERIOD = 20 ;    // 50 MHz
   
  parameter Write_CLK_HALF_PERIOD = Write_CLK_PERIOD/2 ;
  parameter Read_CLK_HALF_PERIOD = Read_CLK_PERIOD/2 ;


  // burst length = 20
  reg [D_SIZE-1:0] Burst_Words [19:0] ;

  reg [4:0]  count ;


  // ----------------------- initial block --------------------------------------------------

 initial 
    begin

    $dumpfile("Async_fifo.vcd") ;    // $dumpfile is used to specify the name of the verilog dumping file, the dumping file standard name is verilog.dump
    $dumpvars;                       // $dumpvars is used to generate the verilog dumping file

    $readmemh("stimulus.txt",Burst_Words);             // read hexadeciemal values from stimulus txt file
    $vcdplusmemon();                                   // Enable dumping Memories and arraies 
                   
    $monitor ("READ DATA is %16d \n", o_r_data);
     
    count = 5'b0;
    i_w_clk = 1'b0 ;
    i_r_clk = 1'b0 ;
    i_w_rstn = 1'b1 ;
    i_r_rstn = 1'b1 ; 
    i_w_inc = 1'b0 ;
    i_r_inc = 1'b0 ;
    #5
    i_w_rstn = 1'b0 ;
    i_r_rstn = 1'b0 ; 
    #5
    i_w_rstn = 1'b1 ;
    i_r_rstn = 1'b1 ; 
    i_w_inc = 1'b1 ;
    i_r_inc = 1'b1 ;


    #500

     $finish  ; 
  
   end

always @ (negedge i_w_clk)
  begin
    if(!o_full && count!= 5'd20)
     begin
     i_w_data <= Burst_Words[count] ;
     count <= count + 5'b01 ;
     end
  end


   // --------------------------------- Clock generator ----------------------------------------

   always #Write_CLK_HALF_PERIOD  i_w_clk = ~i_w_clk ;     // 12.5 ns period (80 MHz clock frequency) 
   
   always #Read_CLK_HALF_PERIOD   i_r_clk = ~i_r_clk ;     // 20 ns period (50 MHz clock frequency) 

   // --------------------------------- Module Instantiation ----------------------------------------

ASYNIC_FIFO 
             DUT (
.W_CLK(i_w_clk),      
.R_CLK(i_r_clk),      
.W_RST(i_w_rstn),          
.R_RST(i_r_rstn),        
.R_INC(i_r_inc),    
.W_INC(i_w_inc),       
.WR_DATA(i_w_data),       
.RD_DATA(o_r_data),     
.FULL(o_full),     
.EMPTY(o_empty)
);

endmodule
*/


`timescale 1ns/1ps
module ASYNIC_FIFO_TB (); 


/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////
parameter FIFO_width_TB   = 8 ;
parameter FIFO_depth_TB   = 8 ;
parameter Pointer_Size_TB = 4 ;

parameter R_CLK_PERIOD    = 25 ; 
parameter W_CLK_PERIOD    = 10 ; 








reg W_CLK_TB;
reg W_RST_TB;
reg W_INC_TB;
reg R_CLK_TB;
reg R_RST_TB;
reg R_INC_TB;
reg [FIFO_width_TB-1:0 ] WR_DATA_TB;

wire FULL_TB;
wire [FIFO_width_TB-1:0] RD_DATA_TB;
wire EMPTY_TB;

//-------------------------------------//


initial
 begin
 initialize();
 r_reset();
 w_reset();
/* 
 WR_DATA_TB  = 'd8	;
  W_INC_TB    = 1'b1  ;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 
 WR_DATA_TB  = 'd10	;
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
 */
 WR_DATA_TB  = 'd8	;
  W_INC_TB    = 1'b1  ;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
  WR_DATA_TB  = 'd7	;
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
  WR_DATA_TB  = 'd9	;
 #(R_CLK_PERIOD);
 W_INC_TB    = 1'b1;
  R_INC_TB = 1'b1 ;
 #(W_CLK_PERIOD);
 W_INC_TB    = 1'b0;
  R_INC_TB = 1'b0 ;
 #1000
 $stop;
 end







/////////////// Signals Initialization //////////////////

task initialize ;
  begin
    
	W_CLK_TB    = 1'b0  ;
	W_RST_TB    = 1'b0  ;
	W_INC_TB    = 1'b0  ;
	R_CLK_TB    = 1'b0  ;
	R_RST_TB    = 1'b0  ;
	R_INC_TB    = 1'b0  ;
    WR_DATA_TB  = 'd0	;
	
  end
endtask

///////////////////////// Reading RESET /////////////////////////

task r_reset ;
 begin
  #(R_CLK_PERIOD)
  R_RST_TB  = 'b0;           // rst is activated
  #(R_CLK_PERIOD)
  R_RST_TB  = 'b1;
  #(R_CLK_PERIOD) ;
 end
endtask


///////////////////// Reading Clock Generator //////////////////

always #(R_CLK_PERIOD/2) R_CLK_TB = ~R_CLK_TB ;



///////////////////////// Writing RESET /////////////////////////

task w_reset ;
 begin
  #(W_CLK_PERIOD)
  W_RST_TB  = 1'b0;           // rst is activated
  #(W_CLK_PERIOD)
  W_RST_TB  = 1'b1;
  #(W_CLK_PERIOD) ;
 end
endtask


///////////////////// Writing Clock Generator //////////////////

always #(W_CLK_PERIOD/2) W_CLK_TB = ~W_CLK_TB ;



ASYNIC_FIFO #(.FIFO_width(FIFO_width_TB), .FIFO_depth(FIFO_depth_TB), .Pointer_Size(Pointer_Size_TB))   DUT
(
.W_CLK 		(W_CLK_TB),
.W_RST 		(W_RST_TB),
.W_INC 		(W_INC_TB),
.R_CLK 		(R_CLK_TB),
.R_RST 		(R_RST_TB),
.R_INC 		(R_INC_TB),
.WR_DATA 	(WR_DATA_TB),
.FULL 		(FULL_TB),
.RD_DATA 	(RD_DATA_TB),
.EMPTY  	(EMPTY_TB)
);


endmodule 
