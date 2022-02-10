--
-- This version of the LPM_COMPONENTS package is specific to Synplify 
-- and should only be used for synthesis.
-- Copyright (c) 1998, Synplicity, Inc. All rights reserved
--
-- $Header: //synplicity/comp2018q2p1/compilers/vhdl/vhd/lpm.vhd#1 $
--

library ieee;
use ieee.std_logic_1164.all;
library synplify;
use synplify.attributes.all;

package LPM_COMPONENTS is

attribute syn_black_box of LPM_COMPONENTS : package is true;

type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

----------------Gates--------------------------------------------------

COMPONENT altcdr_rx
	generic (
		number_of_channels     : positive := 1;
		deserialization_factor : positive := 1;
		inclock_period         : positive;
		run_length             : integer := 43;
		inclock_boost          : positive := 1;
		lpm_type               : string := "altcdr_rx";
		intended_device_family : string := "MERCURY");
	port (
		rx_in : in std_logic_vector(number_of_channels-1 downto 0);
		rx_inclock : in std_logic;
		rx_coreclock : in std_logic;
		rx_fifo_rden : in std_logic_vector(number_of_channels-1 downto 0);
		rx_aclr : in std_logic;
		rx_pll_aclr : in std_logic;
		rx_out : out std_logic_vector(deserialization_factor*number_of_channels-1 downto 0);
		rx_outclock : out std_logic;
		rx_locklost : out std_logic_vector(number_of_channels-1 downto 0);
		rx_pll_locked : out std_logic;
		rx_empty : out std_logic_vector(number_of_channels-1 downto 0);
		rx_full : out std_logic_vector(number_of_channels-1 downto 0);
		rx_rlv : out std_logic_vector(number_of_channels-1 downto 0));
END COMPONENT;
attribute syn_black_box of altcdr_rx : component is true;

COMPONENT altcdr_tx
	generic (
		number_of_channels: positive := 1;
		deserialization_factor : positive := 1;
		inclock_period : positive;
		inclock_boost : positive := 1;
		lpm_type : string := "altcrd_tx";
		intended_device_family : string := "MERCURY");
	port (
		tx_in : in std_logic_vector(deserialization_factor*number_of_channels-1 downto 0);
		tx_inclock : in std_logic;
		tx_coreclock : in std_logic;
		tx_fifo_wren : in std_logic_vector(number_of_channels-1 downto 0);
		tx_aclr : in std_logic;
		tx_pll_aclr : in std_logic;
		tx_out : out std_logic_vector(number_of_channels-1 downto 0);
		tx_outclock : out std_logic;
		tx_pll_locked : out std_logic;
		tx_empty : out std_logic_vector(number_of_channels-1 downto 0);
		tx_full : out std_logic_vector(number_of_channels-1 downto 0));
end COMPONENT;
attribute syn_black_box of altcdr_tx : component is true;

COMPONENT altddio_bidir
	generic(
		width : positive := 1;
		lpm_type : string := "altddio_bidir";
		intended_device_family : string := "MERCURY";
		power_up_high : string := "OFF");
	port (
		datain_H : in std_logic_vector(width-1 downto 0);
		datain_L : in std_logic_vector(width-1 downto 0);
		inclock : in std_logic;
		inclocken : in std_logic := '1';
		outclock : in std_logic;
		outclocken : in std_logic := '1';
		aset : in std_logic := '0';
		aclr : in std_logic := '0';
		oe : in std_logic;
		dataout_H : out std_logic_vector(width-1 downto 0);
		dataout_L : out std_logic_vector(width-1 downto 0);
		padout : inout std_logic_vector(width-1 downto 0));
END COMPONENT;
attribute syn_black_box of altddio_bidir : component is true;
attribute black_box_tri_pins of altddio_bidir : component is "padout";

COMPONENT altddio_bidir
	generic (
		width : positive := 1;
		intended_device_family : string := "MERCURY";
		lpm_type : string := "altddio_in";
		power_up_high : string := "OFF");
	port (
		datain : in std_logic_vector(width-1 downto 0);
		inclock : in std_logic;
		inclocken : in std_logic := '1';
		aset : in std_logic := '0';
		aclr : in std_logic := '0';
		dataout_H : out std_logic_vector(width-1 downto 0);
		dataout_L : out std_logic_vector(width-1 downto 0));
END COMPONENT;
attribute syn_black_box of altddio_bidir : component is true;

