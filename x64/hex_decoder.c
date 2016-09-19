#include <stdio.h>
#include <string.h>

/*extern "C"*/ int hex_decoder(char *, char *);


int main(void)
{
	FILE * F_IN;
	FILE * F_OUT;

	char str[1024];
	char new_str[1024];

	char fin_addr[256];
	char fout_addr[256];
	
	puts("Input file address:");
	scanf("%s", fin_addr);
	puts("Output file address:");
	scanf("%s", fout_addr);

	F_IN = fopen(fin_addr, "r");
	if (F_IN == NULL)
	{
		puts("file_input.txt doesn't exist");
		return 1;
	}
	F_OUT = fopen(fout_addr, "w");
	if (F_OUT == NULL)
	{
		puts("error occured: file_output.txt");
		return 1;
	}

	while (fgets(str, 1024, F_IN) != NULL)
	{
		printf("%s", str);
		hex_decoder(new_str, str);
		fputs(new_str, F_OUT);
		printf("%s", new_str);
		memset(new_str,'\0',1024);
	}

	fclose(F_IN);
	fclose(F_OUT);

	return 0;
}

