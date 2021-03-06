///////////////////////////////////////////////////////////////////////////
// for <basdb>
///////////////////////////////////////////////////////////////////////////
// Please search keyword "TBD" for items to be determined
///////////////////////////////////////////////////////////////////////////


CONF FUNC; FDDT:VGB
IN  B[10]
OUT OUT
ARC B[10]:OUT:LUT4
END

CONF MEM; FDDT:RAM
IN  DIA[18] DIB[18] MDIA[9] MDIB[9] MAA[14] AA[4] MAB[14] AB[4] 
IN  MCEA MCEB MWEA MWEB MCSA[4] MCSB[4] MRSTA MRSTB CLKA CLKB OPRCLKA OPRCLKB
OUT PORTAZ[9] PORTAM[9] PORTA[18] PORTBZ[9] PORTBM[9] PORTB[18] AE AF EF FF
PIN CLKA; CLK
PIN CLKB; CLK
PIN DIA[18]; GATED
PIN DIB[18]; GATED
ARC CLKA:PORTAZ[9]:EBSR_CO CLKA:PORTAM[9]:EBSR_CO CLKA:PORTA[18]:EBSR_CO 
ARC CLKB:PORTBZ[9]:EBSR_CO CLKB:PORTBM[9]:EBSR_CO CLKB:PORTB[18]:EBSR_CO
ARC CLKA:FF:EBSR_CO CLKA:AF:EBSR_CO CLKB:EF:EBSR_CO CLKB:AE:EBSR_CO
CHK DIA[18]:CLKA:EBSWD_S DIA[18]:CLKA:EBSWD_H
CHK DIB[18]:CLKB:EBSWD_S DIB[18]:CLKB:EBSWD_H
END

CONF ZERO; POWER:GND
OUT OUT
PIN OUT; POWER:GND
END

CONF ONE; POWER:VCC
OUT OUT
PIN OUT; POWER:VCC
END

CONF OUT; IO:OUT FDDT:IOB
IN  OUT TRI
PAD PAD; DIR:OUT
ARC OUT:PAD:IOBUF TRI:PAD:IOOEN
END

CONF INP; IO:IN FDDT:IOB
OUT IN
PAD PAD; DIR:IN
ARC PAD:IN:IOIN
END

CONF IOP; IO:BI FDDT:IOB
IN  IN TRI
OUT OUT
PAD PAD; DIR:BI
ARC PAD:OUT:IOIN  IN:PAD:IOBUF TRI:PAD:IOOEN
END

CONF DCS; IO:IN FDDT:IOB
IN CLK0 CLK1 SEL
OUT DCSOUT
ARC CLK0:DCSOUT:I_CO CLK1:DCSOUT:I_CO
END

CONF READBK; IO:IN FDDT:IOB
IN RDCFGN FFRDCFG FFRDCFGCLK
OUT RDDATA
ARC FFRDCFGCLK:RDDATA:I_CO 
END

CONF RDBK; IO:IN FDDT:IOB
IN RDCFGN FFRDCFG FFRDCFGCLK
OUT RDDATA
ARC FFRDCFGCLK:RDDATA:I_CO 
END

CONF IODELAY; IO:IN FDDT:IOB
IN A DCNTL[10]
OUT Z
ARC A:Z:I_CO
END

//////////////////////////////////////////////////////////////////
// DDRs, use the same set of pin template for all DDRs
//////////////////////////////////////////////////////////////////

CONF INDDR; IO:IN FDDT:IOB
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INDDRX; IO:IN FDDT:IOB
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INDDRX1; IO:IN FDDT:IOB
IN D SC EC UPDATE RUN RSTAIL
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INDDRX2; IO:IN FDDT:IOB
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INDDRX4; IO:IN FDDT:IOB
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END
 
CONF INSHREGX1; IO:IN FDDT:IOB 
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INSHREGX2; IO:IN FDDT:IOB 
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF INSHREGX4; IO:IN FDDT:IOB 
IN D SC EC UPDATE RUN 
OUT QP[4] QN[4] UPDATEOUT LOCK
ARC SC:QP[4]:I_CO  SC:QN[4]:I_CO 
ARC EC:QP[4]:I_CO  EC:QN[4]:I_CO 
END

CONF OUTDDRX; IO:OUT FDDT:IOB
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END 

CONF OUTDDRX2; IO:OUT FDDT:IOB
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END 

CONF OUTDDRX4; IO:OUT FDDT:IOB
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END 

CONF OUTSHREGX1; IO:IN FDDT:IOB 
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END

CONF OUTSHREGX2; IO:IN FDDT:IOB 
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END

CONF OUTSHREGX4; IO:IN FDDT:IOB 
IN DP[4] DN[4] SC EC UPDATE
OUT Q UPDATEOUT
ARC SC:Q:O_CO 
ARC EC:Q:O_CO 
END