COMPONENT altddio_out
	generic (width : positive := 1;
		intended_device_family : string := "MERCURY";
		lpm_type : string := "altddio_out";
		power_up_high : string := "OFF");
	port (
		datain_H : in std_logic_vector(width-1 downto 0);
		datain_L : in std_logic_vector(width-1 downto 0);
		outclock : in std_logic;
		outclocken : in std_logic := '1';
		aset : in std_logic := '0';
		aclr : in std_logic := '0';
		oe : in std_logic;
		dataout : out std_logic_vector(width-1 downto 0));
END COMPONENT;
attribute syn_black_box of altddio_out : component is true;

COMPONENT altlvds_rx
    generic (
		number_of_channels     : natural;
		deserialization_factor : natural;
		inclock_boost	       : natural := 0;
		registered_output      : string := "ON";
		inclock_period         : natural;
		clock_setting          : string := "UNUSED";
		lpm_type               : string := "altlvds_rx";
		intended_device_family : string := "APEX20KE");
    port (
		rx_in           : in std_logic_vector(number_of_channels-1 downto 0);
		rx_inclock      : in std_logic;
		rx_deskew       : in std_logic := '0';
		rx_pll_enable   : in std_logic := '1';
		rx_out          : out std_logic_vector(deserialization_factor*number_of_channels -1 downto 0);
		rx_outclock     : out std_logic;
		rx_locked       : out std_logic );
END COMPONENT;
attribute syn_black_box of altlvds_rx : component is true;

COMPONENT altlvds_tx
    generic (
		number_of_channels     : natural;
		deserialization_factor : natural;
		inclock_boost 	       : natural := 0;
		outclock_divide_by     : natural := 0;
		registered_input       : string := "ON";
		multi_clock            : string := "OFF";
		inclock_period         : natural;
		clock_setting          : string := "UNUSED";
		pe                     : string := "altlvds_tx";
		intended_device_family : string := "APEX20KE");
    port (
		tx_in           : in std_logic_vector(deserialization_factor*number_of_channels -1 downto 0);
		tx_inclock      : in std_logic;
		sync_inclock    : in std_logic := '0';
		tx_pll_enable   : in std_logic := '1';
		tx_out          : out std_logic_vector(number_of_channels-1 downto 0);
		tx_outclock     : out std_logic;
		tx_coreclock    : out std_logic;
		tx_locked       : out std_logic );
END COMPONENT;
attribute syn_black_box of altlvds_tx : component is true;

component LPM_CONSTANT
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_CVALUE : natural;
		LPM_STRENGTH : string := "UNUSED";
		LPM_TYPE : string := "LPM_CONSTANT";
		LPM_HINT : string := "UNUSED");
	port (
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_CONSTANT : component is true;

component LPM_INV
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_TYPE : string := "LPM_INV";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_INV : component is true;

component LPM_AND
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_SIZE : natural;    -- MUST be greater than 0
		LPM_TYPE : string := "LPM_AND";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0); 
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0)); 
end component; 
attribute syn_black_box of LPM_AND : component is true;
 
component LPM_OR 
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0 
		LPM_SIZE : natural;    -- MUST be greater than 0 
		LPM_TYPE : string := "LPM_OR";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0); 
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0)); 
end component; 
attribute syn_black_box of LPM_OR : component is true;

component LPM_XOR 
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0 
		LPM_SIZE : natural;    -- MUST be greater than 0 
		LPM_TYPE : string := "LPM_XOR";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0); 
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0)); 
end component; 
attribute syn_black_box of LPM_XOR : component is true;
 
component LPM_BUSTRI 
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_TYPE : string := "LPM_BUSTRI";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		ENABLEDT : in std_logic := '0';
		ENABLETR : in std_logic := '0';
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
		TRIDATA : inout std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_BUSTRI : component is true;
attribute black_box_tri_pins of LPM_BUSTRI : component is "TRIDATA";

component LPM_MUX 
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0 
		LPM_SIZE : natural;    -- MUST be greater than 0 
		LPM_WIDTHS : natural;    -- MUST be greater than 0 
		LPM_PIPELINE : natural := 0;
		LPM_TYPE : string := "LPM_MUX";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
		ACLR : in std_logic := '0';
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		SEL : in std_logic_vector(LPM_WIDTHS-1 downto 0); 
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_MUX : component is true;

