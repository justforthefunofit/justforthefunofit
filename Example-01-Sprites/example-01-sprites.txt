!------------------------------------------------------------------
!- Just for the fun of it, by Sjef (2022)
!-
!- ----------------------------------------------------------------
!- This is a CBM prg Studio formatted file
!------------------------------------------------------------------
!- This example will read a sprite into memory and then copy this
!- sprite to five other sprite memory blocks. Then the sprites are
!- mirrored, flipped and mirrored. 
!------------------------------------------------------------------


110 rem declare variables an initialise them at beginning of program
120 sx= 53248: rem sprite horizontal Positions
130 sy= 53249: rem sprite vertical Positions
140 sc= 53287: rem sprite color
150 sp=  2040: rem sprite memory block pointer
160 sm=200*64: rem a memory block used for the first sprite
170 so=sm    : rem save the original memory block in this variable
180 n=.:i=.:p=.:x=.:y=.: rem initialize variable for counters and values
190 ll=.:rr=.:mm=. : rem initialize variables later used for value swapping

!-------------------------------------------------------------------
!- Define sprites
!-------------------------------------------------------------------
!- First read the first sprite data then copy this to the other sprites
!-
200 for x=0 to 62:read y:poke sm+x,y:next: rem read the data first sprite

210 rem now copy this from memory to the other four sprites memory blocks
220 sm=so+ 64 : gosub 410 : rem copy the sprite
230 sm=so+128 : gosub 410 : rem copy the sprite
240 sm=so+192 : gosub 410 : rem copy the sprite
250 sm=so+256 : gosub 410 : rem copy the sprite

!-------------------------------------------------------------------
!- Set color and sprite positions
!-------------------------------------------------------------------
260 poke sc+0,0:poke sp+0,200+0:poke sx+0,120:poke sy+0,100
270 poke sc+1,1:poke sp+1,200+1:poke sx+2,190:poke sy+2,100
280 poke sc+2,2:poke sp+2,200+2:poke sx+4,120:poke sy+4,150
290 poke sc+3,3:poke sp+3,200+3:poke sx+6,190:poke sy+6,150
300 poke sc+4,4:poke sp+4,200+4:poke sx+8,250:poke sy+8,150

!-------------------------------------------------------------------
!- Set sprite size x and y max en show all sprites
!-------------------------------------------------------------------
310 poke 53277,31: rem set hight of all five sprites to max
320 poke 53271,31: rem set width of all five sprites to max
330 poke 53269,31: rem set all five sprites to visable [00011111=31]

!-------------------------------------------------------------------
!- mirror sprite 1, 3 and 4 to get a full circle
!-------------------------------------------------------------------
340 rem so sprite memory block, no change
350 sm=so +64 :gosub 420 : rem mirror
360 sm=so +128:gosub 480 : rem flip
370 sm=so +192:gosub 480 : rem flip
380 sm=so +192:gosub 420 : rem mirror
390 sm=so +256:gosub 680 : rem inverse

400 end : rem end of program run

!-------------------------------------------------------------------
!- Next define the gosub routines used in this basic program
!-
!-------------------------------------------------------------------
!- Copy sprite from so (original) to sm (destination)
!-------------------------------------------------------------------
410 for x=0 to 62:y=peek(so+x):poke sm+x,y:next:return

!-------------------------------------------------------------------
!- mirror sprite horizontal
!-------------------------------------------------------------------
!- or replace gosub byte constant by cleaner(slower routine)
420 fori=0to20:
430  l=peek(sm+i*3):m=peek(sm+1+i*3):r=peek(sm+2+i*3)
440  b=r:gosub 560:pokesm+0+i*3,n
450  b=m:gosub 560:pokesm+1+i*3,n
460  b=l:gosub 560:pokesm+2+i*3,n
470 nexti:return

!-------------------------------------------------------------------
!- mirror sprite vertical
!-------------------------------------------------------------------
480 fori=0to10:
490  l=peek(sm+0+i*3):m=peek(sm+1+i*3):r=peek(sm+2+i*3)
500  ll=peek(sm+0+(20-i)*3):mm=peek(sm+1+(20-i)*3):rr=peek(sm+2+(20-i)*3)
510  poke sm+0+(20-i)*3,l:pokesm+0+i*3,ll
520  poke sm+1+(20-i)*3,m:pokesm+1+i*3,mm
530  poke sm+2+(20-i)*3,r:pokesm+2+i*3,rr
540 nexti
550 return

!-------------------------------------------------------------------
!- mirror/reverse a byte [10000000 to 00000001]
!-------------------------------------------------------------------
560 n=.
570 if b and   1 then n=n+128
580 if b and   2 then n=n+64
590 if b and   4 then n=n+32
600 if b and   8 then n=n+16
610 if b and  16 then n=n+8
620 if b and  32 then n=n+4
630 if b and  64 then n=n+2
640 if b and 128 then n=n+1
650 return

!-------------------------------------------------------------------
!- mirror/reverse a byte (clean code but slower) not used here
!-------------------------------------------------------------------
660 n=.:for q=0to7:if b and 2^q then n=n+2^(7-q):next
670 return

!-------------------------------------------------------------------
!- Invert sprite memory block
!-------------------------------------------------------------------
680 for i=0 to 63:b=peek(sm+i):gosub 700:poke sm+i,n:next
690 return

!-------------------------------------------------------------------
!- invert a byte [10101010 to 01010101]
!-------------------------------------------------------------------
700 n=255
710 if b and   1 then n=n-1
720 if b and   2 then n=n-2
730 if b and   4 then n=n-4
740 if b and   8 then n=n-8
750 if b and  16 then n=n-16
760 if b and  32 then n=n-32
770 if b and  64 then n=n-64
780 if b and 128 then n=n-128
790 return

!-------------------------------------------------------------------
!- sprite data dice example
!-------------------------------------------------------------------
800 data 0,0,0
810 data 0,0,0
820 data 0,63,240
830 data 0,96,16
840 data 0,160,48
850 data 1,32,80
860 data 2,32,144
870 data 7,255,16
880 data 4,33,16
890 data 4,33,16
900 data 4,33,16
910 data 4,33,16
920 data 4,33,16
930 data 4,63,240
940 data 4,65,16
950 data 4,129,32
960 data 5,1,64
970 data 6,1,128
980 data 7,255,0
990 data 0,0,0
1000 data 0,0,0