CONF CLKDIV; IO:IN FDDT:IOB
IN CLKI LSR CLKO ELSR 
OUT CLKO ELSR 
ARC CLKI:CLKO:IOIN LSR:ELSR:IOIN
END

/////////////////////////////////////////////////////////////////////
// PLL / DLL blocks 
/////////////////////////////////////////////////////////////////////
CONF EHXPLLA; IO:IN FDDT:IOB GNET:PLL
IN SMIADDR[10] SMIRD SMIWR SMICLK SMIWDATA SMIRSTN CLKI CLKFB RSTN 
OUT CLKOP CLKOS LOCK CLKINTFB SMIRDATA
ARC CLKI:CLKOP:PLL CLKI:CLKOS:PLL 
END

CONF TRDLLA; IO:IN FDDT:IOB GNET:PLL
IN CLKI RSTN ALUHOLD UDDCNTL SMIADDR[10] SMIRD SMIWR SMICLK SMIWDATA SMIRSTN 
OUT CLKOP CLKOS LOCK DCNTL[9] SMIRDATA
ARC CLKI:CLKOP:PLL CLKI:CLKOS:PLL 
END

CONF CIDDLLA; IO:IN FDDT:IOB GNET:PLL
IN CLKI CLKFB RSTN ALUHOLD SMIADDR[10] SMIRD SMIWR SMICLK SMIWDATA SMIRSTN 
OUT CLKOP CLKOS LOCK SMIRDATA
ARC CLKI:CLKOP:PLL CLKI:CLKOS:PLL 
END

CONF CIMDLLA; IO:IN FDDT:IOB GNET:PLL
IN CLKI CLKFB RSTN ALUHOLD UDDCNTL SMIADDR[10] SMIRD SMIWR SMICLK SMIWDATA SMIRSTN 
OUT CLKOP CLKOS LOCK DCNTL[9] SMIRDATA
ARC CLKI:CLKOP:PLL CLKI:CLKOS:PLL 
END

CONF SDCDLLA; IO:IN FDDT:IOB GNET:PLL
IN CLKI CLKFB RSTN ALUHOLD UDDCNTL SMIADDR[10] SMIRD SMIWR SMICLK SMIWDATA SMIRSTN 
OUT CLKOP CLKOS LOCK DCNTL[9] SMIRDATA
ARC CLKI:CLKOP:PLL CLKI:CLKOS:PLL 
END

CONF OSCA;
OUT OSC
END

/////////////////////////////////////////////////////////////////////

CONF BUF; FDDT:VGB
IN  B0
OUT OUT
ARC B0:OUT:LUT4
END

CONF A_FF; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF A_DL; LAT FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
ARC D0:Q:LLPD
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF SMFF; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF SMDL; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF S_FF; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF S_DL; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF AMFF; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF AMDL; FDDT:VGB
IN  D0 D1 CK CE SR SE
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN D1; GATED
PIN CE; GATED
PIN SR; RST
ARC CK:Q:L_CO SR:Q:LASSRO
CHK D0:CK:L_S D0:CK:L_H D1:CK:L_S D1:CK:L_H
CHK CE:CK:LCE_S CE:CK:LCE_H
END

CONF SPRAM; FDDT:VGB
IN  RWAD[4] RAD[4] DI[2] RCK CK WREN WPE DPI
OUT DO[2] 
PIN CK; CLK
PIN RCK; CLK
PIN DI[2]; GATED
PIN WREN; GATED
PIN WPE; GATED
ARC RAD[4]:DO[2]:LUT4 CK:DO[2]:LRAM_CO RCK:DO[2]:LRAM_CO
CHK DI[2]:CK:LRAMD_S DI[2]:CK:LRAMD_H
CHK RWAD[4]:CK:LRAMAD_S RWAD[4]:CK:LRAMAD_H
CHK RAD[4]:RCK:LRAMAD_S RAD[4]:RCK:LRAMAD_H
END


CONF DPRAM; FDDT:VGB
IN  RWAD[4] RAD[4] DI[2] RCK CK WREN WPE DPI
OUT DO[2] 
PIN CK; CLK
PIN RCK; CLK
PIN DI[2]; GATED
PIN WREN; GATED
PIN WPE; GATED
ARC RAD[4]:DO[2]:LUT4 CK:DO[2]:LRAM_CO RCK:DO[2]:LRAM_CO
CHK DI[2]:CK:LRAMD_S DI[2]:CK:LRAMD_H
CHK RWAD[4]:CK:LRAMAD_S RWAD[4]:CK:LRAMAD_H
CHK RAD[4]:RCK:LRAMAD_S RAD[4]:RCK:LRAMAD_H
END

