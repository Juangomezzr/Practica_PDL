    
    Programa: conjunto funciones
    Funciones: conjunto sentencias
    Sentencia: conjunto de elementos del lenguaje
    
PROGRAM prog1 ;

INTEGER, PARAMETER :: max_val = 100, min_val = -50;
REAL, PARAMETER :: pi = 3.1415, e = 2.71828, c = 2e-6;

INTEGER :: contador = 0, acumulador;
REAL :: promedio, total = 0.0;
CHARACTER(10) :: mensaje1 = 'Hola', mensaje2 = 'Mundo';

    INTERFACE

        SUBROUTINE ImprimirMensaje(texto)-> texto es un string porque despues aparece CHARACTER(10)
            CHARACTER(10), INTENT(IN) texto; -> si fuese out sería un puntero
        END SUBROUTINE ImprimirMensaje

        FUNCTION Sumar(a, b)
            INTEGER :: Sumar;
            INTEGER, INTENT(IN) a;
            INTEGER, INTENT(IN) b;
        END FUNCTION Sumar

    END INTERFACE

    contador = contador + 1; -> es un int esta def arriba pero se declarará en el main 
    total = total + 45.6;
    CALL ImprimirMensaje('Bienvenido');
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
    suma = a + b;
    Sumar = suma;
END FUNCTION Sumar