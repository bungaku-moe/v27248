
[iscript]
function getPresentSituation()
{
	if (kag.bookMarkDates.count <= 0) {
		return 0;
	}
	else if (!sf.end) {
		return 1;
	}
	else if (!sf.complete) {
		return 2;
	}
	else {
		return 3;
	}
}
[endscript]

[macro name="end_scene"]
	[if exp="tf.scene_mode===true"]
		[return]
	[endif]
	[eval exp="setSceneFlag(kag.conductor.curStorage, true)"]
[endmacro]

;------------------------------------------------------------------------------
;	リンク選択肢の開始処理
;		[_beginlink]
;------------------------------------------------------------------------------
[macro name="_beginlink"]
	[history output="false"]
	[nowait]
[endmacro]


[macro name="cm2"]
	[if exp="f.selectwindow_show===true"]
		[current layer="message0" page="fore" withback="true"]
		[freeimage layer="7"]
		[hide_layer no="7"]
;		[layopt layer="7" index="7000"]
		[eval exp="f.selectwindow_show=false"]
	[endif]
	[cm]
[endmacro]

;------------------------------------------------------------------------------
;	リンク選択肢の終了処理
;		[_endlink]
;------------------------------------------------------------------------------
[macro name="_endlink"]
	[history output="true"]
	[endnowait]
	[record]
	[s]
[endmacro]

;------------------------------------------------------------------------------
;	リンク選択肢の開始処理 中心に出す
;		[_beginlink]
;------------------------------------------------------------------------------

[macro name="_beginlink2"]
	[call target="*selectwindow_begin" storage="private.ks"]
	[current layer="message0" page="fore" withback="true"]
	[position layer="message0" page="fore" visible="true" color="0" opacity="0" left="&tf.left" top="&tf.top" width="&tf.messageWidth" height="&kag.innerHeight" marginl="&tf.height" margint="&tf.height" marginr="&tf.height+24" marginb="&tf.height+24"]
	[backlay layer="message0"]
	[_beginlink]
[endmacro]

;------------------------------------------------------------------------------
;	リンクの終了タグ
;		[endlink2]
;------------------------------------------------------------------------------
[macro name="endlink2"]
	[endlink]
	[resetfont]
[endmacro]

[macro name="_endlink2"]
	[call target="*selectwindow_create" storage="private.ks"]
	[_endlink]
[endmacro]
[return]

*selectwindow_begin
	[iscript]
	tf.left			= 90;
	tf.top			= 200;
	tf.fontSize		= kag.fore.messages[0].fontSize;
	tf.height		= tf.fontSize + kag.fore.messages[0].lineSpacing;
	tf.width		= 620;
	tf.layer		= 7;
	tf.frameBottomH = tf.height + kag.fore.messages[0].lineSpacing;
	tf.frameBottomY	= 100 - tf.frameBottomH;
	tf.messageWidth = tf.width + tf.fontSize*4;
	[endscript]
[return]

*selectwindow_create
	[iscript]
	tf.dy		= 0;
	tf.count	= 0;
	tf.max		= kag.fore.messages[0].links.count;
	Debug.message('■■■■links:'+tf.max);
	[endscript]
	[layer no="&tf.layer" file="clear"]
;	[layopt layer="6" page="fore" index="500"]
	[forelay layer="&tf.layer"]
	[pimage layer="&tf.layer" page="fore" storage="selectwindow" mode="copy" dx="0" dy="&tf.dy" sx="0" sy="0" sw="&tf.width" sh="&tf.height"]
*selectwindow_loop
	[eval exp="tf.dy+=tf.height"]
	[pimage layer="&tf.layer" page="fore" storage="selectwindow" mode="copy" dx="0" dy="&tf.dy" sx="0" sy="&tf.height" sw="&tf.width" sh="&tf.height"]
	[eval exp="tf.count++"]
	[if exp="tf.count<tf.max"]
		[jump target="*selectwindow_loop"]
	[endif]
*selectwindow_loopend
	[eval exp="tf.dy+=tf.height"]
	[pimage layer="&tf.layer" page="fore" storage="selectwindow" mode="copy" dx="0" dy="&tf.dy" sx="0" sy="&tf.frameBottomY" sw="&tf.width" sh="&tf.frameBottomH"]
	[layopt layer="&tf.layer" page="fore" visible="true" autohide="true" left="&tf.left" top="&tf.top"]
	[eval exp="f.selectwindow_show=true"]
[return]

[return]