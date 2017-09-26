#!/bin/bash
#this script can get the slcio file name, and how many files and basic information about the channel; 

if [[ $# != 7 ]] ; then
	echo "usage: ./get_file_name.sh energy(250/350/500/1000) input_class_name (higgs/4f_WW/4f_ZZ/2f_Z..) final_state (leptonic/hadronic/e2/e1..) pol_in (LR/lr/RL...)  ILD_version, reconstruction_version,simulation_version "
	exit
fi

energy=$1
energy_version=${energy}-TDR_ws
class_name=$2
final_states=$3
pol_in=$4
ILD_version=$5
reconstruction_version=$6_${energy}
simulation_version=$7



data_source=/pnfs/desy.de/ilc/prod/ilc/mc-dbd/ild/dst-merged
info_source=/pnfs/desy.de/ilc/prod/ilc/mc-dbd.log/generated 
if [[ ${class_name} == "higgs" ]] ; then
data_folder=${data_source}/${energy_version}/${class_name}_"ffh"/${ILD_version}/${reconstruction_version}
else
data_folder=${data_source}/${energy_version}/${class_name}_${final_states}/${ILD_version}/${reconstruction_version}
fi
info_folder=${info_source}/${energy_version}



if [[ ${pol_in} == "LR" || ${pol_in} == "lr" ]] ; then
	polarization="eL.pR"
elif [[ ${pol_in} == "RL" || ${pol_in} == "rl" ]] ; then
	polarization="eR.pL"
elif [[ ${pol_in} == "LL" || ${pol_in} == "ll" ]] ; then
	polarization="eL.pL"
elif [[ ${pol_in} == "RR" || ${pol_in} == "rr" ]] ; then
	polarization="eR.pR"
fi

if [[ ${class_name} == "4f_WW" ]] ; then
	short_class_name="4f_ww"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106581
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106582
		else
			exit
		fi
	elif [[ ${final_states} == "semileptonic" ]] ; then
		short_final_states="_sl"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106577
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106578
		else
			exit
		fi
	elif [[ ${final_states} == "hadronic" ]] ; then
		short_final_states="_h"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106551
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106552
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_ZZ" ]] ; then
	short_class_name="4f_zz"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106579
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106580
		else
			exit
		fi
	elif [[ ${final_states} == "semileptonic" ]] ; then
		short_final_states="_sl"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106575
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106576
		else
			exit
		fi
	elif [[ ${final_states} == "hadronic" ]] ; then
		short_final_states="_h"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106573
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106574
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_ZZWWMix" ]] ; then
	short_class_name="4f_zzorww"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then

		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106721
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106722
		else
			exit
		fi
	elif [[ ${final_states} == "hadronic" ]] ; then
		short_final_states="_h"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106553
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106554
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_singleZee" ]] ; then
	short_class_name="4f_sze"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106556
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106558
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106555
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106557
		else
			exit
		fi
	elif [[ ${final_states} == "semileptonic" ]] ; then
		short_final_states="_sl"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106560
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106562
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106559
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106561
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_singleZnunu" ]] ; then
	short_class_name="4f_sznu"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106589
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106590
		else
			exit
		fi
	elif [[ ${final_states} == "semileptonic" ]] ; then
		short_final_states="_sl"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106571
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106572
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_singleZsingleWMix" ]] ; then
	short_class_name="4f_szeorsw"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106568
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106570
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106567
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106569
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "4f_singleW" ]] ; then
	short_class_name="4f_sw"
	info_class_name="4f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106586
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106588
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106585
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106587
		else
			exit
		fi
	elif [[ ${final_states} == "semileptonic" ]] ; then
		short_final_states="_sl"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106564
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106566
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106563
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106565
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "2f_Z" ]] ; then
	short_class_name="2f_z"
	info_class_name="2f"
	if [[ ${final_states} == "leptonic" ]] ; then
		short_final_states="_l"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106605
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106606
		else
			exit
		fi
	elif [[ ${final_states} == "bhabhag" ]] ; then
		short_final_states="_bhabhag"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106602
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106604
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106601
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106603
		else
			exit
		fi
	elif [[ ${final_states} == "hadronic" ]] ; then
		short_final_states="_h"
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106607
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106608
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "higgs" ]] ; then
	short_class_name=""
	info_class_name="higgs"
	if [[ ${final_states} == "e1" ]] ; then
		short_final_states=e1e1h
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106476
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106477
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106475
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106478
		else
			exit
		fi
	elif [[ ${final_states} == "e2" ]] ; then
		short_final_states=e2e2h
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106479
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106480
		else
			exit
		fi
	elif [[ ${final_states} == "e3" ]] ; then
		short_final_states=e3e3h
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106481
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106482
		else
			exit
		fi
	elif [[ ${final_states} == "n" ]] ; then
		short_final_states=nnh
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106483
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106484
		else
			exit
		fi
	elif [[ ${final_states} == "q" ]] ; then
		short_final_states=qqh
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106485
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106486
		else
			exit
		fi
	elif [[ ${final_states} == "f" ]] ; then
		short_final_states=ffh
		if [[ ${polarization} == "eL.pR" ]] ; then
			file_id=106487
		elif [[ ${polarization} == "eR.pL"  ]] ; then
			file_id=106488
		elif [[ ${polarization} == "eL.pL"  ]] ; then
			file_id=106473
		elif [[ ${polarization} == "eR.pR"  ]] ; then
			file_id=106474
		else
			exit
		fi
	else
		exit
	fi

