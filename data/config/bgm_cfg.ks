;----------------------------------------------------
;BGM鑑賞画面　座標・環境設定ファイル
;
;TODO:　デザインに合わせて値を変更して下さい。
;
;BGM鑑賞の背景ファイル名：bgm_bg
;
;----------------------------------------------------

[iscript]

tf.bgmNum	= 10;//再生できるようにするBGMファイルの数

//曲目ボタンの座標と再生するファイル（wav or ogg)
//それぞれbgm_btn_1.png～ボタンに対応します。
tf.prop	= [
	%[x:66,y:72,  file:'bgm_01'],				//1		
	%[x:66,y:115, file:'bgm_02'],				//2		
	%[x:66,y:158, file:'bgm_03'],				//3		
	%[x:66,y:201, file:'bgm_04'],				//4		
	%[x:66,y:244, file:'bgm_05'],				//5		
	%[x:66,y:287, file:'bgm_06'],				//6		
	%[x:66,y:330, file:'bgm_07'],				//7		
	%[x:66,y:373, file:'bgm_08'],				//8		
	%[x:66,y:416, file:'bgm_09'],				//9		
	%[x:66,y:459, file:'bgm_10']				//10	
];


var play_button  = [430,553];//再生ボタンの座標 x,y		ファイル名：bgm_btn_play
var stop_button  = [350,553];//停止ボタンの座標 x,y		ファイル名：bgm_btn_stop
var next_button  = [470,553];//次曲ボタンの座標 x,y		ファイル名：bgm_btn_next
var loop_button  = [510,553];//ループボタンの座標 x,y	ファイル名：bgm_btn_loop
var exit_button  = [653,552];//戻るボタンの座標 x,y		ファイル名：bgm_btn_exit



//■ボリュームスライダー
//bgm_config_slider.pngがツマミになります。通常は横置きです。
var volume_button  =[41,561,150,12];//x座標,y座標,スライダーの長さ


[endscript]

[return]