CONF DP8KA; FDDT:RAM
IN  DIA[18] ADA[13] DIB[18] ADB[13]
IN  CSA[3] CEA CLKA WEA RSTA
IN  CSB[3] CEB CLKB WEB RSTB
OUT DOA[18] DOB[18]
PIN CLKA; CLK
PIN CLKB; CLK
PIN DIA[18]; GATED
PIN DIB[18]; GATED
PIN ADA[13]; GATED
PIN ADB[13]; GATED
PIN WEA; GATED
PIN WEB; GATED
PIN CEA; GATED
PIN CEB; GATED
ARC CLKA:DOA[18]:EBSR_CO CLKB:DOB[18]:EBSR_CO 
ARC RSTA:DOA[18]:EBASSRO RSTB:DOB[18]:EBASSRO
CHK DIA[18]:CLKA:EBSWD_S DIA[18]:CLKA:EBSWD_H ADA[13]:CLKA:EBSWAD_S ADA[13]:CLKA:EBSWAD_H
CHK DIB[18]:CLKB:EBSWD_S DIB[18]:CLKB:EBSWD_H ADB[13]:CLKB:EBSWAD_S ADB[13]:CLKB:EBSWAD_H
CHK WEA:CLKA:EBSRWE_S WEA:CLKA:EBSRWE_H WEB:CLKB:EBSRWE_S WEB:CLKB:EBSRWE_H
CHK CEA:CLKA:EBSRCE_S CEA:CLKA:EBSRCE_H CEB:CLKB:EBSRCE_S CEB:CLKB:EBSRCE_H
END

CONF PDP8KA; FDDT:RAM
IN  DI[36] ADW[13] ADR[13] WE RST
IN  CSW[3] CEW CLKW
IN  CSR[3] CER CLKR
OUT DO[36]
PIN CLKW; CLK
PIN CLKR; CLK
PIN DI[36]; GATED
PIN ADW[13]; GATED
PIN ADR[13]; GATED
PIN WE; GATED
PIN CEW; GATED
PIN CER; GATED
ARC CLKR:DO[36]:EBSR_CO RST:DO[36]:EBASSRO
CHK DI[36]:CLKW:EBSWD_S DI[36]:CLKW:EBSWD_H
CHK ADW[13]:CLKW:EBSWAD_S ADW[13]:CLKW:EBSWAD_H
CHK ADR[13]:CLKR:EBSWAD_S ADR[13]:CLKR:EBSWAD_H
CHK WE:CLKW:EBSRWE_S WE:CLKW:EBSRWE_H
CHK CEW:CLKW:EBSRCE_S CEW:CLKW:EBSRCE_H CER:CLKR:EBSRCE_S CER:CLKR:EBSRCE_H
END
 
CONF SP8KA; FDDT:RAM
IN  DI[18] AD[13] WE RST
IN  CS[3] CE CLK
OUT DO[18]
PIN CLK; CLK
PIN DI[18]; GATED
PIN AD[13]; GATED
PIN CE; GATED
PIN WE; GATED
ARC CLK:DO[18]:EBSR_CO RST:DO[18]:EBASSRO
CHK AD[13]:CLK:EBSWAD_S AD[13]:CLK:EBSWAD_H
CHK DI[18]:CLK:EBSWD_S DI[18]:CLK:EBSWD_H
CHK WE:CLK:EBSRWE_S WE:CLK:EBSRWE_H
CHK CE:CLK:EBSRCE_S CE:CLK:EBSRCE_H
END


CONF SP16KA; FDDT:RAM
IN  DI[18] AD[14] WE RST
IN  CS[3] CE CLK
OUT DO[18]
PIN CLK; CLK
PIN DI[18]; GATED
PIN AD[14]; GATED
PIN CE; GATED
PIN WE; GATED
ARC CLK:DO[18]:EBSR_CO RST:DO[18]:EBASSRO
CHK AD[14]:CLK:EBSWAD_S AD[14]:CLK:EBSWAD_H
CHK DI[18]:CLK:EBSWD_S DI[18]:CLK:EBSWD_H
CHK WE:CLK:EBSRWE_S WE:CLK:EBSRWE_H
CHK CE:CLK:EBSRCE_S CE:CLK:EBSRCE_H
END

