#!/bin/bash

mass_profile=(10 30 50 70 90 115)
pol_profile=("lr" "rl")
k=250200


new_filter=/afs/desy.de/group/flc/pool/ywang/light_scalar/slcio

echo "### start runinteg.sh date_time = `date +%y%m%d-%H%M%S`"

for j in {0..5}
do
	for i in {0..1}
	do
		mass=${mass_profile[j]}
		pol_in=${pol_profile[i]}
		if [[ ${pol_in} == "LR" || ${pol_in} == "lr" ]] ; then
			pol="eL.pR."
		elif [[ ${pol_in} == "RL" || ${pol_in} == "rl" ]] ; then
			pol="eR.pL."
		fi

		filter_name=E250-TDR_ws.Pe2e2h_mh${mass}.Gwhizard-1.95.${pol}I${k}
		cd ${filter_name} 
		mv ${filter_name}.001.slcio ${new_filter}
		cd ../
		k=$((k+1))
	done
done

echo "### whizard integ completed. date_time = `date +%y%m%d-%H%M%S`"

