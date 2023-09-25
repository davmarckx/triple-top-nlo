# ------------------------------- #
# Script to install MG and LHAPDF #
# ------------------------------- #

# For printing messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Some paths
MGPATH=$PWD/MG5_aMC_v3_4_2/
function install_mg() {
    # Function to get MG342
    
    echo -e "$GREEN >> Installing MG $NC" 
    wget -O mg5.tar.gz https://launchpad.net/mg5amcnlo/3.0/3.4.x/+download/MG5_aMC_v3.4.2.tar.gz
    tar xzf mg5.tar.gz 

    # Install LHAPDF
    echo "install lhapdf6" >> installLhapdf.cmd
    echo -e "$GREEN >> Installing LHAPDF6 $NC" 
    $MGPATH/bin/mg5_aMC -f installLhapdf.cmd


    if [[ -d $MGPATH/HEPTools/lhapdf6_py3/share/LHAPDF ]]; then 
        # Make soft links to fetch CMSSW pdfs
        echo -e "$GREEN >> Making soft links for PDF variations $NC" 
        pushd $MGPATH/HEPTools/lhapdf6_py3/share/LHAPDF/
	rm pdfsets.index # Take the one from cvmfs
        for file in $(ls /cvmfs/cms.cern.ch/slc7_amd64_gcc10/external/lhapdf/6.4.0-f99dd75eb8675a339d8b05f6184e6d59/share/LHAPDF/); do ln -s /cvmfs/cms.cern.ch/slc7_amd64_gcc10/external/lhapdf/6.4.0-f99dd75eb8675a339d8b05f6184e6d59/share/LHAPDF/$file $file ; done
        popd
    fi
}

install_mg
