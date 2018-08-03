#!/bin/sh
source ~/.bashrc

echo "Enter your design name:"
read design

design_dir=./${design}
rtl_dir=./${design}/rtl
tb_dir=./${design}/tb
sim_dir=./${design}/sim
syn_dir=./${design}/syn
lib_dir=./${design}/library
cdc_dir=./${design}/cdc

#Verilog
rtl_v=${rtl_dir}/*.v
tb_v=${tb_dir}/*.v
tb_sv=${tb_dir}/*.sv

#Simulation
sim_make=${sim_dir}/Makefile
sim_file=${sim_dir}/*.f

#Synthesis
syn_make=${syn_dir}/Makefile
#syn_lib=${lib_dir}/sc_max.db
syn_scr=${syn_dir}/*.tcl
sdc_scr=${syn_dir}/*.sdc
setup_scr=${syn_dir}/.synopsys_dc.setup
#syn_rpt=${syn_dir}/*.rpt

#CDC check
cdc_make=${cdc_dir}/Makefile
cdc_prj=${cdc_dir}/*.prj
cdc_file=${cdc_dir}/*.lst
cdc_sdc=${cdc_dir}/sdc/*.sdc
cdc_sgdc=${cdc_dir}/sgdc/*.sgdc
cdc_swl=${cdc_dir}/waiver/*.swl
cdc_awl=${cdc_dir}/waiver/*.awl

file_list=( $rtl_v $tb_v $tb_sv $sim_make $sim_file $syn_make $syn_scr $sdc_scr $setup_scr )
cdc_list=( $cdc_make $cdc_prj $cdc_file $cdc_sdc $cdc_sgdc $cdc_swl $cdc_awl )

if [ -d ${design_dir} ]; then
  echo "${design} files are uploading..."
  for file in ${file_list[@]}; do
    git add $file
  done
  #add CDC
  if [ -d ${cdc_dir} ]; then
    echo "${design} cdc files are uploading..."
    for file in ${cdc_list[@]}; do
      git add $file
    done
  else
    echo "${design} cdc files do not exist"
  fi
  git commit -m "${design} files"
  git push origin master
else
  echo "${design} files do not exist"
fi


