----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 05:11:40 PM
-- Design Name: 
-- Module Name: topuart - Behavioral
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

entity topuart is
    Port ( TXD : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (1 downto 0):=(others =>'0');
           clk : in STD_LOGIC;
           CTS : out STD_LOGIC;
           RTS : out STD_LOGIC;
           RXD : out STD_LOGIC);
           --ready : inout STD_LOGIC);
end topuart;

architecture structural of topuart is
signal dbnc0,dbnc1,div,send0,rdy0: std_logic;
signal char0: std_logic_vector(7 downto 0);
component debounce port
(
btn,clk: in std_logic;
dbnc: out std_logic
);
end component;
component clk_div port
(
clk: in std_logic;
div: out std_logic
);
end component;
component sender port
(
btn,clk,en,rdy,rst: in std_logic;
char: out std_logic_vector(7 downto 0);
send: out std_logic
);
end component;
component uart port
(
charSend:in std_logic_vector(7 downto 0);
clk,en,rst,rx,send: in std_logic;
ready,tx:out std_logic
);
end component;
begin
u1: debounce port map(
btn=>btn(0),
clk=>clk,
dbnc=>dbnc0
);
u2: debounce port map(
btn=>btn(1),
clk=>clk,
dbnc=>dbnc1
);
u3: clk_div port map(
clk=>clk,
div=>div
);
u4: sender port map(
btn=>dbnc1,
clk=>clk,
en=>div,
rdy=>rdy0,
rst=>dbnc0,
char=>char0,
send=>send0
);
u5: uart port map(
charSend=>char0,
clk=>clk,
en=>div,
rst=>dbnc0,
rx=>TXD,
send=>send0,
ready=>rdy0,
tx=>RXD
);
CTS<='0';
RTS<='0';
end structural;
