
;アイキャッチ

[se file="ec"]

[haikei file="ec03" st="bg" fade="20" time="1500"]

[wait time="2000"]

[stop_se fadeout="1500"]
[haikei file="black" st="bg" fade="cross" time="1500"]

;背景　旅館廊下　昼
[hide_char]
[haikei file="cmnbg0950" st="bg" fade="cross" time="1500"]

[haikei file="cmnbg0950b" st="nv" fade="cross" time="500"]

[bgm file="bgm26"]

Judging from what we did yesterday, I have a[r]pretty good idea of how Yukari feels about this.
[tp]

;背景　旅館廊下　昼
[hide_char]
[haikei file="cmnbg0950" st="ev" fade="cross" time="500"]

[name text="Takeo"]
(Am I really okay with leaving her like this?)
[tp]

[name text="Takeo"]
(What will happen to our relationship the next[r]time I come back?)
[tp]

[stopse buf="2"]
[stopse buf="3"]

[hide_char]
[hide_balloon_window]
[hide_textwindow]
[stop_bgm fadeout="1500"]
[stop_se]
[haikei file="black" st="bg" fade="cross" time="1500"]
[return]