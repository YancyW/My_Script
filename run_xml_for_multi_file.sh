#!/bin/bash

mass_profile=(10 30 50 70 90 115)
pol_profile=("lr" "rl")
k=250200



xml=./xml/My.xml
data_filter=/afs/desy.de/user/y/ywang/Events/pool/light_higgs/
channel_label="e2"

if [[ ${channel_label} == "e1" ]] ; then
	channel=e1e1h
elif [[ ${channel_label} == "e2" ]] ; then
	channel=e2e2h
elif [[ ${channel_label} == "e3" ]] ; then
	channel=e3e3h
elif [[ ${channel_label} == "n1" ]] ; then
	channel=n1n1h
elif [[ ${channel_label} == "n2" ]] ; then
	channel=n2n2h
elif [[ ${channel_label} == "n3" ]] ; then
	channel=n3n3h
elif [[ ${channel_label} == "l" ]] ; then
	channel=llh
elif [[ ${channel_label} == "n" ]] ; then
	channel=nnh
elif [[ ${channel_label} == "u" ]] ; then
	channel=uuh
elif [[ ${channel_label} == "d" ]] ; then
	channel=ddh
elif [[ ${channel_label} == "s" ]] ; then
	channel=ssh
elif [[ ${channel_label} == "c" ]] ; then
	channel=cch
elif [[ ${channel_label} == "b" ]] ; then
	channel=bbh
elif [[ ${channel_label} == "q" ]] ; then
	channel=qqh
elif [[ ${channel_label} == "f" ]] ; then
	channel=ffh
fi



echo "### start mass.sh date_time = `date +%y%m%d-%H%M%S`"

for j in {0..5}
do
	for i in {0..1}
	do
		mass=${mass_profile[j]}
		pol_in=${pol_profile[i]}
		if [[ ${pol_in} == "LR" || ${pol_in} == "lr" ]] ; then
			pol="eL.pR"
		elif [[ ${pol_in} == "RL" || ${pol_in} == "rl" ]] ; then
			pol="eR.pL"
		fi

		file_name=E250-TDR_ws.P${channel}_mh${mass}.Gwhizard-1.95.${pol}.I${k}
		input_file=${data_filter}${file_name}/${file_name}.001.slcio 
		para_mass="<parameter name=\"HiggsMass\" type=\"float\"> ${mass} </parameter>"
		output_file="<parameter name=\"RootFileName\"> ../results/mh${mass}${pol}.root </parameter>"
		sed -i "9c ${input_file}"  ${xml}
		sed -i "21c ${para_mass}"  ${xml}
		sed -i "22c ${output_file}"  ${xml}
		./run.sh 
		k=$((k+1))
		wait
	done
done

echo "### . date_time = `date +%y%m%d-%H%M%S`"

