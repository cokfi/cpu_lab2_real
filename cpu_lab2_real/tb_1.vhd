-- tb_1: VHDL program that test the counter with bound module with regard to changing upperBound over time
--  This program is designated for modelsim  
library IEEE;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    use work.aux_package.all;
---------------------------------------------------------
entity tb_1 is
    constant n : integer := 8;
    constant m : integer := 3; -- m = log(n)
end tb_1;
---------------------------------------------------------
architecture rtb of tb_1 is
    signal rst,clk : std_logic;
    signal upperBound : std_logic_vector(n-1 downto 0);
    signal countOut : std_logic_vector(n-1 downto 0);
begin
    L0 : top generic map (n) port map(rst,clk,upperBound,countOut);

    --------- start of stimulus section ------------------    
    gen_clk : process -- clock's process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= not clk;
        wait for 50 ns;
    end process;
    upper_bound_game : process -- increasing and decreasing bound
    begin
        upperBound <= (1 =>'1', others =>'0');
        for i in 0 to m-1 loop 
            wait for 1200 ns;
        upperBound <= upperBound +2;
    end loop;
        for i in 0 to m-1 loop 
            wait for 1200 ns;
            upperBound <= upperBound -2;
            end loop;
        wait;
    end process;

    gen_rst : process -- reset
    begin
        rst <='1','0' after 100 ns;
        wait;
    end process; 

end architecture rtb;