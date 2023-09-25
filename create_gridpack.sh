# -------------------------------------------------------
# Script to prepare gridpacks for ttt production using scripts from:
# https://github.com/Cvico/triple-top-nlo.
# -------------------------------------------------------

# For printing messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

process=$1


function create_gridpack(){
    MG="$PYTHON $PWD/MG5_aMC_v3_4_2/bin/mg5_aMC"
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib/
    export PYTHONPATH=$PYTHONPATH:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib64/python3.9/site-packages/LHAPDF-6.3.0-py3.9-linux-x86_64.egg/

    script=$1.sh

    if [[ ! -d ${1}_gridpack ]]; then

	MGINSTALLPATH=$PWD/MG5_aMC_v3_4_2
	LHAPDFPATH=$MGINSTALLPATH/HEPTools/lhapdf6_py3/bin/lhapdf-config
        mkdir ${1}_gridpack
        pushd ${1}_gridpack/
        cp ../$script .
        bash ./$script
        # Now copy stuff for grid production
        cp ../runcmsgrid.sh .
	sed -i "s|\$LHAPDFPATH|$LHAPDFPATH|g" runcmsgrid.sh
	sed -i "s|\$MGINSTALLPATH|$MGINSTALLPATH|g" runcmsgrid.sh
	# Now tar it into a tarball
        XZ_OPT="--lzma2=preset=9,dict=512MiB" tar -cJpf ${1}_tarball.tar.xz process runcmsgrid.sh *generation*.log
        popd
    else
	echo -e $RED ${1}_gridpack already exists. $NC
    fi
}

create_gridpack $process
