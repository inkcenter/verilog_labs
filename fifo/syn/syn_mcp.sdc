# Create clock object and set uncertainty
# constraints for read clock domain
create_clock -period 4 [get_ports $myClkA]
set_clock_uncertainty 0.4 [get_clocks $myClkA]
# constraints for write clock domain
create_clock -period 14 [get_ports $myClkB]
set_clock_uncertainty 0.5 [get_clocks $myClkB]

# Set constraints on input ports
set_input_delay 0.2 -max -clock $myClkA [remove_from_collection [all_inputs] [get_ports [list $myClkA $myClkB]]]
set_output_delay 0.2 -max -clock $myClkA [all_outputs]

#set for pure combinational logic
set_max_delay 4 -from [all_inputs] -to [all_outputs]
