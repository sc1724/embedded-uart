----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 11:28:49 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
    Port (
    clk , en , send , rst : in std_logic ;
    char : in std_logic_vector (7 downto 0);
    ready , tx : out std_logic
);
end uart_tx;

architecture fsm of uart_tx is
    type state is (idle, start, data);
    signal curr : state := idle;
    signal d : std_logic_vector (7 downto 0) := (others => '0');
    signal count : std_logic_vector(2 downto 0) := (others => '0');
begin
process(clk) begin
if rising_edge(clk)then

    if rst='1' then
        curr<=idle;
        d<=(others=>'0');
        count<=(others=>'0');
        ready<='1';
    elsif en='1' then
        case curr is
            when idle=>
                ready<='1';
                if send <= '1' then
                    ready<='0';
                    d<=char(7 downto 0);
                    tx<=char(0);
                    curr<=start;
                end if;
            when start=>
                ready<='0';
                d<="00"&d(7 downto 2);
                tx<=d(1);
                count<=(others=>'0');
                curr<=data;                
            when data=>
                if unsigned(count)<7 then
                    d<='0'&d(7 downto 1);
                    tx<=d(0);
                    ready<='0';
                    count<=std_logic_vector(unsigned(count)+1);
                else
                    tx<='0';
                    ready<='1';
                    curr<=idle;
                end if;
           when others=>
            curr<=idle;
    end case;
   end if;                 
end if;
end process;
end fsm;
