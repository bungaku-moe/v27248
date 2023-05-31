;レイヤの初期化文

[call storage="emotion_cfg.ks"]

;★漫符表現マクロ
;
;漫符を出すマクロです。ラグナロクオンラインに倣ってエモーションと呼びます。
;こーゆーのはTJSでプラグインを書いた方がよいと思った

[macro name="emotion_on"]

;★エモーションが指定されたレイヤmp.layer
;　ファイル名先頭３文字charname[mp.layer].substring(0,3)
;　を利用してemo_tableから座標を持ってきます

	[eval exp="mp.emx='x_' + emotion_type[mp.layer] + '_' + charname[mp.layer].substring(0,3)"]
	[eval exp="mp.emy='y_' + emotion_type[mp.layer] + '_' + charname[mp.layer].substring(0,3)"]
	[eval exp="mp.x=+char_center[mp.layer]+emo_table[mp.emx]"]
	[eval exp="mp.y=+emo_table[mp.emy]"]
;	mp.emx=[emb exp="mp.emx"][r]
;	mp.emy=[emb exp="mp.emy"][r]
;	mp.x=[emb exp="mp.x"][r]
;	mp.y=[emb exp="mp.y"][r]
;エモーションに使用するレイヤは立ちレイヤの +5 中央なら9、左右なら7 8となる

	[eval exp="tf.emotion_layer=+mp.layer + 5"]

		[if exp="emotion_type[mp.layer] == 'tameiki'"]
			[tameiki x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]
		
		[if exp="emotion_type[mp.layer] == 'shock'"]
			[shock x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'ase'"]
			[ase x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'ikari'"]
			[ikari x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'hatena'"]
			[hatena x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'bikkuri'"]
			[bikkuri x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'mugon'"]
			[mugon x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

		[if exp="emotion_type[mp.layer] == 'niko'"]
			[niko x="&mp.x" y="&mp.y" layer_no="&tf.emotion_layer"]
		[endif]

[endmacro]


;エモーション別マクロ

[macro name="bikkuri"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[fgzoom storage="emo07" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]+118" sw="28" sh="0" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="28" dh="118" time="125" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo07" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]" sw="28" sh="118" dt="&tf.emo[1]+18" dl="&tf.emo[0]" dw="28" dh="100" time="50" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo07" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]+18" sw="28" sh="100" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="28" dh="118" time="150" accel="-2"]
	[wfgzoom]
	[image storage="emo07" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" page="fore" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[wait time="500" canskip="true"]
	[layopt layer="&mp.layer_no" page="back" opacity="0" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="200"]
[endmacro]

[macro name="hatena"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[fgzoom storage="emo05" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]+150" sw="48" sh="0" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="48" dh="80" time="300" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo05" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]" sw="48" sh="80" dt="&tf.emo[1]+20" dl="&tf.emo[0]" dw="48" dh="60" time="50" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo05" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]+20" sw="48" sh="60" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="48" dh="80" time="150" accel="-2"]
	[wfgzoom]
	[image storage="emo05" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" page="fore" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[wait time="500" canskip="true"]
	[layopt layer="&mp.layer_no" page="back" opacity="0" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="200"]
[endmacro]

[macro name="tameiki"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[image storage="emo01" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" opacity="255" left="&mp.x" top="&mp.y" ]
	[move2 layer="&mp.layer_no" page="fore" time="500" path="(&tf.emo[0],&tf.emo[1],255)(&tf.emo[0]+20,&tf.emo[1]+20,0)" accel="-4"]
[endmacro]

[macro name="shock"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[image storage="emo02" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" visible="true"]
	[wait time="35"]
	[layopt layer="&mp.layer_no" opacity="40" left="&tf.emo[0]" top="&tf.emo[1]" visible="true"]
	[wait time="35"]
	[layopt layer="&mp.layer_no" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" visible="true"]
	[wait time="35"]
	[layopt layer="&mp.layer_no" opacity="40" left="&tf.emo[0]" top="&tf.emo[1]" visible="true"]
	[wait time="35"]
	[image storage="clear" layer="&mp.layer_no" page="back" visible="true" opacity="0"]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="200"]
[endmacro]


[macro name="ase"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[image storage="emo03" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[backlay layer="&mp.layer_no"]
	[layopt layer="&mp.layer_no" page="fore" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[move2 layer="&mp.layer_no" page="fore" time="250" path="(&tf.emo[0],&tf.emo[1],255)(&tf.emo[0],&tf.emo[1]+40,255)" accel="0"]
	[wm2]
	[image storage="clear" layer="&mp.layer_no" page="back" visible="true" opacity="0"]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="250"]
[endmacro]

[macro name="mugon"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[image storage="emo04" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" page="fore" opacity="0" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[move2 layer="&mp.layer_no" page="fore" time="100" path="(&tf.emo[0],&tf.emo[1],0)(&tf.emo[0],&tf.emo[1]-20,255)" accel="-4"]
	[wm2]
	[wait time="500"]
	[layopt layer="&mp.layer_no" page="back" opacity="0" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="250"]
[endmacro]

[macro name="ikari"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[fgzoom storage="emo06" layer="&mp.layer_no" sl="&tf.emo[0]-10" st="&tf.emo[1]-10" sw="90" sh="107" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="75" dh="92" time="50" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo06" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]" sw="75" sh="92" dt="&tf.emo[1]-3" dl="&tf.emo[0]-3" dw="80" dh="97" time="30" accel="+2"]
	[wfgzoom]
	[fgzoom storage="emo06" layer="&mp.layer_no" sl="&tf.emo[0]-3" st="&tf.emo[1]-3" sw="80" sh="97" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="75" dh="93" time="30" accel="-2"]
	[wfgzoom]
	[fgzoom storage="emo06" layer="&mp.layer_no" sl="&tf.emo[0]" st="&tf.emo[1]" sw="75" sh="92" dt="&tf.emo[1]-3" dl="&tf.emo[0]-3" dw="80" dh="97" time="30" accel="+2"]
	[wfgzoom]
	[fgzoom storage="emo06" layer="&mp.layer_no" sl="&tf.emo[0]-3" st="&tf.emo[1]-3" sw="80" sh="97" dt="&tf.emo[1]" dl="&tf.emo[0]" dw="75" dh="93" time="30" accel="-2"]
	[wfgzoom]
	[image storage="emo06" layer="&mp.layer_no" page="fore" visible="true" opacity="0"]
	[layopt layer="&mp.layer_no" page="fore" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" ]
	[wait time="500" canskip="true"]
	[image storage="clear" layer="&mp.layer_no" page="back" visible="true" opacity="0"]
	[eval exp="kag.fore.layers[mp.layer_no].setSize(kag.back.layers[mp.layer_no].width,kag.back.layers[mp.layer_no].height)"]
	[trans method="crossfade" layer="&mp.layer_no" time="250"]
[endmacro]

[macro name="niko"]
	[eval exp="tf.emo=[+mp.x,+mp.y]"]
	[image storage="emo08" layer="&mp.layer_no" page="fore" clipleft="0" cliptop="0" clipwidth="118" clipheight="109"  visible="false"]
	[layopt layer="&mp.layer_no" page="fore" opacity="255" left="&tf.emo[0]" top="&tf.emo[1]" visible="true"]
	[animstart seg="1" layer="&mp.layer_no" page="fore " target="*emo8_loop"]
[endmacro]




[return]
