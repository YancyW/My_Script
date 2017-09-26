#!/bin/bash
cd ./results

pol_l="eL.pR"
pol_r="eR.pL"
pol=${pol_l}
mass_profile="{ \"mh10${pol}\",
 				\"mh30${pol}\",
 				\"mh50${pol}\", 
 				\"mh70${pol}\", 
 				\"mh90${pol}\", 
                \"mh115${pol}\"}"



root -l recoil_mass.C"(${mass_profile})"
root -l gen_pair_mass.C"(${mass_profile})"
root -l gen_pair_pt.C"(${mass_profile})"
root -l gen_pair_rap.C"(${mass_profile})"
root -l gen_recoil_mass.C"(${mass_profile})"
root -l init_energy1.C"(${mass_profile})"
root -l init_energy2.C"(${mass_profile})"
root -l init_energy.C"(${mass_profile})"
root -l ISR_elec_energy1.C"(${mass_profile})"
root -l ISR_elec_energy2.C"(${mass_profile})"
root -l ISR_elec_mass.C"(${mass_profile})"
root -l ISR_photon_energy1.C"(${mass_profile})"
root -l ISR_photon_energy2.C"(${mass_profile})"
root -l ISR_photon_mass.C"(${mass_profile})"
root -l mc_pair_pt.C"(${mass_profile})"
root -l mc_pair_rap.C"(${mass_profile})"
root -l pair_mass.C"(${mass_profile})"
root -l recoil_mass.C"(${mass_profile})"
