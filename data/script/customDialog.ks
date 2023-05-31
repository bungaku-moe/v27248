
[iscript]
//2015/08/07 一部変数を明示的に無効化して一部内部変数を外部変数へ変更 testタグ


//	ダイアログボックスの種類
var	dlgset	=
[
		%[],//dammy
		%[ msg:'ロードしますか？',				bg:'dlg_askLoad',				yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'データを上書きしますか？',		bg:'dlg_askOverWriteData',		yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'タイトルに戻りますか？',		bg:'dlg_askReturnTitle',		yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'終了しますか？',				bg:'dlg_askQuit',				yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'前の選択肢に戻りますか？',		bg:'dlg_askReturnPrevSelect',	yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'クリア後に選択してください。',	bg:'dlg_infoCanNotSelect',		ok:'' ],
		%[ msg:'体験版では使用できません。', 	bg:'dlg_infoCanNotSelect2',		ok:'' ],
		%[ msg:'データが存在しません。',		bg:'dlg_infoDataDoesNotExist',	ok:'' ],
		%[ msg:'シーン回想に戻りますか？',		bg:'dlg_askReturnScene',		yes:'dlg_btn_yes', no:'dlg_btn_no' ],
		%[ msg:'クイックセーブしました。',		bg:'dlg_infoQuickSaveOK',		ok:'' ],
		%[ msg:'クイックロードしますか？',		bg:'dlg_askQuickLoad',			yes:'dlg_btn_yes', no:'dlg_btn_no' ]
];

//test
var		xdlg;

/****************************************************************************/
/*	class			:	レイヤー型Yes/Noダイアログ作成						*/
/*	comment			:	-													*/
/****************************************************************************/
class CustomDialogWindow extends KAGLayer
{
	var		buttons		= [];
	var		clickyes;
	var		result;
	var		param;

	function CustomDialogWindow( win, par, no, func )
	{
		super.KAGLayer(...);

		setSize( win.innerWidth, win.innerHeight );
		setPos( 0, 0 );
		return;
	}

	/*	ダイアログ作成後に一番最初にやる処理	*/
	function open()
	{
		/*	ダイアログの初期設定	*/
		window.openDialog( this );

//		setClickHook( true );
		return;
	}

	/* ダイアログを閉じる際の処理	*/
    function close()
	{
//test
		invalidate buttons;

		enabled		= false;
		window.closeDialog( this );

		setClickHook( false );
    }

	/*	ダイアログベースの表示	*/
	function addImage( file )
	{
		loadImages( file );
		hitThreshold	= 0;
//		bringToFront();
//		absolute = kag.currentDialogAbsolute + 1;
//		visible = true;  // 表示状態にします
		update();
		return;
	}

	/*	マウスキーフック	*/
	function setClickHook( en )
	{
		if ( en ) setClickHook( false );

		var	set	= en ? window.addHook : window.removeHook;

		set( "leftClick",  this.leftClickHook );
		set( "rightClick", this.rightClickHook );
	}

	function leftClickHook()  { return true; }
	function rightClickHook()
	{
		System.inform( "test" );
		if ( enabled )
			close();
		return true;
	}

    function finalize()
	{
        super.finalize();
    }

	/*	ボタン作成関数	*/
	function addButton( name, x, y, file, focus=false )
	{
		var	count	= buttons.count;

//test
//		buttons[count]	= new CustomDialogButton( kag, this );
		kag.add( buttons[count]	= new CustomDialogButton( kag, this ) );
		with ( buttons[count] )
		{
			.loadImages( file );
			.setPos( x, y );
			.visible	= true;
			.name		= name;
			.absolute	= kag.currentDialogAbsolute + 1;
			.focus() if focus===true;
		}

		return;
	}

	function setOptions( func, elm )
	{
		clickyes = func if func !== void;
		param = elm if elm !== void;

		super.setOptions( elm );
	}

