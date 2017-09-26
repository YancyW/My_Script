#!/bin/bash
if [[ $# != 4  ]]; then
	exit
fi







if [[ $2 == "LR" || $2 == "lr" ]] ; then
	pol="eL.pR."
	pol_l="polarization = 1.0 0.0"
	pol_r="polarization = 0.0 1.0"
elif [[ $2 == "RL" || $2 == "rl" ]] ; then
	pol="eR.pL."
	pol_l="polarization = 0.0 1.0"
	pol_r="polarization = 1.0 0.0"
fi


if [[ $4 == "e1" ]] ; then
	channel=e1e1h
elif [[ $4 == "e2" ]] ; then
	channel=e2e2h
elif [[ $4 == "e3" ]] ; then
	channel=e3e3h
elif [[ $4 == "n1" ]] ; then
	channel=n1n1h
elif [[ $4 == "n2" ]] ; then
	channel=n2n2h
elif [[ $4 == "n3" ]] ; then
	channel=n3n3h
elif [[ $4 == "l" ]] ; then
	channel=llh
elif [[ $4 == "n" ]] ; then
	channel=nnh
elif [[ $4 == "u" ]] ; then
	channel=uuh
elif [[ $4 == "d" ]] ; then
	channel=ddh
elif [[ $4 == "s" ]] ; then
	channel=ssh
elif [[ $4 == "c" ]] ; then
	channel=cch
elif [[ $4 == "b" ]] ; then
	channel=bbh
elif [[ $4 == "q" ]] ; then
	channel=qqh
elif [[ $4 == "f" ]] ; then
	channel=ffh
fi





mass="mh$1"
id="I$3"
new_filter=E250-TDR_ws.P${channel}_${mass}.Gwhizard-1.95.${pol}${id}
mkdir ${new_filter}


cp origin_whizard/* ./${new_filter}/
cd ${new_filter}
write_events="write_events_file = \"E250-TDR_ws.P${channel}_${mass}.Gwhizard-1.95.${pol}${id}\" "
pythia="pythia_parameters = \"PMAS(25,1)=$1.0; PMAS(25,2)=0.0043;"
setmh="MH = $1.0"
process_name="process_id = \"${channel}_o\""


sed -i "2c ${process_name}" ./whizard.in
sed -i "28c ${write_events}" ./whizard.in
sed -i "33c ${pythia}" ./whizard.in
sed -i "65c ${setmh}" ./whizard.in
sed -i "71c ${pol_l}" ./whizard.in
sed -i "86c ${pol_r}" ./whizard.in


./whizard > whizard-integ.log 2>&1
wait
./prepar_infomation_for_stdhep.sh> ${new_filter}.txt
wait
cd ../