component LPM_DECODE
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_DECODES : natural;    -- MUST be greater than 0
		LPM_PIPELINE : natural := 0;
		LPM_TYPE : string := "LPM_DECODE";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		ACLR : in std_logic := '0';
		ENABLE : in std_logic := '1';
		EQ : out std_logic_vector(LPM_DECODES-1 downto 0));
end component;
attribute syn_black_box of LPM_DECODE : component is true;

component LPM_CLSHIFT
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHDIST : natural;    -- MUST be greater than 0
		LPM_SHIFTTYPE : string := "LOGICAL";
		LPM_TYPE : string := "LPM_CLSHIFT";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0); 
		DISTANCE : in STD_LOGIC_VECTOR(LPM_WIDTHDIST-1 downto 0); 
		DIRECTION : in STD_LOGIC := '0';
		RESULT : out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
		UNDERFLOW : out STD_LOGIC;
		OVERFLOW : out STD_LOGIC);
end component;
attribute syn_black_box of LPM_CLSHIFT : component is true;


----------------Arithmetic Components------------------------------------

component LPM_ADD_SUB
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_DIRECTION : string := "UNUSED";
		LPM_REPRESENTATION: string := "SIGNED";
		LPM_PIPELINE : natural := 0;
		LPM_TYPE : string := "LPM_ADD_SUB";
		LPM_HINT : string := "UNUSED");
	port (
		DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
		ACLR : in std_logic := '0';
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		CIN : in std_logic := 'Z';
		ADD_SUB : in std_logic := '1';
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
		COUT : out std_logic;
		OVERFLOW : out std_logic);
end component;
attribute syn_black_box of LPM_ADD_SUB : component is true;

component LPM_COMPARE
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_REPRESENTATION : string := "UNSIGNED";
		LPM_PIPELINE : natural := 0;
		LPM_TYPE: string := "LPM_COMPARE";
		LPM_HINT : string := "UNUSED");
	port (
		DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
		ACLR : in std_logic := '0';
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		AGB : out std_logic;
		AGEB : out std_logic;
		AEB : out std_logic;
		ANEB : out std_logic;
		ALB : out std_logic;
		ALEB : out std_logic);
end component;
attribute syn_black_box of LPM_COMPARE : component is true;

component LPM_MULT
	generic (
		LPM_WIDTHA : natural;    -- MUST be greater than 0
		LPM_WIDTHB : natural;    -- MUST be greater than 0
		LPM_WIDTHS : natural := 0;
		LPM_WIDTHP : natural;    -- MUST be greater than 0
		LPM_REPRESENTATION : string := "UNSIGNED";
		LPM_PIPELINE : natural := 0;
		LPM_TYPE : string := "LPM_MULT";
		LPM_HINT : string := "UNUSED";
		INPUT_A_IS_CONSTANT : string := "NO";
		INPUT_B_IS_CONSTANT : string := "NO";
		USE_EAB : string := "OFF";
		MAXIMIZE_SPEED : integer := 5);
	port (
		DATAA : in std_logic_vector(LPM_WIDTHA-1 downto 0);
		DATAB : in std_logic_vector(LPM_WIDTHB-1 downto 0);
		ACLR : in std_logic := '0';
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		SUM : in std_logic_vector(LPM_WIDTHS-1 downto 0) := (OTHERS => '0');
		RESULT : out std_logic_vector(LPM_WIDTHP-1 downto 0));
end component;
attribute syn_black_box of LPM_MULT : component is true;
	
component LPM_DIVIDE
	generic (
		LPM_WIDTHN : natural;    -- MUST be greater than 0
		LPM_WIDTHD : natural;    -- MUST be greater than 0
		LPM_NREPRESENTATION : string := "UNSIGNED";
		LPM_DREPRESENTATION : string := "UNSIGNED";
		LPM_REMAINDERPOSITIVE : string := "TRUE";
		LPM_PIPELINE : natural := 0;
		LPM_TYPE : string := "LPM_DIVIDE";
		LPM_HINT : string := "UNUSED");
	port (
		NUMER : in std_logic_vector(LPM_WIDTHN-1 downto 0);
		DENOM : in std_logic_vector(LPM_WIDTHD-1 downto 0);
		ACLR : in std_logic := '0';
		CLOCK : in std_logic := '0';
		CLKEN : in std_logic := '1';
		QUOTIENT : out std_logic_vector(LPM_WIDTHN-1 downto 0);
		REMAIN : out std_logic_vector(LPM_WIDTHD-1 downto 0));
end component;
attribute syn_black_box of LPM_DIVIDE : component is true;
				
