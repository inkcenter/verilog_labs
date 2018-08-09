#!/bin/sh
source ~/.bashrc

echo "Enter your design name:"
read design

ori_dir=/qixin/proj_users/swru/verilog_labs/linebuffer #to be modified
ori_design=top3buf
syn_ori=${ori_dir}/syn
sim_ori=${ori_dir}/sim


design_dir=./${design}
rtl_dir=./${design}/rtl
tb_dir=./${design}/tb
sim_dir=./${design}/sim
syn_dir=./${design}/syn
lib_dir=./${design}/library

ori_syn_scr=${syn_ori}/syn.tcl
ori_sdc_scr=${syn_ori}/syn.sdc
setup_scr=${syn_ori}/.synopsys_dc.setup
syn_make=${syn_ori}/Makefile

syn_lib=${ori_dir}/library/sc_max.db

sim_time=${ori_dir}/tb/timescale.v

ori_sim_make=${sim_ori}/Makefile

syn_scr=${syn_dir}/syn.tcl
sdc_scr=${syn_dir}/sdc.tcl
sim_make=${sim_dir}/Makefile
sim_file=${sim_dir}/v_list.f



dir_list=( $design_dir $rtl_dir $tb_dir $sim_dir $syn_dir $lib_dir )

scr_list=( $ori_syn_scr $ori_sdc_scr $setup_scr $syn_make )


if [ ! -d ${design_dir} ]; then
  echo "${design} working directory is setting up..."

  for dir in ${dir_list[@]}; do
    mkdir $dir
  done
  
  for scr in ${scr_list[@]}; do
      \cp -rf $scr $syn_dir
  done
  \cp -rf $syn_lib      $lib_dir
  \cp -rf $ori_sim_make $sim_dir
  \cp -rf $sim_time     $tb_dir

  touch ${rtl_dir}/${design}.v ${tb_dir}/${design}_tb.sv ${sim_file}

  sed -i "s/${ori_design}/${design}/g" $sim_make $syn_scr #$sim_file

else 
  echo "${design} exists, try another one"

fi
