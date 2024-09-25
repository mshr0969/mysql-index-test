# MySQLのインデックスのパフォーマンスをテストしてみる

## 数値を単一で検索

```sql
-- プロファイリングの有効化
SET
profiling = 1;
-- インデックスなしのクエリ実行と時間測定
SELECT *
FROM employees
WHERE salary = 75000;

SHOW
PROFILES;

-- インデックスの作成
CREATE INDEX idx_name ON employees (salary);

-- インデックスありのクエリ実行と時間測定
SELECT *
FROM employees
WHERE salary = 75000;

SHOW
PROFILES;
```

## 数値を範囲指定で検索

```sql
-- プロファイリングの有効化
SET
profiling = 1;
-- インデックスなしのクエリ実行と時間測定(比較演算子を使う)
SELECT *
FROM employees
WHERE salary >= 70000
  AND salary <= 90000;

-- BETWEENを使ったクエリ実行と時間測定
SELECT *
FROM employees
WHERE salary BETWEEN 70000
          AND 90000;

-- インデックスの作成
CREATE INDEX idx_name ON employees (salary);

-- インデックスありのクエリ実行と時間測定
SELECT *
FROM employees
WHERE salary >= 70000
  AND salary <= 90000;

-- BETWEENを使ったクエリ実行と時間測定
SELECT *
FROM employees
WHERE salary BETWEEN 70000
          AND 90000;

SHOW
PROFILES;
```