component LPM_ABS
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_TYPE: string := "LPM_ABS";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
		OVERFLOW : out std_logic);
end component;
attribute syn_black_box of LPM_ABS : component is true;

component LPM_COUNTER
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_MODULUS : natural := 0;
		LPM_DIRECTION : string := "UNUSED";
		LPM_AVALUE : string := "UNUSED";
		LPM_SVALUE : string := "UNUSED";
		LPM_PVALUE : string := "UNUSED";
		LPM_TYPE: string := "LPM_COUNTER";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0):= (OTHERS => '0');
		CLOCK : in std_logic ;
		CLK_EN : in std_logic := '1';
		CNT_EN : in std_logic := '1';
		UPDOWN : in std_logic := '1';
		SLOAD : in std_logic := '0';
		SSET : in std_logic := '0';
		SCLR : in std_logic := '0';
		ALOAD : in std_logic := '0';
		ASET : in std_logic := '0';
		ACLR : in std_logic := '0';
		CIN : in std_logic := '1';
		COUT : out std_logic;
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_COUNTER : component is true;

----------------Storage Components------------------------------------

COMPONENT altcam_syn
    generic
      ( width:            natural := 1;
        widthad:          natural := 1;
        numwords:         natural := 1;
        lpm_file:         string := "UNUSED";
        lpm_filex:        string := "UNUSED";
        match_mode:       string := "MULTIPLE";
        output_reg:       string := "UNREGISTERED";
        output_aclr:      string := "ON";
        pattern_reg:      string := "INCLOCK";
        pattern_aclr:     string := "ON";
        wraddress_aclr:   string := "ON";
        wrx_reg:          string := "UNUSED";
        wrx_aclr:         string := "UNUSED";
        wrcontrol_aclr:   string := "ON";
        lpm_type:         string := "altcam";
        use_eab:          string := "ON" );
    port
      ( pattern:    in std_logic_vector(width-1 downto 0);
        wrx:        in std_logic_vector(width-1 downto 0) := (others => '0');
        wrxused:    in std_logic := '1';
        wrdelete:   in std_logic := '0';
        wraddress:  in std_logic_vector(widthad-1 downto 0) := (others => '0');
        wren:       in std_logic := '1';
        inclock:    in std_logic;
        inclocken:  in std_logic := '1';
        inaclr:     in std_logic := '0';
        mstart:     in std_logic := '0';
        mnext:      in std_logic := '0';
        outclock:   in std_logic := '0';
        outclocken: in std_logic := '1';
        outaclr:    in std_logic := '0';
        maddress:   out std_logic_vector(widthad-1 downto 0);
        mbits:      out std_logic_vector(numwords-1 downto 0);
        mfound:     out std_logic;
        mcount:     out std_logic_vector(widthad-1 downto 0);
        rdbusy:     out std_logic;
        wrbusy:     out std_logic );
END COMPONENT;  	    	   
attribute syn_black_box of altcam_syn : component is true;

COMPONENT altdpram
    generic
      ( width                  : natural;
        widthad                : natural;
        numwords               : natural := 0;
        lpm_file               : string := "UNUSED";
        lpm_hint               : string := "USE_EAB=ON";
        indata_reg             : string := "UNREGISTERED";
        indata_aclr            : string := "OFF";
        wraddress_reg          : string := "UNREGISTERED";
        wraddress_aclr         : string := "OFF";
        wrcontrol_reg          : string := "UNREGISTERED";
        wrcontrol_aclr         : string := "OFF";
        rdaddress_reg          : string := "UNREGISTERED";
        rdaddress_aclr         : string := "OFF";
        rdcontrol_reg          : string := "UNREGISTERED";
        rdcontrol_aclr         : string := "OFF";
        outdata_reg            : string := "UNREGISTERED";
        outdata_aclr           : string := "OFF";
        lpm_type               : string := "altdpram";
        intended_device_family : string := "APEX20KE");
    port
      ( wren       : in std_logic := '0';
        data       : in std_logic_vector(width-1 downto 0);
        wraddress  : in std_logic_vector(widthad-1 downto 0);
        inclock    : in std_logic := '0';
        inclocken  : in std_logic := '1';
        rden       : in std_logic := '1';
        rdaddress  : in std_logic_vector(widthad-1 downto 0);
        outclock   : in std_logic := '0';
        outclocken : in std_logic := '1';
        aclr       : in std_logic := '0';
        q          : out std_logic_vector(width-1 downto 0) );
