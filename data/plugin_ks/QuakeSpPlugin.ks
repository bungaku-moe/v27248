@if exp="typeof global.quakesp_object == 'undefined'"
@iscript
//*-------------------------------------------------------------------------------------------*
//
//FileName		:	QuakeSpPlugin.ks
//
//Version		:	1.10
//
//Description	:	指定したレイヤーのみを揺らすプラグイン
//					指定した前景レイヤーの表裏レイヤーを揺らす。
//
//					Copyright (C)2006～2009 西ノ森 蒼水 All rights reserved.
//					改変・再配布自由です。
//
//					ご使用にあたってはreadme.txtおよび、QuakeSpPlugin取扱説明書
//					をよくお読みください。
//
//					タグ名　quakesp
//
//					属性　　	必須？　説明
//					laynum		○　　　揺らす前景レイヤー番号を指定　","(カンマ)で区切ると
//										複数の前景レイヤーを指定可能。
//											例 laynum="0,1"	前景レイヤー0と1が揺れる
//					time		×		揺らす時間を指定(ミリ秒単位)
//											デフォルトは1000
//											[例 time=5000]	1000=1秒
//					timemode	×		time属性の単位
//											(詳しくはタグリファレンスのquakeタグを参照)
//					hmax		×		揺れの横方向への最大振幅(pixel単位)
//											デフォルトは10
//					vmax		×		揺れの縦方向への最大振幅(pixel単位)
//											デフォルトは10
//					usesin		×		三角関数を使った揺らしを行うか
//											デフォルトはfalse
//					speed		×		揺らすスピード(ミリ秒単位)
//											デフォルトは50
//
//
//					タグ名　stopquakesp　揺れを停止
//					
//					属性　なし
//
//
//					タグ名  wqsp　揺れ終了まで待つ
//
//					属性　なし
//
//
//					注意
//					*laynum属性にはbase,メッセージレイヤーは指定できない。
//					背景を揺らしたいなら、quakeタグを使う。
//
//
//*--------------------------------------------------------------------------------------------*
class QuakeSpPlugin extends KAGPlugin
{

	var window;						// Windowオブジェクト
	var quakeSpTimer;				// quake 用のタイマ
	var spquaking		=	false;	// quake中か？
	var spquakeEndTick	=	0;		// 終了tick
	var spquakeHorzMax	=	0;		// 水平方向の最大振幅数
	var spquakeVertMax	=	0;		// 垂直方向の最大振幅数
	var spquakePhase	=	0;		// 揺らす方向
	var laynum			=	[];		// 揺らす前景レイヤの番号を格納する配列
	var laynum_or;					// laynum属性に入力された値を保存
	var laypos			=	[];		// 前景レイヤーの初期位置
	var count			=	0;		// 三角関数揺らし用変数
	var usesin			=	false;	// アルゴリズムに三角関数を使用するか
	var speed			=	0;		// 振幅のスピード
	var time			=	0;		// 終了時間
	var loop;




