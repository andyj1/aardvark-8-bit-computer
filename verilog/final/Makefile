SOURCE = main_tb.v
WAVE = gtkwave

all: 
	iverilog -o bag.vvp $(SOURCE)
	vvp bag.vvp
	$(WAVE) bag.vcd
	
clean:
	rm -rf *.vvp *.vcd