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
    --signal restart:std_logic;
	signal counter,bound :std_logic_vector(n-1 downto 0);--:=(others=>'0');
	signal increment : std_logic;
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
	begin
		if (rst ='1') then
            counter <=(others =>'0'); 
        elsif (clk'event and clk='1') then
            if (counter >= bound) then
                counter <= (others => '0');
                increment <='1';
            elsif (counter< bound) then
				counter <= counter +1;
            end if;
        end if;
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)  
begin
        if (rst ='1') then
            bound <=(others =>'0');
        elsif (clk'event and clk='0') then
            if (bound>upperBound) then
                bound <=(others=>'0');
                elsif (increment='1')and(counter = "00000000") then
                bound <= bound+1;
            end if; 
        end if;
	end process;
	--------------------------------------------------------------
	countOut <= counter;
	
	
	
	
end arc_sys;