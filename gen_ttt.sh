#!/bin/bash

# Setup CMSSW
source /cvmfs/cms.cern.ch/cmsset_default.sh
#if [[ ! -d CMSSW_14_0_1 ]]; then cmsrel CMSSW_14_0_1; fi
cd /user/dmarckx/CMSSW_13_3_0_pre4/src
cmsenv
cd -

# Main script to produce ttt
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/cms.cern.ch/slc7_amd64_gcc12/external/lhapdf/6.4.0-5969784ee06af968580d5197ca83d374/lib
export PYTHONPATH=$PYTHONPATH:/cvmfs/cms.cern.ch/slc7_amd64_gcc12/external/lhapdf/6.4.0-5969784ee06af968580d5197ca83d374/lib:/cvmfs/cms.cern.ch/slc7_amd64_gcc12/external/lhapdf/6.4.0-5969784ee06af968580d5197ca83d374/lib/python3.9/site-packages/LHAPDF-6.4.0-py3.9-linux-x86_64.egg/

# need to specify python3.8 for CS8, while CS9 has python3.9 as default already
PYTHON=python3
MG="$PYTHON $PWD/MG5_aMC_v3_4_2/bin/mg5_aMC"

mode=$1
LO=$2
#SCALECHOICE=$3

# Load patches if required
case $mode in
	nlo_tttwp)
		echo ">> Producing tttW+"
		source patches/patch_tttwp.sh $mode
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t~ t~ W+ [QCD]"
		OUTDIR=nlo_tttwp
		;;
	nlo_tttwm)
		echo ">> Producing tttW-"
		source patches/patch_tttwm.sh $mode
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t t~ W- [QCD]"
		OUTDIR=nlo_tttwm
		;;
	nlo_tttjp)
		echo ">> Producing tttj+"
		source patches/patch_tttjp.sh $mode
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t~ t~ j [QCD]"
		OUTDIR=nlo_tttjp
		;;
	nlo_tttjm)
		echo ">> Producing tttj-"
		source patches/patch_tttjm.sh $mode
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t t~ j [QCD]"
		OUTDIR=nlo_tttjm
		;;

	lo_ewk_tttwp)
		echo ">> Producing tttW+"
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t~ t~ W+ QED=3 QCD=3 QED^2==$(( 0 + 2*$LO )) QCD^2==$(( 8 - 2*$LO ))"
		OUTDIR=lo_ewk_tttwp$LO
		;;
	lo_ewk_tttwm)
		echo ">> Producing tttW-"
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t t~ W- QED=3 QCD=3 QED^2==$(( 0 + 2*$LO )) QCD^2==$(( 8 - 2*$LO ))"
		OUTDIR=lo_ewk_tttwm$LO
		;;
	lo_ewk_tttjp)
		echo ">> Producing tttj+"
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t~ t~ j QED=4 QCD=2 QED^2==$(( 2 + 2*$LO )) QCD^2==$(( 6 - 2*$LO ))"
		OUTDIR=lo_ewk_tttjp$LO
		;;
	lo_ewk_tttjm)
		echo ">> Producing tttj-"
		MODEL=loop_qcd_qed_sm
		PROCESS="p p > t t t~ j QED=4 QCD=2 QED^2==$(( 2 + 2*$LO )) QCD^2==$(( 6 - 2*$LO ))"
		OUTDIR=lo_ewk_tttjm$LO
		;;
esac


echo "set auto_convert_model T          # convert model to python3 automatically
import model ${MODEL}
set complex_mass_scheme True            # not actually needed if resonance width hardcoded
generate ${PROCESS}
output ${OUTDIR}
" > ${OUTDIR}.cmd
time $MG -f ${OUTDIR}.cmd



