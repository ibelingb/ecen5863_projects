transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/repos/ECEN5863_projects/DE10litePWM/source {E:/repos/ECEN5863_projects/DE10litePWM/source/pwm_led_top.v}
vlog -vlog01compat -work work +incdir+E:/repos/ECEN5863_projects/DE10litePWM/source {E:/repos/ECEN5863_projects/DE10litePWM/source/pwm_gen.v}
vlog -vlog01compat -work work +incdir+E:/repos/ECEN5863_projects/DE10litePWM/source {E:/repos/ECEN5863_projects/DE10litePWM/source/debouncer.v}
vlog -vlog01compat -work work +incdir+E:/repos/ECEN5863_projects/DE10litePWM {E:/repos/ECEN5863_projects/DE10litePWM/pwm_pll.v}
vlog -vlog01compat -work work +incdir+E:/repos/ECEN5863_projects/DE10litePWM/db {E:/repos/ECEN5863_projects/DE10litePWM/db/pwm_pll_altpll.v}

