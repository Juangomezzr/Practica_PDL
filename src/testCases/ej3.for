PROGRAM test_bucles ;

INTEGER, PARAMETER :: limite = 10, inicio = 1, paso = 1;
INTEGER :: iterador, suma_total = 0;
INTEGER :: opcion = 2;
REAL :: calculo_extra;
CHARACTER (10):: var7, var8;
CHARACTER :: var4, var5 = "-", var6;

    INTERFACE
        SUBROUTINE EvaluarOpcion(op, res)
            INTEGER, INTENT(IN) op;
            REAL, INTENT(OUT) res;
        END SUBROUTINE EvaluarOpcion
        FUNCTION fun1 ( a, b )
         INTEGER :: fun1;
         INTEGER, INTENT (IN) a;
         CHARACTER(4), INTENT (IN) b;
        END FUNCTION fun1
    END INTERFACE

    ! Prueba de bucle DO clasico (requiere los 3 doval segun tu gramatica)
    DO iterador = inicio, limite, paso
        suma_total = suma_total + iterador;
    ENDDO

    ! Prueba de IF-THEN-ELSE anidado
    IF (suma_total > 50) THEN
        calculo_extra = 1.0;
    ELSE
        IF (suma_total == 50) THEN
            calculo_extra = 0.5;
        ELSE
            calculo_extra = 0.0;
        ENDIF
    ENDIF

    ! Prueba de DO WHILE y SELECT CASE
    DO WHILE (opcion < 5)
        SELECT CASE (opcion)
            CASE (1)
                calculo_extra = calculo_extra + 10.0;
            CASE (2, 3)
                calculo_extra = calculo_extra + 20.0;
            CASE DEFAULT
                calculo_extra = calculo_extra - 1.0;
        END SELECT

        opcion = opcion + 1;
    ENDDO

    CALL EvaluarOpcion(opcion, calculo_extra);

END PROGRAM test_bucles

SUBROUTINE EvaluarOpcion(op, res)
    INTEGER, INTENT(IN) op;
    REAL, INTENT(OUT) res;

    res = 0.0;
END SUBROUTINE EvaluarOpcion

