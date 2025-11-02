#include <graphics.h>
#include <stdio.h>
#include <direct.h>
#include <conio.h>
#include <alloc.h>
#include <stdlib.h>

void print_cwd() {
    char cwd[260]; // Buffer for current directory path

    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("Current directory: %s\n", cwd);
    } else {
        printf("Failed to get current directory.\n");
    }
}

int char_to_int(char pixel_char){
    int pixel_value;
    if (pixel_char >= '0' && pixel_char <= '9') {
        pixel_value = pixel_char - '0';
    } else if (pixel_char >= 'a' && pixel_char <= 'f') {
        pixel_value = pixel_char - 'a' + 10;
    }
    return pixel_value;
}

void save_screen_to_binary(const char *filename, int width, int height) {
    char *buffer = (char *)malloc((width * height) / 2);
    if (buffer == NULL) {
        printf("Memory allocation failed.\n");
        return;
    }
    getimage(0, 0, width - 1, height - 1, buffer);
    FILE *fp = fopen(filename, "wb");
    if (fp == NULL) {
        printf("Failed to open file for writing.\n");
        free(buffer);
        return;
    }
    getch();
    fwrite(buffer, 1, width * height/2, fp);
    fclose(fp);
    free(buffer);
}

int main() {
    int gd = DETECT, gm;

    print_cwd();
    getch();

    initgraph(&gd, &gm, "c:\\borlandc\\bgi");

    FILE *fp = fopen("d:\\output.txt", "rt");
    if (fp == NULL) {
	printf("Error opening file\n");
	getch();
	closegraph();
	return 1;
    }

    const width = 627;
    const height = 252;
    char line[1024];

    int y = 0;
    while (fgets(line, sizeof(line), fp) && y < height) {
	for (int x = 0; x < width; x++) {
	    char pixel_char = line[x];
	    //int color = (pixel_char == '1') ? WHITE : BLACK;
	    if(pixel_char == '\n')  y++;
		putpixel(x, y, char_to_int(pixel_char));
	}
	y++;
    }

    fclose(fp);
    getch();

    save_screen_to_binary("viking.pic", width, height);
    closegraph();
    getch();

    return 0;
}
