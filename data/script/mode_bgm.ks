

[tempsave place="5"]

[call storage="bgm_cfg.ks"]


[iscript]
tf.current	= 1;
tf.loop		= false;
tf.method	= 'stop';
tf.bgmVolume = sf.config.bgmVolume2;
f.bgmpos = 100 - sf.config.bgmVolume2;

kag.onBGMStop = function()
{
	//	BGMÇ™èIóπÇµÇΩÇ∆Ç´Ç…åƒÇŒÇÍÇÈ
	(global.KAGWindow.onBGMStop incontextof kag)(...);
	if (tf.method == 'play') {
		if (tf.loop) {
			process('', '*play');
		}
		else {
			process('', '*next');
		}
	}
} incontextof kag;



function showHint(no, layer=0, page='fore')
{
	var dstlayer = page=='fore' ? kag.fore.layers[layer] : kag.back.layers[layer];
	var srclayer = kag.back.layers[1];

	dstlayer.copyRect(17, 552, srclayer, 0, 20*no, srclayer.width, 20);
}

function hideHint(layer=4, page='fore')
{
	var dstlayer = page=='fore' ? kag.fore.layers[layer] : kag.back.layers[layer];
	var srclayer = kag.back.layers[1];
	
	dstlayer.fillRect(17, 552, srclayer.width, 20, 0);
}

function drawMinMax(minmax, image, layer, page, x, y)
{
	var srclayer = kag.temporaryLayer;
	srclayer.loadImages(image);
	
	var dstlayer;
	if (page=='fore') {
		dstlayer = kag.fore.layers[layer];
	}
	else {
		dstlayer = kag.back.layers[layer];
	}
	
	var width = srclayer.imageWidth / 2;
	var height = srclayer.imageHeight;
	
	dstlayer.copyRect(x, y, srclayer, ((minmax == 'min') ? 0 : width), 0, width, height);
}

function drawVolume(volume, layer, page, x, y)
{
	if (volume <= 0) {
		drawMinMax('min', 'config_minmax', layer, page, x, y);
	}
	else if (volume >= 100) {
		drawMinMax('max', 'config_minmax', layer, page, x, y);
	}
	else {
		drawNumber(volume, 'config_number', layer, page, x, y, 3);
	}
}

function eraseVolume()
{
	var layer = kag.fore.layers[0];
	layer.fillRect(435, 473, 24, 18, 0);
}

[endscript]

;[hide_all_layer page="back"]
[clear_message_layer]
[rclick storage="mode_bgm.ks" target="*exit" jump="true" enabled="true"]

[layer no="0" file="bgm_bg"]
[layer no="1" file="bgm_hint"]
[layopt layer="1" page="back" left="&kag.scWidth"]

[exformopt delete="all" forevisible="false" backvisible="true"]
[exbutton name="exit" x="&exit_button[0]" y="&exit_button[1]" file="bgm_btn_exit" onclick="jump('', '*exit')"  onleave="hideHint()"]

[excheckbox name="loop" x="&loop_button[0]" y="&loop_button[1]" file="bgm_btn_loop" oncheck="jump('', '*loop_oncheck')" onuncheck="jump('', '*loop_uncheck')"  onleave="hideHint()"]
;[excheckbox name="loop" x="138" y="415" file="bgm_btn_loop" oncheck="tf.loop=true" onuncheck="tf.loop=false"  onleave="hideHint()"]



[exbutton name="stop" x="&stop_button[0]" y="&stop_button[1]" file="bgm_btn_stop" onclick="jump('', '*stop')"  onleave="hideHint()"]
[exbutton name="next" x="&next_button[0]" y="&next_button[1]" file="bgm_btn_next" onclick="jump('', '*next')"  onleave="hideHint()"]
[excheckbox name="play" x="&play_button[0]" y="&play_button[1]" file="bgm_btn_play" oncheck="jump('', '*play')" onuncheck="jump('', '*play')"  onleave="hideHint()"]
[exbutton name="back" x="353" y="552" file="bgm_btn_back" onclick="jump('', '*prev')"  onleave="hideHint()"]


;[exslider name="bgm_volume" x="&volume_button[0]" y="&volume_button[1]" width="&volume_button[2]" file="bgm_config_slider" min="0" max="100" center="0" pos="&sf.config.bgmVolume2" var="tf.bgm_volume" onslide="kag.process('', '*bgm_volume')" onenter="" onleave=""]


;[exvolumebar name="voice_volume" x="&voice_volume_slider[0]" y="&voice_volume_slider[1]" width="&voice_volume_slider[2]" height="&voice_volume_slider[3]" color="0xffff5a5a" min="0" max="100" pos="&sf.config.voiceVolume" var="tf.voice_volume" ongain="jump('', '*voice_volume')"]


