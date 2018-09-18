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
	
	fn lgt_change_intensity id val =
	(
		this.aLights[id].intensity = val
	),
	
	fn lgt_change_exposure id val =
	(
		this.aLights[id].exposure = val
	),
	
	fn lgt_change_normalize id state =
	(
		this.aLights[id].normalize = state
	),
	
	fn lgt_change_samples id val =
	(
		this.aLights[id].samples = val
	),
	
	fn lgt_change_volume_samples id val =
	(
		this.aLights[id].volume_samples = val
	),
	
	fn lgt_change_usr_options id val =
	(
		this.aLights[id].userOptions = val
	),
	
	fn lgt_change_name id val =
	(
		this.aLights[id].name = val
		this.ui.sub_rol_lights.rollouts[id]
	),
	
	fn buil_light_param_rollout id =
	(
		local rci = rolloutCreator ("arnold_light_rollout_" + id as string) "" width:1188 height:51
		local shape_type_selection = (this.aLights[id].shapeType + 1) as string
		local intensity = this.aLights[id].intensity
		local exposure = this.aLights[id].exposure
		local samples = this.aLights[id].samples
		local volume_samples = this.aLights[id].volume_samples
		local usr_opt_text = this.aLights[id].userOptions
		if usr_opt_text == undefined then usr_opt_text = ""
		
		rci.begin()
		
		rci.addControl #label "lbl_name" "Light Name:" paramStr:("pos:[8,1] width:83 height:14 align:#left")
		rci.addControl #edittext "edt_name" "" paramStr:("pos:[2,20] width:252 height:20 align:#left text:\"" + (this.aLights[id].name) + "\"")
		rci.addControl #button "btn_select" "Select" paramStr:"pos:[260,2] width:65 height:40 align:#left"
		rci.addControl #checkButton "chk_on" "ON" paramStr:("pos:[331,2] width:45 height:40 align:#left checked:" + this.aLights[id].on as string)
		rci.addControl #label "lbl_type" "Shape Type" paramStr:"pos:[386,1] width:66 height:14 align:#left"
		rci.addControl #dropdownList "ddl_type" "" paramStr:("pos:[384,20] width:84 height:21 align:#left items:(" + (this.aLight_types as string) + ") selection:" + shape_type_selection + "")
		rci.addControl #label "lbl_intensity" "Intensity"  paramStr:"pos:[481,1] width:55 height:14 align:#left"
		rci.addControl #spinner "spn_intensity" ""  paramStr:("pos:[475,21] width:68 height:16 align:#left range:[0,100000," + intensity as string + "] scale:(0.01)")
		rci.addControl #label "lbl_exposure" "Exposure" paramStr:(" pos:[556,1] width:55 height:14 align:#left")
		rci.addControl #spinner "spn_exposure" "" paramStr:("pos:[549,21] width:68 height:16 range:[0,100000," + exposure as string + "] scale:(0.01) align:#left")
		rci.addControl #checkbutton "ckb_normalize" "Normalize Energy" paramStr:("pos:[623,2] width:100 height:37 align:#left checked:" + this.aLights[id].normalize as string)
		rci.addControl #label "lbl_samples" "Samples" paramStr:("pos:[739,1] width:50 height:14 align:#left")
		rci.addControl #spinner "spn_samples" "" paramStr:("pos:[729,21] width:68 height:16 range:[0,1000000," + samples as string + "] scale:1 align:#left")
		rci.addControl #label "lbl_vol_samples" "Volume Samples" paramStr:("pos:[804,1] width:83 height:14 align:#left")
		rci.addControl #spinner "spn_vol_samples" "" paramStr:("pos:[804,21] width:79 height:16 range:[0,1000000," + volume_samples as string + "] scale:1 align:#left")
		rci.addControl #label "lbl_usr_op" "User Options" paramStr:("pos:[893,1] width:83 height:14 align:#left")
		rci.addControl #edittext "edt_usr_op" "" paramStr:(" pos:[888,20] width:288 height:20 align:#left text:\"" + usr_opt_text + "\"")
		
		rci.addHandler "chk_on" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_switch " + id as string + " val")
		rci.addHandler "ddl_type" #selected paramStr:"selection" codeStr:("Arnold_Light_Lister.lgt_change_type " + id as string + " selection")
		rci.addHandler "btn_select" #pressed filter:on codeStr:("Arnold_Light_Lister.lgt_select " + id as string)
		rci.addHandler "spn_intensity" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_intensity " + id as string + " val")
		rci.addHandler "spn_exposure" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_exposure " + id as string + " val")
		rci.addHandler "ckb_normalize" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_normalize " + id as string + " val")
		rci.addHandler "spn_samples" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_samples " + id as string + " val")
		rci.addHandler "spn_vol_samples" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_volume_samples " + id as string + " val")
		rci.addHandler "edt_usr_op" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_usr_options " + id as string + " val")
		rci.addHandler "edt_name" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_change_name " + id as string + " val")
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

global Arnold_Light_Lister = Arnold_Light_Lister()

rollout Arnold_Light_Lister_UI "Arnold Light Lister " width:1210 height:550
(
	button 'btn_refresh' "Refresh" pos:[10,7] width:65 height:22 align:#left
	subRollout 'sub_rol_lights' "Found Files" pos:[10,36] width:1198 height:500 align:#left
	on btn_refresh pressed do
	(
		for sub_rol in sub_rol_lights.rollouts do
		(
			removeSubRollout sub_rol_lights sub_rol
		)
		Arnold_Light_Lister.Init()
		Arnold_Light_Lister.populate_subrollouts()
	)
)

-----------------------------------------------------------------------------------------------
