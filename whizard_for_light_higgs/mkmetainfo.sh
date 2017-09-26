#!/bin/bash

# =====================================================================
ToPolarization()
{
cat <<EOF | python - $*
import sys
argvs=sys.argv
ratl=float(argvs[1])
ratr=float(argvs[2])
pol=(ratr-ratl)/(ratr+ratl)
polstr="R"
if pol < 0 :
  polstr="L"
intpol=int(abs(pol*100.0))
if intpol > 99 : 
  print polstr
else :
  print polstr+str(intpol)
EOF
}

# ======================================================================
ScanStdhepFiles()
{
  for f in *.stdhep ; do
    fcomp=( `echo $f | sed -e "s/\./ /g" ` )
    icomp=${#fcomp[*]}
    serstr=`printf %3.3d ${fcomp[$[icomp-2]]}`
    fpref=`echo $f | sed -e "s/\.[0-9]*\.stdhep$//" `
    newname=${fpref}.${serstr}.stdhep
    mv ${f} ${newname}
  done

  nfiles=0
  filenames=
  nevents=
  nevtotal=0

  rm -rf rflog
  mkdir rflog

  for f in *.stdhep ; do
    nevt=` grep "ilc_fragment_print ncount"  whizard-integ.log | cut -d "=" -f2 | sed -e "s/ //g" `
    nevtotal=$[nevtotal+nevt]
    nfiles=$[nfiles+1]
    if [ "x${filenames}" == "x" ] ; then
      filenames=${f}
      nevents=${nevt}
    else
      filenames="${filenames};${f}"
      nevents="${nevents};${nevt}"
    fi

  done
  echo "total_number_of_events=${nevtotal}"
  echo "number_of_files=${nfiles}"
  echo "file_names=${filenames}"
  echo "number_of_events_in_files=${nevents}"
  rm -rf rflog
}

timezone="GMT+900"
ecmint=` grep "sqrts" whizard.in | head -1 | cut -d "=" -f2 | sed -e "s/ //g" `
channel=` grep "process_id" whizard.in | head -1 | cut -d "\"" -f2 | sed -e "s/\"//g" -e "s/ //g"  -e "s/\_o//g" `
number=` grep "write_events_file = \"E${ecmint}-TDR_ws.P${channel}" whizard.in | head -1 | cut -d "I" -f2 | sed -e "s/\"//g" -e "s/ //g" `
mass=`grep "MH =" whizard.in |  cut -d "=" -f2 | sed -e "s/ //g" -e "s/\.0//g" ` 

fortran_version=` gfortran --version | grep "GNU Fortran (GCC)" | cut -d ")" -f2 | sed -e "s/ //g" `

echo "process_id=${number}"
echo "job_date_time=`date +%y%m%d-%H%M%S`-${timezone}"
echo "process_name=${channel}_mh${mass}"
echo "process_type=${channel}_mh${mass}"
echo "CM_energy_in_GeV=${ecmint}"
echo "lcgentools_version=v2r2"
echo "program_name_version=whizard-1_95"
echo "pythia_version=6.422"
echo "stdhep_version=5-06-01"
echo "OS_version_build=2.6.32-696.1.1.el5;x86_64/GNU/Linux"
echo "OS_version_run=`uname -r`;`uname -p`/`uname -o`"
echo "libc_version=`rpm -q glibc | grep \"x86_64\"`"
echo "fortran_version=gfortran-${fortran_version}"
echo "hadronisation_tune=OPAL"
echo "tau_decay=tauola"
beam_particle1=` grep particle_name whizard.in | head -1 | cut -d"=" -f2 | sed -e "s/'//g" -e "s/ //g" `
beam_particle2=` grep particle_name whizard.in | head -2 | tail -1 | cut -d"=" -f2 | sed -e "s/'//g" -e "s/ //g" `
polin1=`grep polarization whizard.in | head -1 | cut -d"=" -f2` 
polarization1=`ToPolarization ${polin1}`
polin2=`grep polarization whizard.in | head -2 | tail -1 | cut -d"=" -f2` 
polarization2=`ToPolarization ${polin2}`

echo "beam_particle1=${beam_particle1}"
echo "beam_particle2=${beam_particle2}"
echo "polarization1=${polarization1}"
echo "polarization2=${polarization2}"

luminosity=`grep -i luminosity whizard.out | cut -d"=" -f2 | sed -e "s/ *//g"`
xsectstr=`grep sum whizard.out | tail -1 | sed -e "s/  */ /g" -e "s/^ *//g" | cut -d" " -f2 `
cross_section=`echo print ${xsectstr} | python - `
xsecterrstr=`grep sum whizard.out | tail -1 | sed -e "s/  */ /g" -e "s/^ *//g" | cut -d" " -f3 `
cross_section_error=`echo print ${xsecterrstr} | python - `

echo "luminosity=${luminosity}"
echo "cross_section_in_fb=${cross_section}"
echo "cross_section_error_in_fb=${cross_section_error}"
echo "lumi_linker_number=22"
echo "machine_configuration=TDR_ws"
echo "file_type=stdhep24"

ScanStdhepFiles

# echo "total_number_of_events=${total_number_of_events}"
# echo "number_of_files=${number_of_files}"
# echo "file_names=${file_names}"
# echo "number_of_events_in_files=${number_of_events}"

ecm_conf="${ecmint}-TDR_ws"
echo "fileurl=lfn:/grid/ilc/prod/ilc/mc-dbd/generated/${ecm_conf}/higgs"
echo "logurl=http://ilcsoft.desy.de/dbd/generated/${ecmint}/higgs/"
echo "higgs_mass=${mass}.0"
echo "comment=light higgs mass is ${mass} GeV, decay profile is the same as SM higgs"

