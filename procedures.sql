CREATE OR REPLACE PACKAGE PKG_ETL_VENDAS AS

    PROCEDURE LOAD_DIM_PEDIDO;

    PROCEDURE LOAD_DIM_TEMPO;

    PROCEDURE LOAD_DIM_PRODUTO;

    PROCEDURE LOAD_DIM_CLIENTE;

    PROCEDURE LOAD_DIM_VENDEDOR;

    PROCEDURE LOAD_FATO_VENDAS;

    PROCEDURE RUN_ETL_VENDAS;
END PKG_ETL_VENDAS;
/

CREATE OR REPLACE PACKAGE BODY PKG_ETL_VENDAS AS

    PROCEDURE LOAD_DIM_PEDIDO IS
    BEGIN
        INSERT INTO DIMPEDIDO (
            COD_PEDIDO,
            STATUS
        )
            SELECT
                DISTINCT COD_PEDIDO,
                STATUS
            FROM
                PEDIDO;
    END LOAD_DIM_PEDIDO;

    PROCEDURE LOAD_DIM_TEMPO IS
    BEGIN
        INSERT INTO DIMTEMPO (
            DATA_VENDA,
            ANO,
            MES,
            DIA
        )
            SELECT
                DISTINCT DAT_PEDIDO                                                                        AS DAT_PEDIDO,
                EXTRACT(YEAR FROM DAT_PEDIDO)                                                     AS ANO,
                EXTRACT(MONTH FROM DAT_PEDIDO)                                                    AS MES,
                EXTRACT(DAY FROM DAT_PEDIDO)                                                      AS DIA
            FROM
                HISTORICO_PEDIDO;
    END LOAD_DIM_TEMPO;

    PROCEDURE LOAD_DIM_PRODUTO IS
    BEGIN
        INSERT INTO DIMPRODUTO (
            COD_PRODUTO,
            NOM_PRODUTO,
            STA_ATIVO
        )
            SELECT
                DISTINCT P.COD_PRODUTO,
                P.NOM_PRODUTO,
                P.STA_ATIVO
            FROM
                PRODUTO          P;
    END LOAD_DIM_PRODUTO;

    PROCEDURE LOAD_DIM_CLIENTE IS
    BEGIN
        INSERT INTO DIMCLIENTE (
            COD_CLIENTE,
            NOM_CLIENTE,
            STA_ATIVO
        )
            SELECT
                DISTINCT C.COD_CLIENTE,
                C.NOM_CLIENTE,
                C.STA_ATIVO
            FROM
                CLIENTE          C;
    END LOAD_DIM_CLIENTE;

    PROCEDURE LOAD_DIM_VENDEDOR IS
    BEGIN
        INSERT INTO DIMVENDEDOR (
            COD_VENDEDOR,
            NOM_VENDEDOR
        )
            SELECT
                DISTINCT V.COD_VENDEDOR,
                V.NOM_VENDEDOR
            FROM
                VENDEDOR         V;
    END LOAD_DIM_VENDEDOR;

    PROCEDURE LOAD_FATO_VENDAS IS
    BEGIN
        INSERT INTO FATOVENDAS (
            COD_PEDIDO,
            COD_PRODUTO,
            COD_CLIENTE,
            COD_VENDEDOR,
            DATA_VENDA,
            VAL_UNITARIO,
            QTD_VENDIDA,
            VAL_BRUTO,
            VAL_DESCONTO,
            VAL_TOTAL
        )
            SELECT
                DISTINCT HP.COD_PEDIDO                                                                     AS COD_PEDIDO,
                IP.COD_PRODUTO,
                HP.COD_CLIENTE,
                HP.COD_VENDEDOR,
                HP.DAT_PEDIDO                                                                     AS DATA_VENDA,
                IP.VAL_UNITARIO_ITEM                                                              AS VAL_UNITARIO,
                IP.QTD_ITEM                                                                       AS QTD_VENDIDA,
                SUM(IP.VAL_UNITARIO_ITEM * IP.QTD_ITEM)                                           AS VAL_BRUTO,
                SUM(IP.VAL_DESCONTO_ITEM * IP.QTD_ITEM)                                           AS VAL_DESCONTO,
                SUM(IP.VAL_UNITARIO_ITEM * IP.QTD_ITEM) - SUM(IP.VAL_DESCONTO_ITEM * IP.QTD_ITEM) AS VAL_TOTAL
            FROM
                HISTORICO_PEDIDO HP
                JOIN ITEM_PEDIDO IP
                ON HP.COD_PEDIDO = IP.COD_PEDIDO
            GROUP BY
                HP.COD_PEDIDO,
                IP.COD_PRODUTO,
                HP.COD_CLIENTE,
                HP.COD_VENDEDOR,
                HP.DAT_PEDIDO,
                IP.VAL_UNITARIO_ITEM,
                IP.QTD_ITEM;
    END LOAD_FATO_VENDAS;

    PROCEDURE RUN_ETL_VENDAS IS
    BEGIN
        BEGIN
            LOAD_DIM_PEDIDO;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_DIM_PEDIDO: '
                                     || SQLERRM);
        END;

        BEGIN
            LOAD_DIM_TEMPO;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_DIM_TEMPO: '
                                     || SQLERRM);
        END;

        BEGIN
            LOAD_DIM_PRODUTO;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_DIM_PRODUTO: '
                                     || SQLERRM);
        END;

        BEGIN
            LOAD_DIM_CLIENTE;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_DIM_CLIENTE: '
                                     || SQLERRM);
        END;

        BEGIN
            LOAD_DIM_VENDEDOR;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_DIM_VENDEDOR: '
                                     || SQLERRM);
        END;

        BEGIN
            LOAD_FATO_VENDAS;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in LOAD_FATO_VENDAS: '
                                     || SQLERRM);
        END;
    END RUN_ETL_VENDAS;
END PKG_ETL_VENDAS;
/

BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DIMPEDIDO';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DIMTEMPO';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DIMPRODUTO';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DIMCLIENTE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DIMVENDEDOR';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE FATOVENDAS';
    PKG_ETL_VENDAS.RUN_ETL_VENDAS;
END;
/