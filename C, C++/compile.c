#include <stdio.h>
#include <string.h>
typedef struct Labels{
	char strVal[20]; 	//name of label
	char actualVal[20];		//actual value
	char type[20];		//type of data, almost always will be bytes
	char location[8];	//absolute address
} Label;

typedef struct instrLabels{
	char inst_loc[20];
	int location;
} instrLabel;

const char *bit_rep[16] = {
    [ 0] = "0000", [ 1] = "0001", [ 2] = "0010", [ 3] = "0011",
    [ 4] = "0100", [ 5] = "0101", [ 6] = "0110", [ 7] = "0111",
    [ 8] = "1000", [ 9] = "1001", [10] = "1010", [11] = "1011",
    [12] = "1100", [13] = "1101", [14] = "1110", [15] = "1111",
};
int main(){
	//initialization
	FILE *fptr;
	FILE *outfptr;
	char buf[1024];
	char newNameBuf[255];
	char newbuf[1024];
	char *buffer[1024];
	char *outbuf[1024];
	int text = 0;
	int data = 76;
	//open input and output file
	printf("Enter an input file: ");	
	scanf("%s", buf);
	printf("Enter an linker file name: ");
	scanf("%s", newNameBuf);
	printf("Starting to assemble...\n");
	fptr = fopen(buf, "r+");
	outfptr = fopen(newNameBuf, "w");
	
	//error catching
	if (!fptr){
		return 1;
	}
	//store labels in a library
	Label labellist[8];
	instrLabel instrLabellist[4];
	int i = 0;
	int numLabel = 0;
	
	//first scan through the whole file and convert labels to numbers
	fgets(buf, 1000, fptr);
	while (fgets(buf,1000, fptr)!=NULL && buf[1] != 't'){
		
		char numberbuf[3] = {0};
		int j = 1; //goes through the buffer
		int k = 0;
		while (buf[j] != ' '){
			//stores the type
			(labellist[i]).type[k] = buf[j];
			k++;
			j++;
		}
		j += 1;
		k = 0;
		
		while (buf[j] != ' '){
			//stores the label
			(labellist[i]).strVal[k] = buf[j];
			k++;
			j++;
		}
		j += 1;
		k = 0;
		
		while (buf[j] <= 57 && buf[j] >= 48 && k < 3){
			//stores the actual value
			//printf("%d\n", buf[j]);
			numberbuf[k] = buf[j];
			//printf("%d\n", k);
			k++;
			j++;
		}
		//printf("Hello!");
		
		int val = 0;
		//printf("%s\n", numberbuf);
		int m = 0;
		while(numberbuf[m] != 0){
			val *=10;
			val += numberbuf[m] - '0';
			//printf("%d %d\n",numberbuf[m], val);
			m ++;
		}		
		int dec_val_beg = val/16;
		int dec_val_end = val%16;
		int dec_loc_beg = (data+i)/16;
		int dec_loc_end = (data+i)%16;
		sprintf(labellist[i].location,"%s%s",bit_rep[dec_loc_beg],bit_rep[dec_loc_end]);
		sprintf(labellist[i].actualVal,"%s%s",bit_rep[dec_val_beg],bit_rep[dec_val_end]);
		fprintf(outfptr,"%s\n", labellist[i].actualVal);
		
		i++;
	}
	int count = 0;
	while (fgets(buf,1000, fptr)!=NULL){
		int a = 0;
		int d = 0;
		while (buf[a] != ':' && buf[a] != '\0'){
			a++;
		}
		if (buf[a] == ':'){
			for (int b = 0; b < a; b++){
				instrLabellist[numLabel].inst_loc[b] = buf[b];
			}
			instrLabellist[numLabel].location = text + count;
			numLabel += 1;
		}
		count += 1;
	}
	
	rewind(fptr);
	while (fgets(buf,1000, fptr)!=NULL && buf[1] != 't'){
		
	}
	fprintf(outfptr, "%s", buf);
	//go through file again and relabel the labels
	//fputs(buf, outfptr);
	int cur_loc = text;
	while (fgets(buf,1000, fptr)!=NULL){
		
		if (buf[0] == 'l' && buf[1] == 'a'){
			//load address psuedo code
			//e.g. la $r1, var1
			int j = 0;
			int k = 0;
			int stillOK = 1;
			char buffy[20];
			char rt[4] = {0,0,0,0};
			char myByte[8];	//stores the Byte
			//printf("%s\n", buf);
			while (buf[j] != ' '){
				j++;
			}
			j += 1;
			
			while (buf[j] != ' '&& k < 3){
				//printf("%c\n", rt[j]);
				rt[k] = buf[j];
				k++;
				j++;
			}
			//printf("%s\n", rt);
			j += 1;
			k = 0;
			
			while (buf[j] != '\0'||k<3){
				//stores the actual value
				buffy[k] = buf[j];
				k++;
				j++;
			}
			
			
			for (int m = 0; m < 8; m++){
				stillOK = 1;
				for (int n = 0; n < strlen(labellist[m].strVal); n++){
					if ((labellist[m].strVal)[n] != buffy[n]){
						stillOK = 0;
					}
					if (stillOK == 0){
						break;
					}
				}
				if (stillOK == 1){
					for (int g = 0; g < 8; g++){
						myByte[g] = (labellist[m].location)[g];
					}
					for (int m = 0; m < 8; m++){
						fprintf(outfptr,"sl %s %s\n", rt,rt);
						if (myByte[m] == '1'){
							fprintf(outfptr,"addi %s 1\n", rt);
						}
					}
					break;
				}
			}
		}else if ((buf[0] == 'j' && buf[1] == 'a' & buf[2] == 'l') || (buf[0] == 'b' && buf[1] == 'e' & buf[2] == 'q')){
			
			int j = 0;
			int k = 0;
			int stillOK = 1;
			char instLabel[10];
			
			while (buf[j] != ' '){
				j++;
			}
			j += 1;
			
			while (buf[j] != '\0'){
				instLabel[k] = buf[j];
				k++;
				j++;
			}
			
			for (int m = 0; m < numLabel; m++){
				stillOK = 1;
				for (int n = 0; n < strlen(instrLabellist[m].inst_loc); n++){
					if ((instrLabellist[m].inst_loc)[n] != instLabel[n]){
						stillOK = 0;
						break;
					}
				}
				if (stillOK == 1){
					int offset;
					offset = instrLabellist[m].location - cur_loc ;
					if (buf[0] == 'b'){
						fprintf(outfptr, "beq %d\n", offset);
					}else{
						fprintf(outfptr, "jal %d\n", offset);
					}
					break;
				}
			}
			
			
		}else{
			int a = 0;
			int d = 0;
			while (buf[a] != ':' && buf[a] != '\0'){
				a++;
			}
			if (buf[a] == ':'){
				a += 2;
				while (buf[a] != '\0'){
					newbuf[d] = buf[a];
					a++;
					d++;
				}
				fputs(newbuf,outfptr);
				//printf("%s ", newbuf);
			}else if(buf[a] == '\0'){
				fputs(buf,outfptr);
			}
		}
		cur_loc += 1;
	}		
	
	fclose(fptr);
	fclose(outfptr);
	printf("Finish assembling\n");
	//spit out an output file
	return 0;
}