CONF DP16KA; FDDT:RAM
IN  DIA[18] ADA[14] CEA CLKA WEA CSA[3] RSTA
IN  DIB[18] ADB[14] CEB CLKB WEB CSB[3] RSTB
OUT DOA[18] DOB[18]
PIN CLKA; CLK
PIN CLKB; CLK
PIN DIA[18]; GATED
PIN DIB[18]; GATED
PIN ADA[14]; GATED
PIN ADB[14]; GATED
PIN CEA; GATED
PIN WEA; GATED
PIN CEB; GATED
PIN WEB; GATED
ARC CLKA:DOA[18]:EBSR_CO RSTA:DOA[18]:EBASSRO
ARC CLKB:DOB[18]:EBSR_CO RSTB:DOB[18]:EBASSRO
CHK ADA[14]:CLKA:EBSWAD_S ADA[14]:CLKA:EBSWAD_H
CHK ADB[14]:CLKB:EBSWAD_S ADB[14]:CLKB:EBSWAD_H
CHK DIA[18]:CLKA:EBSWD_S DIA[18]:CLKA:EBSWD_H
CHK DIB[18]:CLKB:EBSWD_S DIB[18]:CLKB:EBSWD_H
CHK WEA:CLKA:EBSRWE_S WEA:CLKA:EBSRWE_H
CHK WEB:CLKB:EBSRWE_S WEB:CLKB:EBSRWE_H
CHK CEA:CLKA:EBSRCE_S CEA:CLKA:EBSRCE_H
CHK CEB:CLKB:EBSRCE_S CEB:CLKB:EBSRCE_H
END

CONF PDP16KA; FDDT:RAM
IN  DI[36] ADW[14] ADR[14] WE RST
IN  CSW[3] CEW CLKW
IN  CSR[3] CER CLKR
OUT DO[36]
PIN CLKW; CLK
PIN CLKR; CLK
PIN DI[36]; GATED
PIN ADW[14]; GATED
PIN ADR[14]; GATED
PIN WE; GATED
PIN CEW; GATED
PIN CER; GATED
ARC CLKR:DO[36]:EBSR_CO RST:DO[36]:EBASSRO
CHK DI[36]:CLKW:EBSWD_S DI[36]:CLKW:EBSWD_H
CHK ADW[14]:CLKW:EBSWAD_S ADW[14]:CLKW:EBSWAD_H
CHK ADR[14]:CLKR:EBSWAD_S ADR[14]:CLKR:EBSWAD_H
CHK WE:CLKW:EBSRWE_S WE:CLKW:EBSRWE_H
CHK CEW:CLKW:EBSRCE_S CEW:CLKW:EBSRCE_H CER:CLKR:EBSRCE_S CER:CLKR:EBSRCE_H
END
 

CONF FIFO16KA; FDDT:RAM
IN  DI[36] RE WE RST RPRST
IN  FULLI EMPTYI
IN  CSW[2] CLKW
IN  CSR[2] CLKR
OUT DO[36] EF AEF AFF FF 
PIN CLKW; CLK
PIN CLKR; CLK
PIN DI[36]; GATED
//PIN FULLI; GATED  // TBD
//PIN EMPTYI; GATED  // TBD
PIN RE; GATED
PIN WE; GATED
ARC CLKR:DO[36]:EBSR_CO RST:DO[36]:EBASSRO RPRST:DO[36]:EBASSRO
ARC CLKR:EF:EBSR_CO RST:EF:EBASSRO RPRST:EF:EBASSRO
ARC CLKR:AEF:EBSR_CO RST:AEF:EBASSRO RPRST:AEF:EBASSRO
ARC CLKR:AFF:EBSR_CO RST:AFF:EBASSRO RPRST:AFF:EBASSRO
ARC CLKR:FF:EBSR_CO RST:FF:EBASSRO RPRST:FF:EBASSRO
CHK DI[36]:CLKW:EBSWD_S DI[36]:CLKW:EBSWD_H
CHK RE:CLKR:EBSRWE_S RE:CLKR:EBSRWE_H  // TBD, use write enable temporarily
CHK WE:CLKW:EBSRWE_S WE:CLKW:EBSRWE_H
END



CONF LUT; FDDT:VGB
IN  B[10]
OUT OUT
ARC B[10]:OUT:LUT4
END

CONF MUX; FDDT:VGB
IN  A B SEL
OUT OUT
ARC A:OUT:LUT4 B:OUT:LUT4 SEL:OUT:LUT4
END

CONF PFUMX; COMB FDDT:VGB
IN  A B SEL ALUT BLUT C0
OUT OUT Z
ARC A:OUT:MUXL5 B:OUT:MUXL5 ALUT:Z:MUXL5 BLUT:Z:MUXL5 SEL:OUT:MOFX0 C0:Z:MOFX0
END

