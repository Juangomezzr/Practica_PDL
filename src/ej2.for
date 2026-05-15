PROGRAM test_matematicas ;

REAL, PARAMETER :: gravedad = 9.81;
INTEGER :: a = 5, b = 10;
REAL :: velocidad = 15.5, tiempo = 2.0, posicion_final;

    INTERFACE
        SUBROUTINE Intercambiar(x, y)
            INTEGER, INTENT(INOUT) x;
            INTEGER, INTENT(INOUT) y;
        END SUBROUTINE Intercambiar

        SUBROUTINE CalcularCaida(v0, t, g, pos)
            REAL, INTENT(IN) v0;
            REAL, INTENT(IN) t;
            REAL, INTENT(IN) g;
            REAL, INTENT(OUT) pos;
        END SUBROUTINE CalcularCaida
    END INTERFACE

    ! Si a es distinto de b, intercambiamos sus valores
    IF (a /= b) THEN
        ! Aqui tu traductor deberia generar: Intercambiar(&a, &b);
        CALL Intercambiar(a, b);
    ENDIF

    ! Aqui deberia generar: CalcularCaida(velocidad, tiempo, gravedad, &posicion_final);
    CALL CalcularCaida(velocidad, tiempo, gravedad, posicion_final);

END PROGRAM test_matematicas

SUBROUTINE Intercambiar(x, y)
    INTEGER, INTENT(INOUT) x;
    INTEGER, INTENT(INOUT) y;

    INTEGER :: aux;
    aux = x;
    x = y;
    y = aux;
END SUBROUTINE Intercambiar

SUBROUTINE CalcularCaida(v0, t, g, pos)
    REAL, INTENT(IN) v0;
    REAL, INTENT(IN) t;
    REAL, INTENT(IN) g;
    REAL, INTENT(OUT) pos;

    ! Operaciones encadenadas para probar la regla 'exp' y 'factor'
    pos = (v0 * t) + (0.5 * g * (t * t));
END SUBROUTINE CalcularCaida