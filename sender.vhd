----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 04:40:56 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sender is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rdy : in STD_LOGIC;
           rst : in STD_LOGIC;
           char : out STD_LOGIC_VECTOR (7 downto 0);
           send : out STD_LOGIC);
end sender;

architecture Behavioral of sender is
    type store is array (0 to 5) of std_logic_vector(7 downto 0);
    signal NETID:store:=("01110011","01100011","00110001","00110111","00110010","00110100");
    signal i : std_logic_vector(3 downto 0) := (others => '0');
    type state is (idle, busyA, busyB, busyC);
    signal curr : state := idle;
begin
FSM:process(clk) begin
 if rising_edge(clk) then
       if rst = '1' then
           curr <= idle;
           char <= (others => '0');
           i <= (others => '0');
           send <= '0';
       elsif en = '1' then
           case curr is
               when idle =>
               if rdy='1'and btn='1'and unsigned(i)<6 then
               send<='1';
               char<=NETID(to_integer(unsigned(i)));
               i<=std_logic_vector(unsigned(i)+1);
               curr<=busyA;
               elsif rdy='1'and btn='1'and unsigned(i)=6 then
               i<=(others => '0');
               curr<=idle;
               end if;    
               when busyA =>
                  curr<=busyB;
               when busyB =>
               send<='0';
               curr<=busyC;
               when busyC =>
               if rdy='1' and btn='0' then
               curr<=idle;
               end if;
               when others =>
                curr <= idle;
               end case;
               end if;
               end if;
end process FSM;
end Behavioral;
