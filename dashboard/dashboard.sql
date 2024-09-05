/* -------------------------------------------------------------------------- */
/*    Volume de vendas, segmentado por ano, mês, vendedor e cliente   */
/* -------------------------------------------------------------------------- */

SELECT
    T.ANO,
    T.MES,
    V.NOM_VENDEDOR,
    C.NOM_CLIENTE,
    P.NOM_PRODUTO,
    SUM(F.QTD_VENDIDA)  AS QTD_TOTAL_VENDIDA,
    SUM(F.VAL_BRUTO)    AS VAL_BRUTO_TOTAL,
    SUM(F.VAL_DESCONTO) AS VAL_DESCONTO_TOTAL,
    SUM(F.VAL_TOTAL)    AS VAL_TOTAL_VENDIDO
FROM
    FATOVENDAS  F
    JOIN DIMPRODUTO P
    ON F.COD_PRODUTO = P.COD_PRODUTO
    JOIN DIMCLIENTE C
    ON F.COD_CLIENTE = C.COD_CLIENTE
    JOIN DIMVENDEDOR V
    ON F.COD_VENDEDOR = V.COD_VENDEDOR
    JOIN DIMTEMPO T
    ON F.DATA_VENDA = T.DATA_VENDA
GROUP BY
    T.ANO,
    T.MES,
    V.NOM_VENDEDOR,
    C.NOM_CLIENTE,
    P.NOM_PRODUTO
ORDER BY
    T.ANO,
    T.MES,
    V.NOM_VENDEDOR,
    C.NOM_CLIENTE,
    P.NOM_PRODUTO;

/* -------------------------------------------------------------------------- */
/*                      Qual foi o produto mais rentável?                     */
/* -------------------------------------------------------------------------- */

SELECT
    FV.COD_PRODUTO,
    DP.NOM_PRODUTO,
    TO_CHAR(SUM(FV.VAL_BRUTO), 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''')    AS VAL_BRUTO,
    TO_CHAR(SUM(FV.VAL_DESCONTO), 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''') AS VAL_DESCONTO,
    TO_CHAR(SUM(FV.VAL_TOTAL), 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''')    AS VAL_TOTAL
FROM
    FATOVENDAS FV
    JOIN DIMPRODUTO DP
    ON FV.COD_PRODUTO = DP.COD_PRODUTO
GROUP BY
    FV.COD_PRODUTO,
    DP.NOM_PRODUTO
ORDER BY
    VAL_TOTAL DESC;

/* -------------------------------------------------------------------------- */
/*                  Qual é o perfil de consumo dos clientes?                  */
/* -------------------------------------------------------------------------- */

/* -------------------- -- Clientes que mais compraram ------------------- */
SELECT
    FV.COD_CLIENTE,
    DC.NOM_CLIENTE,
    COUNT(DISTINCT FV.COD_PEDIDO)                                                   AS QTD_PEDIDOS,
    TO_CHAR(SUM(FV.VAL_TOTAL), 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''') AS VAL_TOTAL
FROM
    FATOVENDAS FV
    JOIN DIMCLIENTE DC
    ON FV.COD_CLIENTE = DC.COD_CLIENTE
GROUP BY
    FV.COD_CLIENTE,
    DC.NOM_CLIENTE
ORDER BY
    VAL_TOTAL DESC;

/* -------------------- -- Produto mais comprados por cliente ------------------- */
SELECT
    FV.COD_CLIENTE,
    DC.NOM_CLIENTE,
    DP.NOM_PRODUTO,
    SUM(FV.QTD_VENDIDA)                                                             AS QTD_PRODUTOS,
    TO_CHAR(SUM(FV.VAL_TOTAL), 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''') AS VAL_TOTAL
FROM
    FATOVENDAS FV
    JOIN DIMCLIENTE DC
    ON FV.COD_CLIENTE = DC.COD_CLIENTE
    JOIN DIMPRODUTO DP
    ON FV.COD_PRODUTO = DP.COD_PRODUTO
GROUP BY
    FV.COD_CLIENTE,
    DC.NOM_CLIENTE,
    DP.NOM_PRODUTO,
    DP.COD_PRODUTO
ORDER BY
    FV.COD_CLIENTE,
    VAL_TOTAL DESC;