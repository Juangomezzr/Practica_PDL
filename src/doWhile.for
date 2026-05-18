PROGRAM pruebasDO;

INTEGER :: a = 5;
INTEGER :: b = 10;
INTEGER :: c = 0;

DO WHILE (a < b)
    DO WHILE (c < 5)
    c = c + 1;
    ENDDO
    a = a + 1;
ENDDO

DO i=0,2,1
    a = a + 1;
ENDDO

END PROGRAM pruebasDO