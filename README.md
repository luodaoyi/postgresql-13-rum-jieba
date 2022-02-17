# postgresql-13-rum-jieba

[![Build Image](https://github.com/luodaoyi/postgresql-13-rum-jieba/actions/workflows/build.yml/badge.svg)](https://github.com/luodaoyi/postgresql-13-rum-jieba/actions/workflows/build.yml)

## postgresql 13版本
1. 集成 rum 扩展 二进制 https://github.com/postgrespro/rum
2. 集成 jieba 扩展 二进制 https://github.com/jaiminpan/pg_jieba


## 使用编译好的docker镜像 支持amd64和arm64

> https://github.com/luodaoyi/postgresql-13-rum-jieba/pkgs/container/postgresql-13-rum-jieba

```shell
docker pull ghcr.io/luodaoyi/postgresql-13-rum-jieba:latest
docker run --name pgsql -v ~/data:/var/lib/postgresql -e POSTGRES_PASSWORD=****** -d -p 5432:5432 postgres 

```

## 启用扩展

```sql
CREATE EXTENSION rum;
CREATE EXTENSION pg_jieba;
```
