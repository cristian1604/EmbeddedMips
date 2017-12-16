----------------------------------------------------------------------------------
-- Create Date:    18:44:25 11/19/2017 
-- Design Name: 
-- Module Name:    TOP - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Bottazzi, Cristian - 2017 (https://github.com/cristian1604/)

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SistIntegrado is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           tx : out  STD_LOGIC);
end SistIntegrado;

architecture Behavioral of SistIntegrado is

---- el mips
COMPONENT MIPS
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		readdata : IN std_logic_vector(31 downto 0);          
		MemWrite : OUT std_logic;
		WriteData : OUT std_logic_vector(31 downto 0);
		address : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
--- el deco d direcciones
COMPONENT AddressDecoder
	PORT(
		we : IN std_logic;
		a : IN std_logic_vector(31 downto 0);          
		wuart : OUT std_logic;
		ruart : OUT std_logic;
		selectIn : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
----- la uart
COMPONENT uart
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		rd_uart : IN std_logic;
		wr_uart : IN std_logic;
		rx : IN std_logic;
		w_data : IN std_logic_vector(7 downto 0);          
		tx_full : OUT std_logic;
		rx_empty : OUT std_logic;
		r_data : OUT std_logic_vector(7 downto 0);
		tx : OUT std_logic
		);
	END COMPONENT;
--- el mux de datos de entrada
COMPONENT Mux3a1
	PORT(
		selectIn : IN std_logic_vector(1 downto 0);
		fullUart : IN std_logic;
		emptyUart : IN std_logic;
		datoUart : IN std_logic_vector(7 downto 0);          
		datoOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
-- seales internas
-- de 32
signal SenalDataToMem,SenalWriteData,SenalAddressMem  : std_logic_vector(31 downto 0);
-- de 1
signal SenalMemWrite,Senalwuart,Senalruart,SenalEmpty,SenalFull: std_logic;
signal SenalselectIn: std_logic_vector(1 downto 0);
signal SenalDatoUart: std_logic_vector(7 downto 0);

begin
--- el mips
Inst_MIPS: MIPS PORT MAP(
		clk =>clk ,
		reset => reset,
		readdata =>SenalDataToMem ,
		MemWrite => SenalMemWrite,
		WriteData =>SenalWriteData  ,
		address =>SenalAddressMem 
	);
	
--- el deco d direcciones
Inst_AddressDecoder: AddressDecoder PORT MAP(
		we =>SenalMemWrite ,
		a => SenalAddressMem,
		wuart =>Senalwuart ,
		ruart =>Senalruart ,
		selectIn => SenalselectIn
	);
----- la uart
Inst_uart: uart PORT MAP(
		clk =>clk ,
		reset => reset,
		rd_uart => Senalruart,
		wr_uart =>Senalwuart ,
		rx =>rx ,
		w_data =>SenalWriteData(7 downto 0) ,
		tx_full =>SenalFull ,
		rx_empty =>SenalEmpty ,
		r_data =>SenalDatoUart ,
		tx => tx
	);
--- el mux de datos de entrada
Inst_Mux3a1: Mux3a1 PORT MAP(
		selectIn => SenalselectIn,
		fullUart =>SenalFull ,
		emptyUart => SenalEmpty,
		datoUart => SenalDatoUart,
		datoOut => SenalDataToMem
	);

end Behavioral;

