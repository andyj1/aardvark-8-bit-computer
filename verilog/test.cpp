//Aim of the text: Producing sample binary file to test ram registers

#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(){

	string bin[10] = {"00010000","01010000","00010111","00000000", "11111111", "11101111","10101111","11101000","11111111","00000000"};
	ofstream myfile;
	myfile.open("example.bin");
	
	int m =0;
	for (int i =0; i < 255; i++){
		myfile << bin[m] << endl;;
		m++;
		if (m >= 10){
			m = 0;
		}
	}
	myfile.close();

	return 0;
}