CONF ADD; FDDT:VGB
IN  A0 A1 B0 B1 CIN UPDN
OUT S0 S1 COUT S3
ARC A0:S0:LSTHRU  B0:S0:LSTHRU  CIN:S0:LCINSOUT  A1:S1:LSTHRU B1:S1:LSTHRU CIN:COUT:LCTHRU 
ARC UPDN:S0:LCTHRU UPDN:S1:LCTHRU UPDN:COUT:LSINCOUT2 
ARC A0:S1:LSTHRU2 B0:S1:LSTHRU2 CIN:S1:LCINSOUT2
ARC A0:COUT:LSINCOUT2 B0:COUT:LSINCOUT2 A1:COUT:LSINCOUT B1:COUT:LSINCOUT
END

// S3 as CO2
CONF SUB; FDDT:VGB
IN  A0 A1 B0 B1 CIN
OUT S0 S1 S3 COUT
ARC A0:S0:LSTHRU B0:S0:LSTHRU A1:S1:LSTHRU B1:S1:LSTHRU A0:S1:LSTHRU2 B0:S1:LSTHRU2 
ARC CIN:S0:LCINSOUT CIN:S1:LCINSOUT2 CIN:COUT:LCTHRU CIN:S3:LCINSOUT2 
ARC A0:COUT:LSINCOUT2 B0:COUT:LSINCOUT2 A1:COUT:LSINCOUT B1:COUT:LSINCOUT
ARC A0:S3:LSINCOUT2 B0:S3:LSINCOUT2 A1:S3:LSINCOUT B1:S3:LSINCOUT
END

CONF ADSU; FDDT:VGB
IN  A0 A1 B0 B1 CIN UPDN
OUT S0 S1 S3 COUT
ARC A0:S0:LSTHRU B0:S0:LSTHRU A1:S1:LSTHRU B1:S1:LSTHRU A0:S1:LSTHRU2 B0:S1:LSTHRU2
ARC CIN:S0:LCINSOUT CIN:S1:LCINSOUT2 CIN:COUT:LCTHRU CIN:S3:LCINSOUT2
ARC A0:COUT:LSINCOUT2 B0:COUT:LSINCOUT2 A1:COUT:LSINCOUT B1:COUT:LSINCOUT
ARC A0:S3:LSINCOUT2 B0:S3:LSINCOUT2 A1:S3:LSINCOUT B1:S3:LSINCOUT
END

CONF AGEB; FDDT:VGB
IN  A0 A1 B0 B1 CIN
OUT AGEB
ARC A0:AGEB:LSINCOUT2 A1:AGEB:LSINCOUT B0:AGEB:LSINCOUT2 B1:AGEB:LSINCOUT CIN:AGEB:LCTHRU
END

CONF ALEB; FDDT:VGB
IN  A0 A1 B0 B1 CIN
OUT ALEB
ARC A0:ALEB:LSINCOUT2 A1:ALEB:LSINCOUT B0:ALEB:LSINCOUT2 B1:ALEB:LSINCOUT CIN:ALEB:LCTHRU
END

CONF ANEB; FDDT:VGB
IN  A0 A1 B0 B1 CIN
OUT ANEB
ARC A0:ANEB:LSINCOUT2 A1:ANEB:LSINCOUT B0:ANEB:LSINCOUT2 B1:ANEB:LSINCOUT CIN:ANEB:LCTHRU
END

CONF UPDN; FDDT:VGB
IN  A0 A1 CIN UPDN
OUT R0 R1 COUT
ARC A0:R0:LSTHRU A1:R1:LSTHRU CIN:R0:LCINSOUT CIN:R1:LCINSOUT2 CIN:COUT:LCTHRU
ARC A0:COUT:LSINCOUT2 A1:COUT:LSINCOUT
END

CONF INC; FDDT:VGB
IN  A0 A1 B0 B1 CIN UPDN
OUT R0 R1 COUT
ARC A0:R0:LSTHRU A1:R1:LSTHRU B0:R0:LSTHRU B1:R1:LSTHRU CIN:R0:LCINSOUT CIN:R1:LCINSOUT2 CIN:COUT:LCTHRU
ARC A0:COUT:LSINCOUT2 B0:COUT:LSINCOUT2 A1:COUT:LSINCOUT B1:COUT:LSINCOUT
END

CONF DEC; FDDT:VGB
IN  A0 A1 B0 B1 CIN
OUT R0 R1 COUT
ARC A0:R0:LSTHRU A1:R1:LSTHRU B0:R0:LSTHRU B1:R1:LSTHRU CIN:R0:LCINSOUT CIN:R1:LCINSOUT2 CIN:COUT:LCTHRU
ARC A0:COUT:LSINCOUT2 B0:COUT:LSINCOUT2 A1:COUT:LSINCOUT B1:COUT:LSINCOUT
END

CONF OR; COMB FDDT:VGB
IN  B[8]
OUT OUT
ARC B[8]:OUT:LUT4
END
 
