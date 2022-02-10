/*
    <your_application_description>
    Copyright (C) <year>  <your_name>
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

`timescale 1 ns / 1 ps


module main (
	sysclk,
	jp1,
	jp2
);

parameter CLK_FREQUENCY = 10000000;
parameter TEST_PARAM = 1;

localparam TEST_LOCALPARAM = 1;

input wire sysclk;
inout wire[19:0] jp1;
inout wire[19:0] jp2;

reg[19:0] poscnt;
reg[19:0] negcnt;

wire pllclk;

assign jp1 = poscnt;
assign jp2 = negcnt;

pll pll_block(sysclk, pllclk);

always @(posedge pllclk) begin
	poscnt <= jp1+poscnt;
	negcnt <= ~jp1+negcnt;
end

endmodule
