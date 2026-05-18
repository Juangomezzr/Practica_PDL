    

    
PROGRAM prog1 ;

INTEGER, PARAMETER :: max_val = 100, min_val = -50;
REAL, PARAMETER :: pi = 3.1415, e = 2.71828, c = 2e-6;

INTEGER :: contador = 0, acumulador;
REAL :: promedio, total = 0.0;
CHARACTER(10) :: mensaje1 = 'Hola', mensaje2 = 'Mundo';


    INTERFACE

        SUBROUTINE ImprimirMensaje(texto)
            CHARACTER(10), INTENT(IN) texto;
        END SUBROUTINE ImprimirMensaje

        FUNCTION Sumar(a, b)
            INTEGER :: Sumar;
            INTEGER, INTENT(IN) a;
            INTEGER, INTENT(IN) b;
        END FUNCTION Sumar

        SUBROUTINE proc1 ( c, d , e )
             REAL, INTENT (OUT) c;
             INTEGER, INTENT (IN) d;
             INTEGER, INTENT (INOUT) e;
        END SUBROUTINE proc1

    END INTERFACE

    contador = contador + 1;
    total = total + 45.6;
    CALL ImprimirMensaje('Bienvenido');
    CALL proc1(param1, param2 , param3);
    promedio = total / 2.0;

END PROGRAM prog1

SUBROUTINE ImprimirMensaje(texto)
    CHARACTER(10), INTENT(IN) texto;
    CALL MostrarEnPantalla(texto);

END SUBROUTINE ImprimirMensaje

FUNCTION Sumar(a, b)
    INTEGER :: Sumar;
    INTEGER, INTENT(IN) a;
    INTEGER, INTENT(IN) b;

    INTEGER :: suma;
    suma = a +b;
    Sumar = suma;
END FUNCTION Sumar

SUBROUTINE proc1 ( c, d , e )
 REAL, INTENT (OUT) c;
 INTEGER, INTENT (IN) d;
 INTEGER, INTENT (INOUT) e;
 ...
 c = 1 ;
 ...
 e = 2 +3 ;
 ...
END SUBROUTINE proc1