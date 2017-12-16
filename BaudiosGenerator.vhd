--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Bottazzi, Cristian - 2017 (https://github.com/cristian1604/)

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

 library IEEE;  
 use IEEE.STD_LOGIC_1164.ALL;  
 use IEEE.numeric_std.ALL;
 
 entity mod_m_counter is  
 generic (  
	 N: integer := 4; -- number o f b i t s  
	 M : integer := 10); -- m o d 4  
 port (  
	 clk, reset: in std_logic;  
	 max_tick: out std_logic;  
	 q: out std_logic_vector ( N - 1 downto 0)
	 --an: out std_logic_vector(3 downto 0);  
	 --sseg: out std_logic_vector ( 7 downto 0)  
	);  
 end mod_m_counter ;  
 
 architecture arch of mod_m_counter is
	 signal cath,off: std_logic ;  
	 signal r_reg : unsigned ( N - 1 downto 0 ) ;  
	 signal r_next : unsigned ( N - 1 downto 0 ) ;  
 begin  
	 --enabling the fir  
	 process (clk, reset)  
	 begin  
		 if (reset='1') then  
			r_reg <= ( others => '0' ) ;  
		 elsif (clk'event and clk='1') then  
			r_reg <= r_next;  
		 end if ;  
	 end process ;
	 --n e x t - s t a t e l o g i c  
	 r_next <= ( others => '0' ) when r_reg=(M-1) else  
	 r_reg + 1;  
	 -- o u t p u t l o g i c  
	 q <= std_logic_vector(r_reg);  
	 max_tick <= '1' when r_reg=(M-1) else '0';
 end arch;  
