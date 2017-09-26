#!/bin/bash

mass_profile=(10 30 50 70 90 115)
pol_profile=("lr" "rl")
k=250200



echo "### start runinteg.sh date_time = `date +%y%m%d-%H%M%S`"

for j in {0..5}
do
	for i in {0..1}
	do
		mass=${mass_profile[j]}
		pol=${pol_profile[i]}
 		./runwhizard.sh  ${mass} ${pol}  ${k}  e2
		k=$((k+1))
	done
done

echo "### whizard integ completed with ${ret}. date_time = `date +%y%m%d-%H%M%S`"

