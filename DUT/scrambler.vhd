library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scrambler is
	generic (

		WIDTH : integer := 32;--for input and output data width
		WADDR : integer := 15 --for input and output data width

	);
	port (
		----------- Clocking and reset interface ---------------

		clk : in std_logic;
		reset : in std_logic;
		------------------ Input data interface -------------------
		a_addr_o : out std_logic_vector(WADDR - 1 downto 0);
		a_en_o : out std_logic;
		a_data_i : in std_logic_vector(WIDTH - 1 downto 0);

		b_addr_o : out std_logic_vector(WADDR - 1 downto 0);
		b_data_o : out std_logic_vector(WIDTH - 1 downto 0);
		b_wr_o : out std_logic;
		--------------------- Command interface --------------------

		start : in std_logic;

		--------------------- Status interface ---------------------

		ready : out std_logic
	);
end entity;
architecture Behavioral of scrambler is
	type state_type is (idle, s1, s1_a, s2, s3, s3_a, s4, s4_a, s4_b, s4_c, s4_d, s4_e, s4_g, s4_f, s5, s6, s6_a, s7, s7_a, s7_b, s7_c, s7_d, s7_g, s8, s8_a, s9, s9_a);

	signal state_reg, state_next : state_type;

	signal i_reg, i_next : integer := 0;
	signal n_reg, n_next : integer := 4;

	signal k_reg, k_next : integer := 1;

	signal data_reg, data_next : std_logic_vector(width - 1 downto 0) := (others => '0');
	signal a_addr_s_reg, a_addr_s_next : std_logic_vector(WADDR - 1 downto 0) := (others => '0');
	signal b_addr_s_reg, b_addr_s_next : std_logic_vector(WADDR - 1 downto 0) := (others => '0');
begin

	process (reset, clk)
	begin
		--reseting everything
		--reset for BRAM is on HIGH, on AXI is LOW!!!
		if reset = '1' then
			state_reg <= idle;
			i_reg <= 0;
			n_reg <= 0;

			k_reg <= 1;
			data_reg <= (others => '0');
			a_addr_s_reg <= (others => '0');
			b_addr_s_reg <= (others => '0');

		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
			i_reg <= i_next;
			n_reg <= n_next;

			k_reg <= k_next;

			data_reg <= data_next;
			a_addr_s_reg <= a_addr_s_next;
			b_addr_s_reg <= b_addr_s_next;
		end if;
	end process;

	--treba dodati konstante iz masine stanja u proces u listu osetljivosti(BLOCK_SIZE,CHANEL_BLOCK_SIZE ....itd)
	process (start, state_reg, a_data_i, n_reg, n_next, k_reg, k_next, data_reg, data_next, a_addr_s_reg, a_addr_s_next, b_addr_s_reg, b_addr_s_next, i_reg, i_next)

	begin
		--default assignments
		i_next <= i_reg;
		n_next <= n_reg;

		k_next <= k_reg;
		data_next <= data_reg;
		a_addr_s_next <= a_addr_s_reg;
		b_addr_s_next <= b_addr_s_reg;
		ready <= '0';
		a_en_o <= '0';
		b_wr_o <= '0';
		a_addr_o <= a_addr_s_reg;
		b_addr_o <= b_addr_s_reg;
		b_data_o <= data_reg;
		case state_reg is

			when idle =>
				ready <= '1';

				if start = '1' then -- start the IP core
					state_next <= s1_a;
				else
					state_next <= idle;
				end if;
			when s1_a =>
				i_next <= 0;
				n_next <= 4;
				state_next <= s1;
			when s1 =>
				i_next <= i_reg + 1;
				state_next <= s2;
			when s2 =>
				k_next <= 8192 - n_reg + i_reg;

				state_next <= s3;
			when s3 =>
				if i_reg mod 4 = 0 then
					n_next <= n_reg + 8;
					state_next <= s4;
				else
					state_next <= s4;

				end if;
			when s4 =>
				a_addr_s_next <= std_logic_vector(to_unsigned((i_reg - 1) * 4, 15));

				b_addr_s_next <= std_logic_vector(to_unsigned((k_reg - 1) * 4, 15));
				state_next <= s5;
			when s5 =>
				a_en_o <= '1';
				a_addr_o <= a_addr_s_next;
				state_next <= s6;
			when s6 =>
				a_en_o <= '0';
				data_next <= a_data_i;
				state_next <= s7;
				b_addr_o <= b_addr_s_next;
				state_next <= s8;
			when s8 =>
				b_wr_o <= '1';
				b_data_o <= data_next;
				state_next <= s9;
			when s9 =>
				if i_reg < 8192 then
					state_next <= s1;
				else
					state_next <= idle;
				end if;
			when others =>
				state_next <= idle;

		end case;
	end process;
end Behavioral;
