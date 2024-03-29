open_project -project {E:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\designer\impl1\Voltage_Monitor_fp\Voltage_Monitor.pro}
set_programming_file -no_file
set_device_type -type {A2F200M3F}
set_device_package -package {484 FBGA}
update_programming_file \
    -feature {prog_fpga:on} \
    -fdb_source {fdb} \
    -fdb_file {E:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\designer\impl1\Voltage_Monitor.fdb} \
    -feature {prog_from:off} \
    -feature {prog_nvm:on} \
    -efm_content {location:0;source:efc} \
    -efm_block {location:0;config_file:{E:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\component\work\Voltage_Monitor_MSS\MSS_ENVM_0\MSS_ENVM_0.efc}} \
    -pdb_file {E:\repos\ECEN5863_projects\POT_Uart\Voltage_Monitor\Voltage_Monitor\designer\impl1\Voltage_Monitor_fp\Voltage_Monitor.pdb}
set_programming_action -action {PROGRAM}
run_selected_actions
save_project
close_project
