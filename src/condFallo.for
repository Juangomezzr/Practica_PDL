PROGRAM testIfs;

INTEGER :: a = 3;
INTEGER :: b = 5;
INTEGER :: c = 0;

IF (a < b) THEN
    c = 1;

IF (a == 3) THEN
    c = c + 10;
ELSE
    c = c + 20;

IF (b > a) c = c + 30;
ELSE
    c = c + 40;
ENDIF

c = c + 1;

END PROGRAM testIfs;