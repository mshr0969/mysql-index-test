-- テーブルの作成
CREATE TABLE IF NOT EXISTS employees
(
    id        VARCHAR(36) PRIMARY KEY,
    name      VARCHAR(255) NOT NULL,
    salary    INT,
    isDeleted BOOLEAN DEFAULT FALSE
);

DELIMITER //
CREATE PROCEDURE insert_random_employees()
BEGIN
    DECLARE i INT DEFAULT 1;

    -- 知っているUUIDを指定してレコードを挿入
    INSERT INTO employees (id, name, salary, isDeleted)
    VALUES ('123e4567-e89b-12d3-a456-426614174000', -- 既知のUUID
            'John Doe', -- 固定の名前
            75000, -- 固定の給与
            FALSE);
    -- isDeletedはFALSE固定

    -- 残りのレコードをランダムなUUIDで挿入
    WHILE i <= 9999
        DO
            -- ランダムに名前を選ぶ (プレフィックスとサフィックスを組み合わせる)
            INSERT INTO employees (id, name, salary, isDeleted)
            VALUES (UUID(), -- ランダムなUUID
                    CONCAT(
                            ELT(FLOOR(1 + (RAND() * 8)), -- ランダムにプレフィックスを選ぶ
                                'John', 'Jane', 'Mike', 'Lisa', 'Chris', 'Sara', 'Tom', 'Emma'
                            ),
                            ' ',
                            ELT(FLOOR(1 + (RAND() * 8)), -- ランダムにサフィックスを選ぶ
                                'Smith', 'Doe', 'Johnson', 'Brown', 'Wilson', 'Moore', 'Taylor', 'Anderson'
                            )
                    ),
                    FLOOR(50000 + (RAND() * 50000)), -- ランダムな給与 (50000 ~ 100000)
                    ELT(FLOOR(1 + (RAND() * 2)), TRUE, FALSE) -- ランダムでTRUEまたはFALSEを選ぶ
                   );
            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;

-- ストアドプロシージャの実行
CALL insert_random_employees();
