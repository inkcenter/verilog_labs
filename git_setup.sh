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

rtl_v=${rtl_dir}/*.v
tb_v=${tb_dir}/*.v

sim_make=${sim_dir}/Makefile
sim_file=${sim_dir}/*.f

syn_make=${syn_dir}/Makefile
#syn_lib=${lib_dir}/sc_max.db
syn_scr=${syn_dir}/*.tcl
sdc_scr=${syn_dir}/*.sdc
setup_scr=${syn_dir}/.synopsys_dc.setup

#syn_rpt=${syn_dir}/*.rpt

file_list=( $rtl_v $tb_v $sim_make $sim_file $syn_make $syn_scr $sdc_scr $setup_scr )

if [ -d ${design_dir} ]; then
  echo "${design} files is uploading..."
  for file in ${file_list[@]}; do
    git add $file
  done
  git commit -m "${design} files"
  git push origin master
else
  echo "${design} files does not exist"
fi
