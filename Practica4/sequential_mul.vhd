library ieee;
use ieee.std_logic_1164.all;

entity sequential_mul is

    port(
       rst:             in  std_logic;   
       clk:             in  std_logic;   
       inicio:          in  std_logic;  
       a_in:            in  std_logic_vector(3 downto 0);   
       b_in:            in  std_logic_vector(3 downto 0);    
       display:         out std_logic_vector(6 downto 0);
       display_enable:  out std_logic_vector(3 downto 0); 
       done:            out std_logic   
       );

end sequential_mul;

architecture bh of sequential_mul is

    signal control_signal: std_logic_vector(4 downto 0); 
    signal estado_signal: std_logic_vector(1 downto 0); 

    component rutaDatos is 
        port(
            rst:            in std_logic; 
            clk:            in std_logic;
            a_in:           in std_logic_vector(3 downto 0); 
            b_in:           in std_logic_vector(3 downto 0);
            control:        in std_logic_vector(4 downto 0); 
            display:        out std_logic_vector(6 downto 0);
            display_enable: out std_logic_vector(3 downto 0); 
            estado:         out std_logic_vector(1 downto 0)

        ); 
    end component;

    component unidadControl is 
        port(
            rst:            in std_logic;
            clk:            in std_logic;
            inicio:         in std_logic;
            estado:         in std_logic_vector(1 downto 0); 
            control:        out std_logic_vector(4 downto 0); 
            fin:            out std_logic
        ); 
    end component;

begin

    controlador: unidadControl port map(
        rst => rst,   
        clk =>  clk,
        inicio => inicio,
        estado => estado_signal,
        control => control_signal,
        fin => done

    );

    rd: rutaDatos port map(
        rst => rst,
        clk => clk,
        a_in => a_in,
        b_in => b_in,
        control => control_signal,
        display => display, 
        display_enable => display_enable 
        estado => estado_signal
    );


end bh;