elif [[ ${class_name} == "aa" ]] ; then
	short_class_name="aa"
	if [[ ${final_states} == "2f" ]] ; then
		short_final_states="ee.eW.pW"
		info_class_name="aa_2f"
	elif [[ ${final_states} == "minijet" ]] ; then
		short_final_states="aa"
		info_class_name="aa_minijet"
	elif [[ ${final_states} == "hadronic" ]] ; then
		short_final_states="aa"
		info_class_name="aa_lowpt"
	else
		exit
	fi

fi


short_name=${short_class_name}${short_final_states}
file_name_basic=r${reconstruction_version}.s${simulation_version}.m${ILD_version}.E${energy_version}.I${file_id}.P${short_name}.${polarization}
file_name_ext=DST.slcio

info_name=${info_folder}/${info_class_name}/E${energy_version}.P${short_name}.Gwhizard-1_95.${polarization}.I${file_id}.txt



if [ ! -d ${data_folder} ] ; then
	echo "no such folder, please check!"
	exit
fi

if [ ! -f "${data_folder}/${file_name_basic}-00001-${file_name_ext}" ] ; then
	exit
fi

fnum=0

for j in ${data_folder}/${file_name_basic}* 
do
	fnum=$[fnum+1]
done







echo "channel is:  ${class_name} ${final_states} ${pol_in} is--------"
echo "info_name:    "${info_name}
xection=` grep "cross_section_in_fb" ${info_name} | cut -d "=" -f2 | sed -e "s/ //g" `
xection_err=` grep "cross_section_error_in_fb" ${info_name} | cut -d "=" -f2 | sed -e "s/ //g" `
lumi=` grep "luminosity" ${info_name} | cut -d "=" -f2 | sed -e "s/ //g" `
totnum=` grep "total_number_of_events" ${info_name} | cut -d "=" -f2 | sed -e "s/ //g" `
echo "xection is:      "${xection}
echo "xection err is:  "${xection_err}
echo "luminosity is:   "${lumi}
echo "totnum is:       "${totnum}


slcio_totnum=0
echo  "filenumberis:  "$fnum
for (( i=1; i<=$fnum; i++ )) 
do
	if [[ $i -lt $(( 10 )) ]] ; then
		file_number="0000${i}"
	elif [[ $i -gt $(( 9 )) && $i -lt $(( 100 )) ]] ; then
		file_number="000${i}"
	fi
    full_file_name=${data_folder}/${file_name_basic}-${file_number}-${file_name_ext}
	echo "file_name:    "${full_file_name}
	anainfo=" anajob $full_file_name 1 "
	slcio_num=` eval $anainfo | grep "number of events" | cut -d "," -f2 | cut -d ":" -f2  | sed -e "s/ ]//g" `
	echo "file_number:  " $slcio_num
	(( slcio_totnum= slcio_totnum + slcio_num ))
done
	echo "total_file_number:  " $slcio_totnum

