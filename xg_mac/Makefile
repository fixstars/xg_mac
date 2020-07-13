.PHONY: all clean ip

MODULES :=  align_frame.sv \
			append_crc.sv \
			prepend_preamble.sv \
			remove_crc.sv \
			xg_mac_rx.sv \
			xg_mac_tx.sv \
			xg_mac.sv \
			../xgmii_axis/axis_to_xgmii.v \
			../xgmii_axis/xgmii_to_axis.v \
			../util/simple_fifo.v \
			../crc/crc_mac.v 

all: ip

clean: 
	-@$(RM) component.xml
	-@$(RM) -rf xgui

ip: component.xml

component.xml xgui: $(MODULES) package_ip.tcl
	vivado -mode batch -source package_ip.tcl
