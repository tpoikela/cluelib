#
# modelsim.mk
#

# user definable variables

MODELSIM_LIB_DIR  := ./work
MODELSIM_LIB_NAME := work

# constants

modelsim_compile_opts := +incdir+$(src_dir)+$(test_dir) +define+CL_USE_MODELSIM
modelsim_run_cmd_file := modelsim.cmd
modelsim_run_opts     :=
modelsim_top_module   := test_from_examples

# targets

modelsim: prep_modelsim run_modelsim

prep_modelsim:
	vlib $(MODELSIM_LIB_DIR)
	vmap $(MODELSIM_LIB_NAME) $(MODELSIM_LIB_DIR)

run_modelsim:
	vlog $(modelsim_compile_opts) $(compile_files)
	vsim $(modelsim_run_opts) $(top_module) < $(modelsim_run_cmd_file)

clean_modelsim:
	vdel -lib $(MODELSIM_LIB_NAME) -all
