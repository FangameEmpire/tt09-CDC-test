library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        WIDTH           : integer := 8
    );
    port(
        en_i            : in     vl_logic;
        ctl_i           : in     vl_logic_vector(2 downto 0);
        A_i             : in     vl_logic_vector;
        B_i             : in     vl_logic_vector;
        C_o             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end alu;
