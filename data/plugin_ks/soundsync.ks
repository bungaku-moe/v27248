se][if exp="typeof(global.synchro_object) == 'undefined'"]

[iscript]

//--------------------
// 同期プラグイン
//--------------------
class SynchroPlugin extends KAGPlugin
{
	var buf;
	var time;
	var moving = false;

//----------------------------------------------------------------------

	// コンストラクタ
	function SynchroPlugin(window)
	{
		super.KAGPlugin(); // 親クラスのコンストラクタを呼ぶ
		this.window = window; // ウィンドウへの参照
	}

//----------------------------------------------------------------------

	// デストラクタ
	function finalize()
	{
		finish(); // 終了
		super.finalize(...); // 親クラスのデストラクタを呼ぶ
	}

//----------------------------------------------------------------------

	// 同期の開始
	function startSynchro(buf = 0, time = 0)
	{
		finish(); // 終了

		this.buf = buf;
		this.time = time;

		System.addContinuousHandler(continuousHandler);
		moving = true;
	}

	//----------------------------------------------------------------------

	// タイマーの周期が来た
	function continuousHandler()
	{
		if(kag.se[buf].position >= time)
			finish();
	}

//----------------------------------------------------------------------

	/// 終了
	function finish()
	{
		if(moving)
		{
			window.trigger('synchro');
			System.removeContinuousHandler(continuousHandler);
			moving = false;
			buf = void;
			time = void;
		}
	}

//----------------------------------------------------------------------

	function onRestore(f, clear, elm)
	{
		finish(); // 終了
	}

//----------------------------------------------------------------------

}
//--------------------------------------------------------------------------

kag.addPlugin(global.synchro_object = new SynchroPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]

[macro name=waitsound]
	[eval exp="synchro_object.startSynchro(+mp.buf, +mp.time)"]
	[waittrig * name="synchro" onskip="synchro_object.finish()"]
[endmacro]


[return]
