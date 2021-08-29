----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 12:29:52 AM
-- Design Name: 
-- Module Name: topuart_tb - Behavioral
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

entity topuart_tb is
--  Port ( );
end topuart_tb;

architecture Behavioral of topuart_tb is
component topuart is
port(
TXD,clk:in std_logic;
btn:in std_logic_vector(1 downto 0);
ready: inout std_logic;
RXD,CTS,RTS: out std_logic
);
end component;
begin


end Behavioral;
