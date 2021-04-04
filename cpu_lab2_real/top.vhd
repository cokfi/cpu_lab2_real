LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 8 ); 
	port( rst,clk : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
end top;
------------------------------------------------------------------
architecture arc_sys of top is
    signal counter:std_logic_vector(n-1 downto 0);
    signal restart:std_logic;
	
	
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
	begin
		if (rst ='1') then
            counter <=(others =>'0'); 
        elsif (clk'event and clk='1') then
            if (restart = '0') then 
                counter <= (others => '0');
                restart <= '1';
            else 
				counter <= counter +1;
            end if;
        end if;
        countOut<= counter;
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)
        variable bound :std_logic_vector(n-1 downto 0);
	begin
        bound :=(others=>'0');
        if (clk'event and clk='0') then
            if (counter = bound) then
				bound := bound+1;
				if (bound >upperBound) then
					bound := (others=>'0');
                    restart <='0';
                end if;
            end if; 
        end if;
	end process;
	--------------------------------------------------------------
	
	
	
	
	
end arc_sys;