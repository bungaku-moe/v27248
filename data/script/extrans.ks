;------------------------------------------------------------------------------
;	extrans.dllプラグイントランジション
;		詳しくは「吉里吉里２リファレンス」の「トランジションについて」を参照
;------------------------------------------------------------------------------

[loadplugin module="extrans.dll"]

;------------------------------------------------------------------------------
;	[wavefade time="" wavetype="" maxh="" maxomega="" bgcolor1="" bgcolor2=""]
;------------------------------------------------------------------------------
[macro name="wavefade"]
	[eval exp="mp.method='wave'"]
	[trans2 *]
	[wait time="&mp.time"]
[endmacro]

;------------------------------------------------------------------------------
;	[mosaic time="" maxsize=""]
;------------------------------------------------------------------------------
[macro name="mosaicfade"]
	[eval exp="mp.method='mosaic'"]
	[trans2 *]
	[wait time="&mp.time"]
[endmacro]

;------------------------------------------------------------------------------
;	[turn time="" bgcolor=""]
;------------------------------------------------------------------------------
[macro name="turnfade"]
	[eval exp="mp.method='turn'"]
	[trans2 *]
[endmacro]

;------------------------------------------------------------------------------
;	[rotatezoom time="" factor="" accel="" twist="" twistaccel=""]
;------------------------------------------------------------------------------
[macro name="rotatezoom"]
	[eval exp="mp.method='rotatezoom'"]
	[trans2 *]
[endmacro]

;------------------------------------------------------------------------------
;	[rotatevanish time="" accel="" twist="" twistaccel=""]
;------------------------------------------------------------------------------
[macro name="rotatevanish"]
	[eval exp="mp.method='rotatevanish'"]
	[trans2 *]
[endmacro]

;------------------------------------------------------------------------------
;	[rotateswap time="" twist="" bgcolor=""]
;------------------------------------------------------------------------------
[macro name="rotateswapfade"]
	[eval exp="mp.method='rotateswap'"]
	[trans2 *]
[endmacro]

;------------------------------------------------------------------------------
;	[ripplefade time="" centerx="" centery="" rwidth="" roundness="" speed="" maxdrift=""]
;------------------------------------------------------------------------------
[macro name="ripplefade"]
	[eval exp="mp.method='ripple'"]
	[trans2 *]
[endmacro]


[return]

