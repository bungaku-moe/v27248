
;ＳＥ/夕暮れのカラス
[se file="se154"]

;背景　空　夕
[hide_char]
[haikei file="cmnbg9901" st="bg" fade="cross" time="2000"]

[wait time="2000"]

[stop_se fadeout="1500"]
[haikei file="black" st="bg" fade="cross" time="1500"]

;背景　旅館個室2　夕
[hide_char]
[haikei file="cmnbg0701" st="bg" fade="cross" time="1500"]

[haikei file="cmnbg0701b" st="nv" fade="cross" time="500"]

[bgm file="bgm27"]

A slightly awkward silence spreads between us as[r]we clean up after sex.
[tp]

After we finish, Yukari speaks. 
[tp]

;背景　旅館個室2　夕
[hide_char]
[haikei file="cmnbg0701" st="ev" fade="cross" time="500"]

;湯香里/着物/P2/Ｍ/苦笑
[char_c file="ta117"]
[char_action time="500"]

[name text="Yukari"]
[voice id="ykr" file="vf50_040ykr0000"]
I am happy about your feelings for me… but I[r]can't leave the inn.
[tp]

;湯香里/着物/P1/Ｍ/微笑
[char_c file="ta100"]
[char_action time="200"]

[name text="Yukari"]
[voice id="ykr" file="vf50_040ykr0001"]
I want to maintain the place my husband devoted[r]himself to. 
[tp]

;湯香里/着物/P1/Ｍ/哀しい
[char_c file="ta103"]
[char_action time="200"]

[name text="Yukari"]
[voice id="ykr" file="vf50_040ykr0002"]
Takeo, you're going to leave, right?
[tp]

;背景　旅館個室2　夕
[hide_char]
[haikei file="cmnbg0701b" st="nv" fade="cross" time="500"]

I can't reply. 
[tp]

All I can do is stand there.
[tp]

Yukari leaves the room with a sad smile.
[tp]

;背景　旅館個室2　夕
[hide_char]
[haikei file="cmnbg0701" st="bg" fade="cross" time="1000"]

[stopse buf="2"]
[stopse buf="3"]

[hide_char]
[hide_balloon_window]
[hide_textwindow]
[stop_bgm fadeout="1500"]
[stop_se]
[haikei file="black" st="bg" fade="cross" time="1500"]
[return]