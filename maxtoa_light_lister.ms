global Arnold_Light_Lister
global Arnold_Light_Lister_UI

struct Arnold_Light_Lister
(
	aLights = #(),
	ui,
	aLight_types = #("Point","Distant","Spot","Quad","Disc","Cylinder","SkyDome","Photo..","Mesh"),
	
	fn sort_by_name a b =
	(
		case of
		(
			(a.name < b.name):-1
			(a.name > b.name): 1
			default:0
		)
	),
	
	fn lgt_switch id state =
	(
		this.aLights[id].on = state
	),
	
	fn lgt_select id =
	(
		select (this.aLights[id])
	),
	
	fn lgt_change_type id type_id =
	(
		this.aLights[id].shapeType = (type_id - 1)
	),
	
	fn buil_light_param_rollout id =
	(
		local rci = rolloutCreator ("arnold_light_rollout_" + id as string) (this.aLights[id].name) width:944 height:92
		local shape_type_selection = (this.aLights[id].shapeType + 1) as string
		local intensity = this.aLights[id].intensity
		local exposure = this.aLights[id].exposure
		local res_int = this.aLights[id].exposure
		rci.begin()
		rci.addControl #label "lbl_on" "On" paramStr:"pos:[34,9] width:20 height:18 align:#left"
		rci.addControl #checkbox "chk_on" "" paramStr:("pos:[33,26] width:18 height:20 align:#left checked:" + this.aLights[id].on as string)
		rci.addControl #button "btn_select" "" paramStr:"pos:[8,7] width:17 height:37 align:#left"
		rci.addControl #label "lbl_type" "Shape Type" paramStr:"pos:[58,9] width:66 height:14 align:#left"
		rci.addControl #dropdownList "ddl_type" "" paramStr:("pos:[56,30] width:84 height:21 align:#left items:(" + (this.aLight_types as string) + ") selection:" + shape_type_selection + "")
		rci.addControl #label "lbl_intensity" "Intensity"  paramStr:"pos:[149,11] width:66 height:14 align:#left"
		rci.addControl #spinner "spn_intensity" ""  paramStr:("pos:[147,31] width:68 height:16 align:#left range:[0,100000," + intensity as string + "] scale:(0.01)")
		rci.addControl #label "lbl_exposure" "Exposure" paramStr:("pos:[223,11] width:66 height:14 align:#left")
		rci.addControl #spinner "spn_exposure" "" paramStr:("pos:[221,31] width:68 height:16 range:[0,100000," + exposure as string + "] scale:0 align:#left")
		rci.addControl #label "lbl_nrm_en" "Normalize Energy" paramStr:(" pos:[296,11] width:87 height:18 align:#left")
		rci.addControl #checkbox "chk_nrm_en" "" paramStr:(" pos:[296,28] width:18 height:20 align:#left")
		rci.addControl #label "lbl_samples" "Samples" paramStr:(" pos:[395,11] width:66 height:14 align:#left")
		rci.addControl #spinner "spn_samples" "" paramStr:(" pos:[393,31] width:68 height:16 range:[0,100,0] align:#left")
		rci.addControl #label "lbl_col_samples" "Volume Samples" paramStr:(" pos:[469,11] width:83 height:14 align:#left")
		rci.addControl #spinner "spn_col_samples" "" paramStr:(" pos:[467,31] width:79 height:16 range:[0,100,0] align:#left")
		rci.addControl #label "lbl_usr_op" "User Options" paramStr:(" pos:[556,11] width:83 height:14 align:#left")
		rci.addControl #edittext "edt_usr_op" "" paramStr:(" pos:[552,27] width:381 height:21 align:#left")
		
		rci.addHandler "chk_on" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_switch " + id as string + " val")
		rci.addHandler "ddl_type" #selected paramStr:"selection" codeStr:("Arnold_Light_Lister.lgt_change_type " + id as string + " selection")
		rci.addHandler "btn_select" #pressed filter:on codeStr:("Arnold_Light_Lister.lgt_select " + id as string)
		rci.end()
		return rci.def
	),

	fn populate_subrollouts =
	(
		
		local count = this.aLights.count
		local sub_rollout_ 
		if this.ui != undefined then
		(
			for i=1 to count do 
			(
				
				sub_rollout_ = this.buil_light_param_rollout i
				sub_rollout_.ddl_type.items = this.aLight_types
				addSubRollout (this.ui.sub_rol_lights) sub_rollout_ rolledUp:false
			)
		)
	),
	
	fn clean_subrollouts =
	(
		local count = (this.ui.mipmaps).rollouts.count
		for i=1 to count do removeSubRollout (this.ui.mipmaps) ((this.ui.mipmaps).rollouts)[1]
	),

	fn Init =
	(
		this.aLights = for obj in objects where classof obj == Arnold_Light collect obj
		qsort (this.aLights) (this.sort_by_name)
	)
)
rollout Arnold_Light_Lister_UI "Arnold Light Lister " width:984 height:800
(
	label 'lbl_Name' "Arnold Light Lister" pos:[470,7] width:196 height:16 align:#left
	subRollout 'sub_rol_lights' "Found Files" pos:[5,27] width:964 height:455 align:#left
	on Arnold_Light_Lister_UI open do
	(
		
	)
)

try(Arnold_Light_Lister.ui = undefined; destroyDialog Arnold_Light_Lister_UI)catch()
Arnold_Light_Lister = Arnold_Light_Lister()
Arnold_Light_Lister.Init()
createDialog Arnold_Light_Lister_UI
Arnold_Light_Lister.ui = Arnold_Light_Lister_UI
Arnold_Light_Lister.populate_subrollouts()


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
	spinner 'spn_col_samples' "" pos:[467,31] width:79 height:16 range:[0,100,0] align:#left
	label 'lbl_col_samples' "Volume Samples" pos:[469,11] width:83 height:14 align:#left
	label 'lbl_usr_op' "User Options" pos:[556,11] width:83 height:14 align:#left
	edittext 'edt_usr_op' "" pos:[552,27] width:381 height:21 align:#left
)


--track the light in case they get deleted and deactivate the subrollout
-----------------------------------------------------------------------------------------------
