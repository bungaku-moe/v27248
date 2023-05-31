[eval exp="tf.start=false"]

[tempsave place="1"]


*reload
[call storage="omake_cfg.ks"]

[exbuttonopt delete="all"]
[clear_message_layer]
[rclick target="*exit" jump="true" enabled="true"]
[exkeybind key="VK_RETURN" shift="ssAlt" exp=""]

[bg file="omake_bg"]
;[image layer="0" storage="omake_bg" page="back"]

[freeimage layer="1" page="back"]
[freeimage layer="2" page="back"]
[freeimage layer="3" page="back"]

[if exp="scenario_comp == true"]
[eval exp="drawNumber(sf.scenario_percent, 'omake_number', 1, 'back', comp_locate[0],comp_locate[1], 3)"]
[endif]


[exbuttonopt delete="all"]

;CG鑑賞
[exbutton name="cg" x="&cg_button[0]" y="&cg_button[1]" file="omake_btn_cg" onenter="kag.se[1].play(%[storage:'sys007', loop:false])" onclick="kag.se[1].play(%[storage:'sys013', loop:false]),jump('', '*cg')"]

;BGM鑑賞
;[exbutton name="bgm" x="&bgm_button[0]" y="&bgm_button[1]" file="omake_btn_bgm" onenter="kag.se[1].play(%[storage:'sys007', loop:false])" onclick="kag.se[1].play(%[storage:'sys013', loop:false]),jump('', '*bgm')"]

;シーン鑑賞
[exbutton name="scene" x="&scene_button[0]" y="&scene_button[1]" file="omake_btn_scene" onenter="kag.se[1].play(%[storage:'sys007', loop:false])" onclick="kag.se[1].play(%[storage:'sys013', loop:false]),jump('', '*scene')"]

;ムービー鑑賞
;[exbutton name="movie" x="423" y="350" file="omake_btn_movie" onenter="kag.se[1].play(%[storage:'sys007', loop:false])" onclick="kag.se[1].play(%[storage:'sys013', loop:false]),jump('', '*movie')"]

;終わり
[exbutton name="exit" x="&exit_button[0]" y="&exit_button[1]" file="omake_btn_exit" onenter="kag.se[1].play(%[storage:'sys007', loop:false])" onclick="jump('', '*exit')"]
[exbuttonopt forevisible="false" backvisible="true"]

[crossfade time="500"]

*wait
[rclick target="*exit" jump="true" enabled="true"]
[exkeybind key="VK_RETURN" shift="ssAlt" exp=""]
[s]

*cg
[call storage="mode_cg.ks"]
[wt]
[jump target="*wait"]

*bgm
[call storage="mode_bgm.ks"]
[bgmopt gvolume="&sf.config.bgmVolume"]
[wt]
[jump target="*wait"]

*scene
[call storage="mode_scene.ks"]
[wt]
[jump target="*wait"]

*movie
[call storage="mode_movie.ks"]
[wt]
[jump target="*wait"]

*exit
[tempload place="1" backlay="true"]
[exbuttonopt delete="all"]
[crossfade time="500"]

[return]


