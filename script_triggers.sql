CREATE OR REPLACE TRIGGER check_idade_funcionario
    BEFORE INSERT ON FUNCIONARIO
    FOR EACH ROW
    BEGIN 
        IF TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.DATA_NASCIMENTO) /12) < 18 THEN
            RAISE_APPLICATION_ERROR(-20001, 'O funcionario deve ter pelo menos 18 anos.');
        END IF;
END check_idade_funcionario;
/


CREATE OR REPLACE TRIGGER check_idade_cliente
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    
    IF TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.DATA_NASCIMENTO)/12) < 18 THEN
        RAISE_APPLICATION_ERROR(-20006, 'O cliente não tem idade suficiente para ser registado');
    END IF;

EXCEPTION
   
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20007, 'Erro ao inserir cliente: ' || SQLERRM);
END check_idade_cliente;
/


CREATE or REPLACE TRIGGER check_data
BEFORE INSERT OR UPDATE ON VEICULO 
FOR EACH ROW

BEGIN 
    IF :NEW.DATA_FABRICO > SYSDATE 
    THEN
        RAISE_APPLICATION_ERROR (-20006, 'A Data inserida nao pode ser maior que a actual');
    END IF;
END check_data;