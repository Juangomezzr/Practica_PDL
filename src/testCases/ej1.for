PROGRAM pruebasIf;

INTEGER :: a = 5;
INTEGER :: b = 10;
INTEGER :: c = 0;
REAL :: x = 3.5;
CHARACTER(20) :: msg = 'hola';

IF (a < b) c = 1;


IF ((a < b) .AND. (x > 1.0)) THEN
    c = c + 10;
ENDIF

IF ((a > b) .OR. (c == 200)) THEN
    c = c + 20;
ENDIF

IF (.NOT. (a == b)) THEN
    c = c + 30;
ENDIF

IF (.TRUE.) THEN
    c = c + 40;
ENDIF

IF (.FALSE.) THEN
    c = 999;
ELSE
    c = c + 50;
ENDIF

END PROGRAM pruebasIf