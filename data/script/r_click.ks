
*r_click

;状況を保存
[tempsave place="0"]

@eval exp="fubuki_object.uninit()"
@eval exp="snow_object.uninit()"
;@eval exp="sakurafubuki_object.uninit()"
;@eval exp="sakura_object.uninit()"

;メッセージレイヤを非表示
[layopt layer="message0" page="back" visible="false"]
[layopt layer="message1" page="back" visible="false"]
[layopt layer="message2" page="back" visible="false"]
[layopt layer="message3" page="back" visible="false"]
[layopt layer="message4" page="back" visible="false"]

;フェイスウインドウを非表示
[layopt layer="0" page="back" visible="false"]

[image layer="0" storage="rc_menu_base" page="back" visible="true" left="0" top="0"]

;メニュー＆ウインドウボタンを非表示
[exmenuopt delete="all"]
[exsmenuopt delete="all"]
[exformopt delete="all" forevisible="false" backvisible="true"]

;右クリック時の処理先を指示
[rclick jump=true target="*r_click_exit" storage="r_click.ks" enabled=true]

[exkeybind key="VK_SPACE" exp=""]


;美しくないけどボタン表示制御
[exbutton name="config"	x="225"	y="240"	file="rc_menu_config"	onclick="kag.process('', '*r_config')" hint="コンフィグ画面へ移行します"]

[if exp="tf.scene_mode !== true && sf.trial !== true"]
[exbutton name="save"	x="225"	y="270"	file="rc_menu_save"	onclick="kag.process('', '*r_save')" hint="セーブを行います"]
[exbutton name="load"	x="449"	y="270"	file="rc_menu_load"	onclick="kag.process('', '*r_load')" hint="ロードを行います"]
[endif]

[exbutton name="log"	x="225"	y="300"	file="rc_menu_log"	onclick="showHistory()" hint="バックログを表示します"]

[if exp="tf.scene_mode !== true && canBackHistory()"]
[exbutton name="back"	x="225"	y="330"	file="rc_menu_back"	onclick="backHistory()" hint="直前の選択肢に戻ります"]
[endif]

[if exp="tf.scene_mode !== true"]
[exbutton name="return"	x="449"	y="330"	file="rc_menu_return"	onclick="goToStart()" hint="タイトルへ戻ります"]
[endif]
[exbutton name="exit"	x="225"	y="360"	file="rc_menu_exit"	onclick="kag.close()" hint="ゲームを終了します"]

[crossfade time="100"]

*reload

;クリック待ち
[s]

*r_save
[call storage="mode_saveload.ks" target="*save"]
[jump target="*reload"]

*r_load
[call storage="mode_saveload.ks" target="*load"]
[jump target="*reload"]

*r_config
[call storage="mode_config.ks" target="*config"]
[jump target="*reload"]


*r_click_exit

;保存状況に復帰
[freeimage layer="1" page="back"]
[tempload place="0" backlay="true" bgm="false" se="false"]
[exformopt forevisible="false" backvisible="true"]

;各種状態を復帰
[eval exp="colormode_recovery()"]

[crossfade time="100"]

;右クリック時の処理先を指示
[rclick enabled="true" call="true" storage="r_click.ks" target="*r_click"]

[exkeybind key="VK_SPACE" exp="toggleMessageShowing()"]

[return]
