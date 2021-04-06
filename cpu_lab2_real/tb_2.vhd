library IEEE;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    use work.aux_package.all;
---------------------------------------------------------
entity tb_2 is
    constant n : integer := 8;
end tb_2;

architecture rtl of tb_2 is
    signal rst,clk : std_logic;
    signal upperBound : std_logic_vector(n-1 downto 0);
    signal countOut : std_logic_vector(n-1 downto 0);
begin
    L0 : top generic map (n) port map(rst,clk,upperBound,countOut);

    --------- start of stimulus section ------------------    
    gen_clk : process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= not clk;
        wait for 50 ns;
    end process;
    upperBound <= (2=>'1',1=>'0',0=>'1',others=>'0');
    switch_rst : process
    begin
        rst <= '1';
        wait for 500 ns;
        rst <='0';
        wait for 500 ns;
    end process;
end rtl;