	//*----------------------------------------------------------------*
	//Name		:	QuakeSpPlugin
	//
	//Purpose	:	コンストラクタ
	//				オブジェクト作成時に呼ばれる
	//
	//in		:	window	(Windowオブジェクト)
	//
	//out		:	なし
	//-----------------------------------------------------------------*
	function QuakeSpPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}



	//*----------------------------------------------------------------*
	//Name		:	finalize
	//
	//Purpose	:	デストラクタ
	//				オブジェクト消滅時に呼ばれる
	//
	//in		:	なし
	//
	//out		:	なし
	//-----------------------------------------------------------------*
	function finalize()
	{
		// 揺れを停止
		stopQuake();
		
		// タイマーを破棄
		invalidate quakeSpTimer if quakeSpTimer != void;
		
		super.finalize(...);
	}




	//*----------------------------------------------------------------*
	//Name		:	doQuakeSp
	//
	//Purpose	:	揺れ開始
	//				quakespマクロから呼ばれる
	//
	//in		:	elm (属性として設定された値)
	//
	//out		:	なし
	//-----------------------------------------------------------------*
	function doQuakeSp(elm)
	{

		// レイヤー番号を代入
		laynum = ((string)elm.laynum).split(",", ,true); 
			
		// 元データを保存
		laynum_or = elm.laynum;
		
		// レイヤー座標を代入(ロード後の場合)
		if(elm.laypos != void)
		{
			// ずれを修正
			setLayersPosition();
			
			// ロードした値を代入
			laypos = elm.laypos;
		}
		// 普通の場合
		else
		{
			// 揺らすレイヤー数
			var laycount = laynum.count;
			
			for(var i=0; i<laycount; i++)
			{	
				// 座標を入れる配列を作成
				var mlaypos = [];
				
				// レイヤー名を省略
				var lsf = kag.fore.layers[laynum[i]];
				var lsb = kag.back.layers[laynum[i]];
				
				// レイヤーの座標を代入
				mlaypos[0] = lsf.left;
				mlaypos[1] = lsf.top;
				mlaypos[2] = lsb.left;
				mlaypos[3] = lsb.top;
				
				// 大本の変数に代入
				laypos[i] = mlaypos;
			}
		}

		// 揺れ時間を設定
		if(elm.time != void)
		{
			// 属性設定またはロードした値を代入
			time = elm.time;
		}
		else
		{
			// 初期値を代入
			time = 1000;
		}

		// timemodeの設定による値を設定
		// Config.tjsのdefaultQuakeTimeInChUnitがtrueか？
		if(kag.defaultQuakeTimeInChUnit)
		{
			// timemode属性による設定を優先する　ミリ秒に設定
			if(elm.timemode == 'ms')
			{
				spquakeEndTick = System.getTickCount() + +time;
			}
			// 文字表示速度に設定
			else
			{
				spquakeEndTick = System.getTickCount() + +time * kag.chSpeed;
			}
		}
		// defaultQuakeTimeInChUnitがfalse(default)
		else
		{
			// timemode属性による設定を優先　文字表示速度に設定
			if(elm.timemode == 'delay')
			{
				spquakeEndTick = System.getTickCount() + +time * kag.chSpeed;
			}
			// ミリ秒に設定
			else
			{
				spquakeEndTick = System.getTickCount() + +time;
			}
		}

		// アルゴリズムに三角関数を使用するか？
		if(elm.usesin != void)
		{
			// 属性設定またはロードした値を代入
			usesin = elm.usesin;
		}
		else
		{
			// 初期値を代入
			usesin = false;
		}

		// 水平方向最大振幅を設定
		if(elm.hmax != void)
		{
			// 属性設定またはロードした値を代入
			spquakeHorzMax = elm.hmax;
		}
		else
		{
			// 初期値を代入
			spquakeHorzMax = 10;
		}

		// 垂直方向最大振幅を設定
		if(elm.vmax != void)
		{
			// 属性設定またはロードした値を代入
			spquakeVertMax = elm.vmax;
		}
		else
		{
			// 初期値を代入
			spquakeVertMax = 10;
		}
			
		// 速さの設定
		if(elm.speed != void)
		{
			// 属性設定またはロードした値を代入
			speed = elm.speed;
		}
		else
		{
			// 初期値を代入
			speed = 50;
		}

		if(elm.loop != void)
		{
			// 属性設定またはロードした値を代入
			loop = elm.loop;
		}
		else
		{
			// 初期値を代入
			loop=false;
		}

		// quake 用タイマの作成
		quakeSpTimer = new Timer(onQuakeSpTimerInterval, '');
		
		// 50msごとに呼び出す
		quakeSpTimer.interval = speed;
		
		// タイマーを有効にする
		quakeSpTimer.enabled = true;
		
		// Quake中に設定
		spquaking = true;
	}





	//*----------------------------------------------------------------*
	//Name		:	onQuakeSpTimerInterval
	//
	//Purpose	:	揺れ実行中に呼ばれる
	//				quakeSpTimerから呼ばれる
	//
	//in		:	なし
	//
	//out		:	なし
	//-----------------------------------------------------------------*
	function onQuakeSpTimerInterval()
	{
		// もし揺れ時間を過ぎていたら
		if(System.getTickCount() > spquakeEndTick)
		{
			// loop属性が無効だったら
			if(!loop)
			{
				// 揺れ停止
				stopQuake();

				return;
			}
		}

		var laycount;	// 揺らすレイヤー数
		var	x;			// x座標の増加or減少量
		var	y; 			// y座標の増加or減少量
		
		// 要素数を代入
		laycount = laynum.count;
		
		// メッセージ履歴表示中は揺らさない
		if(kag.historyShowing)
		{
			// すべての前景レイヤーを初期位置に戻す
			setLayersPosition();
				
			return;
		}
		
		// アルゴリズムに三角関数を使用するか?
		if(usesin)
		{
			x = (int)( spquakeHorzMax * Math.sin(count) );
			y = (int)( spquakeVertMax * Math.sin(count) );
		}
		else
		{
			// x座標とy座標への増加量を計算
			if( spquakeHorzMax == spquakeVertMax )
			{
				// だいたい同じ
				x = int( Math.random() * spquakeHorzMax - spquakeHorzMax );
				y = int( Math.random() * spquakeVertMax - spquakeVertMax );
			}
			else if( spquakeHorzMax < spquakeVertMax )
			{
				// 縦揺れ
				x = int( Math.random() * spquakeHorzMax - spquakeHorzMax );
				y = int( (spquakePhase ? Math.random() : -Math.random() ) * spquakeVertMax);
			}
			else
			{
				// 横揺れ
				x = int( (spquakePhase ? Math.random() : -Math.random() ) * spquakeHorzMax );
				y = int( Math.random() * spquakeVertMax - spquakeVertMax );
			}
			
			// 揺らす方向を逆にする
			spquakePhase = !spquakePhase;
		}


		// レイヤーを座標に配置
		for(var i=0; i<laycount; i++)
		{
			// レイヤー座標を格納する配列
			var mlaypos = [];

			// レイヤー座標を受け渡す
			mlaypos = laypos[i];

			// 現在のレイヤー座標 + or - x とｙの座標に移動
			kag.fore.layers[laynum[i]].setPos(mlaypos[0] + x, mlaypos[1] + y);
			kag.back.layers[laynum[i]].setPos(mlaypos[2] + x, mlaypos[3] + y);
		}
		
		// カウントを追加
		count++;
	}




	//*----------------------------------------------------------------*
	//Name		:	stopQuake
	//
	//Purpose	:	揺れ停止
	//
	//in		:	なし
	//
	//out		:	なし
	//-----------------------------------------------------------------*
	function stopQuake()
	{
		// 揺れ確認
		if(quakeSpTimer === void || !spquaking) 
		{
			// 揺れていなかった
			return;
		}
		
		// 揺れを停止
		setLayersPosition();
		
		// 揺れレイヤー解除 
		laynum = []; 
		laypos = []; 

		// タイマーを停止
		quakeSpTimer.enabled = false;

		// 揺れ中設定を解除
		spquaking = false;

		// トリガーを引く
		window.trigger('quake');
	}




	//*----------------------------------------------------------------*
	//Name		:	setLayersPosition
	//
	//Purpose	:	すべての前景レイヤーを初期位置に戻す
	//
	//in		:	なし
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function setLayersPosition()
	{
		for(var i=0; i<laynum.count; i++)
		{
			// レイヤー座標を格納する配列
			var mlaypos = [];

			// レイヤー座標を受け渡す
			mlaypos = laypos[i];

			// レイヤー位置固定
			kag.fore.layers[laynum[i]].setPos(mlaypos[0], mlaypos[1]); 
			kag.back.layers[laynum[i]].setPos(mlaypos[2], mlaypos[3]);
		}
	}




	//*----------------------------------------------------------------*
	//Name		:	PosChange
	//
	//Purpose	:	座標を入れ替える
	//				トランジションやbacklayタグの時用
	//
	//in		:	x1	(	入れ替えるmlayposの要素番号①(x座標)	)
	//				x2	(	入れ替えるmlayposの要素番号②(x座標)	)
	//				y1	(	入れ替えるmlayposの要素番号③(y座標)	)
	//				y2	(	入れ替えるmlayposの要素番号④(y座標)	)
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function PosChange(x1, x2, y1, y2)
	{
		// レイヤー座標を格納する配列
		var mlaypos = [];
		var tmp;
		
		for(var i=0; i<laynum.count; i++)
		{
			// レイヤー座標を受け渡す
			mlaypos = laypos[i];

			// x座標を入れ替え
			tmp			=	mlaypos[x1];
			mlaypos[x1]	=	mlaypos[x2];
			mlaypos[x2]	=	tmp;
			
			// y座標を入れ替え
			tmp		=	mlaypos[y1];
			mlaypos[y1]	=	mlaypos[y2];
			mlaypos[y2]	=	tmp;
		}
		
		
	}




	//*----------------------------------------------------------------*
	//Name		:	onStore
	//
	//Purpose	:	栞の保存されるときに呼ばれる
	//
	//in		:	f		(保存先の栞データを表す辞書配列)
	//						Dictionaryクラスのオブジェクト
	//
	//				elm		(現行バージョンでは使用されていない 常にvoid)
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onStore(f, elm)
	{
		// 揺れを停止
		setLayersPosition();
		
		// 保存する辞書配列を作成
		var dic = f.quakesp = %[];
		
		// 辞書配列に現在の値を保存
		dic.spquaking		=	spquaking;			// 揺れているか？
		dic.laynum			=	laynum_or;			// 揺らす前景レイヤー番号
		dic.laypos			=	laypos;				// 前景レイヤーの初期座標
		dic.usesin			=	usesin;				// アルゴリズムに三角関数を使用するか？
		dic.time			=	time;				// 終了時間
		dic.hmax			=	spquakeHorzMax;		// 水平方向の最大揺れ幅
		dic.vmax			=	spquakeVertMax;		// 垂直方向の最大揺れ幅
		dic.speed			=	speed;				// 揺れの速さ
	}




	//*----------------------------------------------------------------*
	//Name		:	onRestore
	//
	//Purpose	:	栞を読み出すときに呼ばれる
	//
	//in		:	f		(保存先の栞データを表す辞書配列)
	//						Dictionaryクラスのオブジェクト
	//
	//				clear	(メッセージレイヤーをクリアーするか)
	//						tempload時のみfalse
	//
	//				elm		(tempload時のオプション)
	//						tempload時以外は常にvoid,temploadのときは
	//						Dictionaryクラスのオブジェクト
	//
	//out		:	なし
	//*----------------------------------------------------------------*	
	function onRestore(f, clear, elm)
	{
		// 読み出す辞書配列を設定
		var dic = f.quakesp;
		
		// 揺れていなかったか？
		if(dic === void || dic.spquaking == 0)
		{
			// 揺れていなかった
			stopQuake();
		}
		
		// 揺れていたか？
		else if(dic !== void || dic.spquaking == 1)
		{
			// doQuakeSp関数実行
			doQuakeSp( %[ laynum : dic.laynum, laypos : dic.laypos, time : dic.time, hmax : dic.hmax, vmax : dic.vmax,
			usesin : dic.usesin, speed : dic.speed ] );
		}
	}





	//*----------------------------------------------------------------*
	//Name		:	onStableStateChanged
	//
	//Purpose	:	「安定」あるいは「走行中」の状態が変わったときに
	//				呼ばれる。
	//
	//in		:	state	(安定のときはtrue、走行中のときはfalse)
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onStableStateChanged(stable)
	{
	}




	//*----------------------------------------------------------------*
	//Name		:	onMessageHiddenStateChanged
	//
	//Purpose	:	メッセージレイヤーが隠れるときと、その状態から抜ける
	//				ときに呼ばれる。
	//
	//in		:	hidden	(メッセージレイヤーが隠されるときに”true”、
	//				 再び現れるときに”false”となる。)
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onMessageHiddenStateChanged(hidden)
	{
	}




	//*----------------------------------------------------------------*
	//Name		:	onCopyLayer
	//
	//Purpose	:	「backlay」タグあるいは「forelay」タグが実行された
	//				とき、あるいはトランジション終了時に、裏画面の情報を
	//				表画面にコピーする必要があるときに呼ばれる。
	//
	//in		:	toback	(「表→裏」のときに”true”、
	//						「裏→表」のときに”false”になる。)
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onCopyLayer(toback)
	{
		if(spquaking)
		{
			// 前景レイヤーの表裏ページ初期座標情報をそれぞれ交換する

			var mlaypos = [];	// レイヤー座標を格納する配列
			
			// 表→裏
			if(toback)
			{
				for(var i=0; i<laynum.count; i++)
				{
					// レイヤー座標を受け渡す
					mlaypos = laypos[i];

					// x座標を入れ替え
					mlaypos[2]	=	mlaypos[0];

					// y座標を入れ替え
					mlaypos[3]	=	mlaypos[1];
				}
			}
			// 裏→表
			else
			{
				for(var i=0; i<laynum.count; i++)
				{
					// レイヤー座標を受け渡す
					mlaypos = laypos[i];

					// x座標を入れ替え
					mlaypos[0]	=	mlaypos[2];

					// y座標を入れ替え
					mlaypos[1]	=	mlaypos[3];
				}
			}
		}
	}





	//*----------------------------------------------------------------*
	//Name		:	onExchangeForeBack
	//
	//Purpose	: 	トランジションの終了によって、裏画面と表画面の情報を
	//				入れ替える必要があるときに呼ばれる。
	//				このメソッドが呼ばれた時点でレイヤーのツリー構造は
	//				変わっている。
	//
	//in		:	なし
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onExchangeForeBack()
	{
		if(spquaking)
		{
			// 前景レイヤーの表裏ページ初期座標情報をそれぞれ交換する
			
			var mlaypos = [];	// レイヤー座標を格納する配列
			var tmp;			// 一時保存用
		
			for(var i=0; i<laynum.count; i++)
			{
				// レイヤー座標を受け渡す
				mlaypos = laypos[i];

				// x座標を入れ替え
				tmp			=	mlaypos[0];
				mlaypos[0]	=	mlaypos[2];
				mlaypos[2]	=	tmp;
			
				// y座標を入れ替え
				tmp			=	mlaypos[1];
				mlaypos[1]	=	mlaypos[3];
				mlaypos[3]	=	tmp;
			}
		}
	}




	//*----------------------------------------------------------------*
	//Name		:	onSaveSystemVariables
	//
	//Purpose	:	システム変数に情報を確実に保存するためのタイミングを
	//				提供する。
	//				この関数内で「kag.scflags」に何かメンバをつくり、
	//				そこに情報を記録しておくことができる。
	//				「kag.scflags」は辞書配列オブジェクトである。
	//
	//in		:	なし
	//
	//out		:	なし
	//*----------------------------------------------------------------*
	function onSaveSystemVariables()
	{
	}


}


// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.quakesp_object = new QuakeSpPlugin(kag));


//----- TJSスクリプトここまで ----------------------------------------*
@endscript
@endif

;----- タグ定義 ------------------------------------------------------*

;quakeタグ定義
@macro name=quakesp
@eval exp="quakesp_object.doQuakeSp(mp)"
@endmacro

;stopquakeタグ定義
@macro name=stopquakesp
@eval exp="quakesp_object.stopQuake()"
@endmacro

;wqspタグ定義
@macro name=wqsp
@waittrig name="quake"
@eval exp="quakesp_object.stopQuake()"
@endmacro

@return

;----- EOF ----------------------------------------------------------*
