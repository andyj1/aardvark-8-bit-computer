SOURCE = main_tb.v
WAVE = gtkwave
C11 = -std=c11

asm: 
	gcc preassembler.c -o preassemble $(C11)
	./preassemble
	gcc assembler.c -o assemble $(C11)
	./assemble
	rm -f intermediate.txt output.bin link assemble preassemble
run:
	iverilog -o out.vvp $(SOURCE)
	vvp out.vvp
	rm -f out.vvp
wave:
	$(WAVE) bag.vcd
	rm -f bag.vcd
clean:
	echo "Done."
	