CONF XOR; COMB FDDT:VGB
IN  I0 I1 A B C D E
OUT O Z
ARC I0:O:LUT4 I1:O:LUT4
ARC A:Z:LUT4 B:Z:LUT4 C:Z:LUT4 D:Z:LUT4 E:Z:LUT4
END

CONF CLKCNTL; COMB FDDT:VGB
IN  D CLK CE 
OUT Q
ARC D:Q:LUT4 CLK:Q:LUT4 CE:Q:LUT4
END

CONF DQS; COMB FDDT:VGB
IN  D CLK CE 
OUT Q
ARC D:Q:LUT4 CLK:Q:LUT4 CE:Q:LUT4
END

CONF PCM; IO:IN FDDT:IOB GNET:GCLK
PAD CLKIN; DIR:IN
IN  FB
OUT ECLK SCLK LOCK
ARC CLKIN:ECLK:GCLK_IN CLKIN:SCLK:GCLK_IN 
END


// for <ncd>

CONF LVIOL; FDDT:VGB
IN  INDEL DQS SC CE LSR ON[2] OP[2] TD 
OUT DO TO IP[3] INFF 
PIN CE; GATED
PIN SC; CLK
ARC CE:INFF:IO_CO SC:INFF:IO_CO
END

CONF LVPIO; IO FDDT:IOB
IN  OP0 DO TD TO
OUT PADI
PAD PAD; DIR:BI 
ARC PAD:PADI:IOBUF OP0:PAD:IOBUF DO:PAD:IOBUF TD:PAD:IOBUF TO:PAD:IOBUF 
END

CONF PFU; FDDT:VGB
IN  K0_[4] K1_[4] K2_[4] K3_[4] K4_[4] K5_[4] K6_[4] K7_[4] CE[2] CLK[2] LSR[2] DIN[8]
IN  F5A F5B F5C F5D LUT603 LUT647 FCIN CIN
OUT Q[8] F[8] COUT FCOUT
PIN CLK[2]; CLK
PIN DIN[8]; GATED
PIN K0_[4]; GATED
END

CONF MULT; COMB FDDT:VGB
IN  A[2] B[2] C[2] D[2] CI
OUT CO S[2] 
ARC A[2]:S[2]:LSTHRU B[2]:S[2]:LSTHRU C[2]:S[2]:LSTHRU D[2]:S[2]:LSTHRU
ARC A[2]:CO:LSINCOUT B[2]:CO:LSINCOUT C[2]:CO:LSINCOUT D[2]:CO:LSINCOUT 
ARC CI:CO:LCTHRU CI:S[2]:LCINSOUT 
END

CONF MULT2; COMB FDDT:VGB
IN  A[4] B[4] CI LSR
OUT CO CO2 S[2] 
ARC A[4]:S[2]:LSTHRU B[4]:S[2]:LSTHRU 
ARC A[4]:CO:LSINCOUT B[4]:CO:LSINCOUT 
ARC CI:CO:LCTHRU CI:S[2]:LCINSOUT 
END

CONF MULT9; FDDT:VGB
IN  XA_L[9] XB_L[9] XCEI_L XRSTI_L XCLKI_L 
OUT XO_L[18]
PIN XCLKI_L; CLK
ARC XA_L[9]:XO_L[18]:LUT4 XB_L[9]:XO_L[18]:LUT4 XCLKI_L:XO_L[18]:LUT4
END

CONF MULT18; FDDT:VGB
IN  XA_L[9] XB_L[9] XA_H[9] XB_H[9] 
OUT XO_L[18] XO_H[18]
ARC XA_L[9]:XO_L[18]:LUT4 XB_H[9]:XO_H[18]:LUT4
END

CONF LSLICE; COMB FDDT:VGB
IN  A[2] B[2] C[2] D[2] DIN[2] M[2] FXA FXB CE LSR CLK FCIN DP32 DP64 SRI
OUT SRO OFX[2] F[2] Q[2] DP FCOUT
PIN CLK; CLK
PIN DIN[2]; GATED
ARC CLK:Q[2]:L_CO A[2]:F[2]:LUT4
CHK A[2]:CLK:L_S A[2]:CLK:L_H
END

CONF LFSLICE; COMB FDDT:VGB
IN  A[2] B[2] C[2] D[2] DIN[2] M[2] FXA FXB CE LSR CLK FCIN
OUT OFX[2] F[2] Q[2] FCOUT
PIN CLK; CLK
PIN DIN[2]; GATED
ARC CLK:Q[2]:L_CO A[2]:F[2]:LUT4
CHK A[2]:CLK:L_S A[2]:CLK:L_H
END