END COMPONENT;
attribute syn_black_box of altdpram : component is true;

component altqpram
    generic
      ( operation_mode            : string := "QUAD_PORT";

        width_write_a             : natural := 1;
        widthad_write_a           : natural := 1;
        numwords_write_a          : natural := 2;  -- default = 2^widthad_write_a
        indata_reg_a              : string := "INCLOCK_A";
        indata_aclr_a             : string := "INACLR_A";
        wrcontrol_wraddress_reg_a : string := "INCLOCK_A";
        wrcontrol_aclr_a          : string := "INACLR_A";
        wraddress_aclr_a          : string := "INACLR_A";

        width_write_b             : natural := 1;  -- default = width_write_a
        widthad_write_b           : natural := 1;  -- default = widthad_write_a
        numwords_write_b          : natural := 2;  -- default = 2^widthad_write_b
        indata_reg_b              : string := "INCLOCK_B";
        indata_aclr_b             : string := "INACLR_B";
        wrcontrol_wraddress_reg_b : string := "INCLOCK_B";
        wrcontrol_aclr_b          : string := "INACLR_B";
        wraddress_aclr_b          : string := "INACLR_B";

        width_read_a              : natural := 1;
        widthad_read_a            : natural := 1;
        numwords_read_a           : natural := 2;  -- default = 2^widthad_read_a
        rdcontrol_reg_a           : string := "OUTCLOCK_A";
        rdcontrol_aclr_a          : string := "OUTACLR_A";
        rdaddress_reg_a           : string := "OUTCLOCK_A";
        rdaddress_aclr_a          : string := "OUTACLR_A";
        outdata_reg_a             : string := "UNREGISTERED";
        outdata_aclr_a            : string := "OUTACLR_A";

        width_read_b              : natural := 1;  -- default = width_read_a
        widthad_read_b            : natural := 1;  -- default = widthad_read_a
        numwords_read_b           : natural := 2;  -- default = 2^widthad_read_b
        rdcontrol_reg_b           : string := "OUTCLOCK_B";
        rdcontrol_aclr_b          : string := "OUTACLR_B";
        rdaddress_reg_b           : string := "OUTCLOCK_B";
        rdaddress_aclr_b          : string := "OUTACLR_B";
        outdata_reg_b             : string := "UNREGISTERED";
        outdata_aclr_b            : string := "OUTACLR_B";

        init_file                 : string := "UNUSED";
        lpm_type                  : string := "altqpram";
        lpm_hint                  : string := "UNUSED" );

    port
      ( wren_a       : in std_logic := '0';
        wren_b       : in std_logic := '0';
        data_a       : in std_logic_vector(width_write_a-1 downto 0) := (OTHERS => '0');
        data_b       : in std_logic_vector(width_write_b-1 downto 0) := (OTHERS => '0');
        wraddress_a  : in std_logic_vector(widthad_write_a-1 downto 0) := (OTHERS => '0');
        wraddress_b  : in std_logic_vector(widthad_write_b-1 downto 0) := (OTHERS => '0');
        inclock_a    : in std_logic := '1';
        inclock_b    : in std_logic := '1';
        inclocken_a  : in std_logic := '1';
        inclocken_b  : in std_logic := '1';
        rden_a       : in std_logic := '1';
        rden_b       : in std_logic := '1';
        rdaddress_a  : in std_logic_vector(widthad_read_a-1 downto 0) := (OTHERS => '0');
        rdaddress_b  : in std_logic_vector(widthad_read_b-1 downto 0) := (OTHERS => '0');
        outclock_a   : in std_logic := '1';
        outclock_b   : in std_logic := '1';
        outclocken_a : in std_logic := '1';
        outclocken_b : in std_logic := '1';
        inaclr_a     : in std_logic := '0';
        inaclr_b     : in std_logic := '0';
        outaclr_a    : in std_logic := '0';
        outaclr_b    : in std_logic := '0';
        q_a          : out std_logic_vector(width_read_a-1 downto 0);
        q_b          : out std_logic_vector(width_read_b-1 downto 0) );
end component;
attribute syn_black_box of altqpram : component is true;

component csfifo
   generic (
        lpm_width    : positive;
        lpm_type     : string := "csfifo";
        lpm_numwords : positive);
   port (data: in std_logic_vector(lpm_width-1 downto 0);
        wreq, rreq, clock, clockx2, clr: in std_logic;
        empty, full: out std_logic;
        q: out std_logic_vector(lpm_width-1 downto 0));