	function onClick( x, y, ivent )
	{
		//	debug
//		System.inform( "Click " + "\n" + x +  "\n" + y + "\n" + ivent );

		super.onClick( x, y );

		result	= ivent;

		if( result == "yes" )
		{
			Scripts.eval( clickyes( param ) ) if clickyes !== void;
		}

		//	停止していたkagを動かす
		close();
		return;
	}
}

/****************************************************************************/
/*	class			:	レイヤー型Yes/Noダイアログ用のボタン				*/
/*	comment			:	-													*/
/****************************************************************************/
class CustomDialogButton extends ExButtonLayer
{

	function CustomDialogButton( window, parent )
	{
		super.ExButtonLayer(...);
		return;
	}

//test
	function filnalize()
	{
		invalidate this;
		super.finalize(...);
	}

	function onClick( x, y )
	{
		/*	親レイヤーへ作成したボタンの名前を返す	*/
		parent.onClick( x, y, name );

		super.onClick(...);

		return;
	}

}

/****************************************************************************/
/*	function		:	Yes/Noダイアログの作成(Layer使用)					*/
/*	arguments		:	no		: 呼び出しの状態（dlgset参照）				*/
/*						func	: Yesボタンを押下時、動作命令				*/
/*						elm		: funcのパラメータ							*/
/*	return value	:	void												*/
/*	comment			:	-													*/
/****************************************************************************/
function DialogYesNoLayer( no, func, elm )
{
	var	dic		= dlgset[no];

//	var	dlg	= new CustomDialogWindow( kag, kag.primaryLayer, no, func );
//	var	dlg	= new CustomDialogWindow( kag, kag.fore.base, no, func );
//test
//	xdlg	= new CustomDialogWindow( kag, kag.fore.base, no, func );
	kag.add( xdlg	= new CustomDialogWindow( kag, kag.fore.base, no, func ) );

//	with( dlg )
	with( xdlg )
	{
		.open();
		.addImage( dic.bg + '.tlg' );
		.addButton( "yes", 330, 277, dic.yes ) if dic.yes !== void;
		.addButton( "no", 420, 277, dic.no ) if dic.no !== void;
		.setOptions( func, elm );
	}

	return;
}

/****************************************************************************/
/*	function		:	Yes/Noダイアログの作成(Systemダイアログ使用)		*/
/*	arguments		:	no		: 呼び出しの状態（dlgset参照）				*/
/*						func	: Yesボタンを押下時、動作命令				*/
/*						elm		: funcのパラメータ							*/
/*	return value	:	void												*/
/*	comment			:	-													*/
/****************************************************************************/
function DialogYesNoSystem( no, func, elm )
{
	var	dic		= dlgset[no];
	var	result	= 'no';

	if( dic.ok !== void )
		System.inform( dic.msg );
	else
		result	= askYesNo( dic.msg ) ? 'yes' : 'no';

	if( result == "yes" )
		func( elm );

	return;
}
/****************************************************************************/
/*	function		:	Yes/Noダイアログの呼び出し							*/
/*	arguments		:	no		: 呼び出しの状態（dlgset参照）				*/
/*						func	: Yesボタンを押下時、動作関数				*/
/*						elm		: funcのパラメータ							*/
/*	return value	:	void												*/
/*	comment			:	ダイアログを出すだけで処理は結果は押下時の処理は	*/
/*						引数の関数に任せる									*/
/****************************************************************************/
function showDialog( no, func, elm )
{
	var	dic			= dlgset[no];
	var	isFile		= false;
	var	isMovie		= false;

	isFile	= Storages.isExistentStorage( dic.bg+'.tlg' );
	isMovie	= kag.isMoviePlaying();

	/*	ダイアログ用レイヤのモーダル化の為に全てのトランジションを止める	*/
	kag.stopAllTransitions();

	if( isMovie || !isFile )
		DialogYesNoSystem( no, func, elm );
	else
		DialogYesNoLayer( no, func, elm );

	return;
}

[endscript]

[return]
