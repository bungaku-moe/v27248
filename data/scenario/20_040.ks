
;ＳＥ/夜の虫
[se file="se152"]

;背景　旅館中庭　夜
[hide_char]
[haikei file="cmnbg1322" st="bg" fade="cross" time="2000"]

[wait time="2000"]

[stop_se fadeout="1500"]
[haikei file="black" st="bg" fade="cross" time="1500"]

;ＳＥ/バケツがひっくり返るバシャー
[se file="se028"]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262" st="ev" fade="cross" time="1500"]

[bgm file="bgm27"]

[name text="Takeo"]
(Saya ingin menjadi lebih dekat dengan kakak ipar saya...)
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262b" st="nv" fade="cross" time="500"]

Aku tenggelam dalam pikiran.
[tp]

Aku selalu menyukainya, tapi aku menekan perasaanku[r]
perasaan terhadapnya sampai sekarang.
[tp]

Dia istri kakakku, jadi aku berusaha membatasi[r]
kontak dengan dia sebanyak mungkin.
[tp]

Tapi kakakku tidak ada di sini lagi.
[tp]

Adik ipar saya tersedia.
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262" st="ev" fade="cross" time="500"]

[name text="Takeo"]
(Jadi tidak apa-apa bagiku untuk bergerak.)
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262b" st="nv" fade="cross" time="500"]

Saya menepis pikiran itu begitu pikiran itu datang.
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262" st="ev" fade="cross" time="500"]

[name text="Takeo"]
(Adikku tidak ada di sini lagi, tapi dia adalah milikku[r]
kakak ipar.)
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262b" st="nv" fade="cross" time="500"]

Aku menegur diriku lagi.
[tp]

;背景　大浴場　夜
[hide_char]
[haikei file="cmnbg1262" st="bg" fade="cross" time="1000"]

[stopse buf="2"]
[stopse buf="3"]

[hide_char]
[hide_balloon_window]
[hide_textwindow]
[stop_bgm fadeout="1500"]
[stop_se]
[haikei file="black" st="bg" fade="cross" time="1500"]
[return]