end component;
attribute syn_black_box of csfifo : component is true;

component dcfifo
   generic (
        lpm_width           : positive;
        lpm_widthu          : positive;
        lpm_numwords        : positive;
        lpm_showahead       : string:= "off";
        overflow_checking   : string:= "on";
        underflow_checking  : string:= "on";
        delay_rdusedw       : positive:= 1;
        delay_wrusedw       : positive:= 1;
        rdsync_delaypipe    : positive:= 3;
        lpm_type            : string := "dcfifo";
        wrsync_delaypipe    : positive:= 3);
   port (data: in std_logic_vector(lpm_width-1 downto 0);
      rdclk, wrclk, wrreq, rdreq, aclr: in std_logic;
      rdfull,wrfull, wrempty, rdempty: out std_logic;
      q: out std_logic_vector(lpm_width-1 downto 0);
      rdusedw, wrusedw: out std_logic_vector(lpm_widthu-1 downto 0));
end component;
attribute syn_black_box of dcfifo : component is true;

COMPONENT scfifo
    generic
      ( lpm_width               : natural;
        lpm_widthu              : natural;
        lpm_numwords            : natural;
        lpm_showahead           : string := "OFF";
        lpm_hint                : string := "USE_EAB=ON";
        almost_full_value       : natural := 0;
        almost_empty_value      : natural := 0;
        overflow_checking       : string := "ON";
        underflow_checking      : string := "ON";
        allow_rwcycle_when_full : string := "OFF";
        lpm_type                : string := "scfifo";
        use_eab                 : string := "ON");
    port
      ( data         : in std_logic_vector(lpm_width-1 downto 0);
        clock        : in std_logic;
        wrreq        : in std_logic;
        rdreq        : in std_logic;
        aclr         : in std_logic := '0';
        sclr         : in std_logic := '0';
        full         : out std_logic;
        almost_full  : out std_logic;
        empty        : out std_logic;
        almost_empty : out std_logic;
        q            : out std_logic_vector(lpm_width-1 downto 0);
        usedw        : out std_logic_vector(lpm_widthu-1 downto 0)
     );
END COMPONENT;
attribute syn_black_box of scfifo : component is true;

component LPM_LATCH
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_AVALUE : string := "UNUSED";
		LPM_PVALUE : string := "UNUSED";
		LPM_TYPE: string := "LPM_LATCH";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0) := (OTHERS => '0');
		GATE : in std_logic;
		ASET : in std_logic := '0';
		ACLR : in std_logic := '0';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_LATCH : component is true;

component LPM_FF
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_AVALUE : string := "UNUSED";
		LPM_SVALUE : string := "UNUSED";
		LPM_PVALUE : string := "UNUSED";
		LPM_FFTYPE: string := "DFF";
		LPM_TYPE: string := "LPM_FF";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		CLOCK : in std_logic;
		ENABLE : in std_logic := '1';
		SLOAD : in std_logic := '0';
		SCLR : in std_logic := '0';
		SSET : in std_logic := '0';
		ALOAD : in std_logic := '0';
		ACLR : in std_logic := '0';
		ASET : in std_logic := '0';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_FF : component is true;

component LPM_SHIFTREG
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_AVALUE : string := "UNUSED";
		LPM_SVALUE : string := "UNUSED";
		LPM_PVALUE : string := "UNUSED";
		LPM_DIRECTION: string := "UNUSED";
		LPM_TYPE: string := "LPM_SHIFTREG";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0) := (OTHERS => '0');
		CLOCK : in std_logic;
		ENABLE : in std_logic := '1';
		SHIFTIN : in std_logic := '1';
		LOAD : in std_logic := '0';
		SCLR : in std_logic := '0';
		SSET : in std_logic := '0';
		ACLR : in std_logic := '0';
		ASET : in std_logic := '0';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
		SHIFTOUT : out std_logic);
end component;
attribute syn_black_box of LPM_SHIFTREG : component is true;

component LPM_RAM_DQ
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHAD : natural;    -- MUST be greater than 0
		LPM_NUMWORDS : natural := 999999;
		LPM_INDATA : string := "REGISTERED";
		LPM_ADDRESS_CONTROL: string := "REGISTERED";
		LPM_OUTDATA : string := "REGISTERED";
		LPM_FILE : string := "UNUSED";
		LPM_TYPE : string := "LPM_RAM_DQ";
		LPM_HINT : string := "UNUSED");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		ADDRESS : in std_logic_vector(LPM_WIDTHAD-1 downto 0);
		INCLOCK : in std_logic := '0';
		OUTCLOCK : in std_logic := '0';
		WE : in std_logic;
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_RAM_DQ : component is true;

