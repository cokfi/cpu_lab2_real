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
    --signal counter_reg:std_logic_vector(n-1 downto 0);
    signal restart:std_logic;
	signal counter,bound :std_logic_vector(n-1 downto 0);--:=(others=>'0');
	
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
        --variable counter :std_logic_vector(n-1 downto 0);--:=(others=>'0');
	begin
        --counter <=(others =>'0');
        --restart <='1';
		if (rst ='1') then
            counter <=(others =>'0'); 
            restart<= '1';
            bound<=(others =>'0'); 
        elsif (clk'event and clk='1') then
            if (restart = '1') then 
                counter <= (others => '0');
                restart<= '0';
            else 
				counter <= counter +1;
            end if;
        end if;
        --countOut<= counter;
        --counter_reg <=counter;
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)
        --variable bound :std_logic_vector(n-1 downto 0);--:=(others=>'0');
begin
        --if (rst ='1') then
            --bound <=(others =>'0');
            --restart<='1';
        if (clk'event and clk='0') then
            if (counter = bound) then
				bound <= bound+1;
                restart <='1';
				if (bound >=upperBound) then
                    bound <=(others=>'0'); 
                end if;
            end if; 
        end if;
	end process;
	--------------------------------------------------------------
	countOut <= counter;
	
	
	
	
end arc_sys;