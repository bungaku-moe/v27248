
;[loadplugin module="krkrutil.dll"]
[iscript]

function sigCheck2(fname, publickey)
{
	if (!sigCheck(fname, publickey)) {
	/*
		System.inform('署名が無効です : '+fname);
		kag.shutdown();
	*/
	}
}

[endscript]


;------------------------------------------------------------------------------
;	exe, xp3ファイルの署名チェック
;		[signcheck file="" publickey=""]
;		file		ファイル名
;		publickey	署名の公開鍵
;------------------------------------------------------------------------------
[macro name="signcheck"]
	[eval exp="sigCheck2(mp.file, mp.publickey)"]
[endmacro]

;------------------------------------------------------------------------------
;	デバッグホットキー無効化(Shift+F*系)
;		[hook]
;------------------------------------------------------------------------------
[macro name="hook"]
	[eval exp="hook()"]
[endmacro]

;------------------------------------------------------------------------------
;	デバッグホットキー有効化(Shift+F*系)
;		[unhook]
;------------------------------------------------------------------------------
[macro name="unhook"]
	[eval exp="unhook()"]
[endmacro]


[return]



