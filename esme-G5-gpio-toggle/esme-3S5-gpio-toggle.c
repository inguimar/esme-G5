#include <stdio.h>
#include <gpiod.h>
#include <stdlib>
#include <string.h>
#include <unistd.h>

int main(int N, char *P[]){

    if (N != 3 || strcmp(P[1], "--gpio") != 0) {
        fprintf(stderr, "Usage: %s --gpio <GPIO_ID>\n", P[0]);
        return EXIT_FAILURE;
    }

    int gpio = atoi(P[2]);

    if (gpio < 0) {
        fprintf(stderr, "Invalid GPIO ID: %s\n", P[2]);
        return EXIT_FAILURE;
    }

    struct gpiod_chip *chip = gpiod_chip_open("/dev/gpiochip0");
    if (!chip) {
        perror("Failed to open gpiochip0");
        return EXIT_FAILURE;
    }

    struct gpiod_line *line = gpiod_chip_get_line(chip, gpio);
    if (!line) {
        perror("Failed to get GPIO line");
        gpiod_chip_close(chip);
        return EXIT_FAILURE;
    }


    if (gpiod_line_request_output(line, "esme-gpio-toggle", 0) < 0) {
        perror("Failed to request GPIO line as output");

        gpiod_chip_close(chip);
        return EXIT_FAILURE;
    }


    while (1){
        /*inverse la valeur de la gpio toutes les secondes
        gpio=1;
        sleep(1);
        gpio=0;
        */
        

        gpiod_line_set_value(line,0);
        sleep(1);
        gpiod_line_set_value(line,1);


    }

    gpiod_line_release(line);
    gpiod_chip_close(chip);

    return 0;
}
