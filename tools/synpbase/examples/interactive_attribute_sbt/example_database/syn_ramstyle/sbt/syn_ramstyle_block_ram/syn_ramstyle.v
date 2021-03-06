
//Interactive attribute example for syn_ramstyle attribute

module test (ADDRA, ADDRB, data_in, CLK, WEA, data_out);
output[3:0] data_out;
input [7:0] ADDRA;
input [7:0] ADDRB;
input [3:0] data_in;
input CLK, WEA;
reg [3:0] mem [255:0];
reg [7:0] ADDRB_reg;

always@(posedge CLK)
 if(WEA)
  mem[ADDRA] = data_in;
always @(posedge CLK)
ADDRB_reg <= ADDRB;
assign data_out = mem[ADDRB_reg];
endmodule
