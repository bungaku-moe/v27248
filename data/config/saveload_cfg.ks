[iscript]
//■ページの座標　ページの数だけ定義してください。
//ページボタンの画像　saveload_btn_page～.png
tf.btnNum	= 10;//一画面にボタンがいくつあるか
tf.pageMax =9;//ページの最大値
tf.btnOffsetX	= 180;	//
tf.btnOffsetY	= 308;	//
tf.btnWidth		= 719;	//セーブロードボタンの横幅
tf.btnHeight	= 39;	//セーブロードボタンの縦幅



var exit_button  = [652,552];	//戻るボタンの座標 x,y			ファイル名：cg_btn_exit
var autosave  = [518,553];	//オートセーブボタンの座標 x,y			ファイル名：cg_btn_exit



//セーブ　ロードボタンの座標

var btn_pos = [
	[40, 68],
	[40,115],
	[40,162],
	[40,209],
	[40,256],
	[40,303],
	[40,350],
	[40,397],
	[40,444],
	[40,491],
];

//セーブロードボタン上に描画する年月日の座標　通常x値のみ

tf.no_pos = 85;
tf.year_pos = 200;
tf.month_pos = 280;
tf.date_pos = 360;
tf.hours_pos = 530;
tf.minutes_pos = 595;
tf.seconds=660;

var page = [
	[44, 552],
	[74, 552],
	[104,552],
	[134,552],
	[164,552],
	[194,552],
	[224,552],
	[254,552],
	[284,552]
];


[endscript]



[return]
