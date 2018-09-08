rollout light_param_rollout_template "light param rollout template" width:944 height:92
(
	checkbox 'chk_on' "" pos:[33,26] width:18 height:20 align:#left
	label 'lbl2' "On" pos:[34,9] width:20 height:18 align:#left
	button 'btn_select' "" pos:[8,7] width:17 height:38 align:#left
	label 'lbl9d' "Type" pos:[58,9] width:66 height:14 align:#left
	dropdownList 'ddl1' "" pos:[56,31] width:84 height:21 align:#left
	label 'lbl_intensity' "Intensity" pos:[149,11] width:66 height:14 align:#left
	spinner 'spn_intensity' "" pos:[147,31] width:68 height:16 range:[0,100000,0] scale:0.01 align:#left
	spinner 'spn_exposure' "" pos:[221,31] width:68 height:16 range:[0,100000,0] scale:0 align:#left
	label 'lbl_exposure' "Exposure" pos:[223,11] width:66 height:14 align:#left
	checkbox 'chk_nrm_en' "" pos:[296,28] width:18 height:20 align:#left
	label 'lbl_nrm_en' "Normalize Energy" pos:[296,11] width:87 height:18 align:#left
	spinner 'spn_samples' "" pos:[393,31] width:68 height:16 range:[0,100,0] align:#left
	label 'lbl_samples' "Samples" pos:[395,11] width:66 height:14 align:#left
	spinner 'spn_vol_samples' "" pos:[467,31] width:79 height:16 range:[0,100,0] align:#left
	label 'lbl_vol_samples' "Volume Samples" pos:[469,11] width:83 height:14 align:#left
	label 'lbl_usr_op' "User Options" pos:[556,11] width:83 height:14 align:#left
	edittext 'edt_usr_op' "" pos:[552,27] width:381 height:21 align:#left
)
