rollout light_param_rollout_template "light param rollout template" width:1078 height:61
(
	button 'btn_select' "Select" pos:[150,12] width:65 height:40 align:#left
	checkbutton 'ckb_on' "ON" pos:[221,12] width:45 height:40 align:#left
	label 'lbl9d' "Type" pos:[276,11] width:66 height:14 align:#left
	dropdownList 'ddl1' "" pos:[274,30] width:84 height:21 align:#left
	label 'lbl_intensity' "Intensity" pos:[371,11] width:55 height:14 align:#left
	spinner 'spn_intensity' "" pos:[365,31] width:68 height:16 range:[0,100000,0] scale:0.01 align:#left
	spinner 'spn_exposure' "" pos:[439,31] width:68 height:16 range:[0,100000,0] scale:0 align:#left
	label 'lbl_exposure' "Exposure" pos:[446,11] width:55 height:14 align:#left
	spinner 'spn_samples' "" pos:[619,31] width:68 height:16 range:[0,100,0] align:#left
	label 'lbl_samples' "Samples" pos:[629,11] width:50 height:14 align:#left
	spinner 'spn_vol_samples' "" pos:[694,31] width:79 height:16 range:[0,100,0] align:#left
	label 'lbl_vol_samples' "Volume Samples" pos:[694,11] width:83 height:14 align:#left
	label 'lbl_usr_op' "User Options :" pos:[783,11] width:83 height:14 align:#left
	edittext 'edt_usr_op' "" pos:[778,30] width:288 height:20 align:#left
	label 'lbl_name' "Light Name:" pos:[8,11] width:83 height:14 align:#left
	edittext 'edt_name' "" pos:[2,30] width:142 height:20 align:#left
	checkbutton 'ckb_normalize' "Normalize Energy" pos:[513,12] width:100 height:37 align:#left
	
)
