[if exp="typeof(global.exslider_object) == 'undefined'"]
[iscript]


class ExSliderLayer extends ExButtonLayer
{
	var drag;
	var drag_x = 0;
	var max = 100;
	var min = 0;
	var center = 0;
	var pos = 0;
	var onslide;
	var slider_var;
	var slide_width = 100;
	var min_left = 0;
	var max_left = 0;
	var range = Math.abs(max - min);
	var posPerPixel = slide_width/range;
	var leftOrg = 0;
	
	function ExSliderLayer(window, parent)
	{
		super.ExButtonLayer(window, parent);
	}
	function finalize()
	{
		super.finalize();
	}
	
	function setPos(left, top, width=void, height=void)
	{
		leftOrg = left;
		super.setPos(...);
		calcRange();
	}
	
	function calcRange()
	{
		min_left	= leftOrg - center;
		max_left	= min_left + slide_width;
		range		= Math.abs(max - min);
		posPerPixel	= slide_width/range;
	}
	
	function setOptions(elm)
	{
		onslide		= elm.onslide if elm.onslide !== void;
		min			= +elm.min if elm.min !== void;
		max			= +elm.max if elm.max !== void;
		slider_var	= elm.var if elm.var !== void;
		slide_width	= +elm.width if elm.width !== void;
		center		= +elm.center if elm.center !== void;;
		calcRange();
		snap(+elm.pos) if elm.pos !== void;
		
		super.setOptions(...);
	}

	function onMouseDown(x, y, button, shift)
	{
		if(enabled && button == mbLeft) {
			drag = true;
			drag_x = x;
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
	
	//
	//	pos : varに渡す数値
	//	abs	: 見かけ上の位置
	//		  left = min_left + abs * posPerPixel
	//
	function onMouseMove(x, y, shift)
	{
		if (enabled && drag) {
			//前回のonMouseMoveの時との差
			var diff = x - drag_x;
			drag_x = x - diff;
			
			slide(diff);
		}
		super.onMouseMove(...);
	}
	
	function left2Abs(left)
	{
		left = min_left if left < min_left;
		left = max_left if left > max_left;
		return Math.ceil((left-min_left)/posPerPixel);
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

	function snap(pos)
	{
		left = min_left + pos2Abs(pos)*posPerPixel;
	}

	function draw()
	{
		if (drag===true) {
			var enabled_org = enabled;
			enabled = true;
			drawState(1);
			enabled = enabled_org;
		}
		else {
			super.draw();
		}
	}

	function slide(diff)
	{
		var abs = left2Abs(left+diff);
		var last_pos = pos;
		pos = abs2Pos(abs);
		
		if (pos != last_pos) {
			snap(pos);
			Scripts.eval(slider_var+'='+pos) if slider_var !== void;
			Scripts.eval(onslide) if onslide !== void;
			//Debug.message('■■■■■■pos:'+pos);
		}
	}
}


class ExSliderPlugin extends ExPlugin
{
	function ExSliderPlugin()
	{
		super.ExPlugin('ExSliderPlugin');
	}
	function finalize()
	{
		super.finalize();
	}
	
	function newObject(window, parent, elm)
	{
		var obj = new ExSliderLayer(window, parent);
		with (obj) {
			.loadImages(elm.file);
			.setPos(elm.x, elm.y);
			.absolute = 2000000-3;
			.visible = elm.visible;
			.setOptions(elm);
		}
		return obj;
	}
	
	function setOptions(elm)
	{
		if (elm.name!==void && elm.pos!==void) {
			var index = name2Index(elm.name);
			if (index===void) return;
			
			objects[index].fore.setOptions(%[pos:elm.pos]);
			objects[index].back.setOptions(%[pos:elm.pos]);
		}
		
		super.setOptions(elm);
	}
}

kag.addPlugin(global.exslider_object = new ExSliderPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]
[endif]

;------------------------------------------------------------------------------
;	スライダーボタン
;		[exslider name="" x="" y="" file="" min="" max="" center="" pos="" var="" onslide="" onclick="" onenter="" onleave=""]
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
;		center
;		width
;------------------------------------------------------------------------------
[macro name="exslider"]
	[eval exp="exslider_object.createObject(mp)"]
[endmacro]

;------------------------------------------------------------------------------
;	オプション
;	[exslideropt backvisible="" forevisible="" delete=""]
;	backvisible		裏面の表示状態(true,false)
;	forevisible		表面の表示状態
;	delete			名前を指定したものを削除('all'で全て削除)
;	name
;	pos
;------------------------------------------------------------------------------
[macro name="exslideropt"]
	[eval exp="exslider_object.setOptions(mp)"]
[endmacro]

[return]

