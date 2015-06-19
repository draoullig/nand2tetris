// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.


// color=white
@color
M=0

// Valeur precedente de la couleur
@oldcolor
M=0

@INIT
0;JMP

(KEYBOARD)
	
	// On n'a pas appuye sur une touche
	// on boucle
	@KBD
	D=M
	@0
	D=D-M
	@TESTCOLOR
	D;JEQ

	// Une touche est presse donc noir
	@color
	M=-1

	@INIT
	0;JMP

(TESTCOLOR)
	// La couleur a change
	// On met a jour l'affichage
	@color
	D=M
	@oldcolor
	D=D+M
	@CHANGECOLOR
	D;JLT

	@KEYBOARD
	0;JMP

(CHANGECOLOR)
	// RAZ de color
	@color
	M=0
	
	@INIT
	0;JMP

(INIT)
	// Initialisation de l'affichage
	@SCREEN
	D=A
	@addr
	M=D //addr = 16384 (Screen base address)

	// n=8192
	@8192
	D=A
	@n
	M=D

	// initialize i=0
	@i
	M=0

	@AFFICHAGE
	0;JMP


(AFFICHAGE)
	// if (i=n) goto KEYBOARD
	@i
	D=M
	@n
	D=D-M
	@KEYBOARD
	D;JEQ

	// if (color=white) goto WHITE
	@color
	D=M
	@0
	D=D-M
	@WHITE
	D;JEQ

	@BLACK
	0;JMP

(WHITE)
	// Ecran en blanc
	@addr
	D=M
	@i
	A=D+M
	M=0
	@INCRE
	0;JMP

(BLACK)
	// Ecran en noir
	@addr
	D=M
	@i
	A=D+M
	M=-1
	@INCRE
	0;JMP

(INCRE)
	// i++
	@i
	M=M+1
	@AFFICHAGE
	0;JMP