component LPM_RAM_DP
	generic (
		LPM_WIDTH : natural := 2;    -- MUST be greater than 0
		LPM_WIDTHAD : natural := 2;    -- MUST be greater than 0
		LPM_NUMWORDS : natural := 999999;
		LPM_INDATA : string := "REGISTERED";
		LPM_OUTDATA : string := "REGISTERED";
		LPM_RDADDRESS_CONTROL : string := "REGISTERED";
		LPM_WRADDRESS_CONTROL : string := "REGISTERED";
		LPM_FILE : string := "UNUSED";
		LPM_TYPE : string := "LPM_RAM_DP";
		LPM_HINT : string := "UNUSED");
	port (
		RDCLOCK : in std_logic := '0';
		RDCLKEN : in std_logic := '1';
		RDADDRESS : in std_logic_vector(LPM_WIDTHad-1 downto 0);
		RDEN : in std_logic := '1';
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		WRADDRESS : in std_logic_vector(LPM_WIDTHad-1 downto 0);
		WREN : in std_logic;
		WRCLOCK : in std_logic := '0';
		WRCLKEN : in std_logic := '1';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_RAM_DP : component is true;

component LPM_RAM_IO
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHAD : natural;    -- MUST be greater than 0
		LPM_NUMWORDS : natural := 999999;
		LPM_INDATA : string := "REGISTERED";
		LPM_ADDRESS_CONTROL : string := "REGISTERED";
		LPM_OUTDATA : string := "REGISTERED";
		LPM_FILE : string := "UNUSED";
		LPM_TYPE : string := "LPM_RAM_IO";
		LPM_HINT : string := "UNUSED");
	port (
		ADDRESS : in STD_LOGIC_VECTOR(LPM_WIDTHAD-1 downto 0);
		INCLOCK : in STD_LOGIC := '0';
		OUTCLOCK : in STD_LOGIC := '0';
		MEMENAB : in STD_LOGIC := '1';
		OUTENAB : in STD_LOGIC := 'Z';
		WE : in STD_LOGIC := 'Z';
		DIO : inout STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_RAM_IO : component is true;
attribute black_box_tri_pins of LPM_RAM_IO : component is "DIO";

component LPM_ROM
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHAD : natural;    -- MUST be greater than 0
		LPM_NUMWORDS : natural := 999999;
		LPM_ADDRESS_CONTROL : string := "REGISTERED";
		LPM_OUTDATA : string := "REGISTERED";
		LPM_FILE : string;
		LPM_TYPE : string := "LPM_ROM";
		LPM_HINT : string := "UNUSED");
	port (
		ADDRESS : in STD_LOGIC_VECTOR(LPM_WIDTHAD-1 downto 0);
		INCLOCK : in STD_LOGIC := '0';
		OUTCLOCK : in STD_LOGIC := '0';
		MEMENAB : in STD_LOGIC := '1';
		Q : out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0));
end component;
attribute syn_black_box of LPM_ROM : component is true;

component LPM_FIFO
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHU : natural := 1;    -- MUST be greater than 0
		LPM_NUMWORDS : natural;    -- MUST be greater than 0
		LPM_SHOWAHEAD : string := "OFF";
		LPM_TYPE : string := "LPM_FIFO";
		LPM_HINT : string := "UNUSED";
		OVERFLOW_CHECKING: string := "ON";
		UNDERFLOW_CHECKING: string := "ON";
		ALLOW_RWCYCLE_WHEN_FULL : string := "OFF");
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		CLOCK : in std_logic;
		WRREQ : in std_logic;
		RDREQ : in std_logic;
		ACLR : in std_logic := '0';
		SCLR : in std_logic := '0';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
		USEDW : out std_logic_vector(LPM_WIDTHU-1 downto 0);
		FULL : out std_logic;
		EMPTY : out std_logic);
end component;
attribute syn_black_box of LPM_FIFO : component is true;

