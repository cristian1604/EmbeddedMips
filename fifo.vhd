library ieee;  
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
 
 
 entity fifo is  
 generic (  
	 B: natural:=8; -- number of b i t s  
	 W: natural:=4 -- number o f a d d r e s s b i t s  
 );  
 port (  
	 clk, reset: in std_logic;  
	 rd, wr: in std_logic;  
	 w_data: in std_logic_vector ( B - 1 downto 0) ;
	 empty, full : out std_logic;  
	 r_data: out std_logic_vector ( B - 1 downto 0 )
 );  
 end fifo;  
 
 
 architecture arch of fifo is  
 type reg_file_type is array (2**W-1 downto 0) of std_logic_vector ( B - 1 downto 0);
	 signal array_reg : reg_file_type;
	 signal w_ptr_reg , w_ptr_next , w_ptr_succ : std_logic_vector (W-1 downto 0 );
	 signal r_ptr_reg , r_ptr_next , r_ptr_succ:std_logic_vector ( W - 1 downto 0);
	 signal full_reg , empty_reg , full_next , empty_next :std_logic;  
	 signal wr_op: std_logic_vector (1 downto 0 );
	 signal wr_en : std_logic;
 begin  
 -- r e g is t e r f i l e  
	 process (clk, reset)  
	 begin  
	 if (reset='1' ) then  
	 array_reg <= ( others => ( others => '0' ) );
	 elsif (clk'event and clk='1') then  
	 if wr_en='1' then  
	 array_reg(to_integer(unsigned(w_ptr_reg)))  
	 <= w_data;  
	 end if;
	 end if;
	 end process;
	 -- r e a d p o r t  
	 r_data <= array_reg(to_integer(unsigned(r_ptr_reg)));  
	 --w r i t e e n a b l e d o n l y when FIFO is not f u l l  
	 wr_en <= wr and ( not full_reg);  
	 --  
	 -- f if o c o n t r o l l o g i c  
	 -- r e g is t e r f o r r e a d and w r i t e p o in t e r s  
	 process (clk , reset)  
	 begin  
	 if (reset='1') then  
		 w_ptr_reg <= ( others => '0' );
		 r_ptr_reg <= ( others => '0' );
		 full_reg <= '0';
		 empty_reg <= '1';
	 elsif(clk'event and clk='1') then  
		 w_ptr_reg <= w_ptr_next;
		 r_ptr_reg <= r_ptr_next;
		 full_reg <= full_next;  
		 empty_reg <= empty_next;
	 end if;
	 end process;
	 -- s u c c e s s i v e p o in t e r v a l u e s  
	 w_ptr_succ <= std_logic_vector (unsigned(w_ptr_reg)+1);
	 r_ptr_succ <= std_logic_vector(unsigned(r_ptr_reg)+1);  
	 -- n e x t - s t a t e logic f o r r e a d and w r i t e p o in t e r s  
	 wr_op <= wr & rd;  
	 process (w_ptr_reg, w_ptr_succ ,r_ptr_reg ,r_ptr_succ ,wr_op,empty_reg , full_reg)  
	 begin  
		 w_ptr_next <= w_ptr_reg;  
		 r_ptr_next <= r_ptr_reg;  
		 full_next <= full_reg;  
		 empty_next <= empty_reg;
		 case wr_op is  
			 when "00" => -- no op  
			 when "01" => -- r e a d  
			 if (empty_reg /= '1') then -- not e m p t y  
				 r_ptr_next <= r_ptr_succ;  
				 full_next <= '0';
				 if (r_ptr_succ=w_ptr_reg) then  
					empty_next <='1';  
				 end if;
			 end if;
			 when "10" => -- w r i t e  
			 if (full_reg /= '1' ) then -- if fifo not f u l l we write values  
				 w_ptr_next <= w_ptr_succ;  
				 empty_next <= '0';
				 if (w_ptr_succ=r_ptr_reg) then-- otherwise stop writing because is full, write pointer and read pointer point to the same place   
					full_next <='1';  
				 end if;
			 end if;
			 when others => -- w r i t e / r e a d;
			 w_ptr_next <= w_ptr_succ;
			 r_ptr_next <= r_ptr_succ;
		 end case;
	 end process;
 -- out p u t  
 full <= full_reg;  
 empty <= empty_reg;  
 end arch;