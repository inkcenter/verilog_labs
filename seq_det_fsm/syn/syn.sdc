# Create clock object and set uncertainty
create_clock -period 2 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks clk]
# Set constraints on input ports
set_input_delay 0.2 -max -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 0.2 -max -clock clk [all_outputs]

#set for pure combinational logic
set_max_delay 2 -from [all_inputs] -to [all_outputs]
