#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main() 
{
	FILE *fp;
	FILE *outptr;
	char linkerBuff[255];
	char buffName[255];
	printf("Enter linker file: ");
	scanf("%s",linkerBuff);
	fp = fopen(linkerBuff, "r+");
	printf("Enter the output file: ");
	scanf("%s", buffName);
	outptr = fopen(buffName, "w+");
	int counter = 0;
	char buff[255];
	char s[3];
	s[0] = ' ';
	s[1] = 10;
	char globalVar[4][9] = {'\0'};
	int numOfGlobals = 0;

	while(counter < 255)
	{
        char *token;
	fgets(buff, 255, (FILE*)fp);
	if (buff[0] == '0' || buff[0] == '1'){
		for (int i =0; i < 8; i++){
			globalVar[numOfGlobals][i] = buff[i];	
		}
		//printf("%s\n",globalVar[numOfGlobals]);
		numOfGlobals += 1;
	}else{
		while(fgets(buff, 255, (FILE*)fp) != NULL){
			
			printf("%s",buff);
			char *instr = "0000";
			char *string2 = "00";
			char *string3 = "00";
			/* get the first token */
			token = strtok(buff, s);
			if( token != NULL){
			instr = token;
			}
			/* walk through other tokens */
			token = strtok(NULL, s);
			if( token != NULL){
			string2 = token;
			}
			if( token != NULL)
			{
				if (buff[0] != 'j'){
					token = strtok(NULL, s);
					string3 = token;
				}
			}
			char address[] = "00000000";
			//char instr[] = "and";
			//char string2[] = "$s1";
			//char string3[] = "$s2";
			char result[] = "00000000";
			char type;
			//printf("Instruction:%s Reg One:%s  Reg 2:%s \n", instr, string2, string3);
			if(strcmp(instr, "and")==0)
			{
				//printf("Flag one");
				type = 'r';
				char opcode[] = "0001";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "nand")==0)
			{
				type = 'r';
				char opcode[] = "0011";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "slt_0")==0)
			{
				type = 'r';
				char opcode[] = "0100"; //everything with func included in op
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "slt_1")==0)
			{
				type = 'r';
				char opcode[] = "0101";		
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "sl")==0)
			{
				type = 'r';
				char opcode[] = "0110";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "sr")==0)
			{
				type = 'r';
				char opcode[] = "0111";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "lw")==0)
			{
				type = 'i';
				char opcode[] = "1000";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "sw")==0)
			{
				type = 'i';
				char opcode[] = "1001";
				strncpy(result, opcode, 4);
			}
			else if(strcmp(instr, "addi")==0)
			{
				type = 'i';
				char opcode[] = "1010"; //possible func
				strncpy(result, opcode, 3);
			}
			else if(strcmp(instr, "beq")==0)
			{
				type = 'j';
				char opcode[] = "110";
				strncpy(result, opcode, 3);
			}
			else if(strcmp(instr, "jal")==0)
			{
				type = 'j';
				char opcode[] = "111";
				strncpy(result, opcode, 3);
			}
			else if(strcmp(instr, "jr")==0)
			{
				type = 'z';	//technically type jr, but I want one letter
				char opcode[] = "10110011";
				strncpy(result, opcode, 8);
			}
			//Setting registers to binary
			char * reg1;
			char * reg2;
			printf("type: %c\n", type);
			if (string2[0] == '$' && string3[0] == '$'){
				if(strcmp(string2,"$s1")==0){
					char temp[3] = {'0', '0', '\0'};
					reg1 = &temp[0];
				}
				else if(strcmp(string2,"$s2")==0){
					char temp[3] = {'0', '1', '\0'};
					reg1 = &temp[0];
				}
				else if(strcmp(string2,"$sp")==0){
					char temp[3]  = {'1', '0', '\0'};
					reg1 = &temp[0];
				}
				else if(strcmp(string2,"$ra")==0){
					char temp[3] = {'1', '1', '\0'};
					reg1 = &temp[0];
				}
				//Same for reg2
				if(strcmp(string3,"$s1")==0){
					char temp1[3] = {'0', '0', '\0'};
					reg2 = &temp1[0];
				}
				else if(strcmp(string3,"$s2")==0){
					char temp1[3] = {'0', '1', '\0'};
					reg2 = &temp1[0];
				}
				else if(strcmp(string3,"$sp")==0){
					char temp1[3] = {'1', '0', '\0'};
					reg2 = &temp1[0];
				}
				else if(strcmp(string3,"$ra")==0){
					char temp1[3] = {'1', '1', '\0'};
					reg2 = &temp1[0];
				}
			}
			if(type == 'r')
			{
				strncpy(result+4, reg2, 2);
				strncpy(result+6, reg1, 2);
			}
			else if(type == 'i')
			{
				//printf("Flag I \n");
				int first, second;
				//Convert immediate to binary
				int num = atoi(string2);
				first = 0;
				second = 0;
				if(num < 0)
				{
					first = 1;
				}
				if(num%1==1){
					second = 1;
				}
				char a = first +'0';
				char b = second +'0';
				char answer[3] = {a, b, '\0'};
				//printf("Result 4 %s \n", result);
				strncpy(result+4, answer, 2);
				//printf("Result 6 %s \n", result);
				//printf("Reg1: %s Reg2: %s", reg1, reg2);
				strncpy(result+6, reg2, 2);
				//printf("End Flag I \n");
			}
			else if(type == 'j')
			{
				
				 int first, second, third, fourth, fifth;
				//Convert immediate to binary
				int num = atoi(string2); //-16 through 15
				first = second = third = fourth = fifth = 0;
				if(num < 0)
				{
				        first = 1;
					num = num + 16;
				}
				if(num >= 8){
					second = 1;
					num = num - 8;
				}
				if(num >= 4){
				        third = 1;
					num = num - 4;
				}
				if(num >= 2){
					fourth = 1;
					num = num - 2;
				}
				if(num == 1){
					fifth = 1;
				}
				char a = first +'0';
				char b = second +'0';
				char c = third + '0';
				char d = fourth + '0';
				char e = fifth + '0';
				char answer[6] = {a, b, c, d, e,'\0'};
				strncpy(result+3, answer, 5);
			}
			int n = 0;
			int allones = 1;
			char zeros[] = "00000000";
			//Increments by one, has no check for addresses > 256 so make programs short
			while(n < 8){
				if(address[n] == '0' && allones){
					allones = 0;
					address[n] = '1';
					strncpy(address+8-n, zeros, n);
				}
				n = n+1;
			}
			printf("%s\n", result);
			fprintf(outptr, "%s\n", result);
			
			counter++;
		}
		while (counter < 76){
			fprintf(outptr,"00000000\n");
			counter++;
		}
		for (int k = 0; k < numOfGlobals; k++){
			fprintf(outptr,"%s\n",globalVar[k]);
			//printf("%s\n",globalVar[k]);
			counter++;
		}
		while (counter < 256){
			fprintf(outptr,"00000000\n");
			counter++;
		}
	}
	}
		
	fclose(fp);
	fclose(outptr);
	printf("Finish assembling\n");
	return 0;
}
