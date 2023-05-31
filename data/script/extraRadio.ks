[if exp="typeof(global.exradio_object) == 'undefined'"]
[iscript]




class ExRadioPlugin extends ExPlugin
{
	function ExRadioPlugin()
	{
		super.ExPlugin('ExRadioPlugin');
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

		obj.onClick = function()
		{
			global.exradio_object.check(this.name, false);
			(global.ExCheckboxLayer.onClick incontextof this)(...);
		} incontextof obj;

		return obj;
	}
	
	function check(name, check=true)
	{
		var index = name2Index(name);
		if (index === void) {
			return;
		}
		var count = objects.count;
		var group = objects[index].elm.group;
		for (var i = 0; i < count; i++) {
			if (i == index) {
			}
			else if (group!==void && objects[i].elm.group==group) {
				objects[i].fore.uncheck(false);
				objects[i].back.uncheck(false);
				Debug.message('■■■■unchecking:'+objects[i].elm.name+'/'+i);
			}
		}
		if (check==true) {
			objects[index].fore.check(false);
			objects[index].back.check(true);
			Debug.message('■■■■checking:'+objects[index].elm.name+'/'+index);
		}
	}
	
	function setOptions(elm)
	{
		check(elm.check) if elm.check !== void;
		super.setOptions(...);
	}
}

kag.addPlugin(global.exradio_object = new ExRadioPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]
[endif]

;------------------------------------------------------------------------------
;	ラジオボタン
;		[exradio name="" x="" y="" file="" checked="" oncheck="" onclick="" onenter="" onleave=""]
;		type		radio
;		name		識別子
;		group		グループ
;		x			x座標
;		y			y座標
;		file		画像ファイル名
;		checked		デフォルトでチェックをつけるか評価する式
;		oncheck		チェックをつけた時に評価される式
;		onclick		クリック時に評価される式
;		onenter		マウスが乗った時に評価される式
;		onleave		マウスが離れた時に評価される式
;------------------------------------------------------------------------------
[macro name="exradio"]
	[eval exp="exradio_object.createObject(mp)"]
[endmacro]

;------------------------------------------------------------------------------
;	オプション
;	[exradioopt backvisible="" forevisible="" delete=""]
;	backvisible		裏面の表示状態(true,false)
;	forevisible		表面の表示状態
;	delete			名前で指定したものを削除('all'で全て削除)
;	check			名前で指定したものをチェック
;------------------------------------------------------------------------------
[macro name="exradioopt"]
	[eval exp="exradio_object.setOptions(mp)"]
[endmacro]

[return]

