#!/bin/bash
nevt=${1}
echo "%MSG-MG5 number of events requested = $nevt"

rnum=${2}
echo "%MSG-MG5 random seed used for the run = $rnum"

ncpu=${3}
echo "%MSG-MG5 number of cpus = $ncpu"

LHEWORKDIR=`pwd`
cd $LHEWORKDIR/process

#make sure lhapdf points to local cmssw installation area
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MGINSTALLPATH/HEPTools/lhapdf6_py3/lib/
export PYTHONPATH=$PYTHONPATH:$MGINSTALLPATH/HEPTools/lhapdf6_py3/lib:$MGINSTALLPATH/HEPTools/lhapdf6_py3/lib64/python3.9/site-packages/LHAPDF-6.3.0-py3.9-linux-x86_64.egg/
LHAPDFCONFIG=`echo "$LHAPDFPATH"`

# workaround for el8
echo "lhapdf_py3 = $LHAPDFCONFIG" >> ./Cards/amcatnlo_configuration.txt
echo "run_mode = 2" >> ./Cards/amcatnlo_configuration.txt
echo "nb_core = $ncpu" >> ./Cards/amcatnlo_configuration.txt
echo "madspin=OFF" > runscript.dat 
echo "reweight=OFF" >> runscript.dat
echo "done" >> runscript.dat
echo "set nevents $nevt" >> runscript.dat
echo "set iseed $rnum" >> runscript.dat

#set job splitting for worker processes
nevtjob=$[$nevt/$ncpu]
if [ "$nevtjob" -lt "10" ]; then
  nevtjob=10
fi
echo "set nevt_job ${nevtjob}" >> runscript.dat
echo "done" >> runscript.dat

runname=cmsgrid

#generate events
#First check if normal operation with MG5_aMCatNLO events is planned
cat runscript.dat | ./bin/generate_events -ox -n $runname
runlabel=$runname

gzip -d $LHEWORKDIR/process/Events/${runlabel}/events.lhe 
cp $LHEWORKDIR/process/Events/${runlabel}/events.lhe $LHEWORKDIR/${runname}_final.lhe

cd $LHEWORKDIR
sed -i -e '/<mgrwgt/,/mgrwgt>/d' ${runname}_final.lhe 

# check lhe output  
mv ${LHEWORKDIR}/${runname}_final.lhe ${LHEWORKDIR}/test.lhe 
echo -e "\nRun xml check" 
xmllint --stream --noout ${LHEWORKDIR}/test.lhe ; test $? -eq 0 || exit 1 
echo "Number of weights that are NaN:" 
grep  NaN  ${LHEWORKDIR}/test.lhe | grep "</wgt>" | wc -l ; test $? -eq 0 || exit 1 
echo -e "All checks passed \n" 

# copy output and print directory 
mv ${LHEWORKDIR}/test.lhe ${LHEWORKDIR}/${runname}_final.lhe
ls -l

# exit 
exit 0
