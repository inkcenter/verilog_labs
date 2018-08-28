verdiDockWidgetDisplay -dock widgetDock_WelcomePage
verdiDockWidgetHide -dock widgetDock_WelcomePage
wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/qixin/proj_users/cary/training/soc_training_2018_0415/design_labs/ahb_slave/sim_vcs/aaa.fsdb}
wvSelectGroup -win $_nWave2 {G1}
wvSelectGroup -win $_nWave2 {G1}
verdiDockWidgetMaximize -dock windowDock_nWave_2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/ahb_clac_top_tb"
wvGetSignalSetScope -win $_nWave2 "/ahb_clac_top_tb/U_clac_top/U_slave_if"
wvGetSignalSetOptions -win $_nWave2 -all off
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -input on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -output on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvSetPosition -win $_nWave2 {("G1" 13)}
wvSetPosition -win $_nWave2 {("G1" 13)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/haddr\[7:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hburst\[2:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hclk} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hrdata\[31:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hready} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hready_resp} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hresetn} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hresp\[1:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hsel} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hsize\[2:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/htrans\[1:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hwdata\[31:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hwrite} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 )} 
wvSetPosition -win $_nWave2 {("G1" 13)}
wvSetPosition -win $_nWave2 {("G1" 13)}
wvSetPosition -win $_nWave2 {("G1" 13)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/haddr\[7:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hburst\[2:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hclk} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hrdata\[31:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hready} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hready_resp} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hresetn} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hresp\[1:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hsel} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hsize\[2:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/htrans\[1:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hwdata\[31:0\]} \
{/ahb_clac_top_tb/U_clac_top/U_slave_if/hwrite} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 )} 
wvSetPosition -win $_nWave2 {("G1" 13)}
wvGetSignalClose -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
verdiWindowResize -win Verdi_1 "393" "89" "901" "707"
verdiWindowResize -win Verdi_1 "393" "89" "904" "707"
verdiWindowResize -win Verdi_1 "393" "89" "911" "707"
verdiWindowResize -win Verdi_1 "393" "89" "924" "707"
verdiWindowResize -win Verdi_1 "393" "89" "942" "707"
verdiWindowResize -win Verdi_1 "393" "89" "956" "707"
verdiWindowResize -win Verdi_1 "393" "89" "961" "707"
verdiWindowResize -win Verdi_1 "393" "89" "962" "707"
verdiWindowResize -win Verdi_1 "393" "89" "965" "707"
verdiWindowResize -win Verdi_1 "393" "89" "970" "707"
verdiWindowResize -win Verdi_1 "393" "89" "975" "707"
verdiWindowResize -win Verdi_1 "393" "89" "976" "707"
verdiWindowResize -win Verdi_1 "393" "89" "978" "707"
wvSetCursor -win $_nWave2 569385.895807 -snap {("G2" 0)}
wvSelectSignal -win $_nWave2 {( "G1" 13 )} 
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
verdiSetSyncSelection -win nWave_2
wvSetCursor -win $_nWave2 611890.597205 -snap {("G2" 0)}
debExit
