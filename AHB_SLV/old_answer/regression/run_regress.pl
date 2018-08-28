#!/usr/bin/perl -w
##########################################################################
#   this perl scrtart is used for regression		
##########################################################################

use Term::ANSIColor;	#enable the system function to print information with multicolor in your terminal
use Cwd;  				#enable the system function to obtain your current working directory
use Getopt::Long; 		

$debug     = 0;  #the variable used to debug(in debug mode,$debug = 1)
$error_flag = 0;  #the variable used to indicate whether the simulation run suceefully or not,$error_flag=0 -- simulation run successfully
$mark_error_tmp  = 0;  #mark for the failed case $mark_error_tmp= 1 case fail $mark_error_tmp = 0,case pass

GetOptions(	"l=s"  =>\ $list_to_run,
			"cov"  =>\ $cover,
			);
if(defined $list_to_run){
	if($debug){print colored ['yellow'],"$list_to_run\n";}
}else{
  	print colored ['red'],"no regression list *-*\n";
  	exit 0;
}


if(defined $cover){
	if($debug) {print colored ['yellow'],"$cover\n";}
}else {
 	$cover = 0;
	if($debug){print colored ['yellow'],"$cover\n";}
}


########################################################################################

open list_file, "<$list_to_run";  #open a file named list_file and output $list_to_run's content to it

#output each testcase's name to a array named @test_list to run your testcases in a loop
while(<list_file>){
  chomp($_);
  if(/^\s*?(\/\/.*|\s*)$/){
    next;
  }else{
    push @test_list,$_;}
}

if($debug==1){
  foreach(@test_list) {
    print colored ['yellow'],"$_\n";
  }
}

$sdate =`date +%F::%H:%M`;  #call system function to obtain current system time
chomp($sdate);
if($debug ==1) {print colored ['yellow'],"sdate = $sdate \n";}  #if in debug mode,print information in your terminal

$logfilename = "regress_"."$list_to_run"."_"."$sdate"."rlog";  #the name of logfile which obtain the log information during the simulation
if($debug ==1) {print colored ['yellow'],"logfilename = $logfilename \n";}

$faillogdir = "regress_"."fail_case_"."$list_to_run"."_"."$sdate"."logs";  #the name of fail cases'logfile 
$passlogdir = "regress_"."pass_case_"."$list_to_run"."_"."$sdate"."logs";  #the name of pass cases'logfile

$faildir = "$faillogdir";
$passdir = "$passlogdir";

mkdir "$faildir",or warn"Cannot make directory:$!";  #create a directory which contains the history of fail cases
mkdir "$passdir",or warn"Cannot make directory:$!";  #create a directory which contains the history of pass case

if($cover){
	$coverage_dir = "cases_"."$sdate"."_cov_dats"; #the dir to store every case's coverage file
	mkdir "$coverage_dir",or warn"Cannot make directory:$!";                    #call the system function to creat the dir
}

open FULLLOG,">$logfilename";  #open a file to store the log infomation during the simulation
print FULLLOG "The start time for simulation is $sdate\n";  #print the start time of simulation into logfile

$work_dir = &Cwd::cwd();  #call the function to obtain working diectory and print it to terminal and into logfile
print colored ['blue'], "Your current work dicrory is $work_dir\n";
print FULLLOG "The working dictory is $work_dir\n";
if($debug == 1) { print colored ['yellow'], "Current working dictory is $work_dir\n"; }

$total_case = 0;         #the variables calculate the number of total cases,pass cases and fail cases respectively
$pass_case  = 0;
$fail_case  = 0;

$fail_case_list = "fail_case_list";  #the variables store the the list of fail cases and pass cases respectively
$pass_case_list = "pass_case_list";

