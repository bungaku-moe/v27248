;■更新履歴
;2010/12/03		ネガポジモード追加

*save
[eval exp="tf.mode='save', tf.mask='save_bg'"]
[call storage="saveload_cfg.ks"]
[jump target="*function"]

*load
[eval exp="tf.mode='load', tf.mask='load_bg'"]
[call storage="saveload_cfg.ks"]
[jump target="*function"]


*function

@eval exp="fubuki_object.uninit()"
@eval exp="snow_object.uninit()"

[iscript]
sf.lastSavePage = 1 if sf.lastSavePage===void;
tf.page			= 0;
tf.btnOffsetX	= 170;
tf.btnOffsetY	= 308;
tf.btnWidth		= 495;
tf.btnHeight	= 28;
tf.btnMarginW	= 0;
tf.btnMarginH	= 2;

function drawSaveItem(saveNo, layer, page, clear=false)
{
	//400,176
	var line = (saveNo-1) % tf.btnNum;
//	var xpos = %[No:tf.btnOffsetX+30 ,year:tf.btnOffsetX+110, month:tf.btnOffsetX+163, date:tf.btnOffsetX+224, hours:tf.btnOffsetX+321, minutes:tf.btnOffsetX+376, seconds:tf.btnOffsetX+431];

	var xpos = %[No:btn_pos[line][0] + tf.no_pos ,year:btn_pos[line][0]+tf.year_pos,month:btn_pos[line][0]+tf.month_pos,date:btn_pos[line][0]+tf.date_pos,hours:btn_pos[line][0]+tf.hours_pos,minutes:btn_pos[line][0]+tf.minutes_pos,seconds:btn_pos[line][0]+tf.seconds];

//	var ypos = tf.btnOffsetY + (tf.btnHeight+tf.btnMarginH)*line;
	var ypos = btn_pos[line][1];


	if (clear) {
		if (page == 'fore') {
			kag.fore.layers[layer].fillRect(tf.btnOffsetX, ypos, tf.btnWidth, tf.btnHeight, 0x00000000);
		}
		else {
			kag.back.layers[layer].fillRect(tf.btnOffsetX, ypos, tf.btnWidth, tf.btnHeight, 0x00000000);
		}
	}

	//セーブデータからデータ取得
	var fn = kag.getBookMarkFileNameAtNum(saveNo);
	if (!Storages.isExistentStorage(fn)) {
		return;
	}
	var modestr;
	if (kag.saveThumbnail) {
		modestr += "o" + kag.calcThumbnailSize().size;
	}
	var data = Scripts.evalStorage(fn, modestr);
	if (data.id != kag.saveDataID) {
		return;
	}

	var date = new Date();
	date.setTime(data.core.storeTime);
	
	saveload_drawNumber(saveNo, 'saveload_number', layer, page, xpos.No, ypos, 2);
	saveload_drawNumber(date.getYear(), 'saveload_number', layer, page, xpos.year, ypos, 2);
	saveload_drawNumber(date.getMonth()+1, 'saveload_number', layer, page, xpos.month, ypos, 2);
	saveload_drawNumber(date.getDate(), 'saveload_number', layer, page, xpos.date, ypos, 2);
	saveload_drawNumber(date.getHours(), 'saveload_number', layer, page, xpos.hours, ypos, 2);
	saveload_drawNumber(date.getMinutes(), 'saveload_number', layer, page, xpos.minutes, ypos, 2);
	saveload_drawNumber(date.getSeconds(), 'saveload_number', layer, page, xpos.seconds, ypos, 2);

	//System.inform('['+saveNo+']'+kag.bookMarkDates[saveNo]);
}

function createPage(page, forelay=true)
{
	if (page < 0 || page > tf.pageMax) {
		return;
	}
	tf.page = page;

	kag.tagHandlers.image(%[layer:'1', page:'back', storage:'clear', visible:'true', left:0, top:0]);

	for (var i = 0; i < tf.btnNum; i++) {
		var btnName = "btn%02d".sprintf(i);
		var saveNo = (page-1)*tf.btnNum+(i+1);	//0はクイックセーブ用

		global.exbutton_object.deleteObject(btnName);
		var elm = %[];
		with (elm) {
			.name		= btnName;
			.x			= btn_pos[i][0];
			.y			= btn_pos[i][1];
			.file		= "saveload_btn";
			if (tf.mode == 'save') {
				.onclick = 'innerSave' + "(%d)".sprintf(saveNo);
			}
			else {
				.onclick = 'innerLoad' + "(%d)".sprintf(saveNo);
			}
			drawSaveItem(saveNo, 1, 'back');
		}
		/*
		Debug.message(
			"\n" +
			"-------------------------\n" +
			"   name:" + elm.name + "\n" +
			"      x:" + elm.x + "\n" +
			"      y:" + elm.y + "\n" +
			"   file:" + elm.file + "\n" +
			"onclick:" + elm.onclick + "\n" +
			"-------------------------\n"
		);
		*/
		global.exbutton_object.createObject(elm);
	}

	if (forelay) {
		kag.tagHandlers.forelay(%[]);
	}
}


/************************/
/*	セーブ処理			*/
/*	拡張showDialog対応	*/
/************************/
function innerSave( no )
{
	kag.tagHandlers.rclick( %[ enabled:false ] );

	if( kag.bookMarkDates[no] != '' )
	{
		showDialog( 2, innerSave_dlg, %[ no:no ] );
		kag.tagHandlers.rclick( %[ enabled:true ] );
		return;
	}

	/*	セーブ実処理	*/
	innerSave_dlg( %[ no:no ] );
	return;
}

