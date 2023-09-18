# -------------------------------------------------------
# Script to prepare gridpacks for ttt production using scripts from:
# https://github.com/Cvico/triple-top-nlo.
# 
# DISCLAIMER: This is just an interface to @gdurieux implementation of 
# the process, used for CMS production. The original repo is:
# https://github.com/gdurieux/triple-top-nlo
# 
# The scripts themselves have been modified a bit, just to split
# the MG+LHAPDF installation and the proper production.
# -------------------------------------------------------

# For printing messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Some paths
MGPATH=$PWD/MG5_aMC_v3_4_2/

# -- Steps:
#  1. Install MG342 + LHAPDF
#  2. Generate the gridpacks. The process needs to be specified
step=$1
process=$2
function install_mg() {
    # Function to get MG342
    logname=installation.log
    exec >> $logname 2>&1

    echo -e "$GREEN >> Installing MG $NC" 
    wget -O mg5.tar.gz https://launchpad.net/mg5amcnlo/3.0/3.4.x/+download/MG5_aMC_v3.4.2.tar.gz
    tar xzf mg5.tar.gz

    # Install LHAPDF
    echo "install lhapdf6" >> installLhapdf.cmd
    echo -e "$GREEN >> Installing LHAPDF6 $NC" 
    $MGPATH/bin/mg5_aMC -f installLhapdf.cmd
}

function create_gridpack(){
    MG="$PYTHON $PWD/MG5_aMC_v3_4_2/bin/mg5_aMC"
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib/
    export PYTHONPATH=$PYTHONPATH:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib:$PWD/MG5_aMC_v3_4_2/HEPTools/lhapdf6_py3/lib64/python3.9/site-packages/LHAPDF-6.3.0-py3.9-linux-x86_64.egg/

    script=$1.sh
    echo $script
    bash ./$script
}

if [[ $step == 1 ]]; then
    install_mg
elif [[ $step == 2 ]]; then
    create_gridpack $process
fi    
