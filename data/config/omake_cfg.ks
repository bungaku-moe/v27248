;----------------------------------------------------
;おまけ入り口画面　座標・環境設定ファイル
;
;TODO:　デザインに合わせて値を変更して下さい。
;
;おまけ画面の背景ファイル名：omake_bg
;----------------------------------------------------

[iscript]
//■ボタンの座標■
var cg_button    = [131,223];	//CG鑑賞ボタンの座標 x,y		ファイル名：omake_btn_cg
var bgm_button   = [453,118];	//bgm鑑賞ボタンの座標 x,y		ファイル名：omake_btn_bgm
var scene_button = [460,223];	//シーン鑑賞ボタンの座標 x,y	ファイル名：omake_btn_scene
var exit_button  = [652,552];	//戻るボタンの座標 x,y			ファイル名：omake_btn_exit

//■シナリオ達成率■
//
//変数　sf.scenario_percentの内容を表示します。
//数字ファイル名：omake_number.png
//
//sf.scenario_percentの計算実装は各ゲームで行って下さい。

var scenario_comp = false; 		//シナリオ達成率を表示するか？ false or true
var comp_locate = [455,371];	//シナリオ達成率の座標



[endscript]


[return]