CONF SLIC; COMB FDDT:VGB
IN  SIN[8] TRI 
OUT DEC SOUT[4] SOUTTRI[4]
ARC SIN[8]:DEC:LUT4 SIN[8]:SOUT[4]:LUT4 SIN[8]:SOUTTRI[4]:LUT4
ARC TRI:DEC:LUT4 TRI:SOUT[4]:LUT4 TRI:SOUTTRI[4]:LUT4
END

CONF VLO; POWER:GND
OUT Z
PIN Z; POWER:GND
END

CONF VHI; POWER:VCC
OUT Z
PIN Z; POWER:VCC
END

CONF GSR; IO FDDT:IOB
IN  GSR CLK
PAD PAD; DIR:OUT
ARC GSR:PAD:IOBUF CLK:PAD:IOBUF 
END

CONF RESETN; IO:IN FDDT:IOB
OUT RESETN
PAD PAD; DIR:IN 
ARC PAD:RESETN:IOBUF
END

CONF PPLL; COMB FDDT:VGB
IN  CLKFB CLK
OUT INTFB MCLK NCLK LOCK 
ARC CLK:NCLK:LUT4
END

CONF PLLT; COMB FDDT:VGB
IN  CLKIN FB 
OUT ECLK SCLK LOCK 
ARC CLKIN:ECLK:LUT4
END

CONF IPPLL; COMB FDDT:VGB
IN  CLKIN FB CLK
OUT INTFB MCLK NCLK LOCK 
//ARC CLK:NCLK:LUT4
END


CONF MUX81; COMB FDDT:VGB
IN  D[8] SD[4]
OUT Z
ARC D[8]:Z:LUT4
END

CONF IBM; IO:IN FDDT:IOB
OUT O
PAD I; DIR:IN
ARC I:O:IOIN
END

CONF IBMPD; IO:IN FDDT:IOB
OUT O
PAD I; DIR:IN
ARC I:O:IOIN
END

CONF OB6; IO:OUT FDDT:IOB
IN  I
PAD O; DIR:OUT
ARC I:O:IOBUF
END

CONF DCE32X4; RAM:SYNC FDDT:VGB
IN  DI[4] CK WREN WPE[2] RAD[5] WAD[5]
OUT CO NC[4]
END

CONF INCDEC4; COMB FDDT:VGB
IN  PC[4] CON
OUT DO[4] QDO[4]
END

CONF ILF2P3DX; FF:D FDDT:VGB
IN  D SP ECLK SCLK CD
OUT Q
PIN SCLK; CLK
PIN D; GATED
PIN Q; Q
ARC SCLK:Q:L_CO
CHK D:SCLK:L_S D:SCLK:L_H
END

CONF OFE1P3DX; FF:D FDDT:VGB
IN  D SP ECLK CD
OUT Q
PIN ECLK; CLK
PIN D; GATED
PIN Q; Q
ARC ECLK:Q:L_CO
CHK D:ECLK:L_S D:ECLK:L_H
END

CONF FS1P3BX; FF:D FDDT:VGB
IN  D SP CK PD
OUT Q
PIN CK; CLK
PIN D; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D:CK:L_S D:CK:L_H
END

CONF FS1P3DX; FF:D FDDT:VGB
IN  D SP CK CD
OUT Q
PIN CK; CLK
PIN D; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D:CK:L_S D:CK:L_H
END

CONF FD1S3BX; FF:D FDDT:VGB
IN  D CK PD
OUT Q QN
PIN CK; CLK
PIN D; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D:CK:L_S D:CK:L_H
END

CONF FD1P3DX; FF:D FDDT:VGB
IN  D SP CK CD
OUT Q QN
PIN CK; CLK
PIN D; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D:CK:L_S D:CK:L_H
END

CONF FD1S3DX; FF:D FDDT:VGB
IN  D CK CD
OUT Q QN
PIN CK; CLK
PIN D; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D:CK:L_S D:CK:L_H
END

CONF SAOI44; COMB FDDT:VGB
IN  A[5] B[5]
OUT Z
ARC A[5]:Z:LUT4 B[5]:Z:LUT4
END

CONF AND2; COMB FDDT:VGB
IN  A B
OUT Z
ARC A:Z:LUT4 B:Z:LUT4
END

CONF AND; COMB FDDT:VGB
IN  B[8]
OUT OUT
ARC B[8]:OUT:LUT4
END

CONF SAND4; COMB FDDT:VGB
IN  A B C D
OUT Z
ARC A:Z:LUT4 B:Z:LUT4 C:Z:LUT4 D:Z:LUT4
END

CONF SAND8; COMB FDDT:VGB
IN  A B C D E F G H
OUT Z
ARC A:Z:LUT4 B:Z:LUT4 C:Z:LUT4 D:Z:LUT4 E:Z:LUT4 F:Z:LUT4 G:Z:LUT4 H:Z:LUT4
END

