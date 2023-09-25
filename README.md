# Triple top-quark production at NLO in QCD ###

Bash scripts to compute triple top-quark production (tttj and tttw) at NLO in QCD with MG5_aMC (orders αS³α² and αS⁴α, respectively)


## Instructions
This has to be run in a lxplus9 node since it requiers python3.9 and that's the default
in RHEL9 distributions.
### Clone repository
`git clone git@github.com:Cvico/triple-top-nlo.git -b forCMS`
### Install MG+LHAPDF (only done once!!)
The production requires Madgraph5_aMC@NLO v3.4.2 and LHAPDF6 installation. We also need
to link the PDFs in the local directory to point to the ones stored in `/cvmfs/` just to
avoid having to download them again and again.
`./installMG`

This will set up everything and install MG code under `MG5_aMC_v3_4_2`.

### Create basic folder
`./create_gridpack $process`

Where process can be any script within this repository (without the `.sh` extension). 
**Note**: For the moment we haven't adapted the `*_lox.sh` ones. As of now the main
interest is just the NLO ones.  This will generate some events, and prepare the necessary 
templates to keep generating events without having to recompile everything. Then
it will create a gridpack-like file that can be used for batch generation in condor or slurm
clusters.

### Generate events
This can be done using the `submit_plhe.py` script. It can be done in single machine mode, for
condor submission or for slurm submission. Single machine mode should be used just for testing, and
it can be done as follows:

**Single Machine test**
```python3 submit_plhe.py $SEED --gridpack $PWD/${process}_tarball.tar.xz --outpath ./output_folder/ --nevents $NEVENTS```
Here `$SEED` is the seed to be used (the script automatically saves it in the used_seeds.dat file and it prevents the 
user for ever repeating that seed), and `$process` can be any of the processes that are available for production in 
this repository. `$NEVENTS` can be any number of events that is multiple of 2000 (this is hardcoded at the moment).

Each of the subfolders will have its own seed, generated from the initial seed given by the user. This way we
ensure independance between different generations. The output of each job is just a .lhe file that occupies very
little disk space.

**Condor submission**
The script is the same, but adding `--condor` anywhere after the `$SEED` part.

**Slurm submission**
The script is the same, but adding `--slurm` anywhere after the `$SEED` part.

## Specific instructions for contacts
**Run for tttjm**
Please not that these scripts will:
 * Unpack \~500MB gridpack
 * For 50000 events, this is done in 50000/2000=25 jobs. Meaning that a total of about 12 GB will be unpacked
   in a condor node. If we set the number of events generated simultaneously to something very large, then
   it will probably create problems in the lxplus nodes. **We don't want that**
 * Instead, produce events in batches of 50k or 100k events. Wait for them to finish, and continue with the following
   set of X events.
```
./installMG # EXECUTE ONLY ONCE!!!
./create_gridpack gen_tttjm
python3 submit_plhe.py $SEED --gridpack $PWD/gen_tttjm_tarball.tar.xz --outpath ./LHE_ttt_jm/ --nevents 50000
```

**Run for tttjp**
```
./installMG # EXECUTE ONLY ONCE!!!
./create_gridpack gen_tttjp
python3 submit_plhe.py $SEED --gridpack $PWD/gen_tttjp_tarball.tar.xz --outpath ./LHE_ttt_jp/ --nevents 50000 
```

**Run for tttwp**
```
./installMG # EXECUTE ONLY ONCE!!!
./create_gridpack gen_tttwm
python3 submit_plhe.py $SEED --gridpack $PWD/gen_tttwm_tarball.tar.xz --outpath ./LHE_ttt_wm/ --nevents 50000
```

**Run for tttwp**
```
./installMG # EXECUTE ONLY ONCE!!!
./create_gridpack gen_tttjp
python3 submit_plhe.py $SEED --gridpack $PWD/gen_tttjp_tarball.tar.xz --outpath ./LHE_ttt_jp/ --nevents 50000 
```

# Notes
1. The original author of this code is @gdurieux code: https://github.com/gdurieux/triple-top-nlo. Contact: Gauthier Durieux. DOI: https://doi.org/10.5281/zenodo.7682519
2. Here are the changes with respect to Gauthier version:
  a. Use NNPDF31_nnlo_as_0118_mc_hessian_pdfas (lhaid = 325300) instead of qed pdf
  b. Fix mW, mZ and mT to CMS settings
  c. Adapted systematic variations to CMS standards.



