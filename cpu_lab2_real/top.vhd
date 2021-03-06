--VHDL program that implement a counter with Bound.
--Bound starts from zero and increase every time counter reach bound.
--Bound reset every time he reaches upperBound.
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
	signal counter,bound :std_logic_vector(n-1 downto 0);--:=(others=>'0');
	signal enable_inc,delay_bound : std_logic; -- enable increment of bound,delay increment of bound.
begin
	--------------------------------------------------------------
    proc1 : process(clk,rst)
    begin
        if (rst ='1') then
            counter <=(others =>'0');
            enable_inc <='0';
        elsif (clk'event and clk='1') then -- rising edge
            if (counter >= bound) then
                counter <= (others => '0');
                enable_inc <='1';
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
            delay_bound <= '0';
        elsif (clk'event and clk='0') then -- falling edge
            if (counter=upperBound) then
                --enable_inc <='0';
                bound <=(others=>'0'); -- reset bound
                delay_bound<='1'; -- delay one cycle for bound =0
            elsif (delay_bound ='1') then -- delay bound's increment if bound is reset
                delay_bound <='0';
            elsif (enable_inc='1')and(counter = 0) then
                bound <= bound+1;
            end if; 
        end if;
    end process;
	--------------------------------------------------------------
	countOut <= counter;
end arc_sys;