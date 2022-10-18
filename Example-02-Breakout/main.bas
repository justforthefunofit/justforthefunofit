100 rem --  just for the fun of it   --
105 rem -------------------------------
110 rem -      breakout example
115 rem -------------------------------
120 rem
125 rem -------------------------------
130 rem print color tiles top of screen
135 rem -------------------------------
140 print chr$(147):poke53280,0:poke53281,0:sm=1024
145 c$=chr$(28)+chr$(149)+chr$(158)+chr$(30)+chr$(31):print
150 for p=1 to 5:for n=1 to 8 :
155 print chr$(18)+mid$(c$,p,1)+chr$(229)+"   "+chr$(234);
160 nextn, p
165 rem -------------------------------
170 rem place paddle
175 rem -------------------------------
180 poke 650, 128           : rem activate autorepeat key
185 sa= sm + (22*40)        : rem set start line of paddle
190 pp= 17                  : rem set start position of paddle
195 x =int(rnd(1)*24)       : rem random ball start position of x
200 y=12                    : rem ball start line position y
205 dy=1:dx=1               : rem ball directions initialisation
210 sp = sa + pp            : rem set postion of paddle screen memory
215 pokesp  ,32:pokesp+1,98 : rem place paddle on screen (left chars)
220 pokesp+2,98:pokesp+3,98 : rem paddle middle chars
225 pokesp+4,98:pokesp+5,32 : rem paddle right char + extra space
230 getk:pp=pp+(k=1)-(k=2)  : rem get key input 1=left or 2=right
235 if pp < -1 then pp = -1 : rem check left boundery
240 if pp > 35 then pp= 35  : rem chech right boundery
245 rem ------------------------------
250 rem ----------- bounding ball
255 rem ------------------------------
260 poke sm+x+(y*40),32           : rem clean current position of ball
265 if y>=24 or y < 1 then dy=-dy : rem reverse ball direction
270 if y>=24 then ms=ms+1         : rem paddle missed ball
275 if x>=39 or x<1 then dx=-dx   : rem reverse directions on boundery
280 mc=-1:if k=1 then mc=-mc      : rem use user direction also
285 x=x+dx:y=y+dy                 : rem next x,y position
290 if peek(sm+x+(y*40))=98 then dx=-dx*mc:dy=-dy:l=l+1:rem check next position
295 poke sm+x+(y*40),81           : rem place ball on new position
300 print chr$(19)"hit:";l;" missed:";ms : rem show score
305 goto 210 : rem restart main loop
