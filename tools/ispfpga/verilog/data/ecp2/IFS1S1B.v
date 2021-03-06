// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for SC/EC/XP/ECP/ECP2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/IFS1S1B.v,v 1.5 2005/05/19 19:06:37 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine
module IFS1S1B (D, SCLK, PD, Q);
  parameter GSR = "ENABLED";
  input  D, SCLK, PD;
  output Q;
  reg SRN, QR;
  reg notifier; 
  wire QB;

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  not (SR1, SRN);
  or INST1 (SR, PD, SR1);
  //not(QN,QB);

  UDFDL3_UDP_X INST6 (QB, SR, D, SCLK, notifier);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule
`endcelldefine
