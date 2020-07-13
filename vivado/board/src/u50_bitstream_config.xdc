# Bitstream Configuration
# ------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]
# ------------------------------------------------------------------------

set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/txresetdone_out[0]}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/txpcsreset_in[0]}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gen_gtwizard_gtye4.txpmareset_ch_int}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gen_gtwizard_gtye4.txuserrdy_int}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gen_gtwizard_gtye4.gttxreset_ch_int}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_common_wrapper/design_top_xxv_ethernet_0_0_gt_gtye4_common_wrapper_i/common_inst/gtwiz_reset_qpll0lock_in[0]}]


set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/txpmaresetdone_out[0]}]
set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/txpmaresetdone_out[0]}]

set_property MARK_DEBUG true [get_nets {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/txprgdivresetdone_out[0]}]



set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_tx_pause_valid_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]
set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_rx_pause_req_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]

set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_tx_gmii_fifo_unf_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]
set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_tx_gmii_fifo_unf_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]

set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_tx_local_fault_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]
set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_rx_remote_fault_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]

set_false_path -from [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/stat_rx_pause_valid_lh_r_out_reg[*]/C}] -to [get_pins {design_top_i/hier_mac_1/xxv_ethernet_mac_0/inst/i_design_top_xxv_ethernet_0_1_top_0/i_design_top_xxv_ethernet_0_1_axi_if_top/i_pif_registers/IP2Bus_Data_reg[*]/D}]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
