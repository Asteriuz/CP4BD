CREATE OR REPLACE PROCEDURE InsereDimCliente (
    p_COD_CLIENTE IN INT,
    p_NOM_CLIENTE IN VARCHAR2,
    p_NUM_CPF_CNPJ IN VARCHAR2,
    p_TIPO_CLIENTE IN VARCHAR2,
    p_STATUS_CLIENTE IN VARCHAR2
) AS
BEGIN
    -- Validação de dados
    IF p_COD_CLIENTE IS NULL OR p_NOM_CLIENTE IS NULL OR p_NUM_CPF_CNPJ IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Campos obrigatórios não podem ser nulos.');
    END IF;
    
    -- Insere ou atualiza dados
    BEGIN
        MERGE INTO DimCliente dc
        USING (SELECT p_COD_CLIENTE AS COD_CLIENTE FROM DUAL) src
        ON (dc.COD_CLIENTE = src.COD_CLIENTE)
        WHEN MATCHED THEN
            UPDATE SET 
                dc.NOM_CLIENTE = p_NOM_CLIENTE,
                dc.NUM_CPF_CNPJ = p_NUM_CPF_CNPJ,
                dc.TIPO_CLIENTE = p_TIPO_CLIENTE,
                dc.STATUS_CLIENTE = p_STATUS_CLIENTE
        WHEN NOT MATCHED THEN
            INSERT (COD_CLIENTE, NOM_CLIENTE, NUM_CPF_CNPJ, TIPO_CLIENTE, STATUS_CLIENTE)
            VALUES (p_COD_CLIENTE, p_NOM_CLIENTE, p_NUM_CPF_CNPJ, p_TIPO_CLIENTE, p_STATUS_CLIENTE);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir/atualizar DimCliente: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE PROCEDURE InsereDimProduto (
    p_COD_PRODUTO IN INT,
    p_NOM_PRODUTO IN VARCHAR2,
    p_COD_BARRA IN VARCHAR2,
    p_TIPO_PRODUTO IN VARCHAR2,
    p_STATUS_PRODUTO IN VARCHAR2
) AS
BEGIN
    -- Validação de dados
    IF p_COD_PRODUTO IS NULL OR p_NOM_PRODUTO IS NULL OR p_COD_BARRA IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Campos obrigatórios não podem ser nulos.');
    END IF;
    
    -- Insere ou atualiza dados
    BEGIN
        MERGE INTO DimProduto dp
        USING (SELECT p_COD_PRODUTO AS COD_PRODUTO FROM DUAL) src
        ON (dp.COD_PRODUTO = src.COD_PRODUTO)
        WHEN MATCHED THEN
            UPDATE SET 
                dp.NOM_PRODUTO = p_NOM_PRODUTO,
                dp.COD_BARRA = p_COD_BARRA,
                dp.TIPO_PRODUTO = p_TIPO_PRODUTO,
                dp.STATUS_PRODUTO = p_STATUS_PRODUTO
        WHEN NOT MATCHED THEN
            INSERT (COD_PRODUTO, NOM_PRODUTO, COD_BARRA, TIPO_PRODUTO, STATUS_PRODUTO)
            VALUES (p_COD_PRODUTO, p_NOM_PRODUTO, p_COD_BARRA, p_TIPO_PRODUTO, p_STATUS_PRODUTO);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir/atualizar DimProduto: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE PROCEDURE InsereDimVendedor (
    p_COD_VENDEDOR IN INT,
    p_NOM_VENDEDOR IN VARCHAR2,
    p_STATUS_VENDEDOR IN VARCHAR2
) AS
BEGIN
    -- Validação de dados
    IF p_COD_VENDEDOR IS NULL OR p_NOM_VENDEDOR IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Campos obrigatórios não podem ser nulos.');
    END IF;
    
    -- Insere ou atualiza dados
    BEGIN
        MERGE INTO DimVendedor dv
        USING (SELECT p_COD_VENDEDOR AS COD_VENDEDOR FROM DUAL) src
        ON (dv.COD_VENDEDOR = src.COD_VENDEDOR)
        WHEN MATCHED THEN
            UPDATE SET 
                dv.NOM_VENDEDOR = p_NOM_VENDEDOR,
                dv.STATUS_VENDEDOR = p_STATUS_VENDEDOR
        WHEN NOT MATCHED THEN
            INSERT (COD_VENDEDOR, NOM_VENDEDOR, STATUS_VENDEDOR)
            VALUES (p_COD_VENDEDOR, p_NOM_VENDEDOR, p_STATUS_VENDEDOR);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir/atualizar DimVendedor: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE PROCEDURE InsereDimTempo (
    p_COD_TEMPO IN INT,
    p_ANO IN INT,
    p_MES IN INT,
    p_DIA IN INT,
    p_TRIMESTRE IN INT,
    p_SEMESTRE IN INT,
    p_DIA_DA_SEMANA IN VARCHAR2,
    p_DIA_DO_ANO IN INT
) AS
BEGIN
    -- Validação de dados
    IF p_COD_TEMPO IS NULL OR p_ANO IS NULL OR p_MES IS NULL OR p_DIA IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'Campos obrigatórios não podem ser nulos.');
    END IF;
    
    -- Insere ou atualiza dados
    BEGIN
        MERGE INTO DimTempo dt
        USING (SELECT p_COD_TEMPO AS COD_TEMPO FROM DUAL) src
        ON (dt.COD_TEMPO = src.COD_TEMPO)
        WHEN MATCHED THEN
            UPDATE SET 
                dt.ANO = p_ANO,
                dt.MES = p_MES,
                dt.DIA = p_DIA,
                dt.TRIMESTRE = p_TRIMESTRE,
                dt.SEMESTRE = p_SEMESTRE,
                dt.DIA_DA_SEMANA = p_DIA_DA_SEMANA,
                dt.DIA_DO_ANO = p_DIA_DO_ANO
        WHEN NOT MATCHED THEN
            INSERT (COD_TEMPO, ANO, MES, DIA, TRIMESTRE, SEMESTRE, DIA_DA_SEMANA, DIA_DO_ANO)
            VALUES (p_COD_TEMPO, p_ANO, p_MES, p_DIA, p_TRIMESTRE, p_SEMESTRE, p_DIA_DA_SEMANA, p_DIA_DO_ANO);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir/atualizar DimTempo: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE PROCEDURE InsereDimLocalizacao (
    p_COD_LOCALIZACAO IN INT,
    p_CIDADE IN VARCHAR2,
    p_ESTADO IN VARCHAR2,
    p_PAIS IN VARCHAR2
) AS
BEGIN
    -- Validação de dados
    IF p_COD_LOCALIZACAO IS NULL OR p_CIDADE IS NULL OR p_ESTADO IS NULL OR p_PAIS IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'Campos obrigatórios não podem ser nulos.');
    END IF;
    
    -- Insere ou atualiza dados
    BEGIN
        MERGE INTO DimLocalizacao dl
        USING (SELECT p_COD_LOCALIZACAO AS COD_LOCALIZACAO FROM DUAL) src
        ON (dl.COD_LOCALIZACAO = src.COD_LOCALIZACAO)
        WHEN MATCHED THEN
            UPDATE SET 
                dl.CIDADE = p_CIDADE,
                dl.ESTADO = p_ESTADO,
                dl.PAIS = p_PAIS
        WHEN NOT MATCHED THEN
            INSERT (COD_LOCALIZACAO, CIDADE, ESTADO, PAIS)
            VALUES (p_COD_LOCALIZACAO, p_CIDADE, p_ESTADO, p_PAIS);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir/atualizar DimLocalizacao: ' || SQLERRM);
    END;
END;
/