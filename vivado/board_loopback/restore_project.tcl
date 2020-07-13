if { [llength $argv] == 0 } {
    error "Project name must be specified."
}
set project_name [lindex $argv 0]
set board_part {xilinx.com:au50dd:part0:1.0}

create_project $project_name .

set_param board.repoPaths [concat [file normalize ../XilinxBoardStore/boards/Xilinx] [get_param board.repoPaths]]
set_property BOARD_PART_REPO_PATHS [get_param board.repoPaths] [current_project]

set_property BOARD_PART $board_part [current_project]

add_files -fileset [get_filesets constrs_1] ./src/hbm_apb_workaround.xdc
set xdc [add_files -fileset [get_filesets constrs_1] ./src/u50_bitstream_config.xdc]
set_property USED_IN_SYNTHESIS 0 $xdc

lappend ip_repo_path_list [file normalize ../../xg_mac]
set_property ip_repo_paths $ip_repo_path_list [get_filesets sources_1]
update_ip_catalog

source ./design_top.tcl
make_wrapper -top -fileset sources_1 -import [get_files $project_name.srcs/sources_1/bd/design_top/design_top.bd]
