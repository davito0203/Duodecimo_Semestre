/*Here's a very brain dead simple C program that will capture from the defined port at the defined baud rate and write to stdout, from there, you can redirect to a logfile. Put the code in a file called serialcap.c, and specify the serial port and speed in the defines. Compile with gcc -o serialcap serialcap.c It seems to work just fine with my router connected with a null modem cable. This is assuming 8N1.
http://ubuntuforums.org/showthread.php?t=13667
*/
// red(): http://gd.tuwien.ac.at/languages/c/programming-bbrown/c_075.htm

#include <fcntl.h>
#include <stdio.h>
#include <termios.h> // http://en.wikibooks.org/wiki/Serial_Programming/termios
#include <stdlib.h>
#include <strings.h>

/* Change to the baud rate of the port B2400, B9600, B19200, etc */
#define SPEED B115200 // porq la B?


/* Change to the serial port you want to use /dev/ttyUSB0, /dev/ttyS0, etc. */
#define PORT "/dev/ttySP1"

int main( ){

    int fd = open( PORT, O_RDONLY | O_NOCTTY | O_NDELAY); // non-blocking Added.

    if (fd < 0) {
       perror(PORT); 
       exit(-1); 
       printf( "failed to open port\n" );
    } else { 
       printf("Port OPENED successfully \nFile descriptor: %d \n",fd);
    }
    
    struct termios options;
    tcgetattr(fd, &options);   // get current port attribs

//------------** CONFIGURACIÓN PUERTO **-------------------

    options.c_cflag |= SPEED | CS8 | CLOCAL | CREAD; // sin ignorar paridad. 7 u 8 BITS DE ENVÍO???? <--***
    tcsetattr(fd, TCSANOW, &options);


    printf("Config DONE. \n");

//---------------** LOG FILE CREATION **-------------------
  FILE *logFile,*salida;
   	  
    int r,i=0,j,k=0,l=1;
    char buf[256];
    char a;
    int aa;
    
    while (1) {

       logFile = fopen ("/var/www/data.json",/*"a"*/ "w"); //a: append; w: write new file
       if (logFile==NULL)
       {
           printf("Can't create logFile \n");
       } else {
          printf("logFile created \n");
          fputs("{\n \r\"label\" : \"Datos del Osciloscopio\",\n \r\"data\": [ ",logFile);    //json format
       }
      
       while( i < 100 ){    // read port loop
           
           r = read( fd, &buf, 6 ); // http://www.cplusplus.com/reference/istream/istream/read/
           buf[r]=0;
           i++;

           for (j=0;j<100000;j++)        
           {}
        
           if (r == 5){
              k+=1;
              printf( "string = %s; read = %d\n", buf, r);
              if (k != 1){
                 fprintf(logFile,",");
              }
              fprintf(logFile,"[%d,%s]\n", k, buf);
           } else {
              printf( "sync error!!! string = %s; read = %d\n", buf, r);
           }
       }
       
       i=0;
       k=0;
       
       fputs(" ] }", logFile);
       fclose(logFile);
       printf("LogFile successfully closed\n");
     
       while (l){     
          salida = fopen ("salida",/*"a"*/ "r"); //a: append; w: write
          fscanf(salida, "%c", &a);
          if (a == 'Y') {
             l=0;		// sale del loop
             salida = fopen ("salida", "w"); //a: append; w: write
             fprintf(salida,"N");
             printf("N rewritten\n");
          } else if (a == 'Q') {
             l=0;		//sale del loop
             salida = fopen ("salida", "w"); //a: append; w: write
             fprintf(salida,"N");
          } else {
             l=1;
//             printf("waiting for port rescanning\n");
          }
       
          fclose(salida);
       
          for (j=0;j<10000000;j++){}
          
       }
       
       if (a == 'Q') { break; }
       l=1;
       
    }
    
    printf("\nQuitting port rescanning\n");    
    printf("Closing Port\n");
    aa = close(fd);
    printf("Port Close returns: %d\n",aa);
    if (aa <0) {
       printf("Error when closing port!!! %d \n",aa);
       perror(PORT); 
       exit(-1); 
    } else { 
       printf("Port CLOSED successfully\n");
    }
    printf("ACQUISITION PROGRAM CLOSED\n"); 
        
    
    return 0;
}