if [[ $mode == *"nlo"* ]]; then
	# COMMANDS FOR RUNNING ON MADGRAPH NLO MODE
	date
	echo "--- Generate, output and patch"
	time patch -p0 <<< "$PATCH" |& tee ${OUTDIR}_patch.log

	### launch
	date
	echo "launch ${OUTDIR}
	fixed_order=OFF
	shower=OFF
	order=NLO
	done
	set aEWM1 1.289300e+02
	set MZ 91.153509740726733
	set MW 80.351812293789408
	set MT 172.5
	set ptj 10.
	set etaj -1.
	set pdlabel lhapdf
	set lhaid 325300 
	set WW 2.084650                          # don't set WW=0 unless it is hardcoded in patch
	set WT   0.  # 1.36728                   # anyway set to zero by MG as final state particle
	set dynamical_scale_choice -1            # -1 and 3 are the same at MG5_aMC but not in MG5_LO
	set fixed_ren_scale False                # those two actually determine fixed vs dyn scale
	set fixed_fac_scale False                # those two actually determine fixed vs dyn scale
	set mur_ref_fixed 91.112                 # 3*mt = 3*173.3 = 519.9 GeV
	set muf_ref_fixed 91.112
	set mur_over_ref 1.0
	set muf_over_ref 1.0
	set rw_rscale 0.5,1.,2.
	set rw_fscale 0.5,1.,2.
	set reweight_scale False                 # reweight on the fly, but max 8 different scales
	set reweight_PDF False
	set store_rwgt_info True                 # needed for scale/pdf reweighting
	set systematics_program systematics
	set systematics_arguments ['--pdf=325300,316200,306000@0,322500@0,322700@0,322900@0,323100@0,323300@0,323500@0,323700@0,323900@0,305800,303200@0,292200@0,331300,331600,332100,332300@0,332500@0,332700@0,332900@0,333100@0,333300@0,333500@0,333700@0,14000,14066@0,14067@0,14069@0,14070@0,14100,14200@0,14300@0,27400,27500@0,27550@0,93300,61200,42780,315000@0,315200@0,262000@0,263000@0', '--start_id=1001','--mur=1,2,0.5', '--muf=1,2,0.5','--together=mur,muf', '--dyn=-1']
	0" > ${OUTDIR}.cmd
	date
elif [[ $mode == *"lo_ewk"* ]]; then
	# COMMANDS FOR RUNNING ON MADGRAPH LO MODE
	### launch
	date
	echo "launch ${OUTDIR}
	done
	set aEWM1 1.289300e+02
	set MZ 9.118800e+01
	set MW 8.041900e+01
	set MT 173.3
	set ptj 10.
	set ptb 0.
	set etaj -1.
	set etab -1.
	set drbj 0.                              # 0.7 corresponds to default jet radius at NLO
	set pdlabel lhapdf
	set lhaid 325300
	set WW   0.  # 2.084650                  # irrelevant at LO
	set WT   0.  # 1.36728
	set dynamical_scale_choice 3             # -1 and 3 are the same at MG5_aMC but not in MG5_LO
                                                 # for own clarity: 
                                                 # -1 : MadGraph5_aMC@NLO default (different for LO/NLO/ ickkw mode) same as previous version.
                                                 # 0 : Tag reserved for user define dynamical scale (need to be added in setscales.f).
                                                 # 1 : Total transverse energy of the event.
                                                 # 2 : sum of the transverse mass
                                                 # 3 : sum of the transverse mass divide by 2
                                                 # 4 : \sqrt(s), partonic energy (only for LO run)
	set fixed_ren_scale False                # those two actually determine fixed vs dyn scale
	set fixed_fac_scale False                # those two actually determine fixed vs dyn scale
	set scale 519.9                          # 3*mt = 3*173.3 = 519.9 GeV
	set dsqrt_q2fact1 519.9
	set dsqrt_q2fact2 519.9
	set scalefact 1.
	set use_syst True
    set gridpack True
	set systematics_program systematics
	set systematics_arguments ['--pdf=325300,316200,306000@0,322500@0,322700@0,322900@0,323100@0,323300@0,323500@0,323700@0,323900@0,305800,303200@0,292200@0,331300,331600,332100,332300@0,332500@0,332700@0,332900@0,333100@0,333300@0,333500@0,333700@0,14000,14066@0,14067@0,14069@0,14070@0,14100,14200@0,14300@0,27400,27500@0,27550@0,93300,61200,42780,315000@0,315200@0,262000@0,263000@0', '--start_id=1001','--mur=1,2,0.5', '--muf=1,2,0.5','--together=mur,muf', '--dyn=-1']
	0" > ${OUTDIR}.cmd
fi

# Now submit
$MG -f ${OUTDIR}.cmd |& tee ${OUTDIR}_generation.log

# Now prepare gridpack
MGINSTALLPATH=$PWD/MG5_aMC_v3_4_2
LHAPDFPATH=/cvmfs/cms.cern.ch/slc7_amd64_gcc12/external/lhapdf/6.4.0-fccef38e2654e6e08a1bb6a483817484/bin/lhapdf-config
mkdir ${1}${LO}_gridpack
pushd ${1}${LO}_gridpack/
mv ../${OUTDIR} process

# Now copy stuff for grid production
cp ../runcmsgrid.sh .
cp ../${OUTDIR}*log .
cp ../${OUTDIR}*cmd .
chmod +x runcmsgrid.sh

# Now tar it into a tarball
XZ_OPT="--lzma2=preset=9,dict=512MiB" tar -cJpf ${1}${LO}_tarball.tar.xz process runcmsgrid.sh *generation*.log *cmd
popd