#the following is the loop to run all your testcases
#///////////////////////////////////////////////////////////////////////////
foreach $test_list(@test_list){
  @tcinfo = split/:/,"$test_list"; 
  $tc=$tcinfo[0];  
  
  $tc =~s/(\w+)\.v/$1/;
  $tc =~s/(\s)+//g;

  $casedir = "$tc";  #the name of case directory

  print colored ["blue"],"Running Test Casename = $tc.v\n"; 
  print FULLLOG "Running Test Casename = $tc.v\n"; 

 #run rtl simulation
  print FULLLOG "Command to run_rtl: make clean_run TC=$tc \n";
  #system("make clean_run  TC=$tc  COVERAGE=$cover");  #call system function to opreate the command to run each testcase
  system("make clean_run  TC=$tc ");  #call system function to opreate the command to run each testcase

#check the case pass or fail
      open LOGFILE,"sim.log" or die"Can not open the sim.log file";
      while(<LOGFILE>){
        if(/.*case_passed.*/s){
          $mark_error_tmp = 0;  # case pass mark temporary
          last;  #exit from cycle
        } else {
          $mark_error_tmp = 1;     #case fail mark temporary
        }
      }       
      close(LOGFILE);

    if($mark_error_tmp == 1) {
       $error_flag =1;  #case fail flag
     }

      if($mark_error_tmp ==1)  #if the testcase failed,store the history,count the number of failed testcase and append its name to a file
      { 
        mkdir "$faildir/$casedir",or warn"Cannot make directory:$!";  #create a dictory in $faillogdir to store the history of fail testcase
		rename "sim.log","$faildir/$casedir/sim.log",or warn"Cannor rename the file!:$!";  #move testcase's logfile to corresponding directory
		rename "tb_check.log","$faildir/$casedir/tb_check.log",or warn"Cannor rename the file!:$!";  #move tb check logfile to corresponding directory
   		print colored ['red'], "************************* Case Failed!... *_* *************************\n";   #print failed information
        print FULLLOG "***************************** Case Failed!... *_* ******************************\n";
	$fail_case++;                                                                  #count the number of failed testcase
	&append_in_file($fail_case_list, "testcase = ${tc}.v \n");  #call subroutine to append the failed case's name to a file named fail_case_list
      }else   #if the testcase passed,store the history,count the number of passed testcase and append its name to a file
      { 
        mkdir "$passdir/$casedir",or warn"Cannot make directory:$!";   #create a dictory in $passdir to store the history of pass testcase
		rename "sim.log","$passdir/$casedir/sim.log",or warn"Cannor rename the file!:$!";
		rename "tb_check.log","$passdir/$casedir/tb_check.log",or warn"Cannor rename the file!:$!";  #move tb check logfile to corresponding directory
        print colored ['green'],"******************************** Case Passed!... ^_^ *************************** \n";
        print FULLLOG "*************************** Case Passed!... ^_^ ***************************** \n";
        $pass_case++;
        &append_in_file($pass_case_list, "testcase = ${tc}.v \n");
      }
    print "\n";
    print FULLLOG "\n";
	$total_case++;

	$temp = $tc;
	if($cover){
		system("mv -f ${temp}_cov* $coverage_dir");	
	}
}

 	if($cover){ system("urg -dir $coverage_dir/*_cov* -dbname coverage_merge");}

#///////////////////////////////////////////////////////////////////////////
#after the whole simulation,print some information to indicate the simulation result
    print colored ['blue'],"*************** $total_case cases have been run, $fail_case cases failed and $pass_case cases passed! ***************\n\n";
    print FULLLOG "\n";	
    print FULLLOG "**************** $total_case cases have been run, $fail_case cases failed and $pass_case cases passed! ****************\n\n";
	
  if($error_flag){
     print colored ['red'], "************************* Some case failed ***************************\n";
     print FULLLOG "************************** Some case failed *************************\n";
   }else{
     print colored ['green'], "^^^^^^^^^^^^^^^^^^^^^^^^^ All case passed ^^^^^^^^^^^^^^^^^^^^^^^^^^\n";
     print FULLLOG "^^^^^^^^^^^^^^^^^^^^^^^^ All case passed ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n";
   }
  print colored ['magenta'], "Finished regression. Exiting...\n";
  print FULLLOG "Finished regressio${tc}_*_covn. Exiting...\n";
close(FULLLOG);

if($pass_case != 0)    { rename "$pass_case_list","$passdir/$pass_case_list",or warn"Cannor rename the file!:$!"; }
if($fail_case != 0)    { rename "$fail_case_list","$faildir/$fail_case_list",or warn"Cannor rename the file!:$!"; }

exit 0;  #exit successfully

sub append_in_file  #a subroutine to append some content at the end of a file
{
  open(F,">>$_[0]");
  print F $_[1];
  close(F);
}