CONF OB12F; IO:OUT FDDT:IOB
IN  I
PAD O; DIR:OUT
ARC I:O:IOBUF
END

CONF OB12; IO:OUT FDDT:IOB
IN  I
PAD O; DIR:OUT
ARC I:O:IOBUF
END

CONF NEOBUF
IN  IN
OUT OUT
ARC IN:OUT:IOBUF
END

CONF INV; COMB FDDT:VGB
IN  A B0
OUT Z OUT
ARC A:Z:LUT4 B0:OUT:LUT4
END

CONF RDBK; COMB FDDT:VGB
IN  CAPTIN TSALLN 
OUT RDDATA 
ARC CAPTIN:RDDATA:LUT4 TSALLN:RDDATA:LUT4
END

CONF ALU; COMB FDDT:VGB
IN  A0 A1 B0 B1 CI
OUT S0 S1 CO0 CO1
ARC A0:S0:LSTHRU B0:S0:LSTHRU A0:CO0:LSINCOUT B0:CO0:LSINCOUT CI:S0:LCINSOUT  CI:CO0:LCTHRU
ARC A1:S1:LSTHRU B1:S1:LSTHRU A1:CO1:LSINCOUT B1:CO1:LSINCOUT CI:S1:LCINSOUT2 CI:CO1:LCTHRU
END

CONF ORCALUT4; COMB FDDT:VGB
IN  A B C D
OUT Z
ARC A:Z:LUT4 B:Z:LUT4 C:Z:LUT4 D:Z:LUT4
END

CONF ORCALUT5; COMB FDDT:VGB
IN  A B C D E
OUT Z
ARC A:Z:LUT5 B:Z:LUT5 C:Z:LUT5 D:Z:LUT5 E:Z:LUT5
END

CONF IOFF; FF:D FDDT:VGB
IN  D0 SP CK LSR
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D0:CK:L_S D0:CK:L_H
END

CONF IOLATCH; FF:D FDDT:VGB
IN  D0 CK
OUT Q
PIN CK; CLK
PIN D0; GATED
PIN Q; Q
ARC CK:Q:L_CO
CHK D0:CK:L_S D0:CK:L_H
END

CONF ILF2P3DX; FF:D FDDT:VGB
IN  D SP ECLK SCLK CD
OUT Q
PIN ECLK; CLK
PIN D; GATED
PIN Q; Q
ARC ECLK:Q:L_CO
CHK D:ECLK:L_S D:ECLK:L_H
END


//CONF DECODER(SAND4)
//IN  A B C D
//OUT Z
//END

CONF DECODER; COMB FDDT:VGB
IN  A B C D E F G H I J
OUT Z
ARC A:Z:LUT4 B:Z:LUT4 C:Z:LUT4 D:Z:LUT4 E:Z:LUT4
ARC F:Z:LUT4 G:Z:LUT4 H:Z:LUT4 I:Z:LUT4 J:Z:LUT4 
END

CONF INCDEC4; COMB FDDT:VGB
IN  CI PC[4] CON 
OUT CO NC[4]
ARC PC[4]:NC[4]:LSTHRU CI:CO:LCTHRU CI:NC[4]:LCINSOUT PC[4]:CO:LSINCOUT
END

CONF FADD4; COMB FDDT:VGB
IN  A[4] B[4] CI
OUT CO S[4]
ARC A[4]:S[4]:LSTHRU B[4]:S[4]:LSTHRU CI:CO:LCTHRU CI:S[4]:LCINSOUT
ARC A[4]:CO:LSINCOUT B[4]:CO:LSINCOUT
END

CONF AGEB4; COMB FDDT:VGB
IN  A[4] B[4] CI
OUT GE
ARC A[4]:GE:LSINCOUT B[4]:GE:LSINCOUT CI:GE:LCTHRU
END

CONF ANEB4; COMB FDDT:VGB
IN  A[4] B[4] CI
OUT NE
ARC A[4]:NE:LSINCOUT B[4]:NE:LSINCOUT CI:NE:LCTHRU
END


CONF DCE32X4; RAM:SYNC FDDT:VGB
IN  DI[4] CK WREN WPE[2] RAD[5] WAD[5]
OUT DO[4] QDO[4]
ARC DI[4]:DO[4]:LSTHRU RAD[5]:QDO[4]:LSTHRU
END

CONF LAT_SYN_KEEP_BUF; COMB FDDT:VGB
IN i
OUT o
ARC i:o:ZERODEL
END

CONF LAT_INPUT_KEEP_BUF; COMB FDDT:VGB
IN i
OUT o
ARC i:o:ZERODEL
END

CONF LAT_OUTPUT_KEEP_BUF; COMB FDDT:VGB
IN i
OUT o
ARC i:o:ZERODEL
END
