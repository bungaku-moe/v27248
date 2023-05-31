[if exp="typeof(global.excheckbox_object) == 'undefined'"]
[iscript]


class ExCheckboxLayer extends ExButtonLayer
{
	var checked = false;
	var oncheck;
	var onuncheck;
	var group;
	
	function ExCheckboxLayer(window, parent)
	{
		super.ExButtonLayer(window, parent);
		//showFocusImage = true;
	}
	
	function filnalize()
	{
		super.finalize(...);
	}
	
	function onClick()
	{
		checked ? uncheck() : check();
		
		super.onClick(...);
	}

	function check(eval=true)
	{
		checked = true;
		if (eval) {
			Scripts.eval(oncheck) if oncheck !== void;
		}
		update();
	}
	function uncheck(eval=true)
	{
		checked = false;
		if (eval) {
			Scripts.eval(onuncheck) if onuncheck !== void;
		}
		update();
	}

	function setOptions(elm)
	{
		oncheck = elm.oncheck if elm.oncheck !== void;
		onuncheck = elm.onuncheck if elm.onuncheck !== void;
		group = elm.group if elm.group !== void;
		
		if (elm.checked !== void && Scripts.eval(elm.checked)) {
			//	elm.checkedの内容を評価して真ならチェック
			checked = true;
			update();
		}
		
		super.setOptions(...);
	}

	function draw()
	{
		var enabled_org = enabled;
		enabled = true;
		checked ? drawState(1) : super.draw();
		enabled = enabled_org;
	}

}


class ExCheckboxPlugin extends ExPlugin
{
	function ExCheckboxPlugin()
	{
		super.ExPlugin('ExCheckboxPlugin');
	}
	function finalize()
	{
		super.finalize();
	}
	
	function newObject(window, parent, elm)
	{
		var obj = new ExCheckboxLayer(window, parent);
		with (obj) {
			.loadImages(elm.file);
			.setPos(elm.x, elm.y);
			.absolute = 2000000-3;
			.visible = elm.visible;
			.setOptions(elm);
		}
		return obj;
	}
	
	function check(name)
	{
		var index = name2Index(name);
		if (index === void) {
			return;
		}
		objects[index].fore.check(false);
		objects[index].back.check(false);
	}
	function uncheck(name)
	{
		var index = name2Index(name);
		if (index === void) {
			return;
		}
		objects[index].fore.uncheck(false);
		objects[index].back.uncheck(false);
	}
	
	function setOptions(elm)
	{
		check(elm.check) if elm.check !== void;
		uncheck(elm.uncheck) if elm.uncheck !== void;
		super.setOptions(elm);
	}
}

kag.addPlugin(global.excheckbox_object = new ExCheckboxPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]
[endif]

;------------------------------------------------------------------------------
;	チェックボックス
;		[excheckbox name="" x="" y="" file="" oncheck="" onuncheck="" onclick="" onenter="" onleave=""]
;		name		識別子
;		x			x座標
;		y			y座標
;		file		画像ファイル名
;		oncheck		チェックをつけた時に評価される式
;		onuncheck	チェックをはずした時に評価される式
;		onclick		クリック時に評価される式
;		onenter		マウスが乗った時に評価される式
;		onleave		マウスが離れた時に評価される式
;------------------------------------------------------------------------------
[macro name="excheckbox"]
	[eval exp="excheckbox_object.createObject(mp)"]
[endmacro]

;------------------------------------------------------------------------------
;	オプション
;	[excheckboxopt backvisible="" forevisible="" delete=""]
;	backvisible		裏面の表示状態(true,false)
;	forevisible		表面の表示状態
;	delete			名前で指定したものを削除('all'で全て削除)
;	check			名前で指定したものをチェックを付ける
;	uncheck			名前で指定したものをチェックをはずす
;------------------------------------------------------------------------------
[macro name="excheckboxopt"]
	[eval exp="excheckbox_object.setOptions(mp)"]
[endmacro]

[return]

