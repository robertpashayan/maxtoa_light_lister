macroScript MCR_arnold_light_lister
ButtonText:"Arnold Light Lister"
category:"Arnold Utilities"
toolTip:"An interface wich allows you yo control some of the parameters of the arnold light in the scene."
(
	
	if ::Arnold_Light_Lister_UI != undefined and ::Arnold_Light_Lister != undefined then
	(
		if not ::Arnold_Light_Lister_UI.open then
		(
			Arnold_Light_Lister.Init()
			createDialog Arnold_Light_Lister_UI
			Arnold_Light_Lister.ui = Arnold_Light_Lister_UI
			Arnold_Light_Lister.populate_subrollouts()
		)
	)
)
