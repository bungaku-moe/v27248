[if exp="typeof(global.exvolumebar2_object) == 'undefined'"]
[iscript]


class ExVolumeBerLayer2 extends ExButtonLayer
{
	var drag;
	var ongain;
	var min = 0;
	var max = 100;
	var _var;
	var barWidth;
	var pos;
	var range;
	var posPerPixel;
	
	function ExVolumeBerLayer(window, parent)
	{
		super.ExButtonLayer(window, parent);
	}
	function finalize()
	{
		super.finalize();
	}

	function setOptions(elm)
	{
		ongain	= elm.ongain if elm.ongain !== void;
		min		= +elm.min if elm.min !== void;
		max		= +elm.max if elm.max !== void;
		_var	= elm.var if elm.var !== void;
		barWidth = height;
		calcRange();
		snap(+elm.pos) if elm.pos !== void;
		
		super.setOptions(...);
	}
	function setPos(left, top, width=void, height=void)
	{
		super.setPos(...);
		calcRange();
	}
	
	function calcRange()
	{
		range		= Math.abs(max - min);
		posPerPixel	= height/range;
	}
	
	function onMouseDown(x, y, button, shift)
	{
		if(enabled && button == mbLeft) {
			drag = true;
			gain(y);
		}
		super.onMouseDown(...);
	}
	function onMouseUp(x, y, button, shift)
	{
		if(enabled && button == mbLeft) {
			drag = false;
		}
		super.onMouseUp(...);
	}
	
	function onMouseMove(x, y, shift)
	{
		if (enabled && drag) {
			gain(y);
		}
		super.onMouseMove(...);
	}

	function left2Abs(top)
	{
		top = 0 if top < 0;
		top = this.height if top > this.height;
		return Math.ceil(top/posPerPixel);
	}

	function abs2Pos(abs)
	{
		var pos = (min < max) ? (min + abs) : (min - abs);
		return pos;
	}
	
	function pos2Abs(pos)
	{
		var abs = (min < max) ? (pos - min) : (min - pos);
		abs = 0 if abs < 0;
		abs = range if abs > range;
		return abs;
	}

	function gain(y)
	{
		var last_pos = pos;
		var abs = left2Abs(y);
		pos = abs2Pos(abs);

		if (pos !== last_pos) {
			snap(pos);
			Scripts.eval(_var+'='+pos) if _var !== void;
			Scripts.eval(ongain) if ongain !== void;
			//Debug.message('■■■■■■■■gain:'+pos+' abs:'+abs);
		}
	}
	
	function snap(pos)
	{
		barWidth = pos2Abs(pos) * posPerPixel;
		update();
	}

	function draw()
	{
		//今のところ画像は指定出来ない
		fillRect(0,barWidth,width,height-barWidth, 0);
		fillRect(0,0,width,barWidth, color);
	}
}


class ExVolumeBarPlugin2 extends ExPlugin
{
	function ExVolumeBarPlugin2()
	{
		super.ExPlugin('ExVolumeBarPlugin2');
	}
	function finalize()
	{
		super.finalize();
	}
	
	function newObject(window, parent, elm)
	{
		var obj = new ExVolumeBerLayer2(window, parent);
		with (obj) {
			//.loadImages(elm.file);
			.setSize(elm.width,elm.height);
			.color = elm.color;
			//.opacity = 255;
			.setPos(elm.x, elm.y);
			.absolute = 2000000-3;
			.visible = elm.visible;
			.setOptions(elm);
		}
		return obj;
	}
	
}

kag.addPlugin(global.exvolumebar2_object = new ExVolumeBarPlugin2(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]
[endif]

;------------------------------------------------------------------------------
;	スライダーボタン
;		[exvolumebar name="" x="" y="" file="" min="" max="" center="" pos="" var="" onslide="" onclick="" onenter="" onleave=""]
;		name		識別子
;		x			x座標
;		y			y座標
;		file		画像ファイル名
;		min			スライダー位置の最小値(マイナス可)
;		max			スライダー位置の最大値(マイナス可)
;		pos			初期位置
;		var			スライダー位置を受け取る変数
;		onslide		スライダーを動かしたときに評価する式
;		onclick		クリック時に評価される式
;		onenter		マウスが乗った時に評価される式
;		onleave		マウスが離れた時に評価される式
;------------------------------------------------------------------------------
[macro name="exvolumebar2"]
	[eval exp="exvolumebar2_object.createObject(mp)"]
[endmacro]

;------------------------------------------------------------------------------
;	オプション
;	[exslideropt backvisible="" forevisible="" delete=""]
;	backvisible		裏面の表示状態(true,false)
;	forevisible		表面の表示状態
;	delete			名前を指定したものを削除('all'で全て削除)
;------------------------------------------------------------------------------
[macro name="exvolumebar2opt"]
	[eval exp="exvolumebar2_object.setOptions(mp)"]
[endmacro]

[return]

