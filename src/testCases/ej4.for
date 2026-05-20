PROGRAM test_final;

INTEGER, PARAMETER :: bin = b´1010´, oct = o´740´, hex = z´A34´;

INTEGER :: a = 2, b = 3, c = 0;
INTEGER :: resultado;

REAL :: x = 2.5, y = 4.0, z;

CHARACTER(30) :: texto = "hola ""mundo""";
CHARACTER(20) :: texto2 = 'It''s ok';

INTERFACE

    FUNCTION Multiplicar(valor1, valor2)
        REAL :: Multiplicar;
        INTEGER, INTENT(IN) valor1;
        REAL, INTENT(IN) valor2;
    END FUNCTION Multiplicar

    FUNCTION Sumar(v1, v2)
        INTEGER :: Sumar;
        INTEGER, INTENT(IN) v1;
        INTEGER, INTENT(IN) v2;
    END FUNCTION Sumar

END INTERFACE


c = a + b * 2;

z = Multiplicar(c, x);

resultado = Sumar(a, b);

IF ((a < b) .AND. (.NOT. (c == 0))) THEN

    DO WHILE ((a < 10) .AND. (b < 20))

        SELECT CASE (a)

            CASE (1)
                c = c + 1;

            CASE (2,3)
                c = c + 2;

            CASE (4)
                c = c + 4;

            CASE DEFAULT
                c = -1;

        END SELECT

        a = a + 1;

    ENDDO

ELSE

    c = 999;

ENDIF

END PROGRAM test_final


FUNCTION Multiplicar(valor1, valor2)

    REAL :: Multiplicar;

    INTEGER, INTENT(IN) valor1;
    REAL, INTENT(IN) valor2;

    REAL :: temp;

    temp = (valor1 * valor2) + 3.0;

    Multiplicar = temp;

END FUNCTION Multiplicar


FUNCTION Sumar(v1, v2)

    INTEGER :: Sumar;

    INTEGER, INTENT(IN) v1;
    INTEGER, INTENT(IN) v2;

    INTEGER :: aux;

    aux = v1 + v2;

    Sumar = aux;

END FUNCTION Sumar