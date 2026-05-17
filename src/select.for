PROGRAM pruebasIf;

INTEGER :: opcion = 2;
REAL :: calculo_extra;

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

END PROGRAM pruebasIf