[exvolumebar name="voice_volume" x="&volume_button[0]" y="&volume_button[1]" width="&volume_button[2]" height="&volume_button[3]" color="0xffff5a5a" min="0" max="100" pos="&sf.config.bgmVolume2" var="tf.bgm_volume" ongain="jump('', '*bgm_volume')"]

;[exvolumebar name="bgm_volume" x="&volume_button[0]" y="&volume_button[1]" width="&volume_button[2]" height="&volume_button[3]" color="0xffff5a5a" min="0" max="100" pos="&sf.config.bgmVolume2" var="tf.bgm_volume" ongain="jump('', '*bgm_volume')"]



[call target="*createbtn"]
[stop_bgm fadeout="500"]
[crossfade time="500"]

[wb]
[call target="*set_bgm_volume"]



*wait
[s]

*bgm_volume
[eval exp="sf.config.bgmVolume2=tf.bgm_volume"]
[call target="*set_bgm_volume"]
[jump target="*wait"]

*set_bgm_volume
[bgmopt gvolume="&sf.config.bgmVolume2"]
;[eval exp="Debug.message('Å°Å°Å°bgm_volume='+sf.config.bgmVolume2)"]
[return]

*draw_bgm_volume
;[eval exp="drawVolume(sf.config.bgmVolume2, 2, 'fore', 936, 275)"]
[return]


*exit
//å≥Ç…ñﬂÇ∑
[bgmopt gvolume="&sf.config.bgmVolume2"]
[eval exp="kag.onBGMStop=global.KAGWindow.onBGMStop"]
[tempload place="5" backlay="true" bgm="true" se="true"]
[exformopt forevisible="false" backvisible="true"]
[crossfade time="500"]
[return]



*createbtn
[iscript]
tf.count=tf.bgmNum-1;
[endscript]
*createbtn_loop
[iscript]
tf.name		= "bgm%03d".sprintf(tf.count+1);
tf.x		= tf.prop[tf.count].x;
tf.y		= tf.prop[tf.count].y;
tf.file		= "bgm_btn_%02d".sprintf(tf.count+1);
tf.onclick	= "tf.current=%d, jump('', '*play')".sprintf(tf.count+1);
tf.checked	= "tf.current==%d".sprintf(tf.count+1);
//tf.onenter	= "showHint(%d)".sprintf(tf.count+1);
tf.onleave	= "hideHint()";

Debug.message(
	"\n" +
	"-------------------------\n" +
	"   name:" + tf.name + "\n" +
	"      x:" + tf.x + "\n" +
	"      y:" + tf.y + "\n" +
	"   file:" + tf.file + "\n" +
	"onclick:" + tf.onclick + "\n" +
	"-------------------------\n"
);

[endscript]
[exradio name="&tf.name" group="bgm" x="&tf.x" y="&tf.y" file="&tf.file" onclick="&tf.onclick" checked="&tf.checked" onenter="&tf.onenter" onleave="&tf.onleave"]
[jump target="*createbtn_loop" cond="--tf.count>=0"]
[return]




*play
[if exp="tf.current<1 || tf.current>tf.bgmNum"]
	[jump target="*wait"]
[endif]
[excheckboxopt check="play"]
[eval exp="tf.name='bgm%03d'.sprintf(tf.current)"]
[exradioopt check="&tf.name"]
[eval exp="tf.file=tf.prop[tf.current-1].file"]
[eval exp="tf.method='stop'"]
[bgm file="&tf.file" loop="false"]
[eval exp="tf.method='play'"]
[jump target="*wait"]


*loop_oncheck
[eval exp="tf.loop=true"]
[jump target="*wait"]

*loop_uncheck
[eval exp="tf.loop=false"]
;[freeimage layer="2" page="back"]
;[crossfade time="1000"]
[jump target="*wait"]



*stop
[if exp="tf.method=='play'"]
	[excheckboxopt uncheck="play"]
[endif]
[eval exp="tf.method='stop'"]
[stop_bgm]
[jump target="*wait"]



*prev
[iscript]
tf.current--;
tf.current = tf.bgmNum if tf.current < 1;
[endscript]
[call target="*change"]
[if exp="tf.method=='play'"]
	[eval exp="tf.method='prev'"]
	[jump target="*play"]
[endif]
[jump target="*wait"]



*next
[iscript]
tf.current++;
tf.current = 1 if tf.current > tf.bgmNum;
[endscript]
[call target="*change"]
[if exp="tf.method=='play'"]
	[eval exp="tf.method='next'"]
	[jump target="*play"]
[endif]
[jump target="*wait"]



*change
[eval exp="tf.name='bgm%03d'.sprintf(tf.current)"]
[exradioopt check="&tf.name"]
[return]



