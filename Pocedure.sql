-- Passo 1: Criar a tabela de relatório
CREATE TABLE IF NOT EXISTS relatorio_diario (
    data_relatorio DATE PRIMARY KEY,
    quantidade_total INT
);

-- Passo 2: Criar a procedure para gerar o relatório diário
DELIMITER //

CREATE PROCEDURE GerarRelatorioDiario (IN dataRelatorio DATE)
BEGIN
    DECLARE quantidadeTotal INT;

    -- Calcular a quantidade total de produtos comprados na data especificada
    SELECT SUM(od.quantidade) INTO quantidadeTotal
    FROM pedidos o
    JOIN detalhes_pedido od ON o.id_pedido = od.id_pedido
    WHERE o.data_pedido = dataRelatorio;

    -- Inserir ou atualizar o relatório diário na tabela relatorio_diario
    INSERT INTO relatorio_diario (data_relatorio, quantidade_total)
    VALUES (dataRelatorio, quantidadeTotal)
    ON DUPLICATE KEY UPDATE quantidade_total = quantidadeTotal;
END //

DELIMITER ;

-- Chamada da procedure para gerar o relatório para uma data específica (exemplo: '2024-05-26')
CALL GerarRelatorioDiario('2024-05-26');
