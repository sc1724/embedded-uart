----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2021 03:36:52 PM
-- Design Name: 
-- Module Name: debounce_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_tb is
--  Port ( );
end debounce_tb;

architecture testbench of debounce_tb is
signal tb_clk: std_logic := '0';
signal tb_btn: std_logic := '0';
signal tb_dbnc: std_logic := '0';
component debounce is
port(
clk: in std_logic;
btn:in std_logic;
dbnc:out std_logic
);
end component;
begin
clk_gen_proc: process
    begin
    
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
end process clk_gen_proc;
btn: process
    begin
    wait for 50ms;
    tb_btn<='1';
    wait for 60ms;
    tb_btn<='0';
end process btn;
dut: debounce
port map(
clk=>tb_clk,
btn=>tb_btn,
dbnc=>tb_dbnc
);
end testbench;
