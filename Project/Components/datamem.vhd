library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity datamem is
	port (
		clock : in std_logic;
		write_enable : in std_logic;
		address : in std_logic_vector(15 downto 0);
		input_data : in std_logic_vector(7 downto 0);
		output_data : out std_logic_vector(7 downto 0)
	);
end datamem;
architecture behavioural of datamem is
	type ram_type is array (65536 downto 0) of std_logic_vector (7 downto 0);
	signal RAM : ram_type;
	type debug_type is array (1023 downto 0) of std_logic_vector(7 downto 0);
    signal debug_RAM_top1024, debug_RAM_bottom1024: debug_type;
begin
	process (clock, write_enable)
	begin
		if falling_edge(clock) and write_enable = '1' then
			RAM(conv_integer(address)) <= input_data;
		end if;
	end process;
	output_data <= RAM(conv_integer(address));
    debug_RAM_top1024 <= debug_type(RAM(65536 downto 64512));
    debug_RAM_bottom1024 <= debug_type(RAM(1023 downto 0));
end behavioural;