component LPM_FIFO_DC
	generic (
		LPM_WIDTH : natural;    -- MUST be greater than 0
		LPM_WIDTHU : natural := 1;    -- MUST be greater than 0
		LPM_NUMWORDS : natural;    -- MUST be greater than 0
		LPM_SHOWAHEAD : string := "OFF";
		LPM_TYPE : string := "LPM_FIFO_DC";
		LPM_HINT : string := "UNUSED";
		OVERFLOW_CHECKING: STRING := "ON";
		UNDERFLOW_CHECKING: STRING := "ON";
		DELAY_RDUSEDW :POSITIVE := 1;
		DELAY_WRUSEDW : POSITIVE := 1;
		RDSYNC_DELAYPIPE : POSITIVE := 3;
		WRSYNC_DELAYPIPE : POSITIVE := 3);
	port (
		DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
		WRCLOCK : in std_logic;
		RDCLOCK : in std_logic;
		WRREQ : in std_logic;
		RDREQ : in std_logic;
		ACLR : in std_logic := '0';
		Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
		WRUSEDW : out std_logic_vector(LPM_WIDTHU-1 downto 0);
		RDUSEDW : out std_logic_vector(LPM_WIDTHU-1 downto 0);
		WRFULL : out std_logic;
		RDFULL : out std_logic;
		WREMPTY : out std_logic;
		RDEMPTY : out std_logic);
end component;
attribute syn_black_box of LPM_FIFO_DC : component is true;

----------------Other Functions------------------------------------

-- altclklock_syn does not suporot clock2 & clock_ext ports

COMPONENT altclklock_syn
   GENERIC 
     (INCLOCK_PERIOD: NATURAL;
      INCLOCK_SETTINGS: STRING := "UNUSED";
      VALID_LOCK_CYCLES: NATURAL := 3;
      INVALID_LOCK_CYCLES: NATURAL := 3;
      VALID_LOCK_MULTIPLIER: NATURAL := 1;
      INVALID_LOCK_MULTIPLIER: NATURAL := 1;
      OPERATION_MODE: STRING := "NORMAL";
      CLOCK0_BOOST: NATURAL := 1;
      CLOCK0_DIVIDE: NATURAL := 1;
      CLOCK1_BOOST: NATURAL := 1;
      CLOCK1_DIVIDE: NATURAL := 1;
      CLOCK0_SETTINGS: STRING := "UNUSED";
      CLOCK1_SETTINGS: STRING := "UNUSED";
      OUTCLOCK_PHASE_SHIFT: NATURAL := 0;
      LPM_TYPE : STRING:= "ALTCLKLOCK");

   PORT
     (inclock: IN STD_LOGIC;
      inclocken: IN STD_LOGIC;
      fbin : IN STD_LOGIC := '0';
      clock0: OUT STD_LOGIC;
      clock1: OUT STD_LOGIC;
      locked : OUT STD_LOGIC);
END COMPONENT;	 	  

attribute syn_black_box of altclklock_syn : component is true;


-- altclklock supports all ports

COMPONENT altclklock
    generic
      ( inclock_period          : natural := 10000;
        inclock_settings        : string := "UNUSED";
        valid_lock_cycles       : natural := 5;
        invalid_lock_cycles     : natural := 5;
        valid_lock_multiplier   : natural := 1;
        invalid_lock_multiplier : natural := 1;
        operation_mode          : string := "NORMAL";
        clock0_boost            : natural := 1;
        clock0_divide           : natural := 1;
        clock1_boost            : natural := 1;
        clock1_divide           : natural := 1;
        clock2_boost            : natural := 1;
        clock2_divide           : natural := 1;
        clock_ext_boost         : natural := 1;
        clock_ext_divide        : natural := 1;
        clock0_settings         : string := "UNUSED";
        clock1_settings         : string := "UNUSED";
        clock2_settings         : string := "UNUSED";
        clock_ext_settings      : string := "UNUSED";
        outclock_phase_shift    : natural := 0;
        clock0_time_delay       : string := "0";
        clock1_time_delay       : string := "0";
        clock2_time_delay       : string := "0";
        clock_ext_time_delay    : string := "0";
        lpm_type                : string := "altclklock";
        intended_device_family  : string := "MERCURY" );
    port
      ( inclock   : in std_logic;
        inclocken : in std_logic := '1';
        fbin      : in std_logic := '1';
        clock0    : out std_logic;
        clock1    : out std_logic;
        clock2    : out std_logic;
        clock_ext : out std_logic;
        locked    : out std_logic );
END COMPONENT;
attribute syn_black_box of altclklock : component is true;

end package LPM_COMPONENTS;
