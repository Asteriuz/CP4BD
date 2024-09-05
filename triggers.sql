CREATE OR REPLACE TRIGGER TRG_AUDIT_DIMPRODUTO AFTER
    INSERT ON DIMPRODUTO FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_DIMENSOES (
        NOME_TABELA,
        OPERACAO,
        DADOS_INSERIDOS
    ) VALUES (
        'DIMPRODUTO', -- Nome da tabela
        'INSERT', -- Operação realizada
        'COD_PRODUTO: '
        || :NEW.COD_PRODUTO
        || -- Dados inseridos
        ', NOM_PRODUTO: '
        || :NEW.NOM_PRODUTO
        || ', STA_ATIVO: '
        || :NEW.STA_ATIVO
    );
END TRG_AUDIT_DIMPRODUTO;
/

CREATE OR REPLACE TRIGGER TRG_AUDIT_DIMCLIENTE AFTER
    INSERT ON DIMCLIENTE FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_DIMENSOES (
        NOME_TABELA,
        OPERACAO,
        DADOS_INSERIDOS
    ) VALUES (
        'DIMCLIENTE',
        'INSERT',
        'COD_CLIENTE: '
        || :NEW.COD_CLIENTE
        || ', NOM_CLIENTE: '
        || :NEW.NOM_CLIENTE
        || ', STA_ATIVO: '
        || :NEW.STA_ATIVO
    );
END TRG_AUDIT_DIMCLIENTE;
/

CREATE OR REPLACE TRIGGER TRG_AUDIT_DIMVENDEDOR AFTER
    INSERT ON DIMVENDEDOR FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_DIMENSOES (
        NOME_TABELA,
        OPERACAO,
        DADOS_INSERIDOS
    ) VALUES (
        'DIMVENDEDOR',
        'INSERT',
        'COD_VENDEDOR: '
        || :NEW.COD_VENDEDOR
        || ', NOM_VENDEDOR: '
        || :NEW.NOM_VENDEDOR
    );
END TRG_AUDIT_DIMVENDEDOR;
/

CREATE OR REPLACE TRIGGER TRG_AUDIT_DIMTEMPO AFTER
    INSERT ON DIMTEMPO FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_DIMENSOES (
        NOME_TABELA,
        OPERACAO,
        DADOS_INSERIDOS
    ) VALUES (
        'DIMTEMPO',
        'INSERT',
        'DATA_VENDA: '
        || :NEW.DATA_VENDA
        || ', ANO: '
        || :NEW.ANO
        || ', MES: '
        || :NEW.MES
        || ', DIA: '
        || :NEW.DIA
    );
END TRG_AUDIT_DIMTEMPO;
/