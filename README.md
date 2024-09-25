# MySQLのインデックスのパフォーマンスをテストしてみる

詳しくはzennの記事を参照してください！(まだ執筆中)

## セットアップ

データベース立ち上げ

```shell
make up
```

データベースに接続

```shell
docker exec -it mysql-index-test-db-1 mysql -u root -ppassw0rd
```

testデータベースに切り替え

```shell
mysql> use test;
```

## インデックスの効果を確認してみる

```shell
mysql> SET profiling = 1;
```

給料が75000の人を検索

```shell
mysql> SELECT * FROM employees WHERE salary = 75000;
```

実行時間を確認

```shell
mysql> SHOW PROFILES;
```

給与カラムにインデックスを追加する

```shell
mysql> CREATE INDEX idx_salary ON employees (salary);
```

EXPLAINを使ってクエリの実行計画を確認

```shell
mysql> EXPLAIN SELECT * FROM employees WHERE salary = 75000;
```
