debImport "-gui"
verdiDockWidgetDisplay -dock widgetDock_WelcomePage
verdiDockWidgetHide -dock widgetDock_WelcomePage
nsMsgSwitchTab -tab general
debImport \
          "/qixin/proj_users/cary/training/soc_training_2018_0415/design_labs/ahb_slave/rtl/clac.v" \
          "/qixin/proj_users/cary/training/soc_training_2018_0415/design_labs/ahb_slave/rtl/ahb_slave.v" \
          "/qixin/proj_users/cary/training/soc_training_2018_0415/design_labs/ahb_slave/rtl/ahb_clac_top.v" \
          -path \
          {/qixin/proj_users/cary/training/soc_training_2018_0415/design_labs/ahb_slave/rtl}
verdiWindowResize -win Verdi_1 "197" "25" "901" "700"
verdiWindowResize -win Verdi_1 "197" "25" "914" "699"
verdiWindowResize -win Verdi_1 "197" "25" "972" "695"
verdiWindowResize -win Verdi_1 "197" "25" "1071" "689"
verdiWindowResize -win Verdi_1 "197" "25" "1148" "684"
verdiWindowResize -win Verdi_1 "197" "25" "1200" "675"
verdiWindowResize -win Verdi_1 "197" "25" "1229" "674"
verdiWindowResize -win Verdi_1 "197" "25" "1246" "674"
verdiWindowResize -win Verdi_1 "197" "25" "1279" "676"
verdiWindowResize -win Verdi_1 "197" "25" "1302" "679"
verdiWindowResize -win Verdi_1 "197" "25" "1308" "679"
verdiWindowResize -win Verdi_1 "197" "25" "1308" "680"
verdiWindowResize -win Verdi_1 "197" "25" "1310" "689"
verdiWindowResize -win Verdi_1 "197" "25" "1310" "702"
verdiWindowResize -win Verdi_1 "197" "25" "1310" "716"
verdiWindowResize -win Verdi_1 "197" "25" "1309" "724"
verdiWindowResize -win Verdi_1 "197" "25" "1307" "728"
verdiWindowResize -win Verdi_1 "197" "25" "1306" "731"
verdiWindowResize -win Verdi_1 "197" "25" "1305" "731"
schCreateWindow -delim "." -win $_nSchema1 -scope "ahb_clac_top"
srcHBSelect "ahb_clac_top" -win $_nTrace1
srcSetScope -win $_nTrace1 "ahb_clac_top" -delim "."
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {4 19 1 1 24 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -inst "U_clac" -win $_nTrace1
srcAction -pos 65 2 1 -win $_nTrace1 -name "U_clac" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clac_mode" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clac_mode" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {21 25 2 1 2 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {17 29 1 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "result" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcHBSelect "ahb_clac_top.U_slave_if" -win $_nTrace1
srcSetScope -win $_nTrace1 "ahb_clac_top.U_slave_if" -delim "."
srcHBSelect "ahb_clac_top.U_clac" -win $_nTrace1
srcSetScope -win $_nTrace1 "ahb_clac_top.U_clac" -delim "."
srcDeselectAll -win $_nTrace1
srcSelect -signal "result" -win $_nTrace1
srcAction -pos 5 1 2 -win $_nTrace1 -name "result" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "result" -win $_nTrace1
srcHBSelect "ahb_clac_top.U_slave_if" -win $_nTrace1
srcSetScope -win $_nTrace1 "ahb_clac_top.U_slave_if" -delim "."
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clac_mode" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opcode_a" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opcode_b" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {41 45 1 1 2 1} -backward
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {46 47 1 1 2 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {80 81 1 1 1 1}
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {80 82 2 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {80 82 1 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_write" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_read" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwrite_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hready" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hsel" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwrite" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_write" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "NONSEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "SEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "NONSEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "SEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "NONSEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "SEQ" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwrite_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hready" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_write" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_read" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_write" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "haddr_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ENABLE_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "CTRL_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "OPA_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "OPB_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ENABLE_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwdata\[0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "enable_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "CTRL_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opa_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opb_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwdata\[15:0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwdata\[15:0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {88 107 2 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "enable_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opa_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opb_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ahb_read" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "haddr_r\[7:0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ENABLE_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hrdata" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "enable_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "CTRL_ADDR" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ctrl_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opa_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opb_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {151 152 2 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcSelect -signal "result" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hrdata" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcHBSelect "ahb_clac_top" -win $_nTrace1
srcSetScope -win $_nTrace1 "ahb_clac_top" -delim "."
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {4 19 2 1 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -inst "U_slave_if" -win $_nTrace1
srcAction -pos 43 2 4 -win $_nTrace1 -name "U_slave_if" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "htrans_r" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "hwrite_r" -win $_nTrace1
debExit
