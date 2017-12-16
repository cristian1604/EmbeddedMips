----------------------------------------------------------------------------------
-- Company: 
-- Engineer:  Cristian Bottazzi
-- 
-- Create Date:    18:22:54 11/19/2017 
-- Design Name: 
-- Module Name:    AddressDecoder - Behavioral 
-- Project Name:   Embedded System Calculator
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

entity AddressDecoder is
    Port ( we : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR (31 downto 0);
           wuart : out  STD_LOGIC;
           ruart : out  STD_LOGIC;
           selectIn : out  STD_LOGIC_VECTOR (1 downto 0));
end AddressDecoder;

architecture Behavioral of AddressDecoder is

begin
	process(a,we)
		begin
			if(we='1') then
				selectIn<="00";
				wuart<='0';
				ruart<='0';
				if(a=x"ffffff15") then --Escribe en la Uart
					wuart<='1';
				end if;
			else 
				wuart<='0';
				ruart<='0';
				selectIn<="00";
				if(a=x"ffffff15") then --Lee lo que esta en la uart
					ruart<='1';
					selectIn<="01";
				elsif (a=x"ffffff16") then
						selectIn<="10";-- empty
						ruart<='0';
				elsif (a=x"ffffff17") then
						selectIn<="11";
						ruart<='0';
				end if;
			end if;
		end process;
end Behavioral;

