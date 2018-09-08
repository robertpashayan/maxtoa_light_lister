global Arnold_Light_Lister
global Arnold_Light_Lister_UI

struct Arnold_Light_Lister
(
	aLights = #(),
	ui,
	
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
	
	fn buil_light_param_rollout id =
	(
		local rci = rolloutCreator "arnold_light_rollout" (this.aLights[id].name) width:154 height:92
		
		
		rci.begin()
		rci.addControl #label "lbl_on" "On" paramStr:"pos:[34,9] width:20 height:18 align:#left"
		rci.addControl #checkbox "chk_on" "" paramStr:("pos:[33,26] width:18 height:20 align:#left checked:" + this.aLights[id].on as string)
		rci.addControl #button "btn_select" "" paramStr:"pos:[8,7] width:17 height:38 align:#left"
		
		rci.addHandler "chk_on" #changed paramStr:"val" codeStr:("Arnold_Light_Lister.lgt_switch " + id as string + " val")
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
				print i
				sub_rollout_ = this.buil_light_param_rollout i
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
rollout Arnold_Light_Lister_UI "Arnold Light Lister" width:1074 height:500
(
	label 'lbl_Name' "Arnold Light Lister" pos:[470,7] width:196 height:16 align:#left
	subRollout 'sub_rol_lights' "Found Files" pos:[5,27] width:1064 height:455 align:#left
	on Arnold_Light_Lister_UI open do
	(
		
	)
)

try(destroyDialog Arnold_Light_Lister_UI)catch()
Arnold_Light_Lister = Arnold_Light_Lister()
Arnold_Light_Lister.Init()
createDialog Arnold_Light_Lister_UI
Arnold_Light_Lister.ui = Arnold_Light_Lister_UI
Arnold_Light_Lister.populate_subrollouts()

rollout unnamedRollout "Untitled" width:1024 height:92
(
	checkbox 'chk_on' "" pos:[33,26] width:18 height:20 align:#left
	label 'lbl2' "On" pos:[34,9] width:20 height:18 align:#left
	button 'btn_select' "" pos:[8,7] width:17 height:38 align:#left
	
	spinner 'spn1' "" pos:[147,31] width:68 height:16 align:#left
	label 'lbl3' "Intensity" pos:[149,11] width:66 height:14 align:#left
	spinner 'spn2' "" pos:[221,31] width:68 height:16 range:[0,100,0] align:#left
	label 'lbl4' "Exposure" pos:[223,11] width:66 height:14 align:#left
	label 'lbl5' "Res. Intensity" pos:[297,11] width:72 height:14 align:#left
	label 'lbl6' "000000000" pos:[297,31] width:72 height:14 align:#left
	checkbox 'chk3' "" pos:[379,28] width:18 height:20 align:#left
	label 'lbl7' "Normalize Energy" pos:[379,11] width:87 height:18 align:#left
	spinner 'spn4' "" pos:[476,31] width:68 height:16 range:[0,100,0] align:#left
	label 'lbl8' "Samples" pos:[478,11] width:66 height:14 align:#left
	spinner 'spn5' "" pos:[550,31] width:79 height:16 range:[0,100,0] align:#left
	label 'lbl9' "Volume Samples" pos:[552,11] width:83 height:14 align:#left
	label 'lbl9d' "Type" pos:[58,9] width:66 height:14 align:#left
	dropdownList 'ddl1' "" pos:[56,31] width:84 height:21 align:#left
)


--track the light in case they get deleted and deactivate the subrollout
-----------------------------------------------------------------------------------------------
