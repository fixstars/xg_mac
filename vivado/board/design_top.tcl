
################################################################
# This is a generated script based on design: design_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_top_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu50-fsvh2104-2L-e
   set_property BOARD_PART xilinx.com:au50dd:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xxv_ethernet:3.1\
xilinx.com:ip:axi_fifo_mm_s:4.2\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:axis_dwidth_converter:1.1\
xilinx.com:ip:system_ila:1.1\
fixstars:fixstars:xg_mac:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hier_mac_1
proc create_hier_cell_hier_mac_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_mac_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_mac

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axi_fifo_mm_s_0, and set properties
  set axi_fifo_mm_s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.2 axi_fifo_mm_s_0 ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $axis_data_fifo_rx

  # Create instance: axis_data_fifo_tx, and set properties
  set axis_data_fifo_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_tx ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $axis_data_fifo_tx

  # Create instance: axis_dwidth_converter_rx, and set properties
  set axis_dwidth_converter_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_rx ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {4} \
 ] $axis_dwidth_converter_rx

  # Create instance: axis_dwidth_converter_tx, and set properties
  set axis_dwidth_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_tx ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_tx

  # Create instance: rst_xxv_ethernet_0_156M, and set properties
  set rst_xxv_ethernet_0_156M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M ]

  # Create instance: rst_xxv_ethernet_0_156M_2, and set properties
  set rst_xxv_ethernet_0_156M_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_2 ]

  # Create instance: system_ila_rx, and set properties
  set system_ila_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_rx ]
  set_property -dict [ list \
   CONFIG.C_INPUT_PIPE_STAGES {2} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {2} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:display_xxv_ethernet:user_int_ports:2.0} \
   CONFIG.C_SLOT_0_TYPE {0} \
   CONFIG.C_SLOT_1_APC_EN {0} \
   CONFIG.C_SLOT_1_AXI_DATA_SEL {1} \
   CONFIG.C_SLOT_1_AXI_TRIG_SEL {1} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_rx

  # Create instance: system_ila_tx, and set properties
  set system_ila_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_tx ]
  set_property -dict [ list \
   CONFIG.C_INPUT_PIPE_STAGES {2} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {2} \
   CONFIG.C_SLOT_0_APC_EN {0} \
   CONFIG.C_SLOT_0_AXI_DATA_SEL {1} \
   CONFIG.C_SLOT_0_AXI_TRIG_SEL {1} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:display_xxv_ethernet:user_int_ports:2.0} \
   CONFIG.C_SLOT_1_TYPE {0} \
 ] $system_ila_tx

  # Create instance: xxv_ethernet_mac_0, and set properties
  set xxv_ethernet_mac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xxv_ethernet:3.1 xxv_ethernet_mac_0 ]
  set_property -dict [ list \
   CONFIG.ADD_GT_CNTRL_STS_PORTS {1} \
   CONFIG.CORE {Ethernet MAC 64-bit} \
   CONFIG.GT_LOCATION {0} \
   CONFIG.GT_REF_CLK_FREQ {156.25} \
   CONFIG.INCLUDE_SHARED_LOGIC {0} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {0} \
   CONFIG.LINE_RATE {10} \
   CONFIG.XGMII_INTERFACE {0} \
 ] $xxv_ethernet_mac_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_fifo_mm_s_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xxv_ethernet_mac_0/mac_mii_rx_0]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn2] [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins system_ila_rx/SLOT_0_USER_INT_PORTS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets Conn2]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xxv_ethernet_mac_0/mac_mii_tx_0]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn3] [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins system_ila_tx/SLOT_1_USER_INT_PORTS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets Conn3]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axi_mac] [get_bd_intf_pins xxv_ethernet_mac_0/s_axi_0]
  connect_bd_intf_net -intf_net axi_fifo_mm_s_0_AXI_STR_TXD [get_bd_intf_pins axi_fifo_mm_s_0/AXI_STR_TXD] [get_bd_intf_pins axis_dwidth_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_rx_M_AXIS [get_bd_intf_pins axis_data_fifo_rx/M_AXIS] [get_bd_intf_pins axis_dwidth_converter_rx/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_tx_M_AXIS [get_bd_intf_pins axis_data_fifo_tx/M_AXIS] [get_bd_intf_pins xxv_ethernet_mac_0/axis_tx_0]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_data_fifo_tx_M_AXIS] [get_bd_intf_pins axis_data_fifo_tx/M_AXIS] [get_bd_intf_pins system_ila_tx/SLOT_0_AXIS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets axis_data_fifo_tx_M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_rx_M_AXIS [get_bd_intf_pins axi_fifo_mm_s_0/AXI_STR_RXD] [get_bd_intf_pins axis_dwidth_converter_rx/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_tx_M_AXIS [get_bd_intf_pins axis_data_fifo_tx/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_tx/M_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins xxv_ethernet_mac_0/axis_rx_0]
  connect_bd_intf_net -intf_net [get_bd_intf_nets xg_mac_0_rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins system_ila_rx/SLOT_1_AXIS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets xg_mac_0_rx_maxis]

  # Create port connections
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_aresetn [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_2/peripheral_aresetn] [get_bd_pins system_ila_rx/resetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_peripheral_aresetn [get_bd_pins rst_xxv_ethernet_0_156M/peripheral_aresetn] [get_bd_pins system_ila_tx/resetn]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_2/slowest_sync_clk] [get_bd_pins system_ila_rx/clk] [get_bd_pins xxv_ethernet_mac_0/rx_core_clk_0] [get_bd_pins xxv_ethernet_mac_0/rx_mac_mii_clk_0]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_2/ext_reset_in] [get_bd_pins xxv_ethernet_mac_0/rx_mac_mii_reset_0] [get_bd_pins xxv_ethernet_mac_0/rx_reset_0]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_fifo_mm_s_0/s_axi_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins axis_data_fifo_tx/s_axis_aclk] [get_bd_pins axis_dwidth_converter_rx/aclk] [get_bd_pins axis_dwidth_converter_tx/aclk] [get_bd_pins xxv_ethernet_mac_0/s_axi_aclk_0]
  connect_bd_net -net s_axi_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_fifo_mm_s_0/s_axi_aresetn] [get_bd_pins axis_data_fifo_tx/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_rx/aresetn] [get_bd_pins axis_dwidth_converter_tx/aresetn] [get_bd_pins xxv_ethernet_mac_0/s_axi_aresetn_0]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_data_fifo_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M/slowest_sync_clk] [get_bd_pins system_ila_tx/clk] [get_bd_pins xxv_ethernet_mac_0/tx_core_clk_0] [get_bd_pins xxv_ethernet_mac_0/tx_mac_mii_clk_0]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M/ext_reset_in] [get_bd_pins xxv_ethernet_mac_0/tx_mac_mii_reset_0] [get_bd_pins xxv_ethernet_mac_0/tx_reset_0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_mac_0
proc create_hier_cell_hier_mac_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_mac_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axi_fifo_mm_s_0, and set properties
  set axi_fifo_mm_s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.2 axi_fifo_mm_s_0 ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $axis_data_fifo_rx

  # Create instance: axis_data_fifo_tx, and set properties
  set axis_data_fifo_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_tx ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $axis_data_fifo_tx

  # Create instance: axis_dwidth_converter_rx, and set properties
  set axis_dwidth_converter_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_rx ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {4} \
 ] $axis_dwidth_converter_rx

  # Create instance: axis_dwidth_converter_tx, and set properties
  set axis_dwidth_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_tx ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_tx

  # Create instance: rst_xxv_ethernet_0_156M, and set properties
  set rst_xxv_ethernet_0_156M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M ]

  # Create instance: rst_xxv_ethernet_0_156M_2, and set properties
  set rst_xxv_ethernet_0_156M_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_2 ]

  # Create instance: system_ila_rx, and set properties
  set system_ila_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_rx ]
  set_property -dict [ list \
   CONFIG.C_INPUT_PIPE_STAGES {2} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {2} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:display_xxv_ethernet:user_int_ports:2.0} \
   CONFIG.C_SLOT_0_TYPE {0} \
   CONFIG.C_SLOT_1_APC_EN {0} \
   CONFIG.C_SLOT_1_AXI_DATA_SEL {1} \
   CONFIG.C_SLOT_1_AXI_TRIG_SEL {1} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_rx

  # Create instance: system_ila_tx, and set properties
  set system_ila_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_tx ]
  set_property -dict [ list \
   CONFIG.C_INPUT_PIPE_STAGES {2} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {2} \
   CONFIG.C_SLOT_0_APC_EN {0} \
   CONFIG.C_SLOT_0_AXI_DATA_SEL {1} \
   CONFIG.C_SLOT_0_AXI_TRIG_SEL {1} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:display_xxv_ethernet:user_int_ports:2.0} \
   CONFIG.C_SLOT_1_TYPE {0} \
 ] $system_ila_tx

  # Create instance: xg_mac_0, and set properties
  set xg_mac_0 [ create_bd_cell -type ip -vlnv fixstars:fixstars:xg_mac:1.0 xg_mac_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_fifo_mm_s_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xg_mac_0/rx_xgmii]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn2] [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins system_ila_rx/SLOT_0_USER_INT_PORTS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets Conn2]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xg_mac_0/tx_xgmii]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn3] [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins system_ila_tx/SLOT_1_USER_INT_PORTS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets Conn3]
  connect_bd_intf_net -intf_net axi_fifo_mm_s_0_AXI_STR_TXD [get_bd_intf_pins axi_fifo_mm_s_0/AXI_STR_TXD] [get_bd_intf_pins axis_dwidth_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_rx_M_AXIS [get_bd_intf_pins axis_data_fifo_rx/M_AXIS] [get_bd_intf_pins axis_dwidth_converter_rx/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_tx_M_AXIS [get_bd_intf_pins axis_data_fifo_tx/M_AXIS] [get_bd_intf_pins xg_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_data_fifo_tx_M_AXIS] [get_bd_intf_pins axis_data_fifo_tx/M_AXIS] [get_bd_intf_pins system_ila_tx/SLOT_0_AXIS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets axis_data_fifo_tx_M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_rx_M_AXIS [get_bd_intf_pins axi_fifo_mm_s_0/AXI_STR_RXD] [get_bd_intf_pins axis_dwidth_converter_rx/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_tx_M_AXIS [get_bd_intf_pins axis_data_fifo_tx/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_tx/M_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins xg_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net [get_bd_intf_nets xg_mac_0_rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins system_ila_rx/SLOT_1_AXIS]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets xg_mac_0_rx_maxis]

  # Create port connections
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_aresetn [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_2/peripheral_aresetn] [get_bd_pins system_ila_rx/resetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_peripheral_aresetn [get_bd_pins rst_xxv_ethernet_0_156M/peripheral_aresetn] [get_bd_pins system_ila_tx/resetn]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_2/slowest_sync_clk] [get_bd_pins system_ila_rx/clk] [get_bd_pins xg_mac_0/rx_clock]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_2/ext_reset_in] [get_bd_pins xg_mac_0/rx_reset]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_fifo_mm_s_0/s_axi_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins axis_data_fifo_tx/s_axis_aclk] [get_bd_pins axis_dwidth_converter_rx/aclk] [get_bd_pins axis_dwidth_converter_tx/aclk]
  connect_bd_net -net s_axi_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_fifo_mm_s_0/s_axi_aresetn] [get_bd_pins axis_data_fifo_tx/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_rx/aresetn] [get_bd_pins axis_dwidth_converter_tx/aresetn]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_data_fifo_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M/slowest_sync_clk] [get_bd_pins system_ila_tx/clk] [get_bd_pins xg_mac_0/tx_clock]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M/ext_reset_in] [get_bd_pins xg_mac_0/tx_reset]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set cmc_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 cmc_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $cmc_clk

  set sfpdd_refclk0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sfpdd_refclk0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {161132812} \
   ] $sfpdd_refclk0


  # Create ports
  set gt_rxn_in_0 [ create_bd_port -dir I -from 1 -to 0 gt_rxn_in_0 ]
  set gt_rxp_in_0 [ create_bd_port -dir I -from 1 -to 0 gt_rxp_in_0 ]
  set gt_txn_out_0 [ create_bd_port -dir O -from 1 -to 0 gt_txn_out_0 ]
  set gt_txp_out_0 [ create_bd_port -dir O -from 1 -to 0 gt_txp_out_0 ]

  # Create instance: blk_mem_gen_mb, and set properties
  set blk_mem_gen_mb [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_mb ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $blk_mem_gen_mb

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLK_IN1_BOARD_INTERFACE {cmc_clk} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_0

  # Create instance: hier_mac_0
  create_hier_cell_hier_mac_0 [current_bd_instance .] hier_mac_0

  # Create instance: hier_mac_1
  create_hier_cell_hier_mac_1 [current_bd_instance .] hier_mac_1

  # Create instance: lmb_bram_if_cntlr_mb_data, and set properties
  set lmb_bram_if_cntlr_mb_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_bram_if_cntlr_mb_data ]

  # Create instance: lmb_bram_if_cntlr_mb_inst, and set properties
  set lmb_bram_if_cntlr_mb_inst [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_bram_if_cntlr_mb_inst ]

  # Create instance: mdm_0, and set properties
  set mdm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_0

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {0} \
   CONFIG.C_DATA_SIZE {32} \
   CONFIG.C_DCACHE_ADDR_TAG {0} \
   CONFIG.C_D_AXI {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {6} \
   CONFIG.S00_HAS_REGSLICE {4} \
 ] $microblaze_0_axi_periph

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: xlconstant_clksel, and set properties
  set xlconstant_clksel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_clksel ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0b101} \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_clksel

  # Create instance: xlconstant_no_reset, and set properties
  set xlconstant_no_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_no_reset ]

  # Create instance: xxv_ethernet_0, and set properties
  set xxv_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xxv_ethernet:3.1 xxv_ethernet_0 ]
  set_property -dict [ list \
   CONFIG.BASE_R_KR {BASE-R} \
   CONFIG.CORE {Ethernet PCS/PMA 64-bit} \
   CONFIG.DATA_PATH_INTERFACE {MII} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {sfpdd_refclk0} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ETHERNET_BOARD_INTERFACE {Custom} \
   CONFIG.GT_GROUP_SELECT {Quad_X0Y7} \
   CONFIG.GT_REF_CLK_FREQ {161.1328125} \
   CONFIG.INCLUDE_USER_FIFO {0} \
   CONFIG.LANE1_GT_LOC {X0Y28} \
   CONFIG.LANE2_GT_LOC {X0Y30} \
   CONFIG.LINE_RATE {10} \
   CONFIG.NUM_OF_CORES {2} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $xxv_ethernet_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins hier_mac_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net cmc_clk_1 [get_bd_intf_ports cmc_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net hier_mac_0_tx_xgmii [get_bd_intf_pins hier_mac_0/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets hier_mac_0_tx_xgmii]
  connect_bd_intf_net -intf_net hier_mac_1_tx_xgmii [get_bd_intf_pins hier_mac_1/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_1]
  connect_bd_intf_net -intf_net lmb_bram_if_cntlr_mb_data_BRAM_PORT [get_bd_intf_pins blk_mem_gen_mb/BRAM_PORTA] [get_bd_intf_pins lmb_bram_if_cntlr_mb_data/BRAM_PORT]
  connect_bd_intf_net -intf_net lmb_bram_if_cntlr_mb_inst_BRAM_PORT [get_bd_intf_pins blk_mem_gen_mb/BRAM_PORTB] [get_bd_intf_pins lmb_bram_if_cntlr_mb_inst/BRAM_PORT]
  connect_bd_intf_net -intf_net mdm_0_MBDEBUG_0 [get_bd_intf_pins mdm_0/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_DLMB [get_bd_intf_pins lmb_bram_if_cntlr_mb_data/SLMB] [get_bd_intf_pins microblaze_0/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ILMB [get_bd_intf_pins lmb_bram_if_cntlr_mb_inst/SLMB] [get_bd_intf_pins microblaze_0/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins mdm_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins hier_mac_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_0]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_1]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins hier_mac_1/s_axi_mac] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net sfpdd_refclk0_1 [get_bd_intf_ports sfpdd_refclk0] [get_bd_intf_pins xxv_ethernet_0/gt_ref_clk]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_0 [get_bd_intf_pins hier_mac_0/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_0]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_1 [get_bd_intf_pins hier_mac_1/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_1]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins hier_mac_0/s_axi_aclk] [get_bd_pins hier_mac_1/s_axi_aclk] [get_bd_pins lmb_bram_if_cntlr_mb_data/LMB_Clk] [get_bd_pins lmb_bram_if_cntlr_mb_inst/LMB_Clk] [get_bd_pins mdm_0/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins xxv_ethernet_0/dclk] [get_bd_pins xxv_ethernet_0/s_axi_aclk_0] [get_bd_pins xxv_ethernet_0/s_axi_aclk_1]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net gt_rxn_in_0_1 [get_bd_ports gt_rxn_in_0] [get_bd_pins xxv_ethernet_0/gt_rxn_in]
  connect_bd_net -net gt_rxp_in_0_1 [get_bd_ports gt_rxp_in_0] [get_bd_pins xxv_ethernet_0/gt_rxp_in]
  connect_bd_net -net mdm_0_Debug_SYS_Rst [get_bd_pins hier_mac_0/mb_debug_sys_rst] [get_bd_pins hier_mac_1/mb_debug_sys_rst] [get_bd_pins mdm_0/Debug_SYS_Rst] [get_bd_pins proc_sys_reset_0/mb_debug_sys_rst]
  connect_bd_net -net proc_sys_reset_0_mb_reset [get_bd_pins lmb_bram_if_cntlr_mb_data/LMB_Rst] [get_bd_pins lmb_bram_if_cntlr_mb_inst/LMB_Rst] [get_bd_pins microblaze_0/Reset] [get_bd_pins proc_sys_reset_0/mb_reset]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins hier_mac_0/s_axi_aresetn] [get_bd_pins hier_mac_1/s_axi_aresetn] [get_bd_pins mdm_0/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_0] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_1]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins xxv_ethernet_0/sys_reset]
  connect_bd_net -net rx_clock_1 [get_bd_pins hier_mac_1/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_1]
  connect_bd_net -net rx_reset_1 [get_bd_pins hier_mac_1/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_1]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_clksel/dout] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_0] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_1] [get_bd_pins xxv_ethernet_0/txoutclksel_in_0] [get_bd_pins xxv_ethernet_0/txoutclksel_in_1]
  connect_bd_net -net xlconstant_no_reset_dout [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins xlconstant_no_reset/dout]
  connect_bd_net -net xxv_ethernet_0_gt_txn_out [get_bd_ports gt_txn_out_0] [get_bd_pins xxv_ethernet_0/gt_txn_out]
  connect_bd_net -net xxv_ethernet_0_gt_txp_out [get_bd_ports gt_txp_out_0] [get_bd_pins xxv_ethernet_0/gt_txp_out]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_0 [get_bd_pins hier_mac_0/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_0]
  connect_bd_net -net xxv_ethernet_0_tx_mii_clk_0 [get_bd_pins hier_mac_0/tx_clock] [get_bd_pins xxv_ethernet_0/rx_core_clk_0] [get_bd_pins xxv_ethernet_0/tx_mii_clk_0]
  connect_bd_net -net xxv_ethernet_0_tx_mii_clk_1 [get_bd_pins hier_mac_1/tx_clock] [get_bd_pins xxv_ethernet_0/rx_core_clk_1] [get_bd_pins xxv_ethernet_0/tx_mii_clk_1]
  connect_bd_net -net xxv_ethernet_0_user_rx_reset_0 [get_bd_pins hier_mac_0/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_0]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_0 [get_bd_pins hier_mac_0/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_0] [get_bd_pins xxv_ethernet_0/user_tx_reset_0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets xxv_ethernet_0_user_tx_reset_0]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_1 [get_bd_pins hier_mac_1/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_1] [get_bd_pins xxv_ethernet_0/user_tx_reset_1]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets xxv_ethernet_0_user_tx_reset_1]

  # Create address segments
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_mac_0/axi_fifo_mm_s_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_mac_1/axi_fifo_mm_s_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs lmb_bram_if_cntlr_mb_data/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs lmb_bram_if_cntlr_mb_inst/SLMB/Mem] -force
  assign_bd_address -offset 0x41400000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_0/Reg] -force
  assign_bd_address -offset 0x44A80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_1/Reg] -force
  assign_bd_address -offset 0x44AC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_mac_1/xxv_ethernet_mac_0/s_axi_0/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


