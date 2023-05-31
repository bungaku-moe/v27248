



;------------------------------------------------------------------------------
;	画面揺らし（スキップモード時は実行しない）
;	※引数は[quake]と同じ
;------------------------------------------------------------------------------
[macro name="quake2"]
	[stoptrans]
	[if exp="kag.skipMode<=1"]
		[quake *]
	[endif]
[endmacro]



;------------------------------------------------------------------------------
;	フラッシュ
;	[flash layer="フラッシュ用に使うレイヤーNO" count="フラッシュの回数" interval="フラッシュの間隔"]
;------------------------------------------------------------------------------
[macro name="flash"]
	[stoptrans]
	[if exp="kag.skipMode<=1"]
		[eval exp="tf.layer=mp.layer, tf.count=mp.count, tf.interval=mp.interval"]
		[call storage="effect.ks" target="*flash"]
	[endif]
[endmacro]

;------------------------------------------------------------------------------
;	フラッシュ２（黄色：カメラ用）
;	[flash2 layer="フラッシュ用に使うレイヤーNO" count="フラッシュの回数" interval="フラッシュの間隔"]
;------------------------------------------------------------------------------
[macro name="flash2"]
	[stoptrans]
	[if exp="kag.skipMode<=1"]
		[eval exp="tf.layer=mp.layer, tf.count=mp.count, tf.interval=mp.interval"]
		[call storage="effect.ks" target="*flash2"]
	[endif]
[endmacro]

[return]


;フラッシュ用サブルーチン
*flash|
	[image layer="&tf.layer" storage="white" page="fore" visible="false"]
	[resetwait]
*flashloop|
	[if exp="&tf.interval !== void"]
	[wait time="&tf.interval"]
	[layopt layer="&tf.layer" page="fore" visible="true"]
	[wait time="&tf.interval"]
	[layopt layer="&tf.layer" page="fore" visible="false"]
	[jump target="*flashloop" cond="tf.count--"]
	[endif]
[return]


;フラッシュ２用サブルーチン
*flash2|
	[image layer="&tf.layer" storage="yellow" page="fore" visible="false"]
	[resetwait]
*flash2loop|
	[if exp="&tf.interval !== void"]
	[wait time="&tf.interval"]
	[layopt layer="&tf.layer" page="fore" visible="true"]
	[wait time="&tf.interval"]
	[layopt layer="&tf.layer" page="fore" visible="false"]
	[jump target="*flash2loop" cond="tf.count--"]
	[endif]
[return]



