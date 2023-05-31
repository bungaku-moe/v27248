[if exp="typeof(global.exdialog_object) == 'undefined'"]
[iscript]



class ExDialogPlugin extends ExPlugin
{
	var result;
	
	function ExDialogPlugin()
	{
		super.ExPlugin('ExDialogPlugin');
	}

	function finalize()
	{
		super.finalize(...);
	}
	
	function newObject(window, parent, elm)
	{
		var obj;

		switch (elm.type) {
		case 'base':
			obj = new KAGLayer(window, parent);
			with (obj) {
				.loadImages(elm.file);
				.setPos(elm.x, elm.y);
				.setSizeToImageSize();
				.absolute = 2100000;
				.visible = false;
				.setOptions(elm);
				.hitType = htMask;
				.hitThreshold = 0;
				.onClick = function()
				{
					(global.KAGLayer.onClick incontextof this)(...);
					global.exdialog_object.close('cancel');
				} incontextof obj;
			}
			break;
		case 'image':
			obj = new KAGLayer(window, parent);
			with (obj) {
				.loadImages(elm.file);
				.setPos(elm.x, elm.y);
				.setSizeToImageSize();
				.absolute = 2100000+3;
				.visible = false;
				.setOptions(elm);
			}
			break;
		case 'button':
			obj = new ExButtonLayer(window, parent);
			with (obj) {
				.loadImages(elm.file);
				.setPos(elm.x, elm.y);
				.absolute = 2100000+5;
				.visible = false;
				.setOptions(elm);
				.onClick = function()
				{
					(global.ExButtonLayer.onClick incontextof this)(...);
					global.exdialog_object.close(this.name);
				} incontextof obj;
			}
		}
		return obj;
	}
	
	function close(result)
	{
		this.resutl = result;
		deleteObject('all');
		kag.trigger('dialog');
	}
	
}


kag.addPlugin(global.exdialog_object = new ExDialogPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]
[endif]

;[exdialog file="" x="" y=""]
[macro name="exdialog"]
	[eval exp="global.exdialog_object.createObject(mp)"]
[endmacro]

[macro name="exdialogopt"]
	[eval exp="global.exdialog_object.setOptions(mp)"]
[endmacro]


[return]