/********************************************/
/*	セーブ処理								*/
/*	showDialogの第二引数から呼び出す		*/
/*	実セーブ処理を関数化					*/
/********************************************/
function innerSave_dlg( elm )
{
	kag.storeBookMark( elm.no, false );
	drawSaveItem( elm.no, 1, 'fore', true );
	kag.tagHandlers.backlay( %[ layer:'1' ] );
	sf.lastSavePage		= tf.page;
	kag.tagHandlers.rclick( %[ target:'*exit', jump:true, enabled:true ] );
	return;
}

/************************/
/*	ロード処理			*/
/*	拡張showDialog対応	*/
/************************/
function innerLoad( no )
{

	/*	セーブされていない	*/
	if( kag.bookMarkDates[no] == '' )
		return;

	showDialog( 1, innerLoad_dlg, %[ no:no ] );
	return;
}

/********************************************/
/*	ロード処理								*/
/*	showDialogの第二引数から呼び出す		*/
/********************************************/
function innerLoad_dlg( elm )
{
	kag.historyLayer.clear();
	kag.restoreBookMark( elm.no, false );
	colormode_recovery();

	// キーバインド復帰
	global.exkeybind_object.add( VK_SPACE, "", 'toggleMessageShowing()' );

	return;
}

[endscript]

[tempsave place="1"]

[backlay]

[stopquake]
[history enabled="false"]

;フェード時に判定を持たないように表画面のクリッカブルマップを終わらせる
;裏画面は画面切り替え処理で他の処理に書き換わる
[mapdisable layer="base" page="fore"]

[endzoomex]

[hide_all_layer page="back"]
[layopt layer="message0" page="back" visible="false"]
[layopt layer="message1" page="back" visible="false"]
[layopt layer="message2" page="back" visible="false"]
[layopt layer="message3" page="back" visible="false"]
[layopt layer="message4" page="back" visible="false"]

;ストレージ指定がないと*exitの飛び先が怪しくなる
[rclick storage="mode_saveload.ks" target="*exit" jump="true" enabled="true"]

[exkeybind key="VK_SPACE" exp=""]

[image layer="base" storage="&tf.mask" page="back" visible="true" left="0" top="0"]

[exmenuopt delete="all"]
[exsmenuopt delete="all"]
[exformopt delete="all" forevisible="false" backvisible="true"]

[eval exp="createPage(sf.lastSavePage, false)"]

[call target="*createpagebtn"]
[exbutton name="exit" x="&exit_button[0]" y="&exit_button[1]" file="saveload_btn_return" onclick="jump('', '*exit')"]

;[excheckbox name="autosave" x="&autosave[0]" y="&autosave[1]" file="saveload_autosave" checked="sf.config.autoSave==true" oncheck="sf.config.autoSave=true" onuncheck="sf.config.autoSave=false" ]

;[exradio name="autosave" x="&autosave[0]" y="&autosave[1]" file="saveload_autosave" checked="sf.config.autoSave==true" oncheck="sf.config.autoSave=true" onuncheck="sf.config.autoSave=false" ]

[crossfade time="500"]

*wait
[s]


*exit
[exkeybind key="VK_SPACE" exp="toggleMessageShowing()"]
[freeimage layer="1" page="back"]
[tempload place="1" backlay="true" bgm="false" se="false"]
[exformopt forevisible="false" backvisible="true"]

[if exp="f.sepia_mode == true"]
	[sepia_mode]
[endif]

[if exp="f.gray_mode == true"]
	[gray_mode]
[endif]

[if exp="f.pink_mode == true"]
	[pink_mode]
[endif]

;	ネガポジモード追加	2010/12/03
[if exp="f.negaposi_mode == true"]
	[negaposi_mode]
[endif]

;直前が拡大状態なら拡大状態に裏画面を操作
[if exp="f.cgzoom == true"]
[iscript]
	cgzoom_object.dispstretchdib( f.cgzoomdic.file, f.cgzoomdic.dl, f.cgzoomdic.dt, f.cgzoomdic.dw, f.cgzoomdic.dh, "back" );
[endscript]
[endif]

[if exp="tf.fubuki == true"]
[fubukiinit forevisible=false backvisible=true]
[endif]

[if exp="tf.snow == true"]
[snowinit forevisible=false backvisible=true]
[endif]

[crossfade time="500"]

[return]

*createpagebtn
[eval exp="tf.count=0"]
*createpagebtn_loop
[iscript]
tf.name		= 'page%d'.sprintf(tf.count+1);
tf.x		= page[tf.count][0];
tf.y		= page[tf.count][1];
tf.file		= 'saveload_btn_page%d'.sprintf(tf.count+1);
tf.onclick	= 'createPage(%d)'.sprintf(tf.count+1);
/*
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
*/
[endscript]
[exradio name="&tf.name" group="page" x="&tf.x" y="&tf.y" file="&tf.file" onclick="&tf.onclick"]
[jump target="*createpagebtn_loop" cond="++tf.count<tf.pageMax"]
[eval exp="tf.check='page%d'.sprintf(sf.lastSavePage)"]
[exradioopt check="&tf.check"